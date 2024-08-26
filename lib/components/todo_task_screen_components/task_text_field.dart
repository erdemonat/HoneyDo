import 'package:flutter/material.dart';

class TaskTextField extends StatelessWidget {
  final TextEditingController? textcontroller;
  final void Function()? onPressed;

  const TaskTextField({
    super.key,
    this.textcontroller,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: TextFormField(
        controller: textcontroller,
        decoration: InputDecoration(
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
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          hintText: "Yapılacak bir şey ekle",
          hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.3)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}