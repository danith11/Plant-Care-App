import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/plant.dart';

class ApiService {

  // This is the mockAPI. That's why I hardcoded this 
  static const String baseUrl =
      'https://69ec7a3aaf4ff533142b03dd.mockapi.io/api/v1/plants';

  Future<List<Plant>> getPlants() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Plant.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load plants');
    }
  }

  Future<Plant> createPlant(Plant plant) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(plant.toJson()),
    );
    if (response.statusCode == 201) {
      return Plant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create plant');
    }
  }

  Future<void> updatePlant(Plant plant) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${plant.id}'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(plant.toJson()),
    );
    if (response.statusCode != 200) throw Exception('Failed to update plant');
  }

  Future<void> deletePlant(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) throw Exception('Failed to delete plant');
  }
}