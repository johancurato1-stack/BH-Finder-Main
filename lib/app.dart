import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bh_finder/core/repositories/repositories/repositories.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/view_models/chat_view_model.dart';

import 'package:bh_finder/shared/widgets/splash/screens/splash_screen.dart';

import 'package:bh_finder/shared/widgets/auth/auth_coordinator.dart';

//============================================================================
//! APP
//============================================================================

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final repositories = Repositories.instance;

    return MultiProvider(
      providers: [
        //======================================================================
        //! CHAT VIEW MODEL
        //======================================================================
        ChangeNotifierProvider(
          create: (_) => ChatViewModel(
            repository: repositories.chatRepository,
            inquiryRepository: repositories.inquiryRepository,
          ),
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: ThemeData(scaffoldBackgroundColor: AppColors.background),

        home: const SplashScreen(destination: AuthCoordinator()),
      ),
    );
  }
}
