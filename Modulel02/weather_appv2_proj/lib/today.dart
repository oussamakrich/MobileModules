import 'package:flutter/material.dart';
import 'package:weather_appv2_proj/getWeather.dart';
import 'package:weather_appv2_proj/main.dart';

class Today extends StatefulWidget {
  Today({super.key, required this.selectedCity, required this.error});

  Result selectedCity;
  bool error;

  @override
  State<Today> createState() => _TodayState();
}

class _TodayState extends State<Today> {

  List<Weather> data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchIt();
  }

  @override
  void didUpdateWidget(Today oldWidget) {
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
      List<Weather> res = await getTodayWeather(widget.selectedCity);
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
        else if (!isLoading)
          Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return (
                  WeatherPerHour(weather: data[index])
                );
            }),
          ),
        )
        
      ],
    );
  }
}

class WeatherPerHour extends StatelessWidget {
  WeatherPerHour({super.key, required this.weather});

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
                weather!.description,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                '${weather!.windSpeed} km/h',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
        ],     
    );
  }
}