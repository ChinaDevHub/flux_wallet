package com.example.flux_wallet

import android.content.Context
import org.json.JSONArray
import org.json.JSONObject

/** Keeps notifications captured while the Flutter side is not listening. */
object CapturedStore {
    private const val PREFS = "captured_notifications"
    private const val KEY = "queue"
    private const val MAX_ITEMS = 200

    @Synchronized
    fun add(context: Context, item: JSONObject) {
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        val queue = JSONArray(prefs.getString(KEY, "[]"))
        if (queue.length() >= MAX_ITEMS) return
        queue.put(item)
        prefs.edit().putString(KEY, queue.toString()).apply()
    }

    /** Returns everything stored so far as a JSON string and clears it. */
    @Synchronized
    fun drain(context: Context): String {
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        val stored = prefs.getString(KEY, "[]") ?: "[]"
        prefs.edit().remove(KEY).apply()
        return stored
    }
}
