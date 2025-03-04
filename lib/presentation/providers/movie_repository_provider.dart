import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource_impl.dart';
import 'package:cinemapedia/infrastructure/repositories/movies_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Ahora crearemos un Provider.
// Los Providers son objetos que NO pueden cambiar su valor una vez establecidos.
// En este caso, el valor siempre será del tipo MoviesRepositoryImpl,
// independientemente de la fuente de datos.
final movieRepositoryProvider = Provider((ref) {
  return MoviesRepositoryImpl(MoviedbDatasourceImpl());
});
