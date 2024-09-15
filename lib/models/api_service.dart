import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/plant_model.dart';

class ApiService {
  final String apiUrl = 'https://www.jsonkeeper.com/b/6Z9C'; 

  Future<List<Plant>> fetchPlants() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((plantJson) => Plant.fromJson(plantJson)).toList();
    } else {
      throw Exception('Failed to load plants');
    }
  }
}
