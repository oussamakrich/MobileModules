import 'package:flutter/material.dart';
import 'package:weatherproj/main.dart';

class Weekly extends StatelessWidget {
  
  Weekly({super.key, required this.selectedCity,required this.error});

  Result selectedCity;
  bool error;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Weekly', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        Text(selectedCity.city, style: TextStyle(color: error ? Colors.red : Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
      ],
    );
  }
}