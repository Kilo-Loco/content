package com.kiloloco.recyclerview_navigation_with_fragments

import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.recyclerview.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.core.os.bundleOf
import androidx.fragment.app.ListFragment
import androidx.navigation.NavDirections
import androidx.navigation.findNavController

import com.kiloloco.recyclerview_navigation_with_fragments.dummy.DummyContent.DummyItem

/**
 * [RecyclerView.Adapter] that can display a [DummyItem].
 * TODO: Replace the implementation with code for your data type.
 */
class MyItemRecyclerViewAdapter(
    private val values: List<DummyItem>
) : RecyclerView.Adapter<MyViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MyViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.fragment_item, parent, false)
        return MyViewHolder(view)
    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {
        val item = values[position]
        holder.idView.text = item.id
        holder.contentView.text = item.content
        holder.something = item.content
    }

    override fun getItemCount(): Int = values.size
}

class MyViewHolder(view: View, var something: String? = null) : RecyclerView.ViewHolder(view) {
    val idView: TextView = view.findViewById(R.id.item_number)
    val contentView: TextView = view.findViewById(R.id.content)

    init {
        view.setOnClickListener {
            Log.i("kyle", idView.text.toString())
            val directions = ItemFragmentDirections.actionItemFragmentToDetailsFragment(something ?: "kyle")
            it.findNavController().navigate(directions)
        }
    }

    private fun navigateToItem(view: View) {
        view.findNavController().navigate(R.id.action_itemFragment_to_detailsFragment)
    }

    override fun toString(): String {
        return super.toString() + " '" + contentView.text + "'"
    }
}