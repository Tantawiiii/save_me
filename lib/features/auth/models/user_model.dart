// user_model.dart

class User {
  final String? name;
  final String? email;
  final String? password;
  final Location? location;
  final String? phoneNumber;
  final String? contactInfo;

  User({
    this.name,
    this.email,
    this.password,
    this.location,
    this.phoneNumber,
    this.contactInfo,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'location': location?.toJson(),
      'phoneNumber': phoneNumber,
      'contactInfo': contactInfo,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'].toString(),
      email: json['email'].toString(),
      password: json['password'].toString(),
      location: Location.fromJson(json['location']),
      phoneNumber: json['phoneNumber'].toString(),
      contactInfo: json['contactInfo'].toString(),
    );
  }
  User copyWith({
    String? name,
    String? email,
    String? password,
    Location? location,
    String? phoneNumber,
    String? contactInfo,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      location: location ?? this.location,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      contactInfo: contactInfo ?? this.contactInfo,
    );
  }
}

class Location {
  final String? name;
  final double? latitude;
  final double? longitude;

  Location({this.name, this.latitude, this.longitude});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'].toString(),
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
