class PokemonEntry{
  String name;
  String url;
  int id;

  PokemonEntry({required this.name, required this.url, required this.id});

  factory PokemonEntry.fromJson(Map<String, dynamic> map) {
    return PokemonEntry(
      name: map['name'],
      url: map['url'],
      id: map['id']
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
      'id': id
    };
  }
}