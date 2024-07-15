import 'package:flutter/material.dart';

class Today extends StatelessWidget {
  Today({super.key, required this.searchText, required this.error});

  String searchText;
  bool error;

  @override
  Widget build(BuildContext context) {
    print(error);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Today', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        Text(searchText, style: TextStyle(color: error ? Colors.red : Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
      ],
    );
  }
}