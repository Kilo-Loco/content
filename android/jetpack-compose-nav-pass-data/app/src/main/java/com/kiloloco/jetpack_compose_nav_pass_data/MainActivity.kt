package com.kiloloco.jetpack_compose_nav_pass_data

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumnFor
import androidx.compose.material.Card
import androidx.compose.material.ListItem
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.setContent
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import androidx.navigation.NavHostController
import androidx.navigation.NavType
import androidx.navigation.compose.*
import com.google.gson.Gson
import com.kiloloco.jetpack_compose_nav_pass_data.ui.JetpackcomposenavpassdataTheme

data class User(val id: Int, val name: String) {
    val description: String
        get() = "$name has an ID of $id"
}

class MainActivity : AppCompatActivity() {
    
    private val users = listOf(
            User(1, "Kyle"),
            User(2, "Adriana"),
            User(3, "Andrew"),
            User(4, "Xavier"),
            User(5, "Mya")
    )
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            JetpackcomposenavpassdataTheme {
                AppNavigator()
            }
        }
    }

    @Composable
    fun AppNavigator() {
        val navController = rememberNavController()

        NavHost(
                navController = navController,
                startDestination = "usersView"
        ) {
            composable("usersView") { UsersView(navController, users) }
            composable(
                    "userDetailsView/{user}",
                    arguments = listOf(
                            navArgument("user") { type = NavType.StringType }
                    )
            ) { backStackEntry ->
                backStackEntry?.arguments?.getString("user")?.let { json ->
                    val user = Gson().fromJson(json, User::class.java)
                    UserDetailsView(user = user)
                }
            }
        }
    }
}

@Composable
fun UsersView(navController: NavHostController, users: List<User>) {

    fun navigateToUser(user: User) {
        val userJson = Gson().toJson(user)
        navController.navigate("userDetailsView/$userJson")
    }

    LazyColumnFor(items = users) { user ->
        Card(
                elevation = 4.dp,
                modifier = Modifier
                        .padding(8.dp, 4.dp)
                        .clickable(onClick = { navigateToUser(user) })
        ) {
            ListItem(text = { Text(user.name) })
        }
    }
}

@Composable
fun UserDetailsView(user: User) {
    Box(
            contentAlignment = Alignment.Center,
            modifier = Modifier.fillMaxSize()
    ) {
        Text(user.description)
    }
}