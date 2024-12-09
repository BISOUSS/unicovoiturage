import 'package:flutter/material.dart';
import '../pages/my_reservations.dart';

class ReservationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Détails de la Réservation',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header - Carte Conducteur
          _buildDriverCard(),
          SizedBox(height: 20),
          // Contenu des détails du trajet
          _buildTripDetailsCard(),
          Spacer(),
          // Bouton Réserver
          _buildReservationButton(context),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDriverCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16).copyWith(top: 40),
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/driver1.jpg'),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ahmed Kammoun',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 18),
                  SizedBox(width: 4),
                  Text(
                    '4.8 ★',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Conducteur professionnel',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTripDetailsCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildDetailRow(Icons.location_on, 'Départ', 'Route Soukra',
                Colors.orangeAccent),
            Divider(),
            _buildDetailRow(Icons.flag, 'Destination', 'ISIMS', Colors.green),
            Divider(),
            _buildDetailRow(Icons.access_time, 'Durée Estimée', '25 min',
                Colors.deepPurpleAccent),
            Divider(),
            _buildDetailRow(Icons.event_seat, 'Places Disponibles', '3',
                Colors.orangeAccent),
            Divider(),
            _buildDetailRow(Icons.attach_money, 'Prix', '10 TND', Colors.green),
            SizedBox(height: 12),
            Text(
              'Départ à 08:15, Wifi disponible, bagage autorisé.',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      IconData icon, String title, String value, Color color) {
    return Row(
      children: [
        Icon(icon, color: color),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget _buildReservationButton(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyReservations()));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrangeAccent, // Bouton vert
          padding: EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Réserver Maintenant',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
