import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tdah_app/features/ai/presentation/providers/ai_providers.dart';
import 'package:tdah_app/features/auth/presentation/controllers/auth_state_provider.dart';
import 'package:tdah_app/features/tasks/domain/entities/task.dart';
import 'package:tdah_app/features/tasks/presentation/providers/task_providers.dart';

class QuickAddBottomSheet extends ConsumerStatefulWidget {
  const QuickAddBottomSheet({super.key});

  @override
  ConsumerState<QuickAddBottomSheet> createState() => _QuickAddBottomSheetState();
}

class _QuickAddBottomSheetState extends ConsumerState<QuickAddBottomSheet> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  DateTime? _scheduledAt;
  bool _isAILoading = false;

  final List<Map<String, String>> _adhdTemplates = [
    {"title": "Tomar medicación", "desc": "No olvides tu dosis diaria."},
    {"title": "Beber agua", "desc": "La hidratación mejora el enfoque."},
    {"title": "Preparar mochila/bolso", "desc": "Revisa llaves, cartera y móvil."},
    {"title": "Revisar agenda", "desc": "¿Qué tienes que hacer hoy?"},
    {"title": "Guardar llaves", "desc": "Ponlas en su lugar de siempre."},
    {"title": "Limpiar mesa (5 min)", "desc": "Reduce el ruido visual."},
    {"title": "Poner lavadora", "desc": "Gestión de tareas del hogar."},
    {"title": "Hacer la cama", "desc": "Logro completado nada más empezar."},
    {"title": "Pausa de 5 min", "desc": "Reset cognitivo sin pantallas."},
    {"title": "Tirar la basura", "desc": "Mantenimiento del entorno."},
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _applyTemplate(Map<String, String> template) {
    setState(() {
      _titleController.text = template['title']!;
      _descController.text = template['desc']!;
    });
  }

  Future<void> _generateAISteps() async {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Escribe un título para desglosar")),
      );
      return;
    }

    setState(() => _isAILoading = true);

    try {
      final steps = await ref.read(aiRepositoryProvider).breakdownTask(_titleController.text);
      
      final bulletPoints = steps.map((s) => "• $s").join("\n");
      
      setState(() {
        _descController.text = bulletPoints;
        _isAILoading = false;
      });
    } catch (e) {
      setState(() => _isAILoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error de IA: $e")),
        );
      }
    }
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null && mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
        setState(() {
          _scheduledAt = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24, right: 24, top: 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Nueva tarea",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Sugerencias TDAH
          const Text(
            "Sugerencias rápidas:",
            style: TextStyle(fontSize: 14, color: Color(0xFF64748B), fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _adhdTemplates.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                return ActionChip(
                  label: Text(_adhdTemplates[index]['title']!),
                  backgroundColor: const Color(0xFFEFF6FF),
                  labelStyle: const TextStyle(color: Color(0xFF2563EB), fontSize: 13, fontWeight: FontWeight.bold),
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onPressed: () => _applyTemplate(_adhdTemplates[index]),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _titleController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "¿Qué necesitas hacer?",
              filled: true,
              fillColor: const Color(0xFFF1F5F9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _descController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Descripción o pasos (IA)",
              filled: true,
              fillColor: const Color(0xFFF1F5F9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              suffixIcon: _isAILoading 
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : null,
            ),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: _pickDateTime,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_rounded, size: 20, color: Color(0xFF64748B)),
                  const SizedBox(width: 12),
                  Text(
                    _scheduledAt == null 
                        ? "Programar (opcional)" 
                        : DateFormat('dd/MM/yyyy HH:mm').format(_scheduledAt!),
                    style: TextStyle(
                      color: _scheduledAt == null ? const Color(0xFF64748B) : const Color(0xFF0F172A),
                      fontWeight: _scheduledAt == null ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                  if (_scheduledAt != null) ...[
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      onPressed: () => setState(() => _scheduledAt = null),
                    )
                  ]
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _isAILoading ? null : _generateAISteps,
                  icon: const Icon(Icons.auto_awesome),
                  label: Text(_isAILoading ? "Pensando..." : "Desglosar"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_titleController.text.isNotEmpty) {
                      final userId = ref.read(authStateProvider).value?.uid;
                      if (userId == null) return;

                      final newTask = Task(
                        id: '',
                        userId: userId,
                        title: _titleController.text,
                        description: _descController.text,
                        status: 'pending',
                        type: 'task',
                        estimatedMinutes: 5,
                        position: 0,
                        createdAt: DateTime.now(),
                        scheduledAt: _scheduledAt,
                      );

                      await ref.read(tasksRepositoryProvider).create(newTask);
                      if (mounted) Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Guardar"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
