import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ApiHealper/weather_Apihelper.dart';
import '../modal/Weather_Modal.dart';

class WeatherProvider extends ChangeNotifier {
  ApiHelper apiHelper = ApiHelper();
  WeatherModal? weatherModal;
  String search = 'Surat';
  List<String> weather = [];
  List<double> weather1 = [];
  List<String> weather2 = [];
  List SearchList = [];

  void ImgFind(String img) {
    search = img;
    notifyListeners();
  }

  Future<WeatherModal> SearchWeather(
    String img,
  ) async {
    final json = await apiHelper.apiCalling(img);
    final data = WeatherModal.fromJson(json);
    // SearchList.insert(index, data);
    return data;
  }

  Future<void> addFavourite(
    String name,
  ) async {
    String data = "$name";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    weather.add(data);
    sharedPreferences.setStringList('weather', weather);
  }

  Future<void> addFavourite2(double temp) async {
    double data = temp;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    weather1.add(data);
    sharedPreferences.setStringList('weather', weather);
  }

  Future<void> addFavourite3(String temp) async {
    String data = temp;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    weather2.add(data);
    sharedPreferences.setStringList('weather', weather);
  }

  Future<void> getFavourite() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> weather =
        sharedPreferences.getStringList('weather') ?? <String>[];
    print(weather);
    notifyListeners();
  }

  WeatherProvider() {
    print(weather);
    getFavourite();
  }
}
