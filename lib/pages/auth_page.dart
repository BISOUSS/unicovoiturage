import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'home_page.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Box userBox;

  // Contrôleurs de texte distincts pour chaque champ
  final TextEditingController _usernameController = TextEditingController(); // Nom complet
  final TextEditingController _emailController = TextEditingController(); // Email pour la connexion
  final TextEditingController _passwordController = TextEditingController(); // Mot de passe pour la connexion

  final TextEditingController _signUpEmailController = TextEditingController(); // Email pour l'inscription
  final TextEditingController _signUpPasswordController = TextEditingController(); // Mot de passe pour l'inscription
  final TextEditingController _signUpConfirmPasswordController = TextEditingController(); // Confirmer le mot de passe

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Ouvrir la box Hive pour stocker l'utilisateur
    Hive.openBox('userBox').then((box) {
      setState(() {
        userBox = box;
      });
    });
  }

  @override
  void dispose() {
    // Libérer les contrôleurs pour éviter les fuites de mémoire
    _tabController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _signUpEmailController.dispose();
    _signUpPasswordController.dispose();
    _signUpConfirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Fond dégradé
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.orangeAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHeader(),
                SizedBox(height: 20),
                _buildFormContainer(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Section Header avec image et titre
  Widget _buildHeader() {
    return Column(
      children: [
        Image.asset(
          'assets/welcome.png',
          height: 120,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 10),
        Text(
          'UniCovoiturage',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  // Conteneur avec les onglets et les formulaires
  Widget _buildFormContainer(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        constraints: BoxConstraints(maxHeight: 380),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildTabBar(),
            SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(child: _buildSignInForm(context)),
                  SingleChildScrollView(child: _buildSignUpForm(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TabBar minimaliste
  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: Colors.deepPurpleAccent,
      labelColor: Colors.deepPurpleAccent,
      unselectedLabelColor: Colors.grey,
      labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      tabs: [
        Tab(text: 'Connexion'),
        Tab(text: 'Inscription'),
      ],
    );
  }

  // Formulaire Sign In
  Widget _buildSignInForm(BuildContext context) {
    return Column(
      children: [
        _buildTextField(_emailController, 'Email', Icons.email_outlined),
        SizedBox(height: 15),
        _buildTextField(_passwordController, 'Mot de passe', Icons.lock_outline, isPassword: true),
        SizedBox(height: 20),
        _buildAuthButton('Se Connecter', context),
      ],
    );
  }

  // Formulaire Sign Up
  Widget _buildSignUpForm(BuildContext context) {
    return Column(
      children: [
        _buildTextField(_usernameController, 'Nom complet', Icons.person_outline),
        SizedBox(height: 15),
        _buildTextField(_signUpEmailController, 'Email', Icons.email_outlined),
        SizedBox(height: 15),
        _buildTextField(_signUpPasswordController, 'Mot de passe', Icons.lock_outline, isPassword: true),
        SizedBox(height: 15),
        _buildTextField(_signUpConfirmPasswordController, 'Confirmer le mot de passe', Icons.lock_outline, isPassword: true),
        SizedBox(height: 20),
        _buildAuthButtonForSignUp('Créer un Compte', context),
      ],
    );
  }

  // Champs de texte fins et modernes
  Widget _buildTextField(TextEditingController controller, String hint, IconData icon, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.deepPurpleAccent),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }

  // Bouton pour Sign In
  Widget _buildAuthButton(String label, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          String email = _emailController.text;
          String password = _passwordController.text;

          // Vérification des informations de connexion avec Hive
          String? storedPassword = userBox.get(email);
          if (storedPassword != null && storedPassword == password) {
            // Connexion réussie
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          } else {
            // Afficher un message d'erreur
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Identifiants incorrects")));
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurpleAccent,
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }

  // Bouton pour Sign Up qui redirige vers Connexion
  Widget _buildAuthButtonForSignUp(String label, BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {
        String username = _usernameController.text; // Récupérer le nom d'utilisateur
        String email = _signUpEmailController.text;
        String password = _signUpPasswordController.text;
        String confirmPassword = _signUpConfirmPasswordController.text;

        // Vérifier si les mots de passe correspondent
        if (password == confirmPassword) {
          // Ouvrir la box Hive pour enregistrer les informations
          userBox.put(email, password); // Utiliser l'email comme clé et le mot de passe comme valeur

          // Sauvegarder aussi le nom d'utilisateur
          userBox.put('userName', username); // Sauvegarder le nom d'utilisateur

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Compte créé avec succès")));
          _tabController.animateTo(0); // Rediriger vers l'onglet de connexion
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Les mots de passe ne correspondent pas")));
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurpleAccent,
        padding: EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    ),
  );
}
}