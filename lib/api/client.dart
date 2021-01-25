import 'dart:collection';
import 'package:flutter_login2/models/auth.dart';
import 'package:flutter_login2/utils/storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const API_HOST = "http://10.0.11.157:8000/";

class GenericResponse {
  int statusCode;

  GenericResponse(this.statusCode);

  GenericResponse.fromResponse(Response response) {
    statusCode = response.statusCode;
  }
}

class LoginResponse extends GenericResponse {
  final AuthTokens authTokens;

  LoginResponse(statusCode, this.authTokens) : super(statusCode);
}

class RegisterResponse extends GenericResponse {
  final HashMap<String, String> validationErrors;

  RegisterResponse(statusCode, this.validationErrors) : super(statusCode);
}

class APIClient {
  final Dio _dio = Dio();

  Future<AuthTokens> refreshToken(BuildContext context) async {
    final AuthTokens authTokens = await getCurrentTokens();
    if (authTokens == null) {
      return null;
    }
    return _dio
        .post(API_HOST + "jwt/refresh/",
            data: {'refresh': authTokens.refreshToken},
            options: Options(validateStatus: (status) => status < 500))
        .then((response) {
      authTokens.accessToken = response.data['access'];
      if (response.data['access'] != null) {
        authTokens.save();
        return authTokens;
      }
      return null;
    });
  }

  void login(username, Function(LoginResponse) callback) {
    _dio
        .post(API_HOST + "jwt/create/",
            data: {'username': username, 'password': 123}, //password
            options: Options(validateStatus: (status) => status < 500))
        .then((response) {
      AuthTokens authTokens = response.statusCode == 200
          ? AuthTokens.fromJson(response.data)
          : null;
      authTokens?.save();
      callback(new LoginResponse(response.statusCode, authTokens));
    });
  }

  void register(String username, String password,
      Function(RegisterResponse) callback) async {
    _dio
        .post(API_HOST + "api/user/",
            data: {
              'username': username,
              'password': password,
            },
            options: Options(validateStatus: (status) => status < 500))
        .then((response) {
      callback(new RegisterResponse(
          response.statusCode,
          HashMap.from(response.data.map((key, value) => MapEntry(
              key.toString(), value != null ? value[0].toString() : null)))));
    });
  }
}
