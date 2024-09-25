import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SoundEffectProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final Map<String, String> _soundEffects = {
    'copperBell1': 'sfx/copper-bell-ding-1.mp3',
    'copperBell3': 'sfx/copper-bell-ding-3.mp3',
    'copperBell5': 'sfx/copper-bell-ding-5.mp3',
    'copperBell6': 'sfx/copper-bell-ding-6.mp3',
    'copperBell8': 'sfx/copper-bell-ding-8.mp3',
    'copperBell10': 'sfx/copper-bell-ding-10.mp3',
    'copperBell12': 'sfx/copper-bell-ding-12.mp3',
    'copperBell13': 'sfx/copper-bell-ding-13.mp3',
    'doorClosing': 'sfx/door-closing.mp3',
    'bellsLogo': 'sfx/bells-logo.mp3',
    'gameBonus': 'sfx/game-bonus.mp3',
    'softClick': 'sfx/interface-soft-click.mp3',
    'levelPassed': 'sfx/level-passed.mp3',
    'levelUp': 'sfx/level-up.mp3',
    'logoTransparent': 'sfx/logo-transparent.mp3',
    'newNotification': 'sfx/new-notification.mp3',
    'newPositiveNotice': 'sfx/new-positive-notice.mp3',
    'notification': 'sfx/notification-2.mp3',
    'schoolBell': 'sfx/school-bell.mp3'
  };

  Future<void> playSound(String audioId) async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(_soundEffects[audioId]!), volume: 0.3);
    } catch (e) {
      // Hata işleme
      print("Sound effect failed to play: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
