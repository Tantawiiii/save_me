
import 'package:dio/dio.dart';

class ApiClient {

  final Dio dio = Dio();

  Future<Response> registerUser(Map<String, dynamic>? userData) async {
    try {
      Response response = await dio.post(
          'https://api-saveme.preprod.fillflix.de/auth/register',
          data: userData,
          );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<Response> login(String email, String password) async {
    try {
      Response response = await dio.post(
        'https://api-saveme.preprod.fillflix.de/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<Response> logout(String accessToken) async {
    try {
      Response response =
      await dio.get(
        'https://portal-saveme.preprod.fillflix.de/static/media/404Horse.7610c0c9d4cc6bae6840.gif',
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }


}