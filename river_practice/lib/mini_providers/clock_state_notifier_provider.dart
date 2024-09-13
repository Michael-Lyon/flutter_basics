import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_practice/models/my_clock.dart';

// Note: StateNotifierProvider has *two* type annotations
final clockProvider = StateNotifierProvider<Clock, DateTime>((ref) {
  return Clock();
});
