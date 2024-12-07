import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/add_trip_page.dart';
import 'pages/my_reservations.dart';
import 'pages/profile_page.dart';
import 'pages/My_trips_page.dart';
import 'pages/reservation_page.dart';
import 'pages/messages_page.dart';
import 'pages/auth_page.dart';

void main() {
  runApp(CarpoolingApp());
}

class CarpoolingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UniCarpool',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AuthPage(),
        '/home': (context) => HomePage(),
        '/add-Trip': (context) => AddTripPage(),
        '/My-reservations': (context) => MyReservations(),
        '/My-profil': (context) => ProfilePage(),
        '/My-trips-page': (context) => MyTripsPage(),
        '/Reservation': (context) => ReservationPage(),
        '/Messages': (context) => MessagesPage(),
      },
    );
  }
}
