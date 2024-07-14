import 'package:flutter/material.dart';

class Currently extends StatelessWidget {
  Currently({super.key, required this.searchText});

  String searchText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Currently'),
        Text(searchText),
      ],
    );
  }
}