
abstract class Endpoints{

  Endpoints._();

  static const baseUrl = "https://api-saveme.dev.fillflix.de";
  static const register = '$baseUrl/api/v1/users';
  static const login = '$baseUrl/api/v1/login';
  static const profiles = '$baseUrl/api/v1/profiles';
  static const profileId = '$baseUrl/api/v1/profiles/:profileId';

}