import 'package:flutter/material.dart';

class Weekly extends StatelessWidget {
  
  Weekly({super.key, required this.searchText,required this.error});

  String searchText;
  bool error;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Weekly', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        Text(searchText, style: TextStyle(color: error ? Colors.red : Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
      ],
    );
  }
}