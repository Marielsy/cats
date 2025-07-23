import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/voting_provider.dart';
import '../../breed_detail/presentation/widgets/breed_images_carousel.dart';

class VotingScreen extends StatelessWidget {
  const VotingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VotingProvider()..fetchBreeds(),
      child: Consumer<VotingProvider>(
        builder: (context, provider, _) {
          if (provider.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.error != null) {
            return Center(child: Text('Error: \\${provider.error}'));
          }
          if (provider.currentBreed == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¡No quedan más razas para votar!'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: provider.resetVotes,
                    child: const Text('Reiniciar votación'),
                  ),
                ],
              ),
            );
          }
          final breed = provider.currentBreed!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  breed.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 220,
                  child: FutureBuilder<List<String>>(
                    future: provider.repo.getBreedImages(breed.id, limit: 1),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final images = snapshot.data ?? [];
                      // Solo una imagen por raza
                      return Dismissible(
                        key: ValueKey(breed.id),
                        direction: DismissDirection
                            .endToStart, // Solo swipe a la izquierda
                        confirmDismiss: (direction) async {
                          return direction == DismissDirection.endToStart;
                        },
                        onDismissed: (direction) {
                          if (direction == DismissDirection.endToStart) {
                            provider.vote(false);
                          }
                        },
                        background: Container(),
                        child: BreedImagesCarousel(images: images),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.thumb_down,
                        color: Colors.red,
                        size: 36,
                      ),
                      onPressed: () => provider.vote(false),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.thumb_up,
                        color: Colors.green,
                        size: 36,
                      ),
                      onPressed: () => provider.vote(true),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
