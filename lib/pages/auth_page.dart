import 'package:flutter/material.dart';
import 'home_page.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
        _buildTextField('Email', Icons.email_outlined),
        SizedBox(height: 15),
        _buildTextField('Mot de passe', Icons.lock_outline, isPassword: true),
        SizedBox(height: 20),
        _buildAuthButton('Se Connecter', context),
      ],
    );
  }

  // Formulaire Sign Up
  Widget _buildSignUpForm(BuildContext context) {
    return Column(
      children: [
        _buildTextField('Nom complet', Icons.person_outline),
        SizedBox(height: 15),
        _buildTextField('Email', Icons.email_outlined),
        SizedBox(height: 15),
        _buildTextField('Mot de passe', Icons.lock_outline, isPassword: true),
        SizedBox(height: 15),
        _buildTextField('Confirmer le mot de passe', Icons.lock_outline,
            isPassword: true),
        SizedBox(height: 20),
        _buildAuthButtonForSignUp('Créer un Compte', context),
      ],
    );
  }

  // Champs de texte fins et modernes
  Widget _buildTextField(String hint, IconData icon,
      {bool isPassword = false}) {
    return TextField(
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
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
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
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
          // Rediriger vers l'onglet Connexion
          _tabController.animateTo(0);
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
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }
}
