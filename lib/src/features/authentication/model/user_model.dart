

class User{

  late final String name;
  late final String username;
  late final String email;
  late final String password;
  late final String phoneNumber;
  late final String location;

  User({
    required this.name,
    required this.username,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.location });

  //create a User object from a JSON map
  factory User.fromJson(Map<String, dynamic> json){
    return User(
        name: json['name'].toString(),
        username: json['username'].toString(),
        email: json['email'].toString(),
        password: json['password'].toString(),
        phoneNumber: json['phoneNumber'].toString(),
        location: json['location'].toString(),
    );
  }

  // Convert the User to a JSON for API requests
  Map<String, dynamic> toJson()  {
    final Map<String,dynamic> data = <String,dynamic>{};
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    data['location'] = location;
    return data;
  }



}