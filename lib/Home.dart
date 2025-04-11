import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:app_utilizando_sons/Game.dart'; // importa sua classe Game
import 'package:app_utilizando_sons/Api.dart'; // importa getGame()

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AudioPlayer audioPlayer = AudioPlayer();
  List<Game> jogos = []; // <- lista de jogos
  double volume = 0.5;

  _executar() async {
    await audioPlayer.play(AssetSource("audios/musica.mp3"));
  }

  _pausar() async {
    await audioPlayer.stop();
  }

  _parar() async {
    await audioPlayer.pause();
  }

  @override
  void initState() {
    super.initState();
    carregarJogos(); // <- chama ao iniciar
  }

  void carregarJogos() async {
    final response = await getGame();

    if (response != null) {
      setState(() {
        jogos = response;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Player de Áudio")),
      body: Column(
        children: [
          Slider(
            value: volume,
            min: 0,
            max: 1,
            onChanged: (novoVolume) {
              setState(() {
                volume = novoVolume;
              });
              audioPlayer.setVolume(novoVolume);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  _executar();
                },
                child: Image.asset("assets/imagens/executar.png"),
              ),
              TextButton(
                onPressed: () {
                  _pausar();
                },
                child: Image.asset("assets/imagens/pausar.png"),
              ),

              TextButton(
                onPressed: () {
                  _parar();
                },
                child: Image.asset("assets/imagens/parar.png"),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "Jogos encontrados:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: jogos.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(jogos[index].titulo));
              },
            ),
          ),
        ],
      ),
    );
  }
}
