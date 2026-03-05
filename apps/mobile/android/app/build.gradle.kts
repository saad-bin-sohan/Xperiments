import java.util.Properties
import java.util.Base64

plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystorePropertiesFile.inputStream().use(keystoreProperties::load)
}

fun releaseTaskRequested(taskNames: List<String>): Boolean {
    return taskNames.any { taskName ->
        val normalized = taskName.lowercase()
        normalized.contains("release") ||
            normalized.contains("bundle") ||
            normalized.contains("publish")
    }
}

fun decodeDartDefine(encoded: String): String? {
    if (encoded.isBlank()) {
        return null
    }

    return runCatching { String(Base64.getDecoder().decode(encoded)) }.getOrNull()
}

fun dartDefineValue(key: String): String? {
    val dartDefinesProperty = project.findProperty("dart-defines") as String? ?: return null
    if (dartDefinesProperty.isBlank()) {
        return null
    }

    return dartDefinesProperty
        .split(",")
        .mapNotNull(::decodeDartDefine)
        .map { it.trim() }
        .firstOrNull { decoded -> decoded.startsWith("$key=") }
        ?.substringAfter('=', missingDelimiterValue = "")
        ?.trim()
        ?.takeIf { it.isNotEmpty() }
}

fun googleServicesProjectId(): String? {
    val googleServicesFile = project.file("google-services.json")
    if (!googleServicesFile.exists()) {
        return null
    }

    val contents = googleServicesFile.readText()
    val match = Regex("\"project_id\"\\s*:\\s*\"([^\"]+)\"").find(contents)
    return match?.groupValues?.getOrNull(1)?.trim()?.takeIf { it.isNotEmpty() }
}

fun googleServicesHasWebOauthClient(): Boolean {
    val googleServicesFile = project.file("google-services.json")
    if (!googleServicesFile.exists()) {
        return false
    }

    val contents = googleServicesFile.readText()
    return Regex("\"client_type\"\\s*:\\s*3").containsMatchIn(contents)
}

fun validateGoogleServicesConfig() {
    val flavor = dartDefineValue("FLAVOR")?.lowercase()?.takeIf { it.isNotEmpty() } ?: "dev"
    val projectId = googleServicesProjectId()
        ?: throw GradleException(
            "Missing android/app/google-services.json. " +
                "Download it from Firebase Console and place it at " +
                "apps/mobile/android/app/google-services.json.",
        )

    if (projectId != "xperiments-dev") {
        throw GradleException(
            "Unsupported Firebase project_id '$projectId' in android/app/google-services.json. " +
                "Single-project mode expects 'xperiments-dev'.",
        )
    }

    if (!googleServicesHasWebOauthClient()) {
        throw GradleException(
            "android/app/google-services.json for FLAVOR=$flavor is missing a web OAuth client " +
                "(oauth_client with client_type: 3). Re-download config after enabling Google Sign-In " +
                "and adding the Firebase web app.",
        )
    }
}

val validateGoogleServicesConfigTask = tasks.register("validateGoogleServicesConfig") {
    doLast {
        validateGoogleServicesConfig()
    }
}

tasks.matching { task ->
    task.name.startsWith("process") && task.name.endsWith("GoogleServices")
}.configureEach {
    dependsOn(validateGoogleServicesConfigTask)
}

android {
    namespace = "com.xperiments.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.xperiments.app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 31
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            if (!keystorePropertiesFile.exists()) {
                return@create
            }

            val storeFilePath = keystoreProperties.getProperty("storeFile")
                ?: throw GradleException("Missing 'storeFile' in android/key.properties")
            val storePasswordValue = keystoreProperties.getProperty("storePassword")
                ?: throw GradleException("Missing 'storePassword' in android/key.properties")
            val keyAliasValue = keystoreProperties.getProperty("keyAlias")
                ?: throw GradleException("Missing 'keyAlias' in android/key.properties")
            val keyPasswordValue = keystoreProperties.getProperty("keyPassword")
                ?: throw GradleException("Missing 'keyPassword' in android/key.properties")

            storeFile = file(storeFilePath)
            storePassword = storePasswordValue
            keyAlias = keyAliasValue
            keyPassword = keyPasswordValue
        }
    }

    buildTypes {
        release {
            if (keystorePropertiesFile.exists()) {
                signingConfig = signingConfigs.getByName("release")
            } else if (releaseTaskRequested(gradle.startParameter.taskNames)) {
                throw GradleException(
                    "Release signing is not configured. " +
                        "Create android/key.properties (from android/key.properties.example) " +
                        "and provide your upload keystore details.",
                )
            }
        }
    }
}

flutter {
    source = "../.."
}
