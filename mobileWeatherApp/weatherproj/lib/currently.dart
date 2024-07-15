import 'package:flutter/material.dart';
import 'package:weatherproj/getWeather.dart';
import 'package:weatherproj/main.dart';


class Currently extends StatefulWidget {
  Currently({super.key, required this.selectedCity, required this.error});

  Result selectedCity;
  bool error;

  @override
  State<Currently> createState() => _CurrentlyState();
}

class _CurrentlyState extends State<Currently> {
 
  var data = '';

  @override
  void initState() {
    super.initState();
    fetchIt();
  }


  fetchIt() async{
    if (widget.selectedCity.lo == 0){
      return;
    }
    var res = await getCurrentWeather(widget.selectedCity, 0);
    setState(() {
      if (data == 'error'){
        widget.error = true;
        return;
      }
      data = res;
      print(res);
    });
    
  }
  @override
  Widget build(BuildContext context) {



    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Currently', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
        Text(widget.selectedCity.city, style: TextStyle(color: widget.error ? Colors.red : Colors.black,fontWeight: FontWeight.bold, fontSize: 15),),
      ],
    );
  }
}