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
                Column(
                  children: [
                    Text(
                      breed.name,
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: Color(0xFF7D63C8), // violeta fuerte
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                            shadows: [
                              Shadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 80,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Color(0xFFA28CF6).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
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
                            child: images.isNotEmpty
                                ? Container(
                                    width: double.infinity,
                                    height: 220,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                    child: Image.network(
                                      images.first,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 220,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return const Center(child: CircularProgressIndicator());
                                      },
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        color: Colors.grey[200],
                                        child: const Center(child: Icon(Icons.image_not_supported, color: Colors.grey)),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    height: 220,
                                    color: Colors.grey[200],
                                    child: const Center(child: Icon(Icons.image_not_supported, color: Colors.grey)),
                                  ),
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
                      color: Color(0xFFFF4F4F), // rojo
                      shape: const CircleBorder(),
                      elevation: 4,
                      child: IconButton(
                        icon: const Icon(
                          Icons.thumb_down,
                          color: Colors.white,
                          size: 32,
                        ),
                        onPressed: () => provider.vote(false),
                        splashRadius: 32,
                      ),
                    ),
                    // Botón Like
                    Material(
                      color: Color(0xFF4F8FFF), // azul
                      shape: const CircleBorder(),
                      elevation: 4,
                      child: IconButton(
                        icon: const Icon(
                          Icons.thumb_up,
                          color: Colors.white,
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
