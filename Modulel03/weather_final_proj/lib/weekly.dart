import 'package:flutter/material.dart';
import 'package:weather_final_proj/getWeather.dart';
import 'package:weather_final_proj/main.dart';

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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (widget.selectedCity.lo != 0)
          Text(
              widget.selectedCity.city,
                style: const TextStyle(fontSize: 20, fontWeight:  FontWeight.bold, color: Colors.white),
          ),
        if(isLoading && widget.selectedCity.la != 0)
          const CircularProgressIndicator()
        else if (!isLoading && data.isNotEmpty)
          Container(
            height: 300,
            color: Colors.white,
          ),
          Container(
                width: double.infinity,
                height: 200,
                child: RawScrollbar(
                  trackVisibility: true,
                  trackColor: Colors.blueGrey[900],
                  thumbVisibility: true,
                  trackRadius: const Radius.circular(50),
                  radius: const Radius.circular(20),
                  minThumbLength: 50,
                  thumbColor: Colors.amber[700],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal:  15, vertical: 15),
                          child: (
                            WeatherPerDay(weather: data[index])
                          ),
                        );
                    }),
                  ),
                ),
              ),
            ],
    );
  }
}


class WeatherPerDay extends StatelessWidget {
  WeatherPerDay({super.key, required this.weather});

  Weather weather;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
                weather.time,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
                            Text(
                weather!.description,
                style:const  TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                '${weather!.maxTemperature}°C max',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
              ),
              Text(
                '${weather!.temperature}°C min',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
             
              
        ],     
    );
  }
}
