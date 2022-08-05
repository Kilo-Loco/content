package com.example.authflow

import android.content.Context
import android.util.Log
import com.amplifyframework.auth.AuthUserAttributeKey
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin
import com.amplifyframework.auth.options.AuthSignUpOptions
import com.amplifyframework.core.Amplify

interface AmplifyService {
    fun configureAmplify(context: Context)

    fun signUp(state: SignUpState, onComplete: () -> Unit)

    fun verifyCode(state: VerificationCodeState, onComplete: () -> Unit)

    fun login(state: LoginState, onComplete: () -> Unit)

    fun logOut(onComplete: () -> Unit)
}

class AmplifyServiceImpl : AmplifyService {
    override fun configureAmplify(context: Context) {
        try {
            Amplify.addPlugin(AWSCognitoAuthPlugin())
            Amplify.configure(context)
            Log.i("KILO", "Configured amplify")
        } catch (e: Exception) {
            Log.e("KILO", "Amplify configuration failed", e)
        }
    }

    override fun signUp(state: SignUpState, onComplete: () -> Unit) {
        val options = AuthSignUpOptions.builder()
            .userAttribute(AuthUserAttributeKey.email(), state.email)
            .build()

        Amplify.Auth.signUp(state.username, state.password, options,
            { onComplete() },
            { Log.e("KILO", "Sign Up Error:", it) }
        )
    }

    override fun verifyCode(state: VerificationCodeState, onComplete: () -> Unit) {
        Amplify.Auth.confirmSignUp(
            state.username,
            state.code,
            { onComplete() },
            { Log.e("KILO", "Verification Failed: ", it) }
        )
    }

    override fun login(state: LoginState, onComplete: () -> Unit) {
        Amplify.Auth.signIn(
            state.username,
            state.password,
            { onComplete() },
            { Log.e("KILO", "Login Error:", it) }
        )
    }

    override fun logOut(onComplete: () -> Unit) {
        Amplify.Auth.signOut(
            { onComplete() },
            { Log.e("KILO", "Sign Out Failed: ", it) }
        )
    }
}