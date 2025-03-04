import 'package:cinemapedia/config/constants/enviroment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/MovieMapper.dart';
import 'package:cinemapedia/infrastructure/models/movieDB/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasourceImpl implements MoviesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Enviroment.theMovieDbKey,
        'language': 'es-MX',
      },
    ),
  );

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');
    final MovieDbResponse moviDBresponse = MovieDbResponse.fromJson(
      response.data,
    );

    // Con las siguientes líneas podemos usar el mapper Moviemapper creado
    // para convertir los datos de MovieDb a nuestra entidad Movie,
    // que se usará en toda la aplicación sin importar el origen de los datos.
    final List<Movie> movies =
        moviDBresponse.results
            .map((movieDb) => Moviemapper.movieDBToEntity(movieDb))
            .toList();

    return movies;
  }
}
