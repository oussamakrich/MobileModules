import 'package:flutter/material.dart';

class Weekly extends StatelessWidget {
  
  Weekly({super.key, required this.searchText});

  String searchText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Weekly'),
        Text(searchText),
      ],
    );
  }
}