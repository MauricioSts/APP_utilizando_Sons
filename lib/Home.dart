import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AudioPlayer audioPlayer = AudioPlayer();

  _executar() async {
    await audioPlayer.play(AssetSource("audios/musica.mp3"));
  }

  _pausar() async {
    await audioPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Player de Áudio")),
      body: Center(
        child: ElevatedButton(
          onPressed: _executar,
          onLongPress: _pausar,
          child: const Text("Tocar Música (Segure para Pausar)"),
        ),
      ),
    );
  }
}
