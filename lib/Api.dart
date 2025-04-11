import 'dart:convert';

import 'package:app_utilizando_sons/Game.dart';
import 'package:http/http.dart' as http;

void main() async {
  final jogos = await getGame();

  for (var jogo in jogos) {
    print(jogo.titulo);
  }
}

Future getGame() async {
  final cliente = http.Client();

  try {
    final uri = Uri.parse(
      "https://www.cheapshark.com/api/1.0/games?title=batman",
    );

    final response = await cliente.get(uri);

    final jsonData = jsonDecode(response.body);

    return (jsonData as List).map((item) => Game.fromJson(item)).toList();
  } catch (e) {
    print("erro na api: $e");
    return [];
  }
}
