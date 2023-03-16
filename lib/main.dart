import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listview_example/screen/home_screen.dart';

void main() {
  runApp(
    ProviderScope(
      child: const MaterialApp(
        home: Scaffold(
          body: HomeScreen(),
        ),
      ),
    ),
  );
}
