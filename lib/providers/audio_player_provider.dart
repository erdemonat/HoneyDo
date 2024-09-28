import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SoundEffectProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  double _currentVolume = 0.5;
  double get currentVolume => _currentVolume;

  final Map<String, String> _soundEffects = {
    'arcade1': 'sfx/arcade-ui-1.mp3',
    'arcade4': 'sfx/arcade-ui-4.mp3',
    'arcade18': 'sfx/arcade-ui-18.mp3',
    'bloop1': 'sfx/bloop-1.mp3',
    'bloop4': 'sfx/bloop-4.mp3',
    'happyPop1': 'sfx/happy-pop-1.mp3',
    'happyPop2': 'sfx/happy-pop-2.mp3',
    'softClick': 'sfx/interface-soft-click.mp3',
    'levelUp3': 'sfx/level-up-3.mp3',
    'levelUp': 'sfx/level-up.mp3',
    'minimalPop4': 'sfx/minimal-pop-click-ui-4.mp3',
    'notificationBeep': 'sfx/notification-beep.mp3',
    'pianoOutro': 'sfx/soft-cinematic-piano-outro.mp3',
    'pianoIntro': 'sfx/soft-piano-logo.mp3'
  };

  Future<void> playSound(String audioId) async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(_soundEffects[audioId]!),
          volume: _currentVolume);
    } catch (e) {
      print("Sound effect failed to play: $e");
    }
  }

  Future<void> updateVolume(double volume) async {
    _currentVolume = volume;
    try {
      await _audioPlayer.setVolume(volume);
    } catch (e) {
      print("Failed to update volume: $e");
    }
    notifyListeners();
  }
  

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
