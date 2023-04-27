import 'dart:convert';
import 'package:http/http.dart';
import '../../utils/consts.dart';

class NetworkHelper {
  Future getData(String uri) async {
    try{
    Response response = await get(Uri.parse(url + uri));
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