// aqui se guardan widgets personalizados nuestros

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> peliculas;

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
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network("http://via.placeholder.com/350x150",
            fit: BoxFit.fill, // para que la imagen se adapte a las dimensiones que tiene
          ),
          );

          
        },
        itemCount: 4,
        //   pagination: new SwiperPagination(),

        // control: new SwiperControl(),
      ),
    );
  }
}
