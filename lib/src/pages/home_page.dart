import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();
  HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
 
    peliculasProvider.getPopulares();
    return Scaffold(
      
   //    resizeToAvoidBottomInset: false,
        appBar: AppBar(
            centerTitle: false,
            title: Text('Peliculas en cines'),
            backgroundColor: Colors.indigoAccent,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch()
                      // query: 'Hola'

                      );
                },
              )
            ]),

        // body: SafeArea( child: Text('Hola Mundo!!!!!'),)// el safearea es un widget que se encarga de colocar las cosas en lugares que sabemos que se pueden desplegar las cosas

        body: Container(
   
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.end,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[_crearTarjetas(), _footer(context)],
            ),
          ),
        ));
  }

  Widget _crearTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        // el snapshot contiene la lista de peliculas

        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
        width: double.infinity, // para que agarre todo el espacio
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 20.0),
                child: Text('Populares',
                    style: Theme.of(context).textTheme.subtitle1)),
            SizedBox(height: 5.0),
            // Text('Populares', style: Theme.of(context).textTheme.headline6

            // FutureBuilder(
            //   future: peliculasProvider.getPopulares(),
            StreamBuilder(
              stream: peliculasProvider.popularesStream,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                //  snapshot.data?.forEach((pelicula) => print(pelicula.title) ); // haz ese forEach si existe data, eso significa el signo de ?
                // print(snapshot.data);
                if (snapshot.hasData) {
                  return MovieHorizontal(
                    peliculas: snapshot.data,
                    siguientePagina: peliculasProvider.getPopulares,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ));
  }
}
