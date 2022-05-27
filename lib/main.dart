import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:goa/screens/all_models_screen.dart';
import 'package:goa/screens/animation.dart';
import 'package:goa/screens/camera_screen.dart';
import 'package:goa/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GOA APP',
      theme: ThemeData.light().copyWith(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.teal.shade400,
        ),
      ),
      // home: AnimationScreen(),
      initialRoute: AnimationScreen.name,
      routes: {
        HomeScreen.name: (context) => const HomeScreen(),
        CameraScreen.name: (context) => const CameraScreen(),
        AllModels.name: (context) => const AllModels(),
        AnimationScreen.name: (context) => AnimationScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
