import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class WelcomeSection extends StatefulWidget {
  @override
  _WelcomeSectionState createState() => _WelcomeSectionState();
}

class _WelcomeSectionState extends State<WelcomeSection> {
  late String userName = ''; // Variable pour stocker le nom de l'utilisateur.

  @override
  void initState() {
    super.initState();
    _loadUserName(); // Charger le nom dès le début
  }

  // Fonction pour charger le nom de l'utilisateur à partir de Hive.
  _loadUserName() async {
    var box = await Hive.openBox('userBox');
    setState(() {
      userName = box.get('userName', defaultValue: 'Invité'); // Si le nom est inexistant, utiliser 'Invité'.
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: AlwaysStoppedAnimation(1), // On n'a pas besoin d'animation ici.
      child: Center(
        // Centrer tout le contenu
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centrer verticalement
          crossAxisAlignment: CrossAxisAlignment.center, // Centrer horizontalement
          children: [
            Text(
              'Bienvenue, $userName !', // Utiliser le nom dynamique de l'utilisateur.
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              'Où voulez-vous aller aujourd’hui ?',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/welcome.png', // Assurez-vous que le chemin est correct
              height: 150,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
