import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/golbal.dart';
import '../../modal/Weather_Modal.dart';
import '../../provider/weather_provider.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    WeatherProvider weatherProviderTrue = Provider.of(context, listen: true);
    WeatherProvider weatherProviderFalse = Provider.of(context, listen: false);
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color(0xff32255a),
        // backgroundColor: Colors.black12,
        backgroundColor: Color(0xff32255a),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onSubmitted: (value) {
                  weatherProviderFalse.ImgFind(value);
                  weatherProviderTrue.SearchList.add(
                      weatherProviderTrue.weatherModal?.location.name);
                },
                controller: SearchText,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      // Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  focusColor: Colors.white,
                  hintText: 'Enter City Name',
                  hintStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            FutureBuilder(
              future: Provider.of<WeatherProvider>(context).SearchWeather(
                weatherProviderTrue.search,
              ),
              builder: (context, snapshot) {
                WeatherModal? weatherModal = snapshot.data;
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/weather');
                          },
                          child: Container(
                            height: 120,
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
                              color: Colors.black26,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              ),
                            ),
                            child: ListTile(
                              title: Text(
                                '${weatherModal!.location.name}',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Container(
                                width: width * 0.1,
                                // color: Colors.white,
                                child: Text(
                                  // overflow: TextOverflow.ellipsis,
                                  '${weatherModal.current.temp_c.toString()} '
                                  '\n'
                                  '${weatherModal.current.condition.text}\n',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              trailing: Image(
                                image: NetworkImage(
                                    'https:${weatherModal.current.condition.icon}'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.white),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
        floatingActionButton: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/fav');
          },
          icon: Icon(
            CupertinoIcons.square_favorites_alt_fill,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }
}

var Sindex = 1;
//  weatherProviderTrue.Weather.add(
//                             weatherModal.location.name,
//                           );
//                           weatherProviderTrue.Weather1.add(
//                             weatherModal.current.temp_c,
//                           );
