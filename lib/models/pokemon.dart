class Pokemon {
  const Pokemon({
    required this.name,
    required this.id,
    required this.imageUrl,
    this.types = const [],
  });

  final String name;
  final int id;
  final String imageUrl;
  final List<String> types;

  String get displayName => name[0].toUpperCase() + name.substring(1);
  String get formattedId => '#${id.toString().padLeft(3, '0')}';

  factory Pokemon.fromJson(
    Map<String, dynamic> json, {
    Map<String, dynamic>? details,
  }) {
    final url = json['url'] as String;
    final id = int.parse(url.split('/').where((part) => part.isNotEmpty).last);

    return Pokemon(
      name: json['name'] as String,
      id: id,
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
      types: ((details?['types'] as List<dynamic>?) ?? const [])
          .map(
            (entry) =>
                (entry as Map<String, dynamic>)['type'] as Map<String, dynamic>,
          )
          .map((type) => type['name'] as String)
          .toList(growable: false),
    );
  }
}
