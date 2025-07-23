import '../../domain/models/breed.dart';
import '../../domain/repositories/breed_repository.dart';
import '../datasources/breed_api_service.dart';

class BreedRepositoryImpl implements BreedRepository {
  final BreedApiService apiService;
  BreedRepositoryImpl(this.apiService);

  @override
  Future<List<Breed>> getBreeds() {
    return apiService.fetchBreeds();
  }

  @override
  Future<List<String>> getBreedImages(String breedId, {int limit = 10}) {
    return apiService.fetchBreedImages(breedId, limit: limit);
  }
}
