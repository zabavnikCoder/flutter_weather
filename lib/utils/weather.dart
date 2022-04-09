import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'location.dart';


const apiKay='ce0ec473f3a284964ccedc7ad4d7d5f1';

class WeatherDisplayData{
  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDisplayData({required this.weatherIcon,required this.weatherImage});
}

class WeatherData{
 WeatherData({required this.locationData});

  LocationHelper locationData;
  double currentTemperature=0;
  int currentCondition=0;

  Future<dynamic>getCurrentTemperature()async{
    http.Response response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitute}&appid=${apiKay}&units=metric'));
  if(response.statusCode==200){
    String data =response.body;
    var currentWeather=jsonDecode(data);

    try{
      currentTemperature=currentWeather['main']['temp'];
      currentCondition= currentWeather['weather'][0]['id'];
    }catch(e){
      print(e);
    }

    return currentWeather;
  }else{
    print('temperature do not found');
  }
  
  }

  WeatherDisplayData getWeatherDisplayData(){
    if(currentCondition<600){
      return WeatherDisplayData(
        weatherIcon: const Icon(
          FontAwesomeIcons.cloud,
          size: 75.0,
        ),
        weatherImage: const AssetImage('assets/cloudy.png'),
      );
    }else{
      var now = DateTime.now();

      if(now.hour>=19){
        return WeatherDisplayData(
          weatherImage: const AssetImage('assets/night.png'),
          weatherIcon: const Icon(
            FontAwesomeIcons.moon,
            size: 75.0,
            color: Colors.white,
          ),
        );
      }else{
        return WeatherDisplayData(
          weatherIcon: const Icon(
            FontAwesomeIcons.sun,
            size: 75.0,
        
          ),
          weatherImage: const AssetImage('assets/sunny.png'),
        );
      }
    }
  }
}