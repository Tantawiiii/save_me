class ProfileInfo {
  final String? id;
  final String? profileType;
  final String? photoUrl;
  final String? name;
  String? birthdate;
  final String? age;
  final String? size;
  final String? weight;
  final String? height;
  final String? heightUnit;
  final String? weightUnit;
  final String? characteristics;
  final String? behavior;
  final String? specialCharacteristics;
  final String? diet;
  final String? additionalInformation;
  final Institution? institution;
  final String? allergies;
  final String? diseases;
  final String? medicines;
  final String? race;
  final bool? neutered;

  final String? createdDate;
  final String? message;

  ProfileInfo({
    this.id,
    this.profileType,
    this.photoUrl,
    this.name,
    this.birthdate,
    this.age,
    this.size,
    this.weight,
    this.height,
    this.heightUnit,
    this.weightUnit,
    this.characteristics,
    this.behavior,
    this.specialCharacteristics,
    this.diet,
    this.additionalInformation,
    this.institution,
    this.allergies,
    this.diseases,
    this.medicines,
    this.race,
    this.neutered,
    this.createdDate,
    this.message,
  });

  factory ProfileInfo.fromJson(Map<String?, dynamic> json) {
    return ProfileInfo(
      id: json['id'].toString(),
      createdDate: json['createdAt'].toString(),
      profileType: json['profileType'].toString(),
      photoUrl: json['photoUrl'],
      name: json['name'].toString(),
      birthdate: json['birthdate'].toString(),
      age: json['age'].toString(),
      size: json['size'].toString(),
      weight: json['weight'].toString(),
      height: json['height'].toString(),
      heightUnit: json['heightUnit'].toString(),
      weightUnit: json['weightUnit'].toString(),
      characteristics: json['characteristics'].toString(),
      behavior: json['behavior'].toString(),
      specialCharacteristics: json['specialCharacteristics'].toString(),
      diet: json['diet'].toString(),
      additionalInformation: json['additionalInformation'].toString(),
      institution: json['institution'] != null
          ? Institution.fromJson(json['institution']!)
          : null,
      allergies: json['allergies'].toString(),
      diseases: json['diseases'].toString(),
      medicines: json['medicines'].toString(),
      race: json['race'].toString(),
      message: json['message'].toString(),
      neutered: json['neutered'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdDate,
      'profileType': profileType,
      'photoUrl': photoUrl,
      'name': name,
      'birthdate': birthdate,
      'age': age,
      'size': size,
      'weight': weight,
      'height': height,
      'heightUnit': heightUnit,
      'weightUnit': weightUnit,
      'characteristics': characteristics,
      'behavior': behavior,
      'specialCharacteristics': specialCharacteristics,
      'diet': diet,
      'additionalInformation': additionalInformation,
      'institution': institution?.toJson(),
      'allergies': allergies,
      'diseases': diseases,
      'medicines': medicines,
      'race': race,
      'neutered': neutered,
      'message': message,
    };
  }

  // Update data from copy with
  ProfileInfo copyWith({
    String? id,
    String? profileType,
    String? photoUrl,
    String? name,
    // String? birthdate,
    String? age,
    String? size,
    String? weight,
    String? height,
    String? heightUnit,
    String? weightUnit,
    String? characteristics,
    String? behavior,
    String? specialCharacteristics,
    String? diet,
    String? additionalInformation,
    Institution? institution,
    String? allergies,
    String? diseases,
    String? medicines,
    String? race,
    bool? neutered,
    // String? createdDate,
    String? message,
  }) {
    return ProfileInfo(
      id: id ?? this.id,
      profileType: profileType ?? this.profileType,
      photoUrl: photoUrl ?? this.photoUrl,
      name: name ?? this.name,
      // birthdate: birthdate ?? this.birthdate,
      age: age ?? this.age,
      size: size ?? this.size,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      heightUnit: heightUnit ?? this.heightUnit,
      weightUnit: weightUnit ?? this.weightUnit,
      characteristics: characteristics ?? this.characteristics,
      behavior: behavior ?? this.behavior,
      specialCharacteristics:
          specialCharacteristics ?? this.specialCharacteristics,
      diet: diet ?? this.diet,
      additionalInformation:
          additionalInformation ?? this.additionalInformation,
      institution: institution ?? this.institution,
      allergies: allergies ?? this.allergies,
      diseases: diseases ?? this.diseases,
      medicines: medicines ?? this.medicines,
      race: race ?? this.race,
      neutered: neutered ?? this.neutered,
      // createdDate: createdDate ?? this.createdDate,
      message: message ?? this.message,
    );
  }
}

class Institution {
  final String? nameIn;
  final String? websiteIn;
  final String? aidNameIn;
  final String? aidPhoneNumberIn;
  final LocationProfile? locationIn;

  Institution({
    this.nameIn,
    this.websiteIn,
    this.aidNameIn,
    this.locationIn,
    this.aidPhoneNumberIn,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': nameIn,
      'website': websiteIn,
      'aidName': aidNameIn,
      'aidPhoneNumber': aidPhoneNumberIn,
      'location': locationIn?.toJson(),
    };
  }

  factory Institution.fromJson(Map<String, dynamic> json) {
    return Institution(
      nameIn: json['name'].toString(),
      websiteIn: json['website'].toString(),
      aidNameIn: json['aidName'].toString(),
      aidPhoneNumberIn: json['aidPhoneNumber'].toString(),
      locationIn: json['location'] != null
          ? LocationProfile.fromJson(json['location']!)
          : null,
    );
  }

  Institution copyWith({
    String? nameIn,
    String? websiteIn,
    String? aidNameIn,
    String? aidPhoneNumberIn,
    LocationProfile? locationIn,
  }) {
    return Institution(
      nameIn: nameIn ?? this.nameIn,
      websiteIn: websiteIn ?? this.websiteIn,
      aidNameIn: aidNameIn ?? this.aidNameIn,
      aidPhoneNumberIn: aidPhoneNumberIn ?? this.aidPhoneNumberIn,
      locationIn: locationIn ?? this.locationIn,
    );
  }
}

class LocationProfile {
  final String? nameLocation;
  final double? latitude;
  final double? longitude;

  LocationProfile({this.nameLocation, this.latitude, this.longitude});

  Map<String, dynamic> toJson() {
    return {
      'name': nameLocation,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  LocationProfile copyWith({
    String? nameLocation,
    double? latitude,
    double? longitude,
  }) {
    return LocationProfile(
      nameLocation: nameLocation ?? this.nameLocation,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  factory LocationProfile.fromJson(Map<String, dynamic> json) {
    return LocationProfile(
      nameLocation: json['name'].toString(),
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
