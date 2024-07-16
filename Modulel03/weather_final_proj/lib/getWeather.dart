import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:weather_final_proj/main.dart';
import 'package:http/http.dart' as http;

Map<int, String> codes = {0 : 'Clear sky',1 : 'Mainly clear', 2 : 'partly cloudy', 3 : 'overcast',45 : 'Fog', 48 :'depositing rime fog',
    51 : 'Drizzle: Light', 53 : 'moderate', 55 :	'dense intensity',
    56 : 'Freezing Drizzle: Light', 57 : "dense intensity",
    61 : 'Rain: Slight', 63 : 'moderate', 65 : 'heavy intensity',
    66 : 'Freezing Rain: Light', 67 : 'heavy intensity',
    71 : 'Snow fall: Slight', 73 : 'moderate', 75 :'heavy intensity',
    77 :	'Snow grains',
    80 : 'Rain showers: Slight', 81 : 'moderate', 82 :'violent',
    85 : 'Snow showers slight', 86 : 'heavy',
    95 : 	'Thunderstorm: Slight',
    96: 'Thunderstorm with slight', 99 :	'heavy hail'};


class Weather {

  final String description;
  final double temperature;
  double? maxTemperature;
  final double windSpeed;
  final String time ;

  Weather({required this.description, required this.temperature, required this.windSpeed, required this.time, this.maxTemperature});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: codes[json['weather_code']] ?? 'Unkown Code',
      temperature: json['temperature_2m'],
      windSpeed: json['wind_speed_10m'],
      time: '',
    );
  }
}

Future<Weather> getCurrentWeather(Result res, int option) async {

  final response = await http.get(
     Uri.parse('https://api.open-meteo.com/v1/forecast?latitude=${res.la}&longitude=${res.lo}&current=temperature_2m,weather_code,wind_speed_10m'),
  );
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return Weather.fromJson(data['current']);
  } 
  else{
    throw 'error';
  }
}


List<Weather> parseWeather(Map<String, dynamic> parsed) {

    List<Weather> weatherList = [];

    List<String> times = (parsed['time'] as List<dynamic>).cast<String>();
    List<double> temperatures = (parsed['temperature_2m'] as List<dynamic>).cast<double>();
    List<int> weatherCodes = (parsed['weather_code'] as List<dynamic>).cast<int>();
    List<double> windSpeeds = (parsed['wind_speed_10m'] as List<dynamic>).cast<double>();

    for (int i = 0; i < times.length; i++) {
      Weather weather = Weather(
        time: times[i].substring(times[i].length - 4),
        temperature: temperatures[i],
        description: codes[weatherCodes[i]] ?? 'Unkown',
        windSpeed: windSpeeds[i],
      );
      weatherList.add(weather);
    }
    return weatherList;
  }

Future<List<Weather>> getTodayWeather(Result res) async {

  final response = await http.get(
     Uri.parse('https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&hourly=temperature_2m,weather_code,wind_speed_10m&forecast_days=3'),
  );
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);

    return parseWeather(parsed['hourly']);
  } 
  else{
    throw 'error';
  }
}


List<Weather> parseWeeklyWeather(Map<String, dynamic> parsed) {

    List<Weather> weatherList = [];

    List<String> times = (parsed['time'] as List<dynamic>).cast<String>();
    List<double> temperatures = (parsed['temperature_2m_max'] as List<dynamic>).cast<double>();
    List<double> maxTemp = (parsed['temperature_2m_min'] as List<dynamic>).cast<double>();
    List<int> weatherCodes = (parsed['weather_code'] as List<dynamic>).cast<int>();

    for (int i = 0; i < times.length; i++) {
      Weather weather = Weather(
        time: times[i],
        temperature: temperatures[i],
        description: codes[weatherCodes[i]] ?? 'Unkown',
        windSpeed: 0,
        maxTemperature: maxTemp[i],
      );
      weatherList.add(weather);
    }
    return weatherList;
  }

Future<List<Weather>> getWeeklyWeather(Result res) async {

  final response = await http.get(
     Uri.parse('https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&daily=weather_code,temperature_2m_max,temperature_2m_min'),
  );
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);

    return parseWeeklyWeather(parsed['daily']);
  } 
  else{
    throw 'error';
  }
}