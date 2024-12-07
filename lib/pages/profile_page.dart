import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Profil Utilisateur"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Bannière utilisateur
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                          'assets/driver7.png'), // Remplacez par une vraie image
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Yessmine Benamar",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Étudiant - ISIMS",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Informations utilisateur
              ProfileSection(
                title: "Informations personnelles",
                children: [
                  ProfileDetail(
                      icon: Icons.email,
                      label: "Email",
                      value: "yessmine.benamar@example.com"),
                  ProfileDetail(
                      icon: Icons.phone,
                      label: "Téléphone",
                      value: "+216 98 123 456"),
                  ProfileDetail(
                      icon: Icons.location_city,
                      label: "Université",
                      value: "ISIMS"),
                  ProfileDetail(
                      icon: Icons.star,
                      label: "Score de Fiabilité",
                      value: "4.8 / 5"),
                ],
              ),
              SizedBox(height: 20),

              // Historique et préférences
              ProfileSection(
                title: "Préférences et Historique",
                children: [
                  ProfileDetail(
                      icon: Icons.history,
                      label: "Trajets effectués",
                      value: "25"),
                  ProfileDetail(
                      icon: Icons.music_note,
                      label: "Préférences musicales",
                      value: "Oui"),
                  ProfileDetail(
                      icon: Icons.pets,
                      label: "Animaux acceptés",
                      value: "Non"),
                  ProfileDetail(
                      icon: Icons.smoking_rooms, label: "Fumeur", value: "Non"),
                ],
              ),
              SizedBox(height: 20),

              // Actions
              ProfileSection(
                title: "Actions",
                children: [
                  ProfileAction(
                    icon: Icons.edit,
                    label: "Modifier mes informations",
                    onTap: () {
                      // Naviguer vers l'édition du profil
                    },
                  ),
                  ProfileAction(
                    icon: Icons.logout,
                    label: "Déconnexion",
                    onTap: () {
                      // Déconnecter l'utilisateur
                    },
                  ),
                  ProfileAction(
                    icon: Icons.delete,
                    label: "Supprimer mon compte",
                    onTap: () {
                      // Confirmer et supprimer le compte
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(
        currentIndex:
            1, // Indiquez l'onglet actif (par exemple, 1 pour AddTripPage)
        onTabTapped: (index) {
          // Gérer la navigation entre les onglets
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/'); // Retour à HomePage
          } else if (index == 1) {
            // Reste sur AddTripPage
          } else if (index == 2) {
            // Naviguer vers une autre page
            Navigator.pushReplacementNamed(context, '/my-trips');
          }
        },
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ProfileSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple[700]),
          ),
          SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}

class ProfileDetail extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileDetail(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.purple[700]),
          SizedBox(width: 10),
          Text(
            "$label : ",
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.grey[600]),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ProfileAction(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: Colors.purple[700]),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                  color: Colors.purple[700], fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
