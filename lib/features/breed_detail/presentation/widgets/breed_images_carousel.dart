import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BreedImagesCarousel extends StatelessWidget {
  final List<String> images;
  const BreedImagesCarousel({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const Center(child: Text('No hay imágenes disponibles.'));
    }
    return CarouselSlider(
      options: CarouselOptions(
        height: 220,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        viewportFraction: 0.8,
      ),
      items: images.map((url) {
        return Builder( 
          builder: (context) => ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 220,
              placeholder: (context, url) => Container(
                color: Colors.grey[200],
                child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[200],
                child: const Center(child: Icon(Icons.image_not_supported, color: Colors.grey)),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
