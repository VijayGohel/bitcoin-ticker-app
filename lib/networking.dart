import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({this.url});
  final String url;

  void getResponse() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      return jsonBody;
    } else {
      print(response.statusCode);
    }
  }
}
