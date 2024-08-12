import 'package:flutter/material.dart';

Widget buildStep(int step, String label, {bool isActive = false}) {
  return Row(
    children: [
      Column(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: isActive ? Colors.teal : Colors.grey[300],
            child: Text(
              '$step',
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      SizedBox(width: 8), // Adds some space between the steps and line
    ],
  );
}
