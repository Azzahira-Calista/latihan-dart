import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:latihan_local_apii/database/database_helper.dart';
import 'package:latihan_local_apii/models/popular_movie_model.dart';
import 'package:latihan_local_apii/api/api_service.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';

class PopularMovieController extends GetxController {
  var isLoading = true.obs;
  List<PopularMovieModel> popularMovieList = [];

  final String cacheKey = 'cached_movies';

  @override
  void onInit() {
    loadDatabaseProduct();
    fetchPopularMovie();
    super.onInit();
  }

  Future<bool> hasInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  void fetchPopularMovie() async {
    isLoading(true);

    try {
      bool internetAvailable = await hasInternetConnection();

      if (internetAvailable) {
        final PopularMovieModel response =
            await PopularMovieApiService.fetchPopularMovies();
        popularMovieList.clear();

        for (var result in response.results) {
          popularMovieList.add(
            PopularMovieModel(
              page: response.page,
              results: [result],
              totalPages: response.totalPages,
              totalResults: response.totalResults,
            ),
          );
        }

// Simpan data ke dalam database setelah memperbarui popularMovieList
        saveMoviesDatabase();
      } else {
        print('No internet connection. Fetching data from local database.');
        loadDatabaseProduct();
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  // void loadDatabaseProduct() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? cachedData = prefs.getString(cacheKey);
  //   if (cachedData != null) {
  //     final List<PopularMovieModel> cachedMovies = popularMovieModelFromJson(cachedData);
  //     popularMovieList.assignAll(cachedMovies);
  //   }
  // }

  // void saveMoviesDatabase() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(cacheKey, popularMovieModelToJson(popularMovieList.toList()));
  // }

  // void loadDatabaseProduct() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? cachedData = prefs.getString(cacheKey);
  //   if (cachedData != null) {
  //     final List<PopularMovieModel> cachedMovies =
  //         popularMovieModelListFromJson(cachedData);
  //     popularMovieList.assignAll(cachedMovies);
  //   }
  // }

  void loadDatabaseProduct() async {
    try {
      List<Map<String, dynamic>> data =
          await DatabaseHelper.getAllPopularMovies();
      popularMovieList =
          data.map((map) => PopularMovieModel.fromJson(map)).toList();
    } catch (e) {
      print("Error loading data from database: $e");
    }
  }

  void saveMoviesDatabase() async {
  try {
    // Convert List<PopularMovieModel> to List<Map<String, dynamic>>
    List<Map<String, dynamic>> data = popularMovieList.map((model) => model.toJson()).toList();
    
    // Save all data to SQLite database
    await DatabaseHelper.insertAllPopularMovies(data);
  } catch (e) {
    print("Error saving data to database: $e");
  }
}


  // void saveMoviesDatabase() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(cacheKey, popularMovieModelListToJson(popularMovieList));
  // }

  List<PopularMovieModel> popularMovieModelListFromJson(String str) {
    final List<dynamic> jsonData = json.decode(str);
    return jsonData.map((item) => PopularMovieModel.fromJson(item)).toList();
  }

  String popularMovieModelListToJson(List<PopularMovieModel> list) {
    return json.encode(list.map((item) => item.toJson()).toList());
  }
}





// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class MovieController extends GetxController {
//   var movieList = [].obs;
//   var isLoading = true.obs;
//
//   @override
//   void onInit() {
//     fetchMovie();
//     super.onInit();
//   }
//
//   void fetchMovie() async {
//     try {
//       isLoading(true);
//       final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1&api_key=19248e2e2b57b25e4d0e63b5fada8777'),);
//       if (movies != null) {
//         movieList.value = movies;
//       }
//     } finally {
//       isLoading(false);
//     }
//   }

  // Future<void> fetchMovies() async {
  //   try {
  //     final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1&api_key=19248e2e2b57b25e4d0e63b5fada8777'),);
  //     if (response.statusCode == 200) {
  //       final movie = movieFromJson(response.body);
  //       movies.assignAll(movie.results);
  //       isLoading.value = false;
  //     } else {
  //       print("Error: ${response.statusCode.toString()}");
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }
// }