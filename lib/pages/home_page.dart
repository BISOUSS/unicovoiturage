import 'package:flutter/material.dart' hide SearchBar;
import '../widgets/app_bar.dart';
import '../widgets/welcome_section.dart';
import '../widgets/search_bar.dart';
import '../widgets/action_buttons.dart';
import '../widgets/trip_list.dart';
import '../widgets/nav_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Index de la page sélectionnée

  final List<Widget> _pages = [
    // Différentes pages que vous souhaitez afficher dans la navigation
    HomePageContent(), // Page d'accueil
    Center(child: Text('Rechercher', style: TextStyle(fontSize: 24))),
    Center(child: Text('Mes Trajets', style: TextStyle(fontSize: 24))),
    Center(child: Text('Messages', style: TextStyle(fontSize: 24))),
    Center(child: Text('Profil', style: TextStyle(fontSize: 24))),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: _pages[
          _selectedIndex], // Affiche la page correspondant à l'onglet sélectionné
      bottomNavigationBar: NavBar(
        currentIndex: _selectedIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }
}

// Contenu spécifique de la page d'accueil
class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  String searchQuery = ''; // Critère de recherche

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),

            WelcomeSection(),
            SearchBar(
              onSearchChanged: (value) {
                setState(() {
                  searchQuery = value
                      .toLowerCase(); // Mettez en minuscule pour une recherche insensible à la casse
                });
              },
            ),
            SizedBox(height: 20),
            ActionButtons(),
            SizedBox(height: 20),
            TripList(
                searchQuery: searchQuery), // Passez le critère de recherche
          ],
        ),
      ),
    );
  }
}
