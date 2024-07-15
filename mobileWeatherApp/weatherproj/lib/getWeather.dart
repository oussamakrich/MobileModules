import 'dart:convert';
import 'package:weatherproj/main.dart';
import 'package:http/http.dart' as http;

getCurrentWeather(Result res, int option) async {

  print('Called');
  final response = await http.get(
     Uri.parse('https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,weather_code,wind_speed_10m'),
  );
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data;
  } 
  else{
    return 'error';
  }
}