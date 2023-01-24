import 'dart:convert';

import 'package:covid_tracker/services/utility/app_urls.dart';
import 'package:http/http.dart'as http;

import '../modell/WorldStatesModel.dart';
class StateServcies{
  Future<WorldStatesModel> fetchWorldStatesRecords()async{

    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    }else{
      throw Exception('error');
    }

  }

  Future<List<dynamic>> countriesListApi()async{

    final response = await http.get(Uri.parse(AppUrl.countriesList));
var data;
    if(response.statusCode == 200){
       data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception('error');
    }

  }
}