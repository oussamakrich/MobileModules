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
                style: TextStyle(fontSize: 15),
              )
        else if (widget.error)
          const Text(
            'Error fetching data',
            style: TextStyle(color: Colors.red, fontSize: 15),
          )
        else
          Column(
            children: [
              Text(
                'City: ${widget.selectedCity.city}',
                style: const TextStyle(fontSize: 15),
              ),
              Text(
                'Temperature: ${data!.temperature}°C',
                style: const TextStyle(fontSize: 15),
              ),
              Text(
                'Description: ${data!.description}',
                style: const TextStyle(fontSize: 15),
              ),
              Text(
                'Wind Speed: ${data!.windSpeed} km/h',
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
      ],
    );
  }
}