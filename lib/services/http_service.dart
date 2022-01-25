import 'dart:developer';

import 'package:apex_demo/model/tournaments.dart';
import 'package:apex_demo/model/user.dart';
import 'package:dio/dio.dart';

class HttpService {
  final client = Dio();

  Future<User?> getUserData() async {
    Response? response;
    String url = "https://jsonblob.com/api/jsonBlob/935179097194381312";
    try {
      response = await client.get(url);
      print(response.data);
    } on DioError catch (e) {
      ///TODO: Different type of exceptions has to be handled so that proper error message can be generated
      throw Exception(e.message);
    }
    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    }
    return null;
  }

  Future<Tournament?> getTournamentsData(Map<String, String> queryParams) async {
    Response? response;
    String url = "http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2";
    try {
      response = await client.get(url, queryParameters: queryParams);
    } on DioError catch (e) {
      ///TODO: Different type of exceptions has to be handled so that proper error message can be generated
      throw Exception(e.message);
    }
    if (response.statusCode == 200) {
      return Tournament.fromJson(response.data);
    }
    return null;
  }

  HttpService() {
    client.interceptors.add(InterceptorsWrapper(onError: (error, handler) {
      log(error.message);
      handler.next(error);
    }, onRequest: (request, handler) {
      log("${request.method} | ${request.path} | ${request.queryParameters}");
      handler.next(request);
    }, onResponse: (response, handler) {
      log("${response.statusCode}"); // ${response.statusMessage} ${response.data}");
      handler.next(response);
    }));
  }
}
