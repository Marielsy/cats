import '../models/breed.dart';

abstract class BreedRepository {
  Future<List<Breed>> getBreeds();
  Future<List<String>> getBreedImages(String breedId, {int limit});
}
