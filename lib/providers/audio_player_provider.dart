import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:honeydo/main.dart';

class SoundEffectProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  double _currentVolume = 0.5;
  double get currentVolume => _currentVolume;

  final Map<String, String> _soundEffects = {
    'arcade1': 'sfx/arcade-ui-1.wav',
    'arcade4': 'sfx/arcade-ui-4.wav',
    'bloop1': 'sfx/bloop-1.wav',
    'bloop4': 'sfx/bloop-4.wav',
    'happyPop1': 'sfx/happy-pop-1.wav',
    'happyPop2': 'sfx/happy-pop-2.wav',
    'infoPop1': 'sfx/infographic-pop-1.wav',
    'infoPop2': 'sfx/infographic-pop-2.wav',
    'notificationBeep': 'sfx/notification-beep.wav',
    'pianoOutro': 'sfx/soft-cinematic-piano-outro.wav',
    'pianoIntro': 'sfx/soft-piano-logo.wav',
  };

  Future<void> playSound(String audioId) async {
    try {
      await _audioPlayer.stop();

      await _audioPlayer.play(AssetSource(_soundEffects[audioId]!), mode: PlayerMode.lowLatency, volume: _currentVolume);
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

  Future<void> updateSliderValue(double sliderValue) async {
    _currentVolume = sliderValue;
    notifyListeners();
  }

  Future<void> loadVolumeData() async {
    final volumeData = await isarService.getVolumeData();
    _currentVolume = volumeData!.currentVolume;
    updateVolume(volumeData.currentVolume);
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
