import 'dart:convert';

import 'package:http/http.dart';

class NetworkHelper {

  NetworkHelper(this.uri);

  final String uri;

  Future getData() async {
    try{
    Response response = await get(Uri.parse(uri));
    if(response.statusCode == 200){
      var data =  response.body;
      return jsonDecode(data);
    }
    }
    catch(e){return null;}
  }
}