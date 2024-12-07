import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  const NavBar(
      {Key? key, required this.currentIndex, required this.onTabTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        // Logique de navigation en fonction de l'index
        if (index == 0) {
          Navigator.pushNamed(context, '/'); // Accueil
        } else if (index == 1) {
          Navigator.pushNamed(context, '/My-profil'); // Profil
        } else if (index == 2) {
          Navigator.pushNamed(context, '/My-trips-page'); // Trajets
        } else if (index == 3) {
          Navigator.pushNamed(context, '/Messages'); // Messages
        }

        // Ajoutez d'autres routes si nécessaire
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), label: 'Mes trajets'),
        BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Messages'),
      ],
    );
  }
}
