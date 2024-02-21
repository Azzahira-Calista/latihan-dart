import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_local_apii/controllers/popular_movie_controller.dart';
import 'package:latihan_local_apii/controllers/wishlist_controller.dart';
import 'package:latihan_local_apii/models/popular_movie_model.dart';

class MyWishList extends StatelessWidget {
  const MyWishList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PopularMovieController popularMovieController =
        Get.find<PopularMovieController>();
    final WishlistController wishlistController =
        Get.put<WishlistController>(WishlistController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.movie_filter),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('NAMAVA WATCHLIST'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Obx(
          () {
            if (wishlistController.watchlist.isEmpty) {
              return Center(
                child: Text(
                  'There is no watchlist',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: wishlistController.watchlist.length,
                itemBuilder: (context, index) {
                  int id = wishlistController.watchlist[index];
                  Result? movie = wishlistController.findMovieById(id);
                  if (movie == null) {
                    // Handle case where movie details are not available
                    return SizedBox(); // Or show an error message
                  }
                  return MovieListItem(
                      movie: movie,
                      onFavoritePressed: () {
                        wishlistController.removeWatchlist(movie.id);
                      });
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class MovieListItem extends StatelessWidget {
  final Result movie;
  final VoidCallback onFavoritePressed;

  const MovieListItem({
    required this.movie,
    required this.onFavoritePressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 100,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: EdgeInsets.fromLTRB(15, 25, 15, 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: NetworkImage(
                'https://image.tmdb.org/t/p/w500${movie.backdropPath}'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.5),
              Colors.transparent,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.center,
          ),
        ),
      ),
      Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.5),
              Colors.transparent,
            ],
            begin: Alignment.centerRight,
            end: Alignment.center,
          ),
        ),
      ),
      Positioned(
        top: 30,
        left: 40,
        right: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  movie.releaseDate,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.playlist_remove_rounded,
                  color: Colors.white, size: 38),
              onPressed: onFavoritePressed,
            ),
          ],
        ),
      )
    ]);
  }
}
