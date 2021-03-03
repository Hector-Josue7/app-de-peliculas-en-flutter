// aqui se guardan widgets personalizados nuestros

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwiper(
      {@required
          this.peliculas}); // me tienen que mandar a fuerza la lista de peliculas sino no funciona

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context)
        .size; // para obtener el ancho y alto del dispositivo

    return Container(
      padding: EdgeInsets.only(top: 20.0),

      //  width: double.infinity, // usa todo el ancho posible

      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          peliculas[index].uniqueId = '${peliculas[index].id}-tarjeta';
          return Hero(
            //  tag: 'tagImage$index',
            tag: peliculas[index].uniqueId,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  // para hacer animacion
                  onTap: () => Navigator.pushNamed(context, 'detalle',
                      arguments: peliculas[index]),
                  child: FadeInImage(
                    image: NetworkImage(peliculas[index].getPosterImg()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                  ),
                )
                // child: Image.network("http://via.placeholder.com/350x150",fit: BoxFit.cover, //fill: para que la imagen se adapte a las dimensiones que tiene
                ),
          );
        },
        itemCount: peliculas.length,
        //   pagination: new SwiperPagination(),

        // control: new SwiperControl(),
      ),
    );
  }
}
