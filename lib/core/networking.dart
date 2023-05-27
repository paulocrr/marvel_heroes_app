import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

class Networking {
  final dio = Dio();

  Networking() {
    dio.options.baseUrl = 'http://gateway.marvel.com';
  }

  Map<String, dynamic> _getApiKeys() {
    final timestamp = DateTime.now();
    const apiKey = '7e34ba9cf61f21b17560f16cd58ea6e6';
    const privateKey = 'f2040fe74a6cd6debd4fb4e177d096677d1ded23';

    final concatKeys = '$timestamp$privateKey$apiKey';

    final encodeKey = utf8.encode(concatKeys);
    final hash = md5.convert(encodeKey).toString();

    return {'ts': timestamp.toString(), 'apikey': apiKey, 'hash': hash};
  }

  // GET, POST/PUT, PATCH, DELETE
  Future<Map<String, dynamic>> get({
    required String operationPath,
    Map<String, dynamic>? params,
  }) async {
    Map<String, dynamic> queryParams = {};

    final key = _getApiKeys();
    if (params != null) {
      queryParams.addAll(params);
      queryParams.addAll(key);
    } else {
      queryParams.addAll(key);
    }

    final response = await dio.get(operationPath, queryParameters: queryParams);
    return response.data;
  }
}
