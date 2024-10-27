import 'package:flutter/material.dart';

class TaskTextField extends StatelessWidget {
  final TextEditingController? textcontroller;
  final void Function()? onPressed;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTaskMealToggle;
  final IconData taskMealIcon;
  final String hintext;

  const TaskTextField({
    super.key,
    this.textcontroller,
    this.onPressed,
    this.onTaskMealToggle,
    required this.taskMealIcon,
    required this.hintext,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted,
        controller: textcontroller,
        decoration: InputDecoration(
          hoverColor: Theme.of(context).colorScheme.secondary,
          focusColor: Theme.of(context).colorScheme.tertiary,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Theme.of(context).colorScheme.surface),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 1.2),
          ),
          prefixIcon: IconButton(
            onPressed: onTaskMealToggle,
            icon: Icon(taskMealIcon),
          ),
          suffixIcon: IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.add),
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          hintText: hintext,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4)),
        ),
      ),
    );
  }
}
