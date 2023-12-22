import 'dart:convert';

import 'package:covid_19_app/model/WorldStateModel.dart';
import 'package:covid_19_app/services/utilities/app_urls.dart';
import 'package:http/http.dart'as http;

class StateServices {

  Future<WorldStateModel> getWorldStateRecord ()async{
    final response = await http.get(Uri.parse(AppUrls.worldStateApi));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    }else{
      throw Exception('error');
    }
  }
  Future<List<dynamic>> getCountriesRecords ()async{
    final response = await http.get(Uri.parse(AppUrls.countriesList));
    if(response.statusCode == 200){
      var data = jsonDecode( response.body);
      return data;
    }else{
      throw Exception('error');
    }
  }
 }

