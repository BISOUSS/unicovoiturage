import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';

class MyTripsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Mes Trajets"),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple[100]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section des trajets à venir
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Trajets à venir",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple),
                ),
              ),
              SmoothTripCard(
                from: "Ceinture Soukra",
                to: "ISIMS",
                date: "12 Décembre 2024",
                time: "08:00 AM",
                status: "Confirmé",
                price: "8 €",
              ),
              SmoothTripCard(
                from: "CeintureLafran",
                to: "ENETCOM",
                date: "15 Décembre 2024",
                time: "09:30 AM",
                status: "En attente",
                price: "6 €",
              ),
              SmoothTripCard(
                from: "Route Aeroport",
                to: "ISGI",
                date: "03 Décembre 2024",
                time: "07:30 AM",
                status: "Annulé",
                price: "4 €",
              ),
              // Historique des trajets
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Historique des trajets",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple),
                ),
              ),
              SmoothTripCard(
                from: "Centre ville",
                to: "ISIMS",
                date: "10 Novembre 2024",
                time: "08:30 AM",
                status: "Terminé",
                price: "7 €",
              ),
              SmoothTripCard(
                from: "Sfax 2000",
                to: "ENETCOM",
                date: "08 Novembre 2024",
                time: "09:00 AM",
                status: "Terminé",
                price: "5 €",
              ),
              SmoothTripCard(
                from: "Sidi Mansour",
                to: "FSEG",
                date: "01 Novembre 2024",
                time: "08:50 AM",
                status: "Terminé",
                price: "5 €",
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

class SmoothTripCard extends StatelessWidget {
  final String from;
  final String to;
  final String date;
  final String time;
  final String status;
  final String price;

  const SmoothTripCard({
    required this.from,
    required this.to,
    required this.date,
    required this.time,
    required this.status,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          // Action sur clic
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.purple[100],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.directions_car,
                  color: Colors.deepPurple,
                  size: 30,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$from → $to",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.deepPurple),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Date : $date | Heure : $time",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Statut : $status",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: status == "Confirmé"
                            ? Colors.green
                            : (status == "En attente"
                                ? Colors.orange
                                : Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                price,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.purple[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
