import 'package:http/http.dart' as http;
import 'package:latihan_local_apii/models/popular_movie_model.dart';

class PopularMovieApiService {
  
  static var client = http.Client();

  static Future<PopularMovieModel> fetchPopularMovies() async {
    var response = await client.get(
      Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=1f54bd990f1cdfb230adb312546d765d&language=en-US&page=1'),
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return popularMovieModelFromJson(jsonString);
    } else {
      throw Exception('Failed to load popular movies');
    }
  }
}
