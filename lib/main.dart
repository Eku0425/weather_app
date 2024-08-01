import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screen/provider/weather_provider.dart';
import 'package:weather_app/screen/view/favpage/fav_page.dart';
import 'package:weather_app/screen/view/homepage/first.dart';
import 'package:weather_app/screen/view/splashpage/Splash_screen.dart';
import 'package:weather_app/screen/view/weather/weather.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/first': (context) => FirstScreen(),
          '/weather': (context) => WeatherPage(),
          '/fav': (context) => FavScreen(),
        },
      ),
    );
  }
}
