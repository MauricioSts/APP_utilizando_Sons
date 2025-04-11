class Game {
  String titulo;

  Game(this.titulo);

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(json["external"] ?? "sem titulo");
  }
}
