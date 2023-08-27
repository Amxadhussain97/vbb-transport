import 'package:flutter/material.dart';
import 'package:vbb_transport/src/features/favourite/favorite_page.dart';
import 'package:vbb_transport/src/features/home/home_screen.dart';
import 'package:vbb_transport/src/utiles/routes.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
        ),
        useMaterial3: true,
      ),
      // home: const HomeScreen(),
      routes: {
        '/': (context) => const HomeScreen(),
        MyRoutes.favoritesRoute: (context) => const FavoritePage(),
      },
    );
  }
}
