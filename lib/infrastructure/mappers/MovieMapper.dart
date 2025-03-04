import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/movieDB/movie_from_moviedb.dart';

class Moviemapper {
  static Movie movieDBToEntity(MovieFromMovieDb movieDB) => Movie(
    adult: movieDB.adult,
    backdropPath:
        (movieDB.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500/${movieDB.backdropPath}'
            : 'https://mir-s3-cdn-cf.behance.net/project_modules/1400_opt_1/9556d16312333.5691dd2255721.jpg',
    genreIds: movieDB.genreIds.map((element) => element.toString()).toList(),
    id: movieDB.id,
    originalLanguage: movieDB.originalLanguage,
    originalTitle: movieDB.originalTitle,
    overview: movieDB.overview,
    popularity: movieDB.popularity,
    posterPath:
        movieDB.posterPath != ''
            ? 'https://image.tmdb.org/t/p/w500/${movieDB.posterPath}'
            : 'https://mir-s3-cdn-cf.behance.net/project_modules/1400_opt_1/9556d16312333.5691dd2255721.jpg',
    releaseDate: movieDB.releaseDate,
    title: movieDB.title,
    video: movieDB.video,
    voteAverage: movieDB.voteAverage,
    voteCount: movieDB.voteCount,
  );
}
