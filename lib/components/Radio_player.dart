import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

class RadioPlayerComponent extends StatefulWidget {
  final String radioUrl;
  final AudioPlayer audioPlayer; // Añade el AudioPlayer como un parámetro

  const RadioPlayerComponent({Key? key, required this.radioUrl, required this.audioPlayer}) : super(key: key);

  @override
  RadioPlayerComponentState createState() => RadioPlayerComponentState();
}

class RadioPlayerComponentState extends State<RadioPlayerComponent> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    widget.audioPlayer.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await widget.audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(widget.radioUrl)));
      widget.audioPlayer.play();
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<IcyMetadata?>(
              stream: widget.audioPlayer.icyMetadataStream,
              builder: (context, snapshot) {
                final metadata = snapshot.data;
                final title = metadata?.info?.title ?? '';
                final url = metadata?.info?.url;
                return Column(
                  children: [
                    if (url != null)
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.network(url),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(title,
                          style: Theme.of(context).textTheme.headline6),
                    ),
                  ],
                );
              },
            ),
            ControlButtons(widget.audioPlayer),
          ],
        ),
      ),
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 10.0,
                height: 10.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Icons.pause),
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay),
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
      ],
    );
  }
}
