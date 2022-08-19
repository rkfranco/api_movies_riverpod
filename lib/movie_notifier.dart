import 'package:dio/dio.dart';
import 'package:get_api_movies/movie_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'movie_repository.dart';

class MoviesNotifier extends StateNotifier<List<MovieModel>> {
  final _repository = MovieRepository(Dio());
  MoviesNotifier() : super([]) {
    getAllMovies();
  }

  getAllMovies() async {
    state = await _repository.getAllMovies();
  }
}
