import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime{

  late String location;  //  location name for the UI
  late String time;  //  the time in that location
  late String flag;  //  url to an asset flag item
  late String url;  // location url for api endpoint
  late bool isDaytime;  //true or false if day time or not

  WorldTime({required this.location , required this.url , required this.flag});

  Future<void> getTime() async {

    try{

      Response response = await http.get(Uri.parse("https://worldtimeapi.org/api/timezone/$url"));
      Map data =  jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      // print(datetime);
      // print(offset);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //Set time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);

    }
    catch(e){
      print('caught error: $e');
      time = 'could not get time data';
    }


  }

}

