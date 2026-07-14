import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bh_finder/app.dart';
import 'package:bh_finder/core/providers/bh_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => BhProvider())],

      child: const App(),
    ),
  );
}
