import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// Widget personnalisé pour afficher une section du profil
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

// Widget personnalisé pour afficher les détails de l'utilisateur
class ProfileDetail extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileDetail({
    required this.icon,
    required this.label,
    required this.value,
  });

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
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),
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

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, String>> userInfoFuture;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPhoneController = TextEditingController();
  final TextEditingController userUniversityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeUserData();
    userInfoFuture = _loadUserInfo();
  }

  // Initialiser les données utilisateur si elles ne sont pas encore stockées dans Hive
  Future<void> _initializeUserData() async {
    var userBox = await Hive.openBox('userBox');
    if (userBox.get('userName') == null) {
      await userBox.put('userName', 'Manar Khemakhem');
      await userBox.put('userEmail', 'manarkhemakhem@gmail.com');
      await userBox.put('userPhone', '123-456-7890');
      await userBox.put('userUniversity', 'Université ABC');
    }
  }

  // Charger les données utilisateur depuis Hive
  Future<Map<String, String>> _loadUserInfo() async {
    var userBox = await Hive.openBox('userBox');
    String userName = userBox.get('userName', defaultValue: 'Nom non défini');
    String userEmail = userBox.get('userEmail', defaultValue: 'Email non défini');
    String userPhone = userBox.get('userPhone', defaultValue: 'Téléphone non défini');
    String userUniversity = userBox.get('userUniversity', defaultValue: 'Université non définie');

    return {
      'userName': userName,
      'userEmail': userEmail,
      'userPhone': userPhone,
      'userUniversity': userUniversity,
    };
  }

  // Fonction pour mettre à jour les informations utilisateur dans Hive
  Future<void> _updateUserInfo(String key, String value) async {
    var userBox = await Hive.openBox('userBox');
    await userBox.put(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Profil Utilisateur"),
      ),
      body: FutureBuilder<Map<String, String>>(
        future: userInfoFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur de chargement des données'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Aucune donnée disponible'));
          }

          var userInfo = snapshot.data!;

          // Définir les valeurs initiales des contrôleurs
          userNameController.text = userInfo['userName']!;
          userEmailController.text = userInfo['userEmail']!;
          userPhoneController.text = userInfo['userPhone']!;
          userUniversityController.text = userInfo['userUniversity']!;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Affichage de l'image de profil et du nom
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/driver7.png'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          userInfo['userName']!,
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ),
                        SizedBox(height: 5),
                        Text(
                          userInfo['userUniversity']!,
                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  // Section des informations de l'utilisateur
                  ProfileSection(
                    title: "Informations personnelles",
                    children: [
                      ProfileDetail(
                        icon: Icons.email,
                        label: "Email",
                        value: userInfo['userEmail']!,
                      ),
                      ProfileDetail(
                        icon: Icons.phone,
                        label: "Téléphone",
                        value: userInfo['userPhone']!,
                      ),
                      ProfileDetail(
                        icon: Icons.location_city,
                        label: "Université",
                        value: userInfo['userUniversity']!,
                      ),
                      ProfileDetail(
                        icon: Icons.star,
                        label: "Score de Fiabilité",
                        value: "4.8 / 5",
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Section pour modifier les informations
                  ProfileSection(
                    title: "Modifier mes informations",
                    children: [
                      TextField(
                        controller: userNameController,
                        decoration: InputDecoration(labelText: "Nom d'utilisateur"),
                      ),
                      TextField(
                        controller: userEmailController,
                        decoration: InputDecoration(labelText: "Email"),
                      ),
                      TextField(
                        controller: userPhoneController,
                        decoration: InputDecoration(labelText: "Téléphone"),
                      ),
                      TextField(
                        controller: userUniversityController,
                        decoration: InputDecoration(labelText: "Université"),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _updateUserInfo('userName', userNameController.text);
                          _updateUserInfo('userEmail', userEmailController.text);
                          _updateUserInfo('userPhone', userPhoneController.text);
                          _updateUserInfo('userUniversity', userUniversityController.text);
                          setState(() {
                            userInfoFuture = _loadUserInfo(); // Recharger les infos utilisateur
                          });
                        },
                        child: Text("Enregistrer les modifications"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
