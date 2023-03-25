class PokemonEntry{
  String name;
  String url;

  PokemonEntry({required this.name, required this.url});

  factory PokemonEntry.fromJson(Map<String, dynamic> map) {
    return PokemonEntry(
      name: map['name'],
      url: map['url']
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url
    };
  }
}