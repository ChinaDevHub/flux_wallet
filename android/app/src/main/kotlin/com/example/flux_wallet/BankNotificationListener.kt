package com.example.flux_wallet

import android.app.Notification
import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import org.json.JSONObject

/**
 * Forwards notifications that mention AZN to Flutter. Parsing and the
 * decision what to do with them happen in Dart; nothing else leaves here.
 */
class BankNotificationListener : NotificationListenerService() {
    private val money = Regex("(?i)(\\bazn\\b|₼)")

    override fun onNotificationPosted(sbn: StatusBarNotification) {
        if (sbn.packageName == packageName) return
        val extras = sbn.notification.extras
        val body = extras.getCharSequence(Notification.EXTRA_BIG_TEXT)
            ?: extras.getCharSequence(Notification.EXTRA_TEXT)
        val title = extras.getCharSequence(Notification.EXTRA_TITLE)
        val text = listOfNotNull(title, body).joinToString(" ").trim()
        if (!money.containsMatchIn(text)) return
        val item = JSONObject()
            .put("text", text)
            .put("source", sbn.packageName)
            .put("postedAt", sbn.postTime)
        if (!NotificationBridge.emit(item.toString())) {
            CapturedStore.add(applicationContext, item)
        }
    }
}
