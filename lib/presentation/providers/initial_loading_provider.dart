import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movies_provider.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final nowPlayingMovies = ref.read(nowPlayingMoviesProvider).isEmpty;
  final popularMovies = ref.watch(popularMoviesProvider).isEmpty;
  final upcomingMovies = ref.watch(upcomingMoviesProvider).isEmpty;
  final topRatedMovies = ref.watch(topRatedMoviesProvider).isEmpty;

  if (nowPlayingMovies || popularMovies || upcomingMovies || topRatedMovies) {
    return true;
  }

  return false;
});
