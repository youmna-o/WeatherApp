import 'dart:convert';
import 'package:weather_project/api/models/weather_api_response.dart';
import 'package:http/http.dart' as http;

class WeatherAPI{
  Future<WeatherApiResponse> getAPIData(String city)async{
    final http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?q=$city&lat=44.34&lon=10.99&appid=42aacbd350087a49105539256a333f65"
    ));
    if(response.statusCode <=299 && response.statusCode >= 200) {
      final Map<String, dynamic>jsonBody = jsonDecode(response.body);
      WeatherApiResponse weatherApiResponse = WeatherApiResponse.fromMap(
          jsonBody);
      return weatherApiResponse;
    }else{
      throw("RequestFailure" + response.body);
    }

  }
}