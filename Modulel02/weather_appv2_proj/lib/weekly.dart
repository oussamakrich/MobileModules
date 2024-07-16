import 'package:flutter/material.dart';
import 'package:weather_appv2_proj/getWeather.dart';
import 'package:weather_appv2_proj/main.dart';

class Weekly extends StatefulWidget {
  
  Weekly({super.key, required this.selectedCity,required this.error});

  Result selectedCity;
  bool error;

  @override
  State<Weekly> createState() => _WeeklyState();
}

class _WeeklyState extends State<Weekly> {

  List<Weather> data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchIt();
  }

  @override
  void didUpdateWidget(Weekly oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedCity != oldWidget.selectedCity) {
      fetchIt();
    }
  }

  fetchIt() async{
    setState(() {
      isLoading = false;
    });
    if (widget.selectedCity.lo == 0){
      return;
    }
    try{
      List<Weather> res = await getWeeklyWeather(widget.selectedCity);
      setState(() {
        data = res;
        isLoading = false;
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
        if (widget.selectedCity.lo != 0)
          Text(
              'City: ${widget.selectedCity.city}',
                style: const TextStyle(fontSize: 15),
          ),
        if(isLoading && widget.selectedCity.la != 0)
          const CircularProgressIndicator()
        else if (!isLoading && data.isNotEmpty)
          Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return (
                  WeatherPerDay(weather: data[index])
                );
            }),
          ),
        )
      ],
    );
  }
}


class WeatherPerDay extends StatelessWidget {
  WeatherPerDay({super.key, required this.weather});

  Weather weather;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
                weather.time,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                '${weather!.temperature}°C',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                '${weather!.maxTemperature}',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                weather!.description,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
        ],     
    );
  }
}