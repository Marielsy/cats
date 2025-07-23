import 'package:flutter_test/flutter_test.dart';
import 'package:cats/features/breed_detail/presentation/providers/breed_provider.dart';
import 'package:cats/features/breed_detail/domain/models/breed.dart';

import 'package:cats/features/breed_detail/data/repositories/breed_repository_impl.dart';

import 'package:cats/features/breed_detail/data/datasources/breed_api_service.dart';

class FakeBreedApiService implements BreedApiService {
  @override
  Future<List<Breed>> fetchBreeds() async => [];
  @override
  Future<List<String>> fetchBreedImages(String breedId, {int limit = 10}) async => [];
}

class MockBreedRepository extends BreedRepositoryImpl {
  MockBreedRepository() : super(FakeBreedApiService());
  @override
  Future<List<Breed>> getBreeds() async => [
        Breed(
          id: 'abys',
          name: 'Abyssinian',
          origin: 'Egypt',
          lifeSpan: '14-15',
          intelligence: '5',
          description: 'Active and social',
        ),
      ];
  @override
  Future<List<String>> getBreedImages(String breedId, {int limit = 10}) async => ['https://test.com/cat.jpg'];
}

void main() {
  group('BreedProvider', () {
    late BreedProvider provider;
    setUp(() {
      provider = BreedProvider(repository: MockBreedRepository());
    });

    test('fetchBreeds loads breeds and selects first', () async {
      await provider.fetchBreeds();
      expect(provider.breeds.isNotEmpty, true);
      expect(provider.selectedBreed, isNotNull);
      expect(provider.selectedBreed!.name, 'Abyssinian');
    });

    test('selectBreed loads images for selected breed', () async {
      await provider.fetchBreeds();
      final breed = provider.breeds.first;
      await provider.selectBreed(breed);
      expect(provider.images.isNotEmpty, true);
      expect(provider.images.first, contains('cat.jpg'));
    });
  });
}
