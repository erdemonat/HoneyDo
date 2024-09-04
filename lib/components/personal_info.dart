import 'package:flutter/material.dart';
import 'package:honeydo/main.dart';
import 'package:honeydo/model/task_model.dart';

class PersonalInfoDialog extends StatefulWidget {
  const PersonalInfoDialog({super.key});

  @override
  _PersonalInfoDialogState createState() => _PersonalInfoDialogState();
}

class _PersonalInfoDialogState extends State<PersonalInfoDialog> {
  final TextEditingController _ageController =
      TextEditingController(text: "25");
  final TextEditingController _weightController =
      TextEditingController(text: "70");
  final TextEditingController _heightController =
      TextEditingController(text: "170");

  String _selectedGender = 'Erkek';
  String _selectedActivityLevel = 'Orta';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1E1E2C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title:
          const Text('Kişisel Bilgiler', style: TextStyle(color: Colors.white)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Yaş',
                labelStyle: const TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white38),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Kilo (kg)',
                labelStyle: const TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white38),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _heightController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Boy (cm)',
                labelStyle: const TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white38),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: _selectedGender,
              items: ['Erkek', 'Kadın']
                  .map((gender) => DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      ))
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedGender = newValue!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Cinsiyet',
                labelStyle: const TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white38),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              dropdownColor: const Color(0xFF1E1E2C),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: _selectedActivityLevel,
              items: [
                'Hareketsiz',
                'Hafif',
                'Orta',
                'Aktif',
                'Yoğun',
              ].map((String activity) {
                return DropdownMenuItem<String>(
                  value: activity,
                  child: Text(activity),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedActivityLevel = newValue!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Aktivite Seviyesi',
                labelStyle: const TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white38),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              dropdownColor: const Color(0xFF1E1E2C),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('İptal Et', style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: () async {
            await _savePersonalInfo();

            Navigator.of(context).pop();
          },
          child: const Text('Tamamla', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Future<void> _savePersonalInfo() async {
    final personalInfo = PersonalInfo()
      ..id = 1
      ..age = int.parse(_ageController.text)
      ..height = double.parse(_heightController.text)
      ..weight = double.parse(_weightController.text)
      ..gender = _selectedGender
      ..activityLevel = _selectedActivityLevel;

    await isar!.writeTxn(
      () async {
        await isar!.personalInfos.put(personalInfo);
      },
    );
  }
}
