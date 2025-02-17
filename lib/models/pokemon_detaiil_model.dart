class PokemonDetail {
  final int id;
  final String name;
  final String img;
  final List<dynamic> types;
  final int baseExperience;
  final int height;
  final int weight;

  PokemonDetail({
    required this.id,
    required this.name,
    required this.img,
    required this.types,
    required this.height,
    required this.weight,
    required this.baseExperience,
  });

  factory PokemonDetail.fromJson(json) {
    return PokemonDetail(
      id: json['id'],
      name: json['name'],
      types: json['types'],
      img: json['sprites']['other']['official-artwork']['front_default'],
      height: json['height'],
      weight: json['weight'],
      baseExperience: json['base_experience'] ?? 0,
    );
  }
}
