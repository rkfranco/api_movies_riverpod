import 'package:get_api_movies/movie_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'movie_notifier.dart';

final movieProvider = StateNotifierProvider<MoviesNotifier, List<MovieModel>>((ref) => MoviesNotifier());
