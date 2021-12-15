class Doctor {
  final String name;
  final String imageUrl;
  final String occupation;
  final String desc;
  final Location location;
  final List<Reviews> reviews;

  Doctor({
    required this.name,
    required this.imageUrl,
    required this.occupation,
    required this.desc,
    required this.location,
    required this.reviews,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        name: json['name'],
        imageUrl: json['imageUrl'],
        occupation: json['occupation'],
        desc: json['desc'],
        location: Location.fromJson(json['location']),
        reviews: [
          for (final reviews in json['reviews'])
            Reviews.fromJson(reviews as Map<String, dynamic>)
        ],
      );
}

class Location {
  final String name;
  final String address;

  Location({required this.name, required this.address});

  factory Location.fromJson(Map<String, dynamic> json) =>
      Location(name: json['name'], address: json['address']);
}

class Reviews {
  final double ranking;
  final Member member;
  final String commentary;

  Reviews(
      {required this.ranking, required this.member, required this.commentary});

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
      ranking: json['ranking'],
      member: Member.fromJson(json['member']),
      commentary: json['commentary']);
}

class Member {
  final String name;
  final String imageUrl;

  Member({required this.name, required this.imageUrl});

  factory Member.fromJson(Map<String, dynamic> json) =>
      Member(name: json['name'], imageUrl: json['imageUrl']);
}
