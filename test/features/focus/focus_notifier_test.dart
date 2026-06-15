import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdah_app/features/focus/presentation/providers/focus_provider.dart';

void main() {
  group('FocusNotifier Tests with ProviderContainer', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('Initial state is correct', () {
      final state = container.read(focusProvider('123'));
      expect(state.taskId, '123');
      expect(state.isRunning, false);
      expect(state.remainingTime.inMinutes, 25);
    });

    test('startTimer updates isRunning to true', () {
      container.read(focusProvider('123').notifier).startTimer();
      final state = container.read(focusProvider('123'));
      expect(state.isRunning, true);
    });

    test('stopTimer updates isRunning to false', () {
      final notifier = container.read(focusProvider('123').notifier);
      notifier.startTimer();
      notifier.stopTimer();
      final state = container.read(focusProvider('123'));
      expect(state.isRunning, false);
    });
  });
}
