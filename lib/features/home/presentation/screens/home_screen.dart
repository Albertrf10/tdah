import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tdah_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:tdah_app/features/home/presentation/providers/home_provider.dart';
import 'package:tdah_app/features/home/presentation/widgets/current_task_card.dart';
import 'package:tdah_app/features/home/presentation/widgets/next_task_card.dart';
import 'package:tdah_app/features/home/presentation/widgets/daily_progress_widget.dart';
import 'package:tdah_app/features/home/presentation/widgets/quick_add_fab.dart';
import 'package:tdah_app/features/home/presentation/widgets/empty_home_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeAsync = ref.watch(homeStateProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: homeAsync.when(
          data: (state) => state.isEmpty 
              ? const EmptyHomeState()
              : CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.all(24),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          FadeInEntry(
                            delay: Duration.zero,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Hola 👋",
                                      style: TextStyle(
                                        fontSize: 18, 
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF64748B)
                                      ),
                                    ),
                                    Text(
                                      "Tu enfoque de hoy",
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: const Color(0xFFE2E8F0)),
                                  ),
                                  child: IconButton(
                                    onPressed: () => context.push('/achievements'),
                                    icon: const Icon(Icons.emoji_events_outlined, color: Color(0xFFF59E0B)),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: const Color(0xFFE2E8F0)),
                                  ),
                                  child: IconButton(
                                    onPressed: () => _showLogoutDialog(context, ref),
                                    icon: const Icon(Icons.logout_rounded, color: Color(0xFFEF4444)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          FadeInEntry(
                            delay: const Duration(milliseconds: 200),
                            child: DailyProgressWidget(
                              completed: state.completedTasks,
                              total: state.totalTasks,
                              progress: state.progress,
                              active: state.activeTasksCount,
                              inactive: state.inactiveTasksCount,
                            ),
                          ),
                          if (state.currentTask != null)
                            FadeInEntry(
                              delay: const Duration(milliseconds: 400),
                              child: CurrentTaskCard(task: state.currentTask!),
                            ),
                          if (state.nextTask != null) ...[
                            const SizedBox(height: 32),
                            FadeInEntry(
                              delay: const Duration(milliseconds: 600),
                              child: NextTaskCard(task: state.nextTask!),
                            ),
                          ],
                        ]),
                      ),
                    ),
                  ],
                ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text("Error: $e")),
        ),
      ),
      floatingActionButton: const QuickAddFab(),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text("¿Cerrar sesión?"),
        content: const Text("¿Estás seguro de que quieres salir de FocusFlow?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar", style: TextStyle(color: Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authControllerProvider.notifier).logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
              minimumSize: const Size(100, 40),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("Salir"),
          ),
        ],
      ),
    );
  }
}

class FadeInEntry extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const FadeInEntry({super.key, required this.child, required this.delay});

  @override
  State<FadeInEntry> createState() => _FadeInEntryState();
}

class _FadeInEntryState extends State<FadeInEntry> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slide = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart),
    );

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}
