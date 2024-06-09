
import 'package:flutter/material.dart';
import 'package:geo_trackermap/components/Radio_player.dart';
import 'package:just_audio/just_audio.dart'; // Importa la biblioteca de just_audio

class PodscastScreen extends StatelessWidget {
  final String radioUrl = 'https://stream.live.vc.bbcmedia.co.uk/bbc_world_service'; 
  final AudioPlayer audioPlayer; // Añade el AudioPlayer como un parámetro

   PodscastScreen({required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text('Podcast'), 
      ),
      body: Center(
        child: RadioPlayerComponent(audioPlayer: audioPlayer, radioUrl: radioUrl), // Pasa el audioPlayer al componente de radio
      ),
    );
  }
}
