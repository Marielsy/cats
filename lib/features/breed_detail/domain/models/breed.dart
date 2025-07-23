class Breed {
  final String id;
  final String name;
  final String origin;
  final String lifeSpan;
  final String intelligence;
  final String description;
  final String? wikipediaUrl;

  Breed({
    required this.id,
    required this.name,
    required this.origin,
    required this.lifeSpan,
    required this.intelligence,
    required this.description,
    this.wikipediaUrl,
  });

  factory Breed.fromJson(Map<String, dynamic> json) {
    return Breed(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      origin: json['origin'] ?? '',
      lifeSpan: json['life_span'] ?? '',
      intelligence: json['intelligence']?.toString() ?? '',
      description: json['description'] ?? '',
      wikipediaUrl: json['wikipedia_url'],
    );
  }
}
