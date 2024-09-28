import 'package:flutter/material.dart';
import 'package:honeydo/providers/audio_player_provider.dart';
import 'package:honeydo/service/isar_service.dart';
import 'package:provider/provider.dart';

class SoundSlider extends StatefulWidget {
  const SoundSlider({super.key});

  @override
  State<SoundSlider> createState() => _SoundSliderState();
}

class _SoundSliderState extends State<SoundSlider> {
  double _currentSliderValue = 100;
  IsarService isarService = IsarService();

  @override
  void initState() {
    super.initState();
    _loadVolumeData();
  }

  Future<void> _loadVolumeData() async {
    final volumeData = await isarService.getVolumeData();

    if (volumeData != null) {
      setState(() {
        _currentSliderValue = volumeData.currentSliderValue;
      });
      final soundProvider =
          Provider.of<SoundEffectProvider>(context, listen: false);
      soundProvider
          .updateVolume(_sliderToVolume(volumeData.currentSliderValue));
    }
  }

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
                value: _currentSliderValue,
                min: 0,
                max: 100,
                onChanged: (value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                  soundProvider.updateVolume(_sliderToVolume(value));
                  isarService.saveVolumeData(_sliderToVolume(value), value);
                },
              ),
            ),
          ),
        ),
        SizedBox(
          width: 40,
          child: Center(
            child: Text(
              _currentSliderValue.toInt().toString(),
            ),
          ),
        ),
      ],
    );
  }

  IconData _getVolumeIcon() {
    if (_currentSliderValue == 0) {
      return Icons.volume_off;
    } else if (_currentSliderValue > 0 && _currentSliderValue <= 50) {
      return Icons.volume_down;
    } else {
      return Icons.volume_up;
    }
  }

  void _handleIconTap() {
    setState(() {
      if (_currentSliderValue > 0) {
        _currentSliderValue = 0;
      } else {
        _currentSliderValue = 100;
      }
    });
    Provider.of<SoundEffectProvider>(context, listen: false)
        .updateVolume(_sliderToVolume(_currentSliderValue));
    isarService.saveVolumeData(
        _sliderToVolume(_currentSliderValue), _currentSliderValue);
  }

  double _sliderToVolume(double sliderValue) {
    final volume = sliderValue / 200;
    return volume;
  }
}
