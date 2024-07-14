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


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String DisplayedText = "Some Text";

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
                child: Text(DisplayedText, style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (DisplayedText == 'Some Text'){
                      DisplayedText = 'Hello World!';
                    }
                    else{
                      DisplayedText = 'Some Text';
                    }
                  });                  
                },
                child: const Text('Click Me!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}