import 'package:weather_project/api/models/list_models/clouds.dart';
import 'package:weather_project/api/models/list_models/main.dart';
import 'package:weather_project/api/models/list_models/sys.dart';
import 'package:weather_project/api/models/list_models/weather.dart';
import 'package:weather_project/api/models/list_models/wind.dart';

class ListDetails{
  late int dt;
  late Main main;
  late List<Weather> weather;
  late Clouds clouds;
  late Wind wind;
  late int visibility;
  late double pop;
  late SYS sys;
  late String dt_txt;

  ListDetails({
   required this.dt,
   required this.main,
   required this.weather,
   required this.clouds,
   required this.wind,
   required this.visibility,
   required this.pop,
   required this.sys,
   required this.dt_txt,
});
  ListDetails.fromMap(Map<String,dynamic> map){
    dt= map['dt'];
    main= Main.fromMap(map['main']);
    weather=[];
    (map['weather'] as List).forEach((element){
      weather.add(Weather.fromMap(element));
    });
    clouds= Clouds.fromMap(map['clouds']);
    wind= Wind.fromMap(map['wind']);
    visibility= map['visibility'];
    pop= double.parse(map['pop'].toString());
    sys= SYS.fromMap(map['sys']);
    dt_txt= map['dt_txt'];
  }
  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = {};
    map['dt'] =dt;
    List<Map> weatherList = [];
    this.weather.forEach((element) {
      weatherList.add(element.toMap());
    });
    map['main'] =main.toMap();
    map['weather'] =weatherList;
    map['clouds'] =clouds.toMap();
    map['wind'] =wind.toMap();
    map['visibility'] =visibility;
    map['pop'] =pop;
    map['sys'] =sys.toMap();
    map['dt_txt'] =dt_txt;
    return map;
  }
}