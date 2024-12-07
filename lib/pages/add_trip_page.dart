import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/app_bar.dart';
import '../widgets/nav_bar.dart';
import 'dart:io';

class AddTripPage extends StatefulWidget {
  @override
  _AddTripPageState createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  final _formKey = GlobalKey<FormState>();
  String? driverName;
  String? departureCity;
  String? destinationCity;
  DateTime? tripDate;
  TimeOfDay? departureTime;
  int? availableSeats;
  double? price;
  String? details;
  File? driverPhoto;

  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        driverPhoto = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nom du conducteur',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    driverName = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer le nom du conducteur.';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16),
                // Departure City
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Ville de départ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    departureCity = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer une ville de départ.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Destination City
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Ville de destination',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    destinationCity = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer une ville de destination.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Date Picker
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: tripDate == null
                        ? 'Date du trajet'
                        : '${tripDate!.day}/${tripDate!.month}/${tripDate!.year}',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        tripDate = pickedDate;
                      });
                    }
                  },
                  validator: (value) {
                    if (tripDate == null) {
                      return 'Veuillez sélectionner une date.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Time Picker
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: departureTime == null
                        ? 'Heure de départ'
                        : '${departureTime!.hour}:${departureTime!.minute}',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: Icon(Icons.access_time),
                  ),
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        departureTime = pickedTime;
                      });
                    }
                  },
                  validator: (value) {
                    if (departureTime == null) {
                      return 'Veuillez sélectionner une heure.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Available Seats
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    labelText: 'Places disponibles',
                    border: OutlineInputBorder(),
                  ),
                  value: availableSeats,
                  items: List.generate(8, (index) => index + 1)
                      .map((e) => DropdownMenuItem<int>(
                            value: e,
                            child: Text('$e'),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() {
                    availableSeats = value!;
                  }),
                ),
                SizedBox(height: 16),

                // Price
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Prix par passager (€)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    price = double.tryParse(value);
                  },
                  validator: (value) {
                    if (value == null || double.tryParse(value) == null) {
                      return 'Veuillez entrer un prix valide.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Details
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Détails supplémentaires (optionnel)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  maxLines: 3,
                  onChanged: (value) {
                    details = value;
                  },
                ),
                SizedBox(height: 20),
// Driver Photo
                Row(
                  children: [
                    GestureDetector(
                      onTap: _pickImage, // Méthode pour sélectionner une image
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: driverPhoto == null
                            ? Icon(
                                Icons.camera_alt,
                                size: 50,
                                color: Colors.grey,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  driverPhoto!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        driverPhoto == null
                            ? 'Aucune photo sélectionnée'
                            : 'Photo ajoutée avec succès',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          driverPhoto != null) {
                        // Save or submit trip data
                        print('Trajet ajouté avec succès !');
                        print('Nom du conducteur : $driverName');
                        print('Photo : ${driverPhoto!.path}');
                      } else if (driverPhoto == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Veuillez ajouter une photo.')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    ),
                    child: Text(
                      'Ajouter Trajet',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
}
