import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cats/features/splash/presentation/splash_screen.dart';
import 'package:cats/features/home/presentation/home_screen.dart';
import 'package:cats/features/breed_detail/presentation/breed_detail_screen.dart';
import 'package:cats/features/voting/presentation/voting_screen.dart';
import 'package:cats/features/home/presentation/home_provider.dart';

class CatApp extends StatelessWidget {
  const CatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        // Otros providers aquí si es necesario
      ],
      child: MaterialApp(
        title: 'Cat Breeds',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
