package com.example.authflow

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.authflow.ui.theme.AuthFlowTheme

class MainActivity : ComponentActivity() {
    private val viewModel by viewModels<AuthViewModel>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        viewModel.configureAmplify(this)

        setContent {
            AuthFlowTheme {
                AppNavigator()
            }
        }
    }

    @Composable
    private fun AppNavigator() {
        val navController = rememberNavController()
        viewModel.navigateTo = {
            navController.navigate(it)
        }

        NavHost(navController = navController, startDestination = "login") {
            composable("login") {
                LoginScreen(viewModel = viewModel)
            }
            composable("signUp") {
                SignUpScreen(viewModel = viewModel)
            }
            composable("verify") {
                VerificationCodeScreen(viewModel = viewModel)
            }
            composable("session") {
                SessionScreen(viewModel = viewModel)
            }
        }
    }
}