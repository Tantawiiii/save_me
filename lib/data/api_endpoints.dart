abstract class Endpoints {
  Endpoints._();

  /*
      portal-saveme-dev.fillflix.de, api-saveme-dev.fillflix.de
      portal-saveme-qa.fillflix.de, api-saveme-qa.fillflix.de
      portal-saveme-preprod.fillflix.de, api-saveme-preprod.fillflix.de
   */

  static const baseUrl = "https://api-saveme-dev.fillflix.de";
  static const frontUrl = "https://portal-saveme-dev.fillflix.de";
  static const register = '$baseUrl/api/v1/users';
  static const login = '$baseUrl/api/v1/login';
  static const changePassword = '$baseUrl/api/v1/users/change-password';
  static const profiles = '$baseUrl/api/v1/profiles';

  static profilePhotoUplaod(String profileId) =>
      '$baseUrl/api/v1/profiles/$profileId/photo';

  static profileId(String profileId) => '$baseUrl/api/v1/profiles/$profileId';
  static const profileUserUplaodImage = '$baseUrl/api/v1/users/photo';

  static publicProfileFrontEnd(String profileId) =>
      '$frontUrl/public-profile/$profileId';
}
