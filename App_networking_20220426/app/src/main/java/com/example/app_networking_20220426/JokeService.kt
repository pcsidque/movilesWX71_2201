package com.example.app_networking_20220426

import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface JokeService {
    @GET("api")
    fun getJoke(@Query("format") format: String) : Call<Joke>
}