import 'package:flutter/material.dart';

class Today extends StatelessWidget {
  Today({super.key, required this.searchText});

  String searchText;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Today'),
        Text(searchText),
      ],
    );
  }
}