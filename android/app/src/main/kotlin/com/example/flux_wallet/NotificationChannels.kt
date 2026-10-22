package com.example.flux_wallet

import android.content.Context
import android.content.Intent
import android.provider.Settings
import androidx.core.app.NotificationManagerCompat
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

/** Platform channels used by the Dart `AndroidNotificationSource`. */
object NotificationChannels {
    fun register(messenger: BinaryMessenger, context: Context) {
        EventChannel(messenger, "flux_wallet/notification_events")
            .setStreamHandler(NotificationBridge)
        MethodChannel(messenger, "flux_wallet/notification_access")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "isAccessGranted" -> result.success(
                        NotificationManagerCompat
                            .getEnabledListenerPackages(context)
                            .contains(context.packageName)
                    )
                    "openAccessSettings" -> {
                        context.startActivity(
                            Intent(Settings.ACTION_NOTIFICATION_LISTENER_SETTINGS)
                                .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        )
                        result.success(null)
                    }
                    "drain" -> result.success(CapturedStore.drain(context))
                    else -> result.notImplemented()
                }
            }
    }
}
