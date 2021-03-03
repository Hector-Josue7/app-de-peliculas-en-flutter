import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/models/actores_model.dart';

class PeliculasProvider {
  String _apiKey = 'f7ad9993103a300ad2b2f2c9331498c3';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularesPage = 0;
  // el stream tiene que ser una corriente de datos, esta corriente de datos lo que va a transmitir dentro de ella va a ser la colección de peliculas, va a ser un listado de peliculas
  bool _cargando = false;

  List<Pelicula> _populares = [];
  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();
  // si yo no pongo el broadcast, esto va a funcionar con un solo listener, es decir solo una persona va a estar escuchando este popularesStream
  // si yo lo dejo con el broadcast puedo tener muchos lugares escuchando la misma vision del stream
  // voy a definir dos getters uno para poder insertar informacion al stream y otro para poder escuchar todo lo que ese stream emita

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add; // para agregar peliculas

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream; // para escuchar esas peliculas

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData =
        json.decode(resp.body); // esto se va a transformar en un mapa
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items; // esto es una coleccion o lista de peliculas
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    // print(peliculas.items[2].title);
    // print(decodedData['results']);
    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];

    _cargando = true;
    _popularesPage++; // incrementa la pagina
    //print('Cargando siguientes...');

    final url = Uri.https(_url, '/3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);
    _populares.addAll(resp);
    popularesSink(_populares);
    _cargando = false;
    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final resp = await http.get(url);
    final decodedData =
        json.decode(resp.body); // toma el body y lo transforma en un mapa, es la respuesta del mapa
    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actores;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query':   query
    });

    // print(peliculas.items[2].title);
    // print(decodedData['results']);
    return await _procesarRespuesta(url);
  }
}
