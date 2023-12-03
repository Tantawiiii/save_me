
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:get/get.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:http/http.dart' as http;

import '../web_services/network_utils.dart';

class LocationSearch extends GetxController{


  // To controller a Search TextField with a picked location from Maps.
  final Placemark _pickPlaceMark = Placemark();
  Placemark get pickPlaceMark => _pickPlaceMark;
  List <Prediction> _predictionList = [];
  Future<List<Prediction>> searchLocation(BuildContext context, String text) async {

    if (text != null && text.isNotEmpty) {
      http.Response response = await getLocationData(text);
      var data = jsonDecode(response.body.toString());
      print("My status is "+data['status']);
      if (data['status'] == "OK") {
        _predictionList = [];
        data['predictions'].forEach((prediction) =>
            _predictionList.add(Prediction.fromJson(prediction)));
      } else {

      }
    }
    return _predictionList;
  }

  getLocationData(String text) {}


}