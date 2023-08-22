import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  final String url;

  Network(
    this.url,
  );

  Future collectData() async {
    var response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      print(response.statusCode);
    }
  }
}
