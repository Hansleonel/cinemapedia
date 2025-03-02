import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MovieRepositories {
  Future<List<Movie>> getNowPlay({int page = 1});
}
