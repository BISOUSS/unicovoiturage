import 'package:flutter/material.dart';

import '../pages/reservation_page.dart';

class TripList extends StatelessWidget {
  final String searchQuery; // Critère de recherche
  TripList({required this.searchQuery});

  List<Map<String, dynamic>> trips = [
    {
      'driverName': 'Ahmed kammoun',
      'driverPhoto': 'assets/driver1.jpg',
      'departureCity': 'Route soukra',
      'destinationCity': 'ISIMS',
      'price': 10,
      'availableSeats': 3,
      'rating': 4.8,
      'estimatedDuration': '25 min',
      'details': 'Départ à 08:15, Wifi disponible, bagage autorisé'
    },
    {
      'driverName': 'Manar Khmekhem',
      'driverPhoto': 'assets/driver2.jpg',
      'departureCity': 'Route lafran',
      'destinationCity': 'ENETCOM',
      'price': 15,
      'availableSeats': 4,
      'rating': 4.7,
      'estimatedDuration': '15 min',
      'details': 'Départ à 09:00, silence préféré, climatisation'
    },
    {
      'driverName': 'Camille Moreau',
      'driverPhoto': 'assets/driver3.png',
      'departureCity': 'Montpellier',
      'destinationCity': 'Université de Montpellier',
      'price': 8,
      'availableSeats': 2,
      'rating': 4.6,
      'estimatedDuration': '30 min',
      'details': 'Départ à 07:45, musique autorisée, bagage léger accepté'
    },
    {
      'driverName': 'Louis Garnier',
      'driverPhoto': 'assets/driver4.png',
      'departureCity': 'Lyon',
      'destinationCity': 'Université Claude Bernard Lyon 1',
      'price': 12,
      'availableSeats': 3,
      'rating': 4.9,
      'estimatedDuration': '20 min',
      'details': 'Départ à 10:30, boisson offerte, véhicule électrique'
    },
    {
      'driverName': 'Emma Durand',
      'driverPhoto': 'assets/driver5.png',
      'departureCity': 'Toulouse',
      'destinationCity': 'Université Toulouse Jean Jaurès',
      'price': 10,
      'availableSeats': 4,
      'rating': 4.5,
      'estimatedDuration': '35 min',
      'details': 'Départ à 08:00, non-fumeur, silence préféré'
    },
    {
      'driverName': 'Hugo Lambert',
      'driverPhoto': 'assets/driver6.png',
      'departureCity': 'Bordeaux',
      'destinationCity': 'Université de Bordeaux',
      'price': 9,
      'availableSeats': 3,
      'rating': 4.4,
      'estimatedDuration': '30 min',
      'details': 'Départ à 09:45, climatisation, animal de compagnie accepté'
    },
    {
      'driverName': 'Chloé Petit',
      'driverPhoto': 'assets/driver7.png',
      'departureCity': 'Nantes',
      'destinationCity': 'Université de Nantes',
      'price': 8,
      'availableSeats': 4,
      'rating': 4.6,
      'estimatedDuration': '25 min',
      'details': 'Départ à 07:30, Wifi disponible, bagage autorisé'
    },
    {
      'driverName': 'Lucas Dubois',
      'driverPhoto': 'assets/driver8.png',
      'departureCity': 'Strasbourg',
      'destinationCity': 'Université de Strasbourg',
      'price': 11,
      'availableSeats': 2,
      'rating': 4.7,
      'estimatedDuration': '40 min',
      'details': 'Départ à 10:00, musique autorisée, bagage autorisé'
    },
  ];

  Widget build(BuildContext context) {
    final filteredTrips = trips.where((trip) {
      final destination = trip['destinationCity'].toLowerCase();
      final price = trip['price'].toString();
      return destination.contains(searchQuery) || price.contains(searchQuery);
    }).toList(); // Filtrez les trajets

    return ListView.builder(
      shrinkWrap: true, // Adapte la hauteur à son parent
      physics:
          NeverScrollableScrollPhysics(), // Désactive le défilement interne
      itemCount: filteredTrips.length,
      itemBuilder: (context, index) {
        final trip = filteredTrips[index];
        return TripCard(trip: trip);
      },
    );
  }
}

class TripCard extends StatefulWidget {
  final Map<String, dynamic> trip;

  const TripCard({Key? key, required this.trip}) : super(key: key);

  @override
  _TripCardState createState() => _TripCardState();
}

class _TripCardState extends State<TripCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final trip = widget.trip;
    return GestureDetector(
      onTap: () {
        print(
            'Trip selected: ${trip['departureCity']} → ${trip['destinationCity']}');
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? Colors.deepPurple.withOpacity(0.2)
                    : Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
            border: _isHovered
                ? Border.all(color: Colors.deepPurple, width: 1.5)
                : Border.all(color: Colors.transparent),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Photo et Informations principales
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(trip['driverPhoto']),
                    radius: 30,
                  ),
                  SizedBox(width: 16),
                  // Nom du conducteur + ville de départ → destination
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trip['driverName'], // Nom du conducteur
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${trip['departureCity']} → ${trip['destinationCity']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Durée estimée : ${trip['estimatedDuration']}',
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  // Prix
                  Text(
                    '${trip['price']} €',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Places disponibles et Note
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.people, color: Colors.deepPurple),
                      SizedBox(width: 4),
                      Text('${trip['availableSeats']} places disponibles'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orangeAccent),
                      SizedBox(width: 4),
                      Text('${trip['rating']} / 5'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Détails supplémentaires (affichés uniquement lors du survol)
              if (_isHovered)
                Text(
                  trip['details'],
                  style: TextStyle(color: Colors.deepPurple),
                ),

              SizedBox(height: 16),
              // Bouton Réserver
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReservationPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.deepOrangeAccent, // Couleur du bouton
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Coins arrondis
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: Text(
                    'Réserver',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
