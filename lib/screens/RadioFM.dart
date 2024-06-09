import 'package:flutter/material.dart';
import 'package:geo_trackermap/components/Radio_player.dart';
import 'package:just_audio/just_audio.dart'; // Importa la biblioteca de just_audio

class RadioFMScreen extends StatelessWidget {
  final String radioUrl = 'https://stream-uk1.radioparadise.com/aac-320';
  final AudioPlayer audioPlayer; // Añade el AudioPlayer como un parámetro

  RadioFMScreen({required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Radio Beta'),
      ),
      body: Center(
        child: RadioPlayerComponent(audioPlayer: audioPlayer, radioUrl: radioUrl), // Pasa el audioPlayer al componente de radio
      ),
    );
  }
}
