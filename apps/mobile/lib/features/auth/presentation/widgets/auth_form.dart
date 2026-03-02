import 'package:flutter/material.dart';
import 'package:mobile/core/constants/app_sizes.dart';
import 'package:mobile/core/utils/validators.dart';
import 'package:mobile/core/widgets/app_text_field.dart';
import 'package:mobile/features/auth/presentation/widgets/google_sign_in_button.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({
    super.key,
    required this.isSignUp,
    required this.formKey,
    required this.displayNameController,
    required this.emailController,
    required this.passwordController,
    required this.loading,
    required this.onSubmit,
    required this.onGoogleSignIn,
    required this.onToggle,
  });

  final bool isSignUp;
  final GlobalKey<FormState> formKey;
  final TextEditingController displayNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool loading;
  final VoidCallback onSubmit;
  final VoidCallback onGoogleSignIn;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (isSignUp)
            AppTextField(
              controller: displayNameController,
              label: 'Display name',
              validator: Validators.displayName,
            ),
          if (isSignUp) const SizedBox(height: AppSizes.spacingSm),
          AppTextField(
            controller: emailController,
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: Validators.email,
          ),
          const SizedBox(height: AppSizes.spacingSm),
          AppTextField(
            controller: passwordController,
            label: 'Password',
            obscureText: true,
            textInputAction: TextInputAction.done,
            validator: Validators.password,
          ),
          const SizedBox(height: AppSizes.spacingMd),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: loading ? null : onSubmit,
              child: Text(isSignUp ? 'Create account' : 'Sign in'),
            ),
          ),
          const SizedBox(height: AppSizes.spacingSm),
          GoogleSignInButton(onPressed: onGoogleSignIn, loading: loading),
          const SizedBox(height: AppSizes.spacingXs),
          TextButton(
            onPressed: loading ? null : onToggle,
            child: Text(
              isSignUp
                  ? 'Already have an account? Sign in'
                  : 'Need an account? Create one',
            ),
          ),
        ],
      ),
    );
  }
}
