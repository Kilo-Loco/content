package com.kiloloco.auth_web_ui_proto

import android.app.Application
import android.util.Log
import com.amplifyframework.AmplifyException
import com.amplifyframework.core.Amplify

class AuthApplication : Application() {

    override fun onCreate() {
        super.onCreate()
        configureAmplify()
    }

    fun configureAmplify() {
        try {
            Amplify.configure(applicationContext)
            Log.i("logtag", "Initialized Amplify🥳")

        } catch (error: AmplifyException) {
            Log.e("logtag", "Could not initialize amplify", error)
        }
    }
}