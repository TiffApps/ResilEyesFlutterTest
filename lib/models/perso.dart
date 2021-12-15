class Perso {
  final String name;
  final String image;

  Perso({
    required this.name,
    required this.image,
  });

  factory Perso.fromJson(Map<String, dynamic> json) {
    return Perso(name: json['name'], image: json['imageUrl']);
  }
}
