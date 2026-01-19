class User {
  final String id;
  final String name;
  final int age;
  final List<String> photos;
  final String? occupation;
  final String? incomeTier;
  final bool isVerified;
  final bool isBlack;

  User({
    required this.id,
    required this.name,
    required this.age,
    required this.photos,
    this.occupation,
    this.incomeTier,
    this.isVerified = false,
    this.isBlack = false,
  });

  factory User.fromFirestore(Map<String, dynamic> data, String id) {
    return User(
      id: id,
      name: data['name'] ?? '',
      age: data['age'] ?? 0,
      photos: List<String>.from(data['photos'] ?? []),
      occupation: data['occupation'],
      incomeTier: data['incomeTier'],
      isVerified: data['isVerified'] ?? false,
      isBlack: data['isBlack'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'photos': photos,
      'occupation': occupation,
      'incomeTier': incomeTier,
      'isVerified': isVerified,
      'isBlack': isBlack,
    };
  }
}
