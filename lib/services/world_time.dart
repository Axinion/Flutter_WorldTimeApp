import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the ui
  late String time; // time in that location
  String flag; // url to asset flag icon
  String url; // location url for api endpoint
  late bool? isDaytime; // true or false if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      var u = Uri.parse('https://worldtimeapi.org/api/timezone/$url');
      // make a request
      Response response = await get(u);
      Map data = jsonDecode(response.body);
      //print(data);

      // get properties from 'data' variable
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      //print(datetime);
      //print(offset);

      // create a date time object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      //print(now);

      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      // set time property
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
  }
}
