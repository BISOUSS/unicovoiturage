import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';

class MessagesPage extends StatelessWidget {
  final List<Map<String, String>> messages = [
    {
      'senderName': 'Ahmed Kammoun',
      'senderPhoto': 'assets/driver1.jpg',
      'lastMessage': 'Bonjour, êtes-vous disponible pour demain ?',
      'time': '08:45',
      'unread': '2',
    },
    {
      'senderName': 'Manar Khmekhem',
      'senderPhoto': 'assets/driver2.jpg',
      'lastMessage': 'Je serai en retard de 10 minutes.',
      'time': 'Hier',
      'unread': '0',
    },
    {
      'senderName': 'Camille Moreau',
      'senderPhoto': 'assets/driver3.png',
      'lastMessage': 'Merci pour le covoiturage !',
      'time': 'Lundi',
      'unread': '1',
    },
    {
      'senderName': 'Ali Jlassi',
      'senderPhoto': 'assets/driver4.png',
      'lastMessage': 'J\'arrive dans 5 minutes.',
      'time': '10:30',
      'unread': '0',
    },
    {
      'senderName': 'Rania Saidi',
      'senderPhoto': 'assets/driver5.png',
      'lastMessage': 'Est-ce que la place est toujours libre ?',
      'time': '09:15',
      'unread': '3',
    },
    {
      'senderName': 'Sami Ben Youssef',
      'senderPhoto': 'assets/driver6.png',
      'lastMessage': 'Merci encore pour hier !',
      'time': 'Jeudi',
      'unread': '0',
    },
    {
      'senderName': 'Hela Zouari',
      'senderPhoto': 'assets/driver7.png',
      'lastMessage': 'C\'est confirmé pour demain matin.',
      'time': '12:00',
      'unread': '1',
    },
    {
      'senderName': 'Mohamed Trabelsi',
      'senderPhoto': 'assets/driver8.png',
      'lastMessage': 'Je peux prendre votre bagage si besoin.',
      'time': '14:20',
      'unread': '0',
    },
    {
      'senderName': 'Salma Kallel',
      'senderPhoto': 'assets/driver2.jpg',
      'lastMessage': 'Je serai prête à l\'heure convenue.',
      'time': 'Hier',
      'unread': '1',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Action de recherche
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: messages.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              itemCount: messages.length,
              padding: EdgeInsets.only(top: 10),
              itemBuilder: (context, index) {
                final message = messages[index];
                return _buildMessageTile(context, message);
              },
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

  // Widget pour l'état vide
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.mark_chat_unread_outlined,
              size: 120, color: Colors.grey[400]),
          SizedBox(height: 16),
          Text(
            'Aucun message pour le moment',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  // Widget pour chaque message
  Widget _buildMessageTile(BuildContext context, Map<String, String> message) {
    bool hasUnread = message['unread'] != '0';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(message['senderPhoto']!),
            ),
            if (hasUnread)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    message['unread']!,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          message['senderName']!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.deepPurpleAccent,
          ),
        ),
        subtitle: Text(
          message['lastMessage']!,
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          message['time']!,
          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
        ),
        onTap: () {
          // Action lorsqu'un message est cliqué
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Ouverture de la conversation avec ${message['senderName']}'),
            ),
          );
        },
      ),
    );
  }
}
