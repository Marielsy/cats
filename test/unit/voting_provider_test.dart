import 'package:flutter_test/flutter_test.dart';
import 'package:cats/features/voting/presentation/providers/voting_provider.dart';
import 'package:cats/features/breed_detail/domain/models/breed.dart';

import 'package:cats/features/breed_detail/data/repositories/breed_repository_impl.dart';
import 'package:cats/features/breed_detail/data/datasources/breed_api_service.dart';

class FakeBreedApiService implements BreedApiService {
  @override
  Future<List<Breed>> fetchBreeds() async => [];
  @override
  Future<List<String>> fetchBreedImages(String breedId, {int limit = 10}) async => [];
}

class MockRepo extends BreedRepositoryImpl {
  MockRepo() : super(FakeBreedApiService());
  Future<List<Breed>> getBreeds() async => [
        Breed(id: '1', name: 'TestCat', origin: 'Test', lifeSpan: '10', intelligence: '5', description: 'desc'),
        Breed(id: '2', name: 'OtherCat', origin: 'Test', lifeSpan: '10', intelligence: '5', description: 'desc'),
      ];
  Future<List<String>> getBreedImages(String breedId, {int limit = 10}) async => ['url'];
}

void main() {
  group('VotingProvider', () {
    late VotingProvider provider;
    setUp(() {
      provider = VotingProvider(repository: MockRepo());
    });

    test('fetchBreeds loads breeds and picks one', () async {
      await provider.fetchBreeds();
      expect(provider.breeds.length, 2);
      expect(provider.currentBreed, isNotNull);
    });

    test('vote marks breed as voted and loads new', () async {
      await provider.fetchBreeds();
      final first = provider.currentBreed;
      provider.vote(true);
      expect(provider.currentBreed, isNot(first));
    });

    test('resetVotes clears voted breeds', () async {
      await provider.fetchBreeds();
      provider.vote(true);
      provider.resetVotes();
      expect(provider.currentBreed, isNotNull);
    });
  });
}
