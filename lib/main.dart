import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bh_finder/app.dart';
import 'package:bh_finder/core/providers/boarding_house_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BoardingHouseProvider()),
      ],

      child: const App(),
    ),
  );
}
