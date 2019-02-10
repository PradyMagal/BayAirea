import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class AirData {
  static final String key = "15130";
  static final String url = "https://www.purpleair.com/json?show=";

  static String currentSensor = "";
  static int temperatureF = -1;
  static int humidityPercent = -1;
  static double latitude = -1, longitude = -1;

  //These are 2.5um particles right now, might be the wrong one
  static double particles = -1;

  AirData() {
    reloadData();
  }

  static reloadData() async {
    var purpleAirResponse = await http.get(url + key);
    var purpleAirJSON = convert.jsonDecode(purpleAirResponse.body)["results"][0];

    AirData.currentSensor = purpleAirJSON["Label"];
    AirData.temperatureF = int.parse(purpleAirJSON["temp_f"]);
    AirData.humidityPercent = int.parse(purpleAirJSON["humidity"]);
    AirData.latitude = (purpleAirJSON["Lat"]);
    AirData.longitude = (purpleAirJSON["Lon"]);

    //Everything below this might be incorrect because thing speak says the channel/key lead to lat/long of 0, 0.
    final thingspeakChannel = purpleAirJSON["THINGSPEAK_PRIMARY_ID"];
    final thingspeakKey = purpleAirJSON["THINGSPEAK_PRIMARY_ID_READ_KEY"];

    var thingspeakURL = "https://api.thingspeak.com/channels/"+thingspeakChannel+"/feeds.json?api_key="+thingspeakKey+"&results=1";
    var thingspeakResponse = await http.get(thingspeakURL);
    var thingspeakJSON = convert.jsonDecode(thingspeakResponse.body);

    AirData.particles = double.parse(thingspeakJSON["feeds"][0]["field2"]);

    printData();
  }

  static printData() {
    print("\nCurrentSensor: " + currentSensor + "\nTemperature (F): $temperatureF \nHumidity (%): $humidityPercent \nLat, Long: $latitude, $longitude");
    print("2.5 PM ug/m3: $particles \n");
  }




}