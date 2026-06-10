import 'package:flutter/material.dart';

class DailyProgressWidget extends StatelessWidget {
  final int completed;
  final int total;
  final double progress;

  const DailyProgressWidget({
    super.key, 
    required this.completed, 
    required this.total, 
    required this.progress
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$completed de $total tareas completadas",
          style: const TextStyle(
            fontSize: 24, 
            fontWeight: FontWeight.bold, 
            color: Color(0xFF0F172A)
          ),
        ),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 12,
            backgroundColor: const Color(0xFFE2E8F0),
            color: const Color(0xFF22C55E),
          ),
        ),
      ],
    );
  }
}
