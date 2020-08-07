package com.kiloloco.auth_web_ui_proto

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import kotlinx.android.synthetic.main.activity_auth.*
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        checkSessionStatus()
    }

    private fun checkSessionStatus() {
        val isSignedIn = true
        val activity = if (isSignedIn) SessionActivity::class.java else AuthActivity::class.java
        val intent = Intent(this, activity)
        startActivity(intent)
    }
}