import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiHelper {
  Future apiCalling(String search) async {
    Uri Url = Uri.parse(
        'http://api.weatherapi.com/v1/current.json?key=7f53ff8467194836884101314243007&q=$search');
    Response response = await http.get(Url);
    if (response.statusCode == 200) {
      final json = response.body;
      final data = jsonDecode(json);
      return data;
    } else {
      return {};
    }
  }
}
