import 'package:flutter/material.dart';
import '../providers/breed_provider.dart';
import '../../domain/models/breed.dart';
import 'package:provider/provider.dart';

class BreedDropdown extends StatelessWidget {
  const BreedDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BreedProvider>(context);
    return DropdownButton<Breed>(
      value: provider.selectedBreed,
      hint: const Text('Selecciona una raza'),
      items: provider.breeds.map((breed) {
        return DropdownMenuItem<Breed>(
          value: breed,
          child: Text(breed.name),
        );
      }).toList(),
      onChanged: (breed) {
        if (breed != null) provider.selectBreed(breed);
      },
      isExpanded: true,
    );
  }
}
