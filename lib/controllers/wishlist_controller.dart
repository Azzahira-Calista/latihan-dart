import 'package:get/get.dart';
import 'package:latihan_local_apii/database/database_helper.dart';
import 'package:latihan_local_apii/models/popular_movie_model.dart';
import 'package:latihan_local_apii/controllers/popular_movie_controller.dart';

class WishlistController extends GetxController {
  RxList<int> watchlist = <int>[].obs;
  final movieDB = DatabaseHelper();
  final String watchlistKey = 'watchlist';

  @override
  void onInit() {
    loadWatchlist();
    super.onInit();
  }

  void loadWatchlist() async {
    try {
      // Memanggil metode getAllWatchlist dari DatabaseHelper untuk mendapatkan semua data watchlist dari SQLite
      List<int> cachedWatchlist = await movieDB.getAllWatchlist();
      if (cachedWatchlist.isNotEmpty) {
        watchlist.value = cachedWatchlist.obs;
      }
    } catch (e) {
      print("Error loading watchlist from SQLite: $e");
    }
  }

  void saveWatchlist() async {
    try {
      // Memanggil metode insertWatchlist dari DatabaseHelper untuk menyimpan daftar watchlist ke dalam SQLite
      await movieDB.insertWatchlist(watchlist.toList());
    } catch (e) {
      print("Error saving watchlist to SQLite: $e");
    }
  }

  void addWatchlist(int id) async {
    try {
      // Memanggil metode insertWatchlist dari DatabaseHelper untuk menambahkan film ke dalam SQLite
      if (!watchlist.contains(id)) {
        watchlist.add(id);
        await movieDB.insertWatchlist([id]);
      }
    } catch (e) {
      print("Error adding movie to watchlist: $e");
    }
  }

  void removeWatchlist(int id) async {
    try {
      // Memanggil metode removeMovie dari DatabaseHelper untuk menghapus film dari SQLite
      watchlist.remove(id);
      await movieDB.removeMovies(id);
    } catch (e) {
      print("Error removing movie from watchlist: $e");
    }
  }

  Result findMovieById(int id) {
    final popularMovieController = Get.find<PopularMovieController>();
    List<PopularMovieModel> popularMovies =
        popularMovieController.popularMovieList;
    try {
      return popularMovies
          .expand((movie) => movie.results)
          .firstWhere((movie) => movie.id == id);
    } catch (e) {
      print("Movie with id $id not found: $e");
      return Result(
          adult: false,
          backdropPath: "",
          genreIds: [],
          id: 0,
          originalLanguage: '',
          originalTitle: '',
          overview: '',
          popularity: 0,
          posterPath: '',
          releaseDate: '',
          title: '',
          video: false,
          voteAverage: 0,
          voteCount: 0);
    }
  }
}
