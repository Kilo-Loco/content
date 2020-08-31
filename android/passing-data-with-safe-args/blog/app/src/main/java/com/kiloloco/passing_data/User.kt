package com.kiloloco.passing_data

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class User(val id: Int, val name: String, val age: Int): Parcelable {
    val description: String
        get() = "$name is $age years old."
}