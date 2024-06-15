class User {
  final String id;
  final String name;
  final String gender;
  final DateTime? dateOfBirth;
  final String? phone;
  final String email;
  final String password;
  final String? location;
  final double? familyIncome;
  final int? adhaarNumber;
  final String? levelOfEducation;
  final String areaOfInterest;
  final String languagesKnown;
  final String preferableLanguage;

  User({
    required this.id,
    required this.name,
    required this.gender,
    required this.dateOfBirth,
    required this.phone,
    required this.email,
    required this.password,
    required this.location,
    required this.familyIncome,
    required this.adhaarNumber,
    required this.levelOfEducation,
    required this.areaOfInterest,
    required this.languagesKnown,
    required this.preferableLanguage,
  });

  // Convert a User object into a Map object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'dateOfBirth': dateOfBirth!.toIso8601String(),
      'phone': phone,
      'email': email,
      'password': password,
      'location': location,
      'familyIncome': familyIncome,
      'adhaarNumber': adhaarNumber,
      'levelOfEducation': levelOfEducation,
      'areaOfInterest': areaOfInterest,
      'languagesKnown': languagesKnown,
      'preferableLanguage': preferableLanguage,
    };
  }

  // Convert a Map object into a User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      phone: json['phone'],
      email: json['email'],
      password: json['password'],
      location: json['location'],
      familyIncome: json['familyIncome'].toDouble(),
      adhaarNumber: json['adhaarNumber'],
      levelOfEducation: json['levelOfEducation'],
      areaOfInterest: json['areaOfInterest'],
      languagesKnown: json['languagesKnown'],
      preferableLanguage: json['preferableLanguage'],
    );
  }
}
