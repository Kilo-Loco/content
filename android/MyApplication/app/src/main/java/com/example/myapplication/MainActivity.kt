package com.example.myapplication

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import com.example.myapplication.posts.model.Post
import com.example.myapplication.ui.theme.MyApplicationTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            MyApplicationTheme {
                // A surface container using the 'background' color from the theme
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    Greeting("Android")
                }
            }
        }

    }



    private fun doAThing(value: String, block: (String) -> String) {

    }

    private fun doOtherThing(value: String): String {
        return ""
    }

    private fun executeAllTheThings(maybeValue: String?) {
        maybeValue?.let { valueToExecuteOn ->
            doAThing(valueToExecuteOn) { mutatedValueAfterThing ->
                doOtherThing(mutatedValueAfterThing)
            }
        }
    }

    val postRepository = PostRepository()

    val postId = ""

    fun toggleHeart() {}
    fun showError() {}

    fun likePost() {
        postRepository.likePost(postId) { result ->
            if (result == APIResult.FAILURE) {
                showError()
            }
        }
        toggleHeart()
    }
}

enum class APIResult {
    SUCCESS, FAILURE
}

class PostRepository {
    fun likePost(postId: String, block: (APIResult) -> Unit) {

    }
}

@Composable
fun Greeting(name: String) {
    Text(text = "Hello $name!")
}

@Preview(showBackground = true)
@Composable
fun DefaultPreview() {
    MyApplicationTheme {
        Greeting("Android")
    }
}