import 'package:http/http.dart' as http;

import '../model/fake_store_model.dart';

class ApiService {
  static Future<List<FackModel>?> getData() async {
    http.Response response = await http.get(
      Uri.parse("https://fakestoreapi.com/products"),
    );
    if (response.statusCode == 200) {
      return fackModelFromJson(response.body);
    } else {
      return null;
    }
  }
}
