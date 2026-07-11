import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'package:bh_finder/core/provider/bh_provider.dart'; // Make sure this path is correct

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BhProvider(),
      child: const App(),
    ),
  );
}
