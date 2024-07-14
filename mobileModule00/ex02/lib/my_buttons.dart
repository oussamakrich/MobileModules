import 'package:ex00/main.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  const MyButton({super.key, required this.button});

  final Button button;


  @override
  Widget build(BuildContext context) {

    double fontSize = 30;
    if (button.text.length > 1){
      fontSize = 20;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
            backgroundColor: WidgetStatePropertyAll(button.backColor),
            alignment: Alignment.center
          ),
          child: Text(button.text, style: TextStyle(color: button.textColor,fontWeight: FontWeight.w400 ,fontSize: fontSize),),
        ),
      ),
    );
  }
}