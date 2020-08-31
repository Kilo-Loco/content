package com.kiloloco.passing_data

import android.os.Bundle
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup

class UsersFragment : Fragment() {

    private val users = listOf<User>(
        User(1, "Kyle", 29),
        User(2, "Adri", 36),
        User(3, "Andy", 14),
        User(4, "Xayxay", 3),
        User(5, "Mya", 1)
    )

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.fragment_users_list, container, false)

        // Set the adapter
        if (view is RecyclerView) {
            with(view) {
                layoutManager = LinearLayoutManager(context)
                adapter = UsersRecyclerViewAdapter(users)
            }
        }
        return view
    }
}