import 'package:flutter/material.dart';
import 'quick_add_bottom_sheet.dart';

class QuickAddFab extends StatelessWidget {
  const QuickAddFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        builder: (_) => const QuickAddBottomSheet(),
      ),
      backgroundColor: const Color(0xFF2563EB),
      foregroundColor: Colors.white,
      icon: const Icon(Icons.add, size: 28),
      label: const Text("Añadir tarea", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }
}
