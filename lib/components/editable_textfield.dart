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
  EditableTextFieldState createState() => EditableTextFieldState();
}

class EditableTextFieldState extends State<EditableTextField> {
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
        style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.4)),
      ),
      subtitle: _isEditingMode
          ? _subTitleTextField
          : SizedBox(
              height: 48,
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  model.subTitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
            ),
      trailing: _isEditingMode ? _saveButton : _editButton,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  Widget get _subTitleTextField {
    return SizedBox(
      height: 48,
      child: TextField(
        autofocus: true,
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.maxLength),
        ],
        controller: _subTitleEditingController,
        style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.tertiary),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.tertiary.withOpacity(0.4)),
          hintText: widget.hintText,
        ),
      ),
    );
  }

  Widget get _editButton {
    return IconButton(
      icon: Icon(
        Icons.edit,
        color: Theme.of(context).colorScheme.tertiary,
      ),
      onPressed: _toggleEditMode,
    );
  }

  Widget get _saveButton {
    return IconButton(
      icon: Icon(
        Icons.check,
        color: Theme.of(context).colorScheme.tertiary,
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

    String formattedCity = model.subTitle.replaceAll(' ', '%20').toLowerCase();

    Provider.of<WeatherProvider>(context, listen: false).changeCity(formattedCity);
    Provider.of<WeatherProvider>(context, listen: false).updateWeatherData(context, repeat: false);
  }
}
