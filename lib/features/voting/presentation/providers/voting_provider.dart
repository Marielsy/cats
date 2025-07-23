import 'dart:math';
import 'package:flutter/material.dart';
import '../../../breed_detail/domain/models/breed.dart';
import '../../../breed_detail/data/repositories/breed_repository_impl.dart';
import '../../../breed_detail/data/datasources/breed_api_service.dart';

class VotingProvider extends ChangeNotifier {
  final BreedRepositoryImpl repo;

  VotingProvider({BreedRepositoryImpl? repository})
      : repo = repository ?? BreedRepositoryImpl(BreedApiService());
  List<Breed> _breeds = [];
  List<String> _votedBreeds = [];
  Breed? _currentBreed;
  bool _loading = false;
  String? _error;

  List<Breed> get breeds => _breeds;
  Breed? get currentBreed => _currentBreed;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> fetchBreeds() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _breeds = await repo.getBreeds();
      _votedBreeds.clear();
      _chooseRandomBreed();
    } catch (e) {
      _error = e.toString();
    }
    _loading = false;
    notifyListeners();
  }

  void _chooseRandomBreed() {
    final available = _breeds.where((b) => !_votedBreeds.contains(b.id)).toList();
    if (available.isEmpty) {
      _currentBreed = null;
      return;
    }
    _currentBreed = available[Random().nextInt(available.length)];
  }

  void vote(bool liked) {
    if (_currentBreed == null) return;
    _votedBreeds.add(_currentBreed!.id);
    _chooseRandomBreed();
    notifyListeners();
  }

  void resetVotes() {
    _votedBreeds.clear();
    _chooseRandomBreed();
    notifyListeners();
  }
}
