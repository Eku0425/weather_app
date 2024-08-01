import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../modal/Weather_Modal.dart';
import '../../provider/weather_provider.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    WeatherProvider weatherProviderTrue = Provider.of(context, listen: true);
    WeatherProvider weatherProviderFalse = Provider.of(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: Provider.of<WeatherProvider>(context).SearchWeather(
            weatherProviderTrue.search,
          ),
          builder: (context, snapshot) {
            WeatherModal? weatherModal = snapshot.data;
            if (snapshot.hasData) {
              return Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: (weatherModal!.current.is_day == 1)
                        ? AssetImage('assets/img/day.gif')
                        : AssetImage('assets/img/night1.gif'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${weatherModal!.location.name}',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Successfully added '),
                                    action: SnackBarAction(
                                      label: '',
                                      onPressed: () {},
                                    ),
                                  ),
                                );
                                weatherProviderTrue.addFavourite(
                                    // weatherModal.location.name,
                                    weatherModal.location.name);

                                weatherProviderTrue.addFavourite2(
                                  // weatherModal.location.name,

                                  weatherModal.current.temp_c,
                                );
                                weatherProviderTrue.addFavourite3(
                                  // weatherModal.location.name,
                                  weatherModal.current.condition.text,
                                );
                                // weatherProviderFalse
                                //     .weatherModal!.current.condition.icon);
                                // weatherProviderFalse.addFavourite();
                                weatherProviderFalse.getFavourite();
                              },
                              child: Text(
                                'Add to Fav City',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.2,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: width * 0.25,
                            ),
                            Text(
                              '${weatherModal.current.temp_c}',
                              style: TextStyle(
                                  fontSize: 75,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 40),
                              child: Text(
                                '°C',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white54,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: width * 0.23,
                            ),
                            SizedBox(
                              width: width * 0.5,
                              child: Text(
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                // '${weatherModal.current.condition.text}',
                                'Most Clear',
                                //
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                          blurRadius: 15, color: Colors.white)
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.18,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...List.generate(
                                CloudList.length,
                                (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(18),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: width * 0.05,
                                          ),
                                          Text(
                                            '${dayList[index]}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width * 0.1,
                                        ),
                                        Icon(
                                          CloudList[index],
                                          color: Colors.blue,
                                          size: 30,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: width * 0.10,
                                          ),
                                          Text(
                                            '${weatherModal.current.temp_c}°c',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
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
        ),
      ),
    );
  }
}

List CloudList = [
  CupertinoIcons.cloud_bolt_fill,
  CupertinoIcons.cloud_bolt_rain_fill,
  CupertinoIcons.cloud_drizzle_fill,
  CupertinoIcons.cloud_fill,
  CupertinoIcons.cloud_moon_bolt_fill,
  CupertinoIcons.cloud_moon_fill,
  CupertinoIcons.cloud_moon_rain_fill,
  // CupertinoIcons.cloud_heavyrain_fill,
  // CupertinoIcons.cloud_snow_fill,
  // CupertinoIcons.cloud_snow_fill,
];

List dayList = [
  'Mon',
  'Tus',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
  'Sun',
];
