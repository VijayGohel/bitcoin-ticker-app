import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({this.url});
  final String url;

  Future getResponse() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      print('in response');
      return jsonBody;
    } else {
      print(response.statusCode);
    }
  }
}
