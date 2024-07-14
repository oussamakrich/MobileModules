import 'package:ex00/my_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}

class Button {

  Button({required this.onPressed, required this.text, required this.textColor, required this.backColor});

  String text;
  Color textColor;
  Color backColor;
  VoidCallback onPressed;
}
  
List<Button> buttons = [
    Button(onPressed: () {}, text: '', textColor: Colors.green, backColor:const Color.fromARGB(255, 72, 71, 71)),
    Button(onPressed: () {}, text: '', textColor: Colors.green, backColor:const Color.fromARGB(255, 72, 71, 71)),
    Button(onPressed: () {}, text: 'C', textColor: Colors.red, backColor:const Color.fromARGB(255, 72, 71, 71)),
    Button(onPressed: () {}, text: 'AC', textColor: Colors.red, backColor:const Color.fromARGB(255, 72, 71, 71)),
    Button(onPressed: () {}, text: '7', textColor: Colors.white, backColor:const Color.fromARGB(255, 49, 49, 49)),
    Button(onPressed: () {}, text: '8', textColor: Colors.white, backColor:const Color.fromARGB(255, 49, 49, 49)),
    Button(onPressed: () {}, text: '9', textColor: Colors.white, backColor:const Color.fromARGB(255, 49, 49, 49)),
    Button(onPressed: () {}, text: '*', textColor: Colors.green, backColor:const Color.fromARGB(255, 72, 71, 71)),
    Button(onPressed: () {}, text: '4', textColor: Colors.white, backColor:const Color.fromARGB(255, 49, 49, 49)),
    Button(onPressed: () {}, text: '5', textColor: Colors.white, backColor:const Color.fromARGB(255, 49, 49, 49)),
    Button(onPressed: () {}, text: '6', textColor: Colors.white, backColor:const Color.fromARGB(255, 49, 49, 49)),
    Button(onPressed: () {}, text: '-', textColor: Colors.green, backColor:const Color.fromARGB(255, 72, 71, 71)),
    Button(onPressed: () {}, text: '1', textColor: Colors.white, backColor:const Color.fromARGB(255, 49, 49, 49)),
    Button(onPressed: () {}, text: '2', textColor: Colors.white, backColor:const Color.fromARGB(255, 49, 49, 49)),
    Button(onPressed: () {}, text: '3', textColor: Colors.white, backColor:const Color.fromARGB(255, 49, 49, 49)),
    Button(onPressed: () {}, text: '+', textColor: Colors.green, backColor:const Color.fromARGB(255, 72, 71, 71)),
    Button(onPressed: () {}, text: '0', textColor: Colors.white, backColor:const Color.fromARGB(255, 49, 49, 49)),
    Button(onPressed: () {}, text: '.', textColor: Colors.white, backColor:const Color.fromARGB(255, 49, 49, 49)),
    Button(onPressed: () {}, text: '/', textColor: Colors.white, backColor:const Color.fromARGB(255, 49, 49, 49)),
    Button(onPressed: () {}, text: '=', textColor: Colors.white, backColor: Colors.green),
  ];

class Home extends StatefulWidget {
  
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

String updateText(String text, String lastText){
    if (text == '=')
      return lastText;
    if (text == 'AC'){
      return '';
    }
    else if(text == 'C'){
      if (text.isNotEmpty){
        return lastText.substring(0, lastText.length - 1);
      }
    }
    else if ('*-+/'.contains(text)){
      if ('*-+/'.contains(lastText[lastText.length - 1])){
        return lastText.substring(0, lastText.length - 1) + text;
      }
      else
        return lastText += text;
    }
    else
      return lastText += text;
      
    return '';
                
}

String claculate(String expression){
  try{
    Parser parser = Parser();
    Expression exp = parser.parse(expression);
    ContextModel cm = ContextModel();
    double result = exp.evaluate(EvaluationType.REAL, cm);
    if (expression.contains('.')) {
      return result.toString();
    } else {
      return result % 1 == 0 ? result.toInt().toString() : result.toString();
    }
  }
  catch (e) {
    return 'Error';
  }
}

class _HomeState extends State<Home> {

  String EntredText = '';
  String Result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
        title: const Text('Calcuator'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(EntredText,maxLines: 1 , overflow: TextOverflow.ellipsis ,style: const TextStyle(color: Colors.white, fontSize: 30)),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(Result, style: const TextStyle(color: Colors.white, fontSize: 30)),
            ),
            const Spacer(),
           Expanded(
            flex: 3,
             child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                itemCount: buttons.length,
                itemBuilder: (context, index) =>  MyButton(button: buttons[index], onPressed: () => setState(() {
                  String text = buttons[index].text;
                  EntredText = updateText(text, EntredText);
                  if (text == 'AC'){
                    Result = '';
                  }
                  else if (text == '='){
                    Result = claculate(EntredText);
                  }
                })
                ,),    
              ),
           ),
          ],
        ),
      ),
    );
  }
}