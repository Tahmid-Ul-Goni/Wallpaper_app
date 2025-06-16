import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:wallpaper_project/Splash_screen.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  runApp(const MyApp());
}

Future<void> initializeFirebase() async {
  try {
    await Firebase.initializeApp();
    debugPrint("Firebase Initialized Successfully!");
  } catch (e) {
    debugPrint("Firebase Initialization Failed");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase App',
      theme: ThemeData(
        scaffoldBackgroundColor:Colors.blueGrey,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
            iconSize: 30,
        )
      ),
      home: SplashScreen(),
    );
  }
}

