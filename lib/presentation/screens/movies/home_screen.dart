import 'package:cinemapedia/domain/entities/movie.dart' show Movie;
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Home Screen')),
      body: _HomeView(),
      bottomNavigationBar: CustomButtomNavigation(),
    );
  }
}

// recordemos que con provider debemos de usar el ConsumerWidget para reemplazar a los StatelessWidgets
// y a los ConsumerStatefulWidget para reemplazar a los StatefulWidget
// esto se debe a que queremos referenciar a nuestros providers
class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    // aqui usamos el read puesto que no queremos estar atentos a los changs de los estados
    // puesto que estamos dentro del initState, si queremos estar atentos a los changs de los estados
    // debemos de usar el watch y generalmente se debe de usar con widgets
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final bool initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) return FullScreenLoader();

    final List<Movie> slideshowMovies = ref.watch(moviesSlideShowProvider);
    final List<Movie> nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final List<Movie> popularMovies = ref.watch(popularMoviesProvider);
    final List<Movie> upcomingMovies = ref.watch(upcomingMoviesProvider);
    final List<Movie> topRatedMovies = ref.watch(topRatedMoviesProvider);

    /* if (nowPlayingMovies.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } */

    // CustomScrollView permite crear vistas de desplazamiento personalizadas utilizando una combinación de slivers.
    // Los slivers son widgets que pueden tener un tamaño variable y que se pueden desplazar dentro de una vista de desplazamiento.
    // Esto proporciona una gran flexibilidad para crear interfaces de usuario complejas y personalizadas.
    // en este caso por ejemplo lo usamos para poder hacer un desplazamiento suave del SliverAppBar
    // esto nos permite ver el appbar en cualquier parte de la pagina con el uso sel scroll del CustomScrollView
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(title: CustomAppbar()),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                // CustomAppBar toma su espacion necesario
                // CustomAppbar(),
                // Expanded toma todo el espacio restante del column luego de que otros widgets hayan tomado su espacio
                /*Expanded(
            child: ListView.builder(
              itemCount: nowPlayingMovies.length,
              itemBuilder: (context, index) {
                final movie = nowPlayingMovies[index];
                return ListTile(title: Text(movie.title));
              },
            ),
          ),*/
                // Carrousel de peliculas now_playing
                MoviesSlideshow(movies: slideshowMovies),
                // ListView de peliculas now_playing
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En Cines',
                  subtitle: 'Lunes 20',
                  loadNextPage: () {
                    // en este caso estamos cambiando el estado del provider de tipo personalizado es decir un StateNotifierProvider
                    // con .notifier podemos acceder a las operaciones que podemos realizar con el provider
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                  },
                ),
                MovieHorizontalListview(
                  movies: popularMovies,
                  title: 'Populares',
                  loadNextPage: () {
                    // en este caso estamos cambiando el estado del provider de tipo personalizado es decir un StateNotifierProvider
                    // con .notifier podemos acceder a las operaciones que podemos realizar con el provider
                    ref.read(popularMoviesProvider.notifier).loadNextPage();
                  },
                ),
                MovieHorizontalListview(
                  movies: upcomingMovies,
                  title: 'Por Estrenar',
                  subtitle: 'Lunes 20',
                  loadNextPage: () {
                    // en este caso estamos cambiando el estado del provider de tipo personalizado es decir un StateNotifierProvider
                    // con .notifier podemos acceder a las operaciones que podemos realizar con el provider
                    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
                  },
                ),
                MovieHorizontalListview(
                  movies: topRatedMovies,
                  title: 'Top Peliculas',
                  subtitle: 'Lunes 20',
                  loadNextPage: () {
                    // en este caso estamos cambiando el estado del provider de tipo personalizado es decir un StateNotifierProvider
                    // con .notifier podemos acceder a las operaciones que podemos realizar con el provider
                    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                  },
                ),
              ],
            );

            // childCount nos permite decirle al SliverChildBuilderDelegate cuántas veces queremos repetir
            // el widget que retornamos en el builder.
          }, childCount: 1),
        ),
      ],
    );
  }
}
