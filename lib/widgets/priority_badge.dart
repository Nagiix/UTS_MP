import 'package:flutter/material.dart';

Color priorityColor(String priority) {
  if (priority == "Tinggi") {
    return Colors.red;
  }
  if (priority == "Sedang") {
    return Colors.orange;
  }
  return Colors.green;
}

class PriorityBadge extends StatelessWidget {
  final String priority;

  const PriorityBadge({required this.priority});

  @override
  Widget build(BuildContext context) {
    final color = priorityColor(priority);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        priority,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
