import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:honeydo/main.dart';

class SoundEffectProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  double _currentVolume = 0.5;
  double get currentVolume => _currentVolume;

  final Map<String, String> _soundEffects = {
    'bloop1': 'sfx/bloop-1.wav',
    'bloop4': 'sfx/bloop-4.wav',
    'happyPop1': 'sfx/happy-pop-1.wav',
    'happyPop2': 'sfx/happy-pop-2.wav',
    'infoPop1': 'sfx/infographic-pop-1.wav',
    'infoPop2': 'sfx/infographic-pop-2.wav',
    'marimbaWin1': 'sfx/marimba-win-a-1.wav',
    'marimbaWin2': 'sfx/marimba-win-a-2.wav',
    'marimbaWin3': 'sfx/marimba-win-a-3.wav',
    'marimbaWin4': 'sfx/marimba-win-b-1.wav',
    'marimbaWin5': 'sfx/marimba-win-b-2.wav',
    'marimbaWin6': 'sfx/marimba-win-b-3.wav',
    'marimbaWin7': 'sfx/marimba-win-c-1.wav',
    'marimbaWin8': 'sfx/marimba-win-c-2.wav',
    'marimbaWin9': 'sfx/marimba-win-c-3.wav',
    'marimbaWin10': 'sfx/marimba-win-d-1.wav',
    'marimbaWin11': 'sfx/marimba-win-d-2.wav',
    'marimbaWin12': 'sfx/marimba-win-d-3.wav',
    'marimbaWin13': 'sfx/marimba-win-e-1.wav',
    'marimbaWin14': 'sfx/marimba-win-e-2.wav',
    'marimbaWin15': 'sfx/marimba-win-e-3.wav',
    'marimbaWin16': 'sfx/marimba-win-f-1.wav',
    'marimbaWin17': 'sfx/marimba-win-f-2.wav',
    'marimbaWin18': 'sfx/marimba-win-f-3.wav',
    'marimbaWin19': 'sfx/marimba-win-g-1.wav',
    'marimbaWin20': 'sfx/marimba-win-g-2.wav',
    'marimbaWin21': 'sfx/marimba-win-g-3.wav',
    'marimbaWin22': 'sfx/marimba-win-h-1.wav',
    'marimbaWin23': 'sfx/marimba-win-h-2.wav',
    'marimbaWin24': 'sfx/marimba-win-h-3.wav',
    'marimbaWin25': 'sfx/marimba-win-i-1.wav',
    'marimbaWin26': 'sfx/marimba-win-i-2.wav',
    'multiPop2': 'sfx/multi-pop-2.wav',
    'multiPop3': 'sfx/multi-pop-3.wav',
    'multiPop4': 'sfx/multi-pop-4.wav',
    'multiPop5': 'sfx/multi-pop-5.wav',
    'multiPop6': 'sfx/multi-pop-6.wav',
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
