import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/home_provider.dart';
import '../widgets/current_task_card.dart';
import '../widgets/next_task_card.dart';
import '../widgets/daily_progress_widget.dart';
import '../widgets/quick_add_fab.dart';
import '../widgets/empty_home_state.dart';

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
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.all(24),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          const Text(
                            "Hola 👋",
                            style: TextStyle(
                              fontSize: 18, 
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF64748B)
                            ),
                          ),
                          const SizedBox(height: 8),
                          DailyProgressWidget(
                            completed: state.completedTasks,
                            total: state.totalTasks,
                            progress: state.progress,
                          ),
                          const SizedBox(height: 40),
                          CurrentTaskCard(task: state.currentTask!),
                          if (state.nextTask != null) ...[
                            const SizedBox(height: 32),
                            NextTaskCard(task: state.nextTask!),
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
}
