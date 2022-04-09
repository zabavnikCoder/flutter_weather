import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_weather/screens/main_screen.dart';
import 'package:flutter_weather/utils/location.dart';
import 'package:flutter_weather/utils/weather.dart';


class LoadingScreen extends StatefulWidget {
  
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

late LocationHelper locationData;

Future<void>getLocationData()async{
  locationData=LocationHelper();
  await locationData.getCurrentLocation();

  print(locationData.longitute);
  print(locationData.latitude);

  getWeatherData();

}

@override
void initState() {
  super.initState();
  getLocationData();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple,Colors.blue],
          ),
        ),
        child: const Center(
          child: SpinKitRipple(
            color: Colors.green,
            size: 140.0,
            duration: Duration(milliseconds: 1200),
          ),
        ),
      ),
    );
  }

  getWeatherData()async{

    // await getLocationData();

    WeatherData weatherData = WeatherData(locationData: locationData);
    var weath=await weatherData.getCurrentTemperature();

     print(weath);

   Navigator.push(
     context,
     MaterialPageRoute(
       builder: (context){
         return MainScreen(weatherData: weatherData);
       }
     ),
   );
  }
}


