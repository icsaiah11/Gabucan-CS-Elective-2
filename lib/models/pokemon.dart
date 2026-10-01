class Pokemon {
  const Pokemon({required this.name, required this.id, required this.imageUrl});

  final String name;
  final int id;
  final String imageUrl;

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final url = json['url'] as String;
    final id = int.parse(url.split('/').where((part) => part.isNotEmpty).last);

    return Pokemon(
      name: json['name'] as String,
      id: id,
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
    );
  }
}
