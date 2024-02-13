import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:latihan_local_apii/controllers/popular_movie_controller.dart';
import 'package:latihan_local_apii/controllers/wishlist_controller.dart';
import 'package:latihan_local_apii/views/homePage.dart';

class DetailPage extends StatelessWidget {
  // final PopularMovieController popularMovieController =
  //     Get.put(PopularMovieController());

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        Get.arguments as Map<String, dynamic>;
    final int movieId = arguments['id'];
    final int index = arguments['index'];
    final PopularMovieController popularMovieController =
        Get.find<PopularMovieController>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.file_download_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.playlist_add_rounded),
            onPressed: () {
              WishlistController().addWatchlist(movieId);
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Stack(
          children: [
            Container(child: Obx(() {
              if (popularMovieController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            height: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500' +
                                  popularMovieController.popularMovieList[index]
                                      .results[0].posterPath,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                print('Error loading image: $error');
                                return Icon(Icons.error);
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    popularMovieController
                                        .popularMovieList[index]
                                        .results[0]
                                        .title,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
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
                                    onRatingUpdate: (rating) {},
                                    ignoreGestures: true,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    popularMovieController
                                        .popularMovieList[index]
                                        .results[0]
                                        .releaseDate,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  SizedBox(height: 30),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    height: 40,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          'Play Now',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 38, 38, 38),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Storyline',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        popularMovieController
                            .popularMovieList[index].results[0].overview,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(height: 40),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Cast',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 25),
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://i.pinimg.com/564x/15/4c/5d/154c5dbc100dbbae9b5ee0ea25434ddb.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text('Actor Name',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white)),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            }))
          ],
        ),
      ),
    );
  }
}
