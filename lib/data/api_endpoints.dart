abstract class Endpoints {
  Endpoints._();

  // http://portal-saveme.preprod.fillflix.de
  // http://portal-saveme.qa.fillflix.de
  //https://api-saveme.dev.fillflix.de

  static const baseUrl = "https://api-saveme.dev.fillflix.de";
  static const frontUrl = "https://portal-saveme.dev.fillflix.de";
  static const register = '$baseUrl/api/v1/users';
  static const login = '$baseUrl/api/v1/login';
  static const changePassword = '$baseUrl/api/v1/users/change-password';
  static const profiles = '$baseUrl/api/v1/profiles';

  static profilePhotoUplaod(String profileId) => '$baseUrl/api/v1/profiles/$profileId/photo';
  static profileId(String profileId) => '$baseUrl/api/v1/profiles/$profileId';
  static const profileUserUplaod = '$baseUrl/api/v1/users/photo';

  static publicProfileFrontEnd(String profileId) => '$frontUrl/public-profile/$profileId';
}
