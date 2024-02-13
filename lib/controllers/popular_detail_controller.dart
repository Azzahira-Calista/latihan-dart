// ignore_for_file: unnecessary_null_comparison
import 'package:get/get.dart';
import 'package:latihan_local_apii/api/api_service.dart';

class DetailPageController extends GetxController {
  var isLoading = true.obs;
  var popularMovieList = [].obs;

  @override
  void onInit() {
    fetchPopularMovie();
    super.onInit();
  }

  void fetchPopularMovie() async {
    try {
      isLoading(true);
      var popularMovies = await PopularMovieApiService.fetchPopularMovies();
      if (popularMovies != null) {
        popularMovieList.value = popularMovies.results;
      }
    } finally {
      isLoading(false);
    }
  }
}
