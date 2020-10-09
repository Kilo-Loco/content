package com.kiloloco.jetpack_compose_pagination

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.foundation.Text
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumnFor
import androidx.compose.foundation.lazy.LazyColumnForIndexed
import androidx.compose.material.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.livedata.observeAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.setContent
import androidx.compose.ui.unit.dp
import androidx.lifecycle.LiveData
import androidx.lifecycle.ViewModelProvider
import androidx.ui.tooling.preview.Preview
import com.kiloloco.jetpack_compose_pagination.ui.JetpackcomposepaginationTheme

class MainActivity : AppCompatActivity() {

    private lateinit var viewModel: MainActivityViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        viewModel = ViewModelProvider(this)
            .get(MainActivityViewModel::class.java)

        viewModel.getAnimals()

        setContent {
            JetpackcomposepaginationTheme {
                Scaffold(
                    topBar = {
                        TopAppBar(title = { Text("Animals") })
                    }
                ) {
                    AnimalList(liveAnimals = viewModel.liveAnimals)
                }
            }
        }
    }

    @Composable
    fun AnimalList(liveAnimals: LiveData<List<Animal>>) {
        val animals by liveAnimals.observeAsState(initial = emptyList())

        LazyColumnForIndexed(items = animals) { index, animal ->

            if (index == animals.lastIndex) {
                viewModel.getAnimals()
            }

            ListItem(
                icon = { Text(animal.emoji) },
                text = { Text(animal.name)},
                modifier = Modifier.padding(vertical = 30.dp)
            )
        }
    }
}
