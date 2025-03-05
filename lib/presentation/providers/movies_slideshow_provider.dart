import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';

// podemos crear Providers que no van a cambiar de valor, en este caso como queremos que escoger solo 6 del total
// de peliculas que vienen del servicio lo podemos hacer asi,
// ademas como podemos ver al crear un provider podemos tener al referencia de ref, que contiene la informacion
// de todos los providers creados, es decir podemos acceder a cualquier provider
final moviesSlideShowProvider = Provider<List<Movie>>((ref) {
  // la documentacion sugiere usar watch
  final List<Movie> nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
  if (nowPlayingMovies.isEmpty) {
    return [];
  }
  return nowPlayingMovies.sublist(0, 6);
});
