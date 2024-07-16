import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_final_proj/getWeather.dart';
import 'package:weather_final_proj/main.dart';



class Currently extends StatefulWidget {
  Currently({super.key, required this.selectedCity, required this.error});

  Result selectedCity;
  bool error;

  @override
  State<Currently> createState() => _CurrentlyState();
}

class _CurrentlyState extends State<Currently> {
 
  late Weather data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchIt();
  }

  @override
  void didUpdateWidget(Currently oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedCity != oldWidget.selectedCity) {
      fetchIt();
    }
  }

  fetchIt() async{
    setState(() {
      isLoading = true;
    });
    if (widget.selectedCity.lo == 0){
      return;
    }
    try{
      var res = await getCurrentWeather(widget.selectedCity, 0);
      setState(() {
        data = res;
        isLoading = false;
        // print(data);
      });
    }
    catch (e){
        widget.error = true;
    }
  }

  @override
  Widget build(BuildContext context) {
  return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading && widget.selectedCity.la != 0)
         const  CircularProgressIndicator()
        else if (isLoading && widget.selectedCity.la == 0)
          const Text(
                'Currently',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              )
        else if (widget.error)
          const Text(
            'Error fetching data',
            style: TextStyle(color: Colors.red, fontSize: 15),
          )
        else
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.selectedCity.city,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    '${data!.temperature}°C',
                    style: TextStyle(fontSize: 30, color: Colors.amber[700]),
                  ),
                  
                  Column(
                    children: [
                      Text(
                        data!.description,
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const Icon(Icons.sunny, color: Colors.blue, size: 50,),
                    ],
                  ),
              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(CupertinoIcons.wind,color: Colors.blue,),
                      const SizedBox(width: 10),
                      Text(
                        '${data!.windSpeed} km/h',
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}