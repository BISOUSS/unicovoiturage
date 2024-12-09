import 'package:hive/hive.dart';

part 'user.g.dart';  // Ce fichier sera généré après la commande build_runner

@HiveType(typeId: 0)  // Identifiant unique pour le type User
class User {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String password;

  User({required this.name, required this.email, required this.password});
}
