import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../modal/Weather_Modal.dart';
import '../../provider/weather_provider.dart';

var index = 0;

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    WeatherProvider weatherProviderTrue = Provider.of(context, listen: true);
    WeatherProvider weatherProviderFalse = Provider.of(context, listen: false);
  

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black26,
          // backgroundColor: Colors.white,
          body: FutureBuilder(
            future: Provider.of<WeatherProvider>(context).SearchWeather(
              weatherProviderTrue.search,
            ),
            builder: (context, snapshot) {
              WeatherModal? weatherModal = snapshot.data;
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ...List.generate(
                        weatherProviderTrue.weather.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 210,
                            width: 380,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.6),
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                  offset: Offset(0, 5),
                                ),
                              ],
                              color: Color(0xff3C2E6C),
                            ),
                            child: Center(
                              child: ListTile(
                                  title: Text(
                                    '${weatherProviderTrue.weather[index]}',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Text(
                                    '${weatherProviderTrue.weather2[index]}',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  trailing: Column(
                                    children: [
                                      Text(
                                        '${weatherProviderTrue.weather1[index]}°c',
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  )

                                  //
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/error.jpg'),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }
}
