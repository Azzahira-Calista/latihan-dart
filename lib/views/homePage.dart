// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_local_apii/views/wishlist_page.dart';
import 'package:latihan_local_apii/widget/popular_movie.dart';
import 'package:latihan_local_apii/widget/popular_movie_carousell.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.movie_filter),
        actions: [
          IconButton(
            icon: Icon(Icons.playlist_add_check_rounded),
            onPressed: () {
              Get.to(
                () => MyWishList(),
              );
            },
          ),
        ],
        title: const Text('NAMAVA'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PopularMovieCarousel(),
                      SizedBox(
                        height: 35,
                      ),
                      // Container(
                      //   height: MediaQuery.of(context).size.height / 3,
                      //   color: Colors.white,
                      // ),
                      PopularMovie(),
                      PopularMovie(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // BottomNavigation(),
        ],
      ),
    );
  }
}
