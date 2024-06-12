import 'package:http/http.dart' as http;

class RegisterRepo {
  static Register(String jsonString) async {
    http.Response res = await http.post(
      Uri.parse('http://192.168.0.107:8000/allInone/register'),
      body: jsonString,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}
