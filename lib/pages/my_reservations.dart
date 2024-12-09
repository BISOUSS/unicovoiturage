import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';

class MyReservations extends StatelessWidget {
  final List<Map<String, dynamic>> reservations = [
    {
      'driverName': 'Ahmed Kammoun',
      'driverPhoto': 'assets/driver1.jpg',
      'departureCity': 'Route Soukra',
      'destinationCity': 'ISIMS',
      'price': 10,
      'status': 'Confirmé',
      'estimatedDuration': '25 min',
      'details': 'Départ à 08:15, Wifi disponible, bagage autorisé',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          'Mes Réservations',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: reservations.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              itemCount: reservations.length,
              padding: EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (context, index) {
                final reservation = reservations[index];
                return _buildReservationCard(context, reservation);
              },
            ),
      bottomNavigationBar: NavBar(
        currentIndex: 1,
        onTabTapped: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/my-trips');
          }
        },
      ),
    );
  }

  // Widget pour l'état vide
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today, size: 100, color: Colors.grey[400]),
          SizedBox(height: 20),
          Text(
            'Vous n\'avez pas encore de réservations.',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Widget pour la carte de réservation
  Widget _buildReservationCard(
      BuildContext context, Map<String, dynamic> reservation) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            // Entête avec l'image du conducteur
            Container(
              color: Colors.deepPurpleAccent.withOpacity(0.1),
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(reservation['driverPhoto']),
                    radius: 32,
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reservation['driverName'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Statut : ${reservation['status']}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(height: 1),
            // Contenu des détails
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(Icons.location_on, 'Départ',
                      reservation['departureCity']),
                  _buildDetailRow(Icons.flag, 'Destination',
                      reservation['destinationCity']),
                  _buildDetailRow(Icons.access_time, 'Durée Estimée',
                      reservation['estimatedDuration']),
                  _buildDetailRow(Icons.attach_money, 'Prix',
                      '${reservation['price']} TND'),
                  SizedBox(height: 8),
                  Text(
                    reservation['details'],
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            Divider(height: 1),
            // Bouton d'action
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Annulation de la réservation pour ${reservation['destinationCity']}',
                      ),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                },
                icon: Icon(Icons.cancel, size: 20),
                label: Text('Annuler'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour les détails avec icônes
  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.deepPurpleAccent),
          SizedBox(width: 8),
          Text(
            '$title : ',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
