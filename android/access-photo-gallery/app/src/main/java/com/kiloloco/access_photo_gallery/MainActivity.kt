package com.kiloloco.access_photo_gallery

import android.net.Uri
import android.os.Bundle
import androidx.activity.result.contract.ActivityResultContracts.GetContent
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.foundation.Text
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material.Button
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.setContent
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.kiloloco.access_photo_gallery.ui.theme.AccessphotogalleryTheme
import dev.chrisbanes.accompanist.glide.GlideImage

class MainActivity : AppCompatActivity() {

    private var imageUriState = mutableStateOf<Uri?>(null)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            photoSelector()
        }
    }

    private val selectImageLauncher = registerForActivityResult(GetContent()) { uri ->
        imageUriState.value = uri
    }

    @Composable
    fun photoSelector() {
        Box(contentAlignment = Alignment.Center, modifier = Modifier.fillMaxSize()) {
            Column(horizontalAlignment = Alignment.CenterHorizontally) {

                if (imageUriState.value != null) {
                    GlideImage(data = imageUriState.value!!)
                }

                Button(
                        onClick = { selectImageLauncher.launch("image/*") },
                        modifier = Modifier.padding(vertical = 8.dp)
                ) {
                    androidx.compose.material.Text("Open Gallery")
                }

            }
        }
    }
}