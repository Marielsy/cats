import 'package:flutter/material.dart';
import '../providers/breed_provider.dart';
import '../../domain/models/breed.dart';
import 'package:provider/provider.dart';

class BreedDropdown extends StatelessWidget {
  const BreedDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BreedProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Breed>(
          value: provider.selectedBreed,
          hint: Text(
            'Selecciona una raza',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 32,
          ),
          items: provider.breeds.map((breed) {
            return DropdownMenuItem<Breed>(
              value: breed,
              child: Text(
                breed.name,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            );
          }).toList(),
          onChanged: (breed) {
            if (breed != null) provider.selectBreed(breed);
          },
          isExpanded: true,
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
