package com.kiloloco.recyclerview_navigation_with_fragments

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.navigation.fragment.navArgs
import kotlinx.android.synthetic.main.details_fragment.*

class DetailsFragment : Fragment() {

    private val args: DetailsFragmentArgs by navArgs()
    private lateinit var something: String

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.details_fragment, container, false)

        something = args.something

        Log.i("kyle", "The something is: $something")

        return view
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        myLabel.text = something
    }

}