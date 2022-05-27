import 'package:flutter/material.dart';
import 'package:goa/button/round_button.dart';
import 'package:goa/screens/all_models_screen.dart';
import 'package:goa/screens/camera_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String name = "home_screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1B7E81),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RoundButton(
                title: 'Détection en temps réel',
                text:
                    'Cette fonction vous permet d allumer votre caméra et de détecter tout objet que vous pointez avec votre caméra.',
                onPressed: () {
                  Navigator.pushNamed(context, CameraScreen.name);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              RoundButton(
                title: 'Détection classique',
                text:
                    'Dans cette fonction, vous pouvez soit télécharger une image depuis votre stockage local, soit cliquer sur une photo avec votre appareil photo pour détecter tout objet.',
                onPressed: () {
                  Navigator.pushNamed(context, AllModels.name);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
