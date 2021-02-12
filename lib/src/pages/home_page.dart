import 'package:flutter/material.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: Text('Peliculas en cines'),
            backgroundColor: Colors.indigoAccent,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              )
            ]),

        // body: SafeArea( child: Text('Hola Mundo!!!!!'),)// el safearea es un widget que se encarga de colocar las cosas en lugares que sabemos que se pueden desplegar las cosas

        body: Container(
          child: Column(
            children: <Widget>[_crearTarjetas()],
          ),
        ));
  }

  Widget _crearTarjetas() {
      return CardSwiper(
      peliculas: [1,2,3,4,5],
    );
   // return Container();
  }
}
