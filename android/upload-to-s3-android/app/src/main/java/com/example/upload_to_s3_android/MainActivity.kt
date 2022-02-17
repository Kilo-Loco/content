package com.example.upload_to_s3_android

import android.net.Uri
import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.result.contract.ActivityResultContracts.GetContent
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material.Button
import androidx.compose.material.Text
import androidx.compose.runtime.mutableStateOf
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import coil.compose.rememberImagePainter
import com.amplifyframework.AmplifyException
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin
import com.amplifyframework.core.Amplify
import com.amplifyframework.storage.s3.AWSS3StoragePlugin
import java.io.File

sealed class ImageState {
    object Initial: ImageState()
    class ImageSelected(val imageUri: Uri): ImageState()
    object ImageUploaded: ImageState()
    class ImageDownloaded(val downloadedImageFile: File): ImageState()
}

class MainActivity : ComponentActivity() {

    companion object {
        const val PHOTO_KEY = "my-photo.jpg"
    }

    private var imageState = mutableStateOf<ImageState>(ImageState.Initial)

    private val getImageLauncher = registerForActivityResult(GetContent()) { uri ->
        uri?.let { imageState.value = ImageState.ImageSelected(it) }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        configureAmplify()

        setContent {
            Column(
                verticalArrangement = Arrangement.Center,
                horizontalAlignment = Alignment.CenterHorizontally,
                modifier = Modifier.fillMaxSize()
            ) {
                when (val state = imageState.value) {
                    // Show Open Gallery Button
                    is ImageState.Initial -> {
                        Button(onClick = { getImageLauncher.launch("image/*") }) {
                            Text(text = "Open Gallery")
                        }
                    }

                    // Show Upload Button
                    is ImageState.ImageSelected -> {
                        Button(onClick = { uploadPhoto(state.imageUri) }) {
                            Text(text = "Upload Photo")
                        }
                    }

                    // Show Download Button
                    is ImageState.ImageUploaded -> {
                        Button(onClick = ::downloadPhoto) {
                            Text(text = "Download Photo")
                        }
                    }

                    // Show downloaded image
                    is ImageState.ImageDownloaded -> {
                        Image(
                            painter = rememberImagePainter(state.downloadedImageFile),
                            contentDescription = null,
                            modifier = Modifier.fillMaxSize()
                        )
                    }
                }
            }
        }
    }

    private fun configureAmplify() {
        try {
            Amplify.addPlugin(AWSCognitoAuthPlugin())
            Amplify.addPlugin(AWSS3StoragePlugin())
            Amplify.configure(applicationContext)

            Log.i("kilo", "Initialized Amplify")
        } catch (error: AmplifyException) {
            Log.e("kilo", "Could not initialize Amplify", error)
        }
    }

    private fun uploadPhoto(imageUri: Uri) {
        val stream = contentResolver.openInputStream(imageUri)!!

        Amplify.Storage.uploadInputStream(
            PHOTO_KEY,
            stream,
            { imageState.value = ImageState.ImageUploaded },
            { error -> Log.e("kilo", "Failed upload", error) }
        )
    }

    private fun downloadPhoto() {
        val localFile = File("${applicationContext.filesDir}/downloaded-image.jpg")

        Amplify.Storage.downloadFile(
            PHOTO_KEY,
            localFile,
            { imageState.value = ImageState.ImageDownloaded(localFile) },
            { Log.e("kilo", "Failed download", it) }
        )
    }

}