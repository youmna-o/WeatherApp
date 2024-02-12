import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:intl/intl.dart';
import 'package:weather_project/api/api.dart';
import 'package:weather_project/api/models/weather_api_response.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return
     MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController city = TextEditingController();
  var date ;
  String defultCity = 'Mansoura';
  void initstate() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white,

      body:
      FutureBuilder<WeatherApiResponse>(
        future: WeatherAPI().getAPIData(defultCity),
        builder: (context , snapshot){
          if(snapshot.hasData){
            return
              Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                    image: AssetImage("lib/Assets/WhatsApp Image 2024-02-06 at 02.24.46_1dd89a73.jpg"),
                      fit:BoxFit.fill
                  )
                ),

                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: city,
                            decoration: InputDecoration(
                                   hintText: "Search Here ",
                                   hintStyle: TextStyle(color:

                                   Color(0xFF20578C),
                                       fontSize: 15),

                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:BorderSide(width: 4,
                                    color : Colors.grey.withOpacity(0.5),

                                  )),

                                  focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color:Colors.grey.withOpacity(0.5),),


                              ),
                                   suffixIcon: IconButton(color: Color(0xFF20578C),
                                         onPressed: (){
                                       defultCity = city.text.toString();
                                       setState(() {
                                       });
                                         },
                                         icon: Icon(Icons.search)),
                            ),
                          ),
                      ),

                      Container(
                          child:  Text(" Last Updated at " + DateFormat.jm().format(DateTime.parse((snapshot.data?.list.elementAt(0).dt_txt).toString())),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15)),
                          height: 40),

                      Container(
                        height: 300,
                        width: 330,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          border: Border.all(width: 2,color: Colors.white),
                            borderRadius: BorderRadiusDirectional.circular(30),
                        ),

                        child:
                       Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(" ${snapshot.data?.city.name}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 32)),

                          Text(DateFormat.MMMMEEEEd().format(DateTime.parse((snapshot.data?.list.elementAt(0).dt_txt).toString())),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                          Text(" ${(snapshot.data!.list.elementAt(0).main.temp - 273.15).round()}\u2103",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25)),
                          Text("min:${(snapshot.data!.list.elementAt(0).main.temp_min - 273.15).round()}\u2103 / max:${(snapshot.data!.list.elementAt(0).main.temp_max - 273.15).round()}\u2103",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                          Image.network(
                            'https://openweathermap.org/img/wn/${snapshot.data?.list.elementAt(0).weather.first.icon}@2x.png'),
                          Text("${snapshot.data?.list.elementAt(0).weather.first.description}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                                       ],),),
                      SizedBox(height: 14,),

                      Container(height: 250,
                       width: double.infinity,
                       child:
                       Padding(
                         padding: const EdgeInsets.all(8),
                         child: SingleChildScrollView(
                           scrollDirection: Axis.horizontal,
                           child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                               children: [

                                 WeatherDetails(
                                     snapshot.data!.list.elementAt(8).dt_txt ,
                                     snapshot.data!.list.elementAt(8).main.temp,
                                     snapshot.data!.list.elementAt(8).weather.first.icon ,
                                     snapshot.data!.list.elementAt(8).weather.first.description),
                                 SizedBox(width: 20,),

                                 WeatherDetails(
                                     snapshot.data!.list.elementAt(16).dt_txt ,
                                     snapshot.data!.list.elementAt(16).main.temp,
                                     snapshot.data!.list.elementAt(16).weather.first.icon ,
                                     snapshot.data!.list.elementAt(16).weather.first.description),
                                 SizedBox(width: 20,),

                                 WeatherDetails(
                                     snapshot.data!.list.elementAt(24).dt_txt ,
                                     snapshot.data!.list.elementAt(24).main.temp,
                                     snapshot.data!.list.elementAt(24).weather.first.icon ,
                                     snapshot.data!.list.elementAt(24).weather.first.description),
                                 SizedBox(width: 20,),
                                 WeatherDetails(
                                     snapshot.data!.list.elementAt(32).dt_txt ,
                                     snapshot.data!.list.elementAt(32).main.temp,
                                     snapshot.data!.list.elementAt(32).weather.first.icon ,
                                     snapshot.data!.list.elementAt(32).weather.first.description),


                           ]
                           ),
                         ),
                       ),
                      ),

                    ],),
                  ),
                ),
              );

          }
          if(snapshot.hasError){
            print(snapshot.error.toString());
            return Container();
          }
          return const Center(child: SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(),
          ),);
        },
      ),
    );
  }
}

    DateTime toDate(String?date ) {
    return DateTime.parse(date!);
    }


    WeatherDetails ( String date , double temp , String icon , String description ){
      return Container( width: 120,
        decoration:
        BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadiusDirectional.circular(30),
          border: Border.all(width: 1,color: Colors.white),),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(DateFormat('EEEE').format(DateTime.parse((date).toString())),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15)),
              Text(" ${(temp - 273.15).round()}\u2103",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
              Image.network(
                  'https://openweathermap.org/img/wn/${icon}@2x.png'),
              Text("${description}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15)),

        ],),
    ),
  );
    }




