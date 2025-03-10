import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref.watch(moviesRepositoryProvider).getPopular;
      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref.watch(moviesRepositoryProvider).getUpcoming;
      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref.watch(moviesRepositoryProvider).getTopRated;
      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });
// Ahora crearemos un Provider de tipo personalizado,
// es decir, de tipo StateNotifierProvider.
final nowPlayingMoviesProvider = StateNotifierProvider<
  MoviesNotifier,
  List<Movie>
>((ref) {
  // Con la ayuda del ref podemos tener la referencia a todos los providers creados.
  // En este caso, hacemos la referencia a nuestro movieRepositoryProvider,
  // que como sabemos, hace el llamado a MoviesRepositoryImpl, el cual tiene el método getNowPlaying().
  // Este método, a su vez, usa la fuente de datos MoviedbDatasourceImpl que hace el llamado al API de MovieDB para obtener el listado de películas.
  final fetchMoreMovies = ref.watch(moviesRepositoryProvider).getNowPlaying;

  // Le pasamos la función fetchMoreMovies que tiene que ser del mismo tipo,
  // en este caso, Future<List<Movie>> que acepta el parámetro opcional page, que es el número de página.
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

// Un typedef es simplemente un alias para una función que devuelve el tipo que tú quieras.
// En este caso, el tipo Future<List<Movie>> que acepta un parámetro opcional con el nombre de page,
// y page es del tipo int.
typedef MovieCallBack = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;

  // Esta línea:
  // Future<List<Movie>> Function({int page}) fetchMoreMovies
  // es equivalente a la siguiente línea, solo que en la siguiente línea se usa el typedef:
  MovieCallBack fetchMoreMovies;

  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    print(
      'cargando movies del servicio con la ayuda del StateNotifierProvider',
    );
    isLoading = true;
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);

    // Aquí debemos usar esta forma para generar un nuevo estado.
    // Con el spread operator garantizamos que se genere una lista nueva, con los elementos anteriores
    // más los elementos de movies, en el contexto de las películas que llegan desde el servicio.
    // Esto nos sirve porque va acumulando películas gracias a la paginación.
    // No debemos usar state.addAll(movies) puesto que no nos garantiza que se cree un nuevo estado, ya que solo modifica la lista que ya se tiene.
    state = [...state, ...movies];
    await Future.delayed(Duration(microseconds: 200));
    isLoading = false;
  }
}
