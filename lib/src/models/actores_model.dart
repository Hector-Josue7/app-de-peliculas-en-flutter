// Generated by https://quicktype.io

// Se utilizo el snippet de Paste JSON as code, para llegar a el pulsar ctrl + shift +p y escribir eso en la barra de busqueda
// el objeto raiz se llama Respuesta
// voy a necesitar un metodo para recibir la información en un mapa y asignar cada una de las propiedades del mapa a las propiedades de la clase
// a su vez crear una instancia de mi clase actor

// si tengo varios actores necesito algo para agruparlosp
class Cast {
  List<Actor> actores = [];  // coleccion de actores

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return; // si viene nulo no hace nada

    jsonList.forEach((item) {
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
    });
  }
}

class Actor {
  // este modelo es para manejar a un solo actor, para manejarlos de manera independiente
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    this.castId = json['cast_id'];
    this.character = json['character'];
    this.creditId = json['credit_id'];
    this.gender = json['gender'];
    this.id = json['id'];
    this.name = json['name'];
    this.order = json['order'];
    this.profilePath = json['profile_path'];
  }

  getFoto() {
    if (profilePath == null) {
      return 'https://www.kindpng.com/picc/m/22-223863_no-avatar-png-circle-transparent-png.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
