import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:latihan_local_apii/controllers/popular_movie_controller.dart';
import 'package:latihan_local_apii/assets/themes.dart';
import 'package:latihan_local_apii/views/detail_page.dart';
// import 'package:latihan_local_apii/router/router.dart';

class PopularMovie extends StatelessWidget {
  final PopularMovieController popularMovieController =
      Get.put(PopularMovieController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Popular",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Spacer(),
              Text("Show all", style: Theme.of(context).textTheme.titleSmall),
            ],
          ),
          SizedBox(height: 15),
          Obx(() {
            if (popularMovieController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Container(
                height: 300,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    // itemCount: popularMovieController.popularMovieList.length,

                    // itemCount: popularMovieController.popularMovieList.length,
                    itemBuilder: (context, index) {
                      final movie =
                          popularMovieController.popularMovieList[index];
                      if (movie.results.isNotEmpty) {
                        return InkWell(
                          onTap: () {
                            print("InkWell tapped");
                            Get.to(
                              () => DetailPage(),
                              arguments: {
                                'id': movie
                                    .results[0].id, 
                                'index': index
                              },
                            );
                          },
                          child: Container(
                            width: 120,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500' +
                                            popularMovieController
                                                .popularMovieList[index]
                                                .results[0]
                                                .posterPath,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  popularMovieController
                                      .popularMovieList[index].results[0].title,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                SizedBox(height: 5),
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
                                  itemSize: 15,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    // Handle rating updates if needed
                                  },
                                  ignoreGestures: true,
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return null;
                    }),
              );
            }
          }),
        ],
      ),
    );
  }
}
