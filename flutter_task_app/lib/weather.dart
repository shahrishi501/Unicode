import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _cityController = TextEditingController();
  String _temperature = '';
  String _condition = '';
  String _icon = '';

  Future<void> _fetchWeather(String city) async {
    
    final apiUrl = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=6ae5f650978cb606a04f1398e98f723d';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final weatherData = jsonDecode(response.body);
      setState(() {
        _temperature = (weatherData['main']['temp'] - 273.15).toStringAsFixed(2);
        _condition = weatherData['weather'][0]['main'];
        _icon = weatherData['weather'][0]['icon'];
      });
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App')),
      body: Column(
        children: [
          SizedBox(height: 10,),
          TextField(

            controller: _cityController,
            decoration: InputDecoration(
              labelText: 'Enter a city',
              
              ),
            
          ),
          ElevatedButton(
            onPressed: () {
              _fetchWeather(_cityController.text);
            },
            child: Text('Get Weather'),
          ),
          Text('Temperature: $_temperature °C'),
          Text('Condition: $_condition'),
          if (_icon.isNotEmpty) Image.network('https://openweathermap.org/img/w/$_icon.png'),
        ],
      ),
    );
  }
}

