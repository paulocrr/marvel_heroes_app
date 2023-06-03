class Character {
  final int id;
  final String name;
  final String thumbnail;

  Character({
    required this.id,
    required this.name,
    required this.thumbnail,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      thumbnail:
          "${json['thumbnail']['path']}.${json['thumbnail']['extension']}",
    );
  }
}
