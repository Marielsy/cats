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
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Color(0xFFA28CF6), // lila
            onPrimary: Colors.white,
            secondary: Color(0xFFF9D87A), // amarillo suave
            onSecondary: Colors.black,
            background: Color(0xFFFFE3EF), // rosa claro
            onBackground: Colors.black,
            surface: Color(0xFFE9E9F1), // gris suave
            onSurface: Colors.black,
            error: Colors.red,
            onError: Colors.white,
          ),
          scaffoldBackgroundColor: Color(0xFFFFE3EF), // rosa claro
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFA28CF6), // lila
            foregroundColor: Colors.white,
            elevation: 0,
          ),

          iconTheme: const IconThemeData(color: Color(0xFF7D63C8)), // violeta
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFFA28CF6), // lila
            foregroundColor: Colors.white,
          ),
          textTheme: const TextTheme(
            headlineSmall: TextStyle(
              color: Color(0xFF222222),
              fontWeight: FontWeight.bold,
            ),
            bodyMedium: TextStyle(color: Color(0xFF444444)),
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
