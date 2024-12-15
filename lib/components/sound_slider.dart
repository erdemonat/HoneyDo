import 'package:flutter/material.dart';
import 'package:honeydo/main.dart';
import 'package:honeydo/providers/audio_player_provider.dart';
import 'package:provider/provider.dart';

class SoundSlider extends StatefulWidget {
  const SoundSlider({super.key});

  @override
  State<SoundSlider> createState() => _SoundSliderState();
}

class _SoundSliderState extends State<SoundSlider> {
  @override
  Widget build(BuildContext context) {
    final soundProvider =
        Provider.of<SoundEffectProvider>(context, listen: false);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: _handleIconTap,
          icon: Icon(_getVolumeIcon()),
        ),
        SizedBox(
          width: 142,
          child: Center(
            child: SliderTheme(
              data: SliderThemeData(
                thumbColor: Theme.of(context).colorScheme.tertiary,
                activeTrackColor: Theme.of(context).colorScheme.tertiary,
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 15),
                overlayColor:
                    Theme.of(context).colorScheme.onPrimary.withOpacity(0.1),
                inactiveTrackColor:
                    Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
                thumbShape: const RoundSliderThumbShape(
                  disabledThumbRadius: 0,
                  enabledThumbRadius: 9,
                ),
              ),
              child: Slider(
                value: soundProvider.currentVolume,
                min: 0,
                max: 0.5,
                onChanged: (value) {
                  setState(() {});
                  soundProvider.updateSliderValue(value);
                  isarService.saveVolumeData(context, value);
                },
              ),
            ),
          ),
        ),
        SizedBox(
          width: 40,
          child: Center(
            child: Text(
              (soundProvider.currentVolume * 200).toStringAsFixed(0),
            ),
          ),
        ),
      ],
    );
  }

  IconData _getVolumeIcon() {
    final soundProvider =
        Provider.of<SoundEffectProvider>(context, listen: false);
    if (soundProvider.currentVolume == 0) {
      return Icons.volume_off;
    } else if (soundProvider.currentVolume > 0 &&
        soundProvider.currentVolume <= 0.25) {
      return Icons.volume_down;
    } else {
      return Icons.volume_up;
    }
  }

  void _handleIconTap() {
    final soundProvider =
        Provider.of<SoundEffectProvider>(context, listen: false);
    setState(() {
      if (soundProvider.currentVolume > 0) {
        soundProvider.updateSliderValue(0);
      } else {
        soundProvider.updateSliderValue(0.5);
      }
    });
    isarService.saveVolumeData(context, soundProvider.currentVolume);
  }
}
