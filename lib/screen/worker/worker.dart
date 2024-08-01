import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

class worker {
  String cityname;

  //Constructor

  worker({required this.cityname}) {
    cityname = this.cityname;
  }

  late String temp;
  late String humidity;
  late String air_speed;
  late String description;
  late String main;
  late String icon;

  //method =
  Future<void> getData() async {
    try {
      final url = Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=2449684f4bb0b3951ed45329adcdbce4");
      Response response = await http.get(url);
      Map data = jsonDecode(response.body);

      //Getting Temp,Humidiy
      Map temp_data = data['main'];
      String getHumidity = temp_data['humidity'].toString();
      double getTemp = temp_data['temp'] - 273.15;

//Getting air_speed
      Map wind = data['wind'];
      double getAir_speed = wind["speed"] / 0.27777777777778;

      //Getting Description
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String getMain_des = weather_main_data['main'];
      String getDesc = weather_main_data["description"];

      //Assigning Values
      temp = getTemp.toString();
      humidity = getHumidity;
      air_speed = getAir_speed.toString();
      description = getDesc;
      main = getMain_des;
      icon = weather_main_data["icon"].toString();
    } catch (e) {
      temp = "Can't Find Data";
      humidity = "Can't Find Data";
      air_speed = "Can't Find Data";
      description = "Can't Find Data";
      main = "Can't Find Data";
      icon = "03d";
      print(e);
    }
  }
}
