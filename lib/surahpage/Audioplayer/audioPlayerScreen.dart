import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerScreen extends StatefulWidget {
  final String audioUrl;
  final List<String> audioSecondary;

  const AudioPlayerScreen({
    super.key,
    required this.audioUrl,
    required this.audioSecondary,
  });

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playPrimaryAudio() async {
    try {
      await _audioPlayer.setUrl(widget.audioUrl);
      _audioPlayer.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future<void> playSecondaryAudio(int index) async {
    try {
      await _audioPlayer.setUrl(widget.audioSecondary[index]);
      _audioPlayer.play();
    } catch (e) {
      print("Error playing secondary audio: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: playPrimaryAudio,
            child: const Text("Play Primary Audio"),
          ),
          ...List.generate(widget.audioSecondary.length, (index) {
            return ElevatedButton(
              onPressed: () => playSecondaryAudio(index),
              child: Text("Play Secondary Audio ${index + 1}"),
            );
          }),
          ElevatedButton(
            onPressed: () => _audioPlayer.pause(),
            child: const Text("Pause Audio"),
          ),
        ],
      ),
    );
  }
}
