package com.xperiments.app.widget

import android.appwidget.AppWidgetManager
import android.content.Context
import android.net.Uri
import android.view.View
import android.widget.RemoteViews
import com.xperiments.app.MainActivity
import com.xperiments.app.R
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetPlugin
import es.antonborri.home_widget.HomeWidgetProvider

class TodayChecklistWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: android.content.SharedPreferences,
    ) {
        appWidgetIds.forEach { appWidgetId ->
            val views = RemoteViews(context.packageName, R.layout.today_checklist_widget)
            updateRows(context, views, widgetData)
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }

    private fun updateRows(
        context: Context,
        views: RemoteViews,
        widgetData: android.content.SharedPreferences,
    ) {
        val count = widgetData.getInt("today_widget_count", 0)
        val hasMore = widgetData.getBoolean("today_widget_has_more", false)

        val rowIds = intArrayOf(
            R.id.widget_row_0,
            R.id.widget_row_1,
            R.id.widget_row_2,
            R.id.widget_row_3,
            R.id.widget_row_4,
        )
        val titleIds = intArrayOf(
            R.id.widget_row_0_title,
            R.id.widget_row_1_title,
            R.id.widget_row_2_title,
            R.id.widget_row_3_title,
            R.id.widget_row_4_title,
        )
        val subtitleIds = intArrayOf(
            R.id.widget_row_0_subtitle,
            R.id.widget_row_1_subtitle,
            R.id.widget_row_2_subtitle,
            R.id.widget_row_3_subtitle,
            R.id.widget_row_4_subtitle,
        )

        views.setViewVisibility(R.id.widget_empty, if (count == 0) View.VISIBLE else View.GONE)
        views.setViewVisibility(R.id.widget_overflow, if (hasMore) View.VISIBLE else View.GONE)

        for (index in rowIds.indices) {
            if (index >= count) {
                views.setViewVisibility(rowIds[index], View.GONE)
                continue
            }

            val title = widgetData.getString("today_widget_name_$index", "") ?: ""
            val lab = widgetData.getString("today_widget_lab_$index", "") ?: ""
            val checked = widgetData.getBoolean("today_widget_checked_$index", false)
            val route = widgetData.getString("today_widget_route_$index", "") ?: ""

            views.setViewVisibility(rowIds[index], View.VISIBLE)
            views.setTextViewText(titleIds[index], if (checked) "✓ $title" else title)
            views.setTextViewText(subtitleIds[index], lab)

            val routeUri = Uri.parse("xperiments://open?route=$route")
            val pendingIntent = HomeWidgetLaunchIntent.getActivity(
                context,
                MainActivity::class.java,
                routeUri,
            )
            views.setOnClickPendingIntent(rowIds[index], pendingIntent)
        }

        val rootPendingIntent = HomeWidgetLaunchIntent.getActivity(
            context,
            MainActivity::class.java,
            Uri.parse("xperiments://open?route=/experiments"),
        )
        views.setOnClickPendingIntent(R.id.widget_title, rootPendingIntent)
    }
}
