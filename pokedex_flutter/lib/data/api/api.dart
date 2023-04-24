import 'dart:convert';

import 'package:http/http.dart';

const _url = 'https://pokeapi.co/api/v2/';

class NetworkHelper {
  Future getData(String uri) async {
    try{
    Response response = await get(Uri.parse(_url + uri));
    if(response.statusCode == 200){
      var data =  response.body;
      return jsonDecode(data);
    }
    }
    catch(e){
      rethrow;
    }
  }
}