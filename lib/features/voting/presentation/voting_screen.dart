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
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(24),
                  color: Theme.of(context).colorScheme.surface,
                  child: SizedBox(
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
                          direction: DismissDirection.endToStart, // Solo swipe a la izquierda
                          confirmDismiss: (direction) async {
                            return direction == DismissDirection.endToStart;
                          },
                          onDismissed: (direction) {
                            if (direction == DismissDirection.endToStart) {
                              provider.vote(false);
                            }
                          },
                          background: Container(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: BreedImagesCarousel(images: images),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Botón Dislike
                    Material(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: const CircleBorder(),
                      elevation: 4,
                      child: IconButton(
                        icon: Icon(
                          Icons.thumb_down,
                          color: Theme.of(context).colorScheme.onSecondary,
                          size: 32,
                        ),
                        onPressed: () => provider.vote(false),
                        splashRadius: 32,
                      ),
                    ),
                    // Botón Like
                    Material(
                      color: Theme.of(context).colorScheme.primary,
                      shape: const CircleBorder(),
                      elevation: 4,
                      child: IconButton(
                        icon: Icon(
                          Icons.thumb_up,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 32,
                        ),
                        onPressed: () => provider.vote(true),
                        splashRadius: 32,
                      ),
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
