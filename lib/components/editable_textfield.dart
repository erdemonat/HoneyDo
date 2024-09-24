import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:honeydo/providers/weather_provider.dart';
import 'package:provider/provider.dart';

import '../model/editable_textfield_model.dart';

class EditableTextField extends StatefulWidget {
  final ListModel model;
  final Function(ListModel listModel)? onChanged;
  final String hintText;
  final int maxLength;

  const EditableTextField({
    super.key,
    required this.model,
    this.onChanged,
    required this.hintText,
    required this.maxLength,
  });

  @override
  _EditableTextFieldState createState() => _EditableTextFieldState();
}

class _EditableTextFieldState extends State<EditableTextField> {
  late ListModel model;
  bool _isEditingMode = false;
  late TextEditingController _titleEditingController;
  late TextEditingController _subTitleEditingController;

  @override
  void initState() {
    super.initState();
    model = widget.model;
    _titleEditingController = TextEditingController(text: model.title);
    _subTitleEditingController = TextEditingController(text: model.subTitle);
  }

  @override
  void dispose() {
    _titleEditingController.dispose();
    _subTitleEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        model.title,
        style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.secondary),
      ),
      subtitle: _isEditingMode
          ? _subTitleTextField
          : Text(
              model.subTitle,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
      trailing: _isEditingMode ? _saveButton : _editButton,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  Widget get _subTitleTextField {
    return TextField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(widget.maxLength),
        LowerCaseNoSpaceFormatter(),
      ],
      controller: _subTitleEditingController,
      style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.75)),
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.tertiary.withOpacity(0.4)),
        hintText: widget.hintText,
      ),
    );
  }

  Widget get _editButton {
    return IconButton(
      icon: Icon(
        Icons.edit,
        color: Theme.of(context).colorScheme.secondary,
      ),
      onPressed: _toggleEditMode,
    );
  }

  Widget get _saveButton {
    return IconButton(
      icon: Icon(
        Icons.check,
        color: Theme.of(context).colorScheme.secondary,
      ),
      onPressed: _saveChanges,
    );
  }

  void _toggleEditMode() {
    setState(() {
      _isEditingMode = !_isEditingMode;
    });
  }

  void _saveChanges() {
    setState(() {
      model.subTitle = _subTitleEditingController.text;

      _isEditingMode = false;
    });

    Provider.of<WeatherProvider>(context, listen: false).changeCity(model.subTitle);
    Provider.of<WeatherProvider>(context, listen: false).updateWeatherData();
  }
}

class LowerCaseNoSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(' ', '%20').toLowerCase();

    return TextEditingValue(
      text: newText,
      selection: newValue.selection.copyWith(
        baseOffset: newText.length,
        extentOffset: newText.length,
      ),
    );
  }
}
