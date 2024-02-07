import 'package:weather_project/api/models/city.dart';

import 'list_details.dart';

class WeatherApiResponse{
  late String cod;
  late int message;
  late int cnt;
  late List<ListDetails> list;
  late City city;

  WeatherApiResponse({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });
  WeatherApiResponse.fromMap(Map<String,dynamic> map){
    cod = map['cod'];
    message= map['message'];
    cnt= map['cnt'];
    list= [];
    (map['list'] as List).forEach((element) {
      list.add(ListDetails.fromMap(element));
    });
    city= City.fromMap(map['city']);
  }
  Map<String,dynamic>toMap(){
    Map <String,dynamic> map={};
    List <Map> tmplist=[];
    list.forEach((element) {
      tmplist.add(element.toMap());
    });
    map['cod'] = cod;
    map['message'] = message;
    map['cnt'] = cnt;
    map['list'] = tmplist;
    map['city'] = city.toMap();
    return map;
  }
}