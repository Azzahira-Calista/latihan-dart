// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:latihan_local_apii/controllers/popular_movie_controller.dart';

class PopularMovieCarousel extends StatelessWidget {
  final PopularMovieController popularMovieController =
      Get.put(PopularMovieController());

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 400,
      child: Obx(
        () {
          if (popularMovieController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return CarouselSlider.builder(
              itemCount: popularMovieController.popularMovieList.length,
              itemBuilder: (context, index, realIndex) {
                return Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://image.tmdb.org/t/p/w500' +
                                popularMovieController.popularMovieList[index]
                                    .results[0].backdropPath,
                          ),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5), BlendMode.darken),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      right: 8,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              popularMovieController
                                  .popularMovieList[index].results[0].title,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  popularMovieController.popularMovieList[index]
                                      .results[0].releaseDate,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '•',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 4),
                                RatingBar.builder(
                                  initialRating: popularMovieController
                                          .popularMovieList[index]
                                          .results[0]
                                          .voteAverage /
                                      2,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 20,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {},
                                  ignoreGestures: true,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              options: CarouselOptions(
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                autoPlay: true,
              ),
            );
          }
        },
      ),
    );
  }
}
