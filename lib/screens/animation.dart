import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:goa/cards/page_card.dart';
import 'package:goa/data/page_data.dart';
import 'package:goa/screens/all_models_screen.dart';
import 'package:goa/screens/camera_screen.dart';

Color _blue = const Color(0xFF457b9d);
Color _yellow = const Color(0xFFfca311);
Color _white = const Color(0xFFf1faee);

class AnimationScreen extends StatelessWidget {
  static const String name = "animation_screen";

  final List<PageData> pages = [
    PageData(
        icon: Icons.nature_people_rounded,
        title: "Détection en temps réel",
        textColor: Colors.white,
        bgColor: _yellow,
        logoColor: _yellow,
        cardColor: _white,
        screen: CameraScreen.name,
        subtitle:
            'Détectez les objets en temps réel en pointant votre caméra vers le sujet.'),
    PageData(
        icon: Icons.add_a_photo_rounded,
        title: "Cliquez et détectez",
        textColor: Colors.grey.shade700,
        bgColor: _white,
        logoColor: _white,
        cardColor: _yellow,
        screen: AllModels.name,
        subtitle:
            'Cliquez sur une photo de votre appareil photo pour détecter les objets.'),
    PageData(
        icon: Icons.image,
        title: "Charger et détecter",
        textColor: Colors.white,
        bgColor: _blue,
        logoColor: _blue,
        cardColor: _white,
        screen: AllModels.name,
        subtitle:
            'Chargez les images de votre galerie pour détecter les objets'),
  ];

  AnimationScreen({Key? key}) : super(key: key);

  List<Color> get colors => pages.map((p) => p.bgColor).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: colors,
        radius: 40,
        curve: Curves.ease,
        duration: const Duration(seconds: 2),
        // itemCount: 1,
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (index) {
          PageData page = pages[index % pages.length];
          return Container(
            child: Theme(
              data: ThemeData(
                textTheme: TextTheme(
                  headline6: TextStyle(
                    color: page.textColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Helvetica',
                    letterSpacing: 0.0,
                    fontSize: 23,
                  ),
                  subtitle2: TextStyle(
                    color: page.textColor,
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                  ),
                ),
              ),
              child: PageCard(page: page),
            ),
          );
        },
      ),
    );
  }
}
