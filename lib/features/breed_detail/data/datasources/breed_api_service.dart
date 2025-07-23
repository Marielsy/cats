import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/models/breed.dart';

class BreedApiService {
  static const String _baseUrl = 'https://api.thecatapi.com/v1';
  static const String _apiKey = 'live_JBT0Ah0Nt12iyl2IpjQVLDWjcLk0GQwf4zI9wBMfmfejKmcC31mOJp4yJz5TsOUP';

  Future<List<Breed>> fetchBreeds() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/breeds'),
      headers: {'x-api-key': _apiKey},
    );
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Breed.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar razas');
    }
  }

  Future<List<String>> fetchBreedImages(String breedId, {int limit = 10}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/images/search?limit=$limit&breed_ids=$breedId&api_key=$_apiKey'),
    );
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map<String>((item) => item['url'] as String).toList();
    } else {
      throw Exception('Error al cargar imágenes de la raza');
    }
  }
}
