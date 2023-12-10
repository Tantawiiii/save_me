

class User{

   final String? name;
   final String? photoUrl;
   final String email;
   final String password;
   final String? phoneNumber;
   final String? location;
   final String? contactInfo;
   final String? id;


  User({
    this.id,
    this.name,
    required this.email,
    required this.password,
     this.phoneNumber,
     this.location,
     this.photoUrl,
     this.contactInfo,
  });

  //create a User object from a JSON map
  factory User.fromJson(Map<String, dynamic> json){
    return User(
        name: json['name'].toString(),
        email: json['email'].toString(),
        password: json['password'].toString(),
        phoneNumber: json['phoneNumber'].toString(),
        location: json['location'].toString(),
      photoUrl:  json['photoUrl'].toString(),
      contactInfo:  json['contactInfo'].toString(),
      id:  json['id'].toString(),
    );
  }

  // Convert the User to a JSON for API requests
  Map<String, dynamic> toJson()  {
    final Map<String,dynamic> data = <String,dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    data['location'] = location;
    data['photoUrl'] = photoUrl;
    data['contactInfo'] = contactInfo;
    data['id'] = id;
    return data;
  }



}