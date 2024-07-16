import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_final_proj/getWeather.dart';
import 'package:weather_final_proj/main.dart';

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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (widget.selectedCity.lo != 0)
          Text(
              widget.selectedCity.city,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        if(isLoading && widget.selectedCity.la != 0)
          const CircularProgressIndicator()
        else if (!isLoading)
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
                            WeatherPerHour(weather: data[index])
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

class WeatherPerHour extends StatelessWidget {
  WeatherPerHour({super.key, required this.weather});

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
                style:const  TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              Text(
                '${weather!.temperature}°C',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.amber[700]),
              ),
              Row(
                children: [
                  const Icon(CupertinoIcons.wind, color: Colors.blue,),
                  const SizedBox(width: 5),
                  Text(
                    '${weather!.windSpeed} km/h',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
        ],     
    );
  }
}