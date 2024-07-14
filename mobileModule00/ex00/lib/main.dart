import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[600],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.lightGreen[800]),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal:5),
                child: const Text('Some text', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {print('Button pressed!');},
                child: const Text('Click Me!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}