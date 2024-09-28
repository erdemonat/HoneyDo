import 'package:isar/isar.dart';

part 'volume_model.g.dart';

@Collection()
class VolumeData {
  Id id = 1;

  late double currentProviderSoundValue;
  late double currentSliderValue;
}
