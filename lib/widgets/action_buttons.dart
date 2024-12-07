import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // Naviguer vers l'ajout de trajet
            Navigator.pushNamed(context, '/add-Trip');
          },
          icon: Icon(Icons.add),
          label: Text('Ajouter un Trajet'),
        ),
        ElevatedButton.icon(
          onPressed: () {
             Navigator.pushNamed(context, '/My-reservations');
          },
          icon: Icon(Icons.bookmark),
          label: Text('Mes Réservations'),
        ),
      ],
    );
  }
}
