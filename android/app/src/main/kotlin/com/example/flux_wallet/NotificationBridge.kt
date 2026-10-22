package com.example.flux_wallet

import android.os.Handler
import android.os.Looper
import io.flutter.plugin.common.EventChannel

/** Live link to Dart; null while the app process has no Flutter listener. */
object NotificationBridge : EventChannel.StreamHandler {
    private var sink: EventChannel.EventSink? = null
    private val main = Handler(Looper.getMainLooper())

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events
    }

    override fun onCancel(arguments: Any?) {
        sink = null
    }

    /** True when Dart received it live (so it need not be stored). */
    fun emit(payload: String): Boolean {
        val target = sink ?: return false
        main.post { target.success(payload) }
        return true
    }
}
