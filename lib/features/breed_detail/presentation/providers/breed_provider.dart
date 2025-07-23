import 'package:flutter/material.dart';
import '../../domain/models/breed.dart';
import '../../data/datasources/breed_api_service.dart';
import '../../data/repositories/breed_repository_impl.dart';

class BreedProvider extends ChangeNotifier {
  final _repository = BreedRepositoryImpl(BreedApiService());

  List<Breed> _breeds = [];
  List<Breed> get breeds => _breeds;

  Breed? _selectedBreed;
  Breed? get selectedBreed => _selectedBreed;

  List<String> _images = [];
  List<String> get images => _images;

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  Future<void> fetchBreeds() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _breeds = await _repository.getBreeds();
      if (_breeds.isNotEmpty) {
        selectBreed(_breeds.first);
      }
    } catch (e) {
      _error = e.toString();
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> selectBreed(Breed breed) async {
    _selectedBreed = breed;
    _images = [];
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _images = await _repository.getBreedImages(breed.id);
    } catch (e) {
      _error = e.toString();
    }
    _loading = false;
    notifyListeners();
  }
}
