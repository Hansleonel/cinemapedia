import 'package:cinemapedia/domain/entities/movie.dart' show Movie;
import 'package:cinemapedia/presentation/providers/movies_provider.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    final List<Movie> nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    final List<Movie> slideshowMovies = ref.watch(moviesSlideShowProvider);

    /* if (nowPlayingMovies.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } */

    return Column(
      children: [
        // CustomAppBar toma su espacion necesario
        CustomAppbar(),
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
      ],
    );
  }
}
