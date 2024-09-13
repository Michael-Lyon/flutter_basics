import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_practice/mini_providers/hello_provider.dart';
import 'package:riverpod/riverpod.dart';


class HelloWorldWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final helloWorld = ref.watch(helloWorldProvider);
    return Text(
      helloWorld
    );
  }
}