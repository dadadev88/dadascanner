class Pokemon {
  final int id;
  final String name;
  final String img;
  final List<dynamic>? types;
  final List<dynamic>? abilities;

  Pokemon({
    required this.id,
    required this.name,
    required this.img,
    this.types,
    this.abilities,
  });

  factory Pokemon.fromJson(json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      types: json['types'],
      img: json['img'],
      abilities: json['abilities'],
    );
  }

  @override
  String toString() {
    return 'Pokemon $id: ${name.toUpperCase()}';
  }
}
