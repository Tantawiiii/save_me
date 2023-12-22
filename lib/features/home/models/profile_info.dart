class ProfileInfo {
  final String? id;
  final String? profileType;
  final String? photoUrl;
  final String? name;
  final String? birthdate;
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
      institution:json['institution'] != null
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
}

class Institution {
  final String? nameIn;
  final String? websiteIn;
  final String? aidNameIn;
  final String? aidPhoneNumberIn;
  final Location? locationIn;

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
          ? Location.fromJson(json['location']!)
          : null,
    );
  }
}

class Location {
  final String? nameLocation;
  final double? latitude;
  final double? longitude;

  Location({this.nameLocation, this.latitude, this.longitude});

  Map<String, dynamic> toJson() {
    return {
      'name': nameLocation,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      nameLocation: json['name'].toString(),
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
