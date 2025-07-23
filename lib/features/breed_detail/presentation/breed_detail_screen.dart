import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../presentation/providers/breed_provider.dart';
import '../presentation/widgets/breed_dropdown.dart';
import '../presentation/widgets/breed_images_carousel.dart';
import '../../breed_detail/domain/models/breed.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BreedDetailScreen extends StatelessWidget {
  const BreedDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BreedProvider()..fetchBreeds(),
      child: Consumer<BreedProvider>(
        builder: (context, provider, _) {
          if (provider.loading && provider.breeds.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.error != null) {
            return Center(child: Text('Error: ${provider.error}'));
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Detalles de la Raza'),
              backgroundColor: const Color(0xFFA28CF6),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Si se agrega un TabBar, usar este patrón:
                    // Container(
                    //   color: Color(0xFFA28CF6),
                    //   child: TabBar(...),
                    // ),
                    const BreedDropdown(),
                    const SizedBox(height: 16),
                    if (provider.loading && provider.selectedBreed != null)
                      const Center(child: CircularProgressIndicator()),
                    if (!provider.loading && provider.selectedBreed != null) ...[
                      BreedImagesCarousel(images: provider.images),
                      const SizedBox(height: 16),
                      _BreedDetails(breed: provider.selectedBreed!),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BreedDetails extends StatelessWidget {
  final Breed breed;
  const _BreedDetails({required this.breed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(breed.name, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('Origen: ${breed.origin}'),
                const SizedBox(width: 16),
                Text('Vida: ${breed.lifeSpan} años'),
              ],
            ),
            const SizedBox(height: 8),
            Text('Inteligencia: ${breed.intelligence}/5'),
            const SizedBox(height: 8),
            Text(breed.description),
            if (breed.wikipediaUrl != null && breed.wikipediaUrl!.isNotEmpty)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: const Text('Ver en Wikipedia'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => Scaffold(
                          appBar: AppBar(title: Text('Wikipedia: ${breed.name}')),
                          body: WebViewWidget(
                            controller: WebViewController()
                              ..loadRequest(Uri.parse(breed.wikipediaUrl!)),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
