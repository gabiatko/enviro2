import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
// import 'package:intl/date_symbol_data_local.dart';


class GetJson{

  // late Map json1;
  String json1='init';
  // late List jsonResponse=[];
  // Map
  // GetJson({})

  Future<List> getNovinky() async{
    List jsonResponse=[];
    var url = Uri.https('envirof.envirofond.sk','news');
    // // Uri.https('envirof.envirofond.sk', '/news', {'q': '{http}'});
    Response response=await get(url);
    // response.body=
    String telo='['+response.body+']';
    // print(response.body);
    // if (kDebugMode) {
    //   print(telo);
    // }
    if (kDebugMode) {
      print(response.statusCode);
    }
    // //
    if (response.statusCode == 200) {
      jsonResponse = jsonDecode(telo);

      if (kDebugMode) {
        print ('OK');
      }
      print ('response ' + jsonResponse[2]['guid'].toString());

    } else {
      print ('NIE OK');
    //   print('Request failed with status: ${response.statusCode}.');
    }
    return jsonResponse;
  }
}

class WorldTime {

  String location; // location for UI
  String time = '?'; // time for that location
  String flag;
  String url;
  bool isDateTime=true;


  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    // DateFormat dateFormat;
    // DateFormat timeFormat;
    // initializeDateFormatting().then((_) => runMyCode());
    // initializeDateFormatting();
    // dateFormat = new DateFormat.yMMMMd('cs');
    // timeFormat = new DateFormat.Hms('cs');
    int pocet=0;
    bool nepreslo;

    do {
      try {

        var urli = Uri.http('worldtimeapi.org', 'api/timezone/' + url);
        var response = await get(urli);

        Map jsonResponse = jsonDecode(response.body);

        // print('response.statusCode is: '+ response.statusCode.toString());

        String datetime = jsonResponse['datetime'].toString();
        String offset = jsonResponse['utc_offset'].toString().substring(1, 3);


        // create date object
        DateTime teraz = DateTime.parse(datetime);
        // isDateTime= ((teraz.hour>6) & (teraz.hour<9)) ? true : false;
        // if(teraz.hour>6 && teraz.hour<11){
        teraz = teraz.add(Duration(hours: int.parse(offset)));
        // if(teraz.hour<10){
        //
        //   isDateTime=false;
        //   print ('fasd sdfv adf vadf va d         '+teraz.hour.toString());
        // }
        isDateTime= (teraz.hour>6 && teraz.hour<10) ? true : false;
        print('teraz.hour '+ teraz.hour.toString()+'     is Date: '+isDateTime.toString());
        time = DateFormat.jm().format(teraz).toString();
        nepreslo=false;
      }
      catch (e) {
        time = 'Zle spojenie!!!';
        nepreslo=true;
        pocet =pocet+1;
        // print('caught error: $e   '+pocet.toString()+ '    '+nepreslo.toString());
      }
    } while ((pocet < 10) && nepreslo);
  }
}


// class ScArguments {
//   String location; // location for UI
//   String time; // time for that location
//   String flag;
//
//
//   ScArguments({required this.location, required this.time, required this.flag});
//
//
//   // ScreenArguments(this.title, this.message);
// }
