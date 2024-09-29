import 'package:flutter/material.dart';
import 'package:honeydo/main.dart';
import 'package:honeydo/providers/audio_player_provider.dart';
import 'package:honeydo/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class DarkModeSwitch extends StatefulWidget {
  const DarkModeSwitch({super.key});

  @override
  DarkModeSwitchState createState() => DarkModeSwitchState();
}

class DarkModeSwitchState extends State<DarkModeSwitch> {
  IconData darkThemeIcon = Icons.nightlight_round_outlined;
  IconData lightThemeIcon = Icons.sunny;
  IconData knobIcon = Icons.nightlight_round_outlined;
  Alignment knobAlignment = Alignment.centerLeft;
  bool switchStatus = true;

  @override
  void initState() {
    super.initState();

    final isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    setState(() {
      switchStatus =
          isDarkMode; // Temaya göre switch'in başlangıç durumunu belirle
      knobIcon = switchStatus ? darkThemeIcon : lightThemeIcon;
      knobAlignment =
          switchStatus ? Alignment.centerLeft : Alignment.centerRight;
    });
  }

  @override
  Widget build(BuildContext context) {
    final playerProvider =
        Provider.of<SoundEffectProvider>(context, listen: false);
    final ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        setState(() {
          switchStatus = !switchStatus; // Switch'i tersine çevir
          knobIcon = switchStatus ? darkThemeIcon : lightThemeIcon;
          knobAlignment =
              switchStatus ? Alignment.centerLeft : Alignment.centerRight;

          Provider.of<ThemeProvider>(context, listen: false).toggleDarkMode();
        });
        isarService.saveThemeData(
            themeProvider.currentThemeIndex, switchStatus);
        playerProvider.playSound(switchStatus ? 'bloop1' : 'bloop4');
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.maxFinite,
        height: double.maxFinite,
        curve: Curves.decelerate,
        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.onSurface, width: 2),
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  darkThemeIcon,
                  size: 20,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  lightThemeIcon,
                  size: 20,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment: knobAlignment,
              curve: Curves.decelerate,
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Icon(
                    knobIcon,
                    size: 20,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
