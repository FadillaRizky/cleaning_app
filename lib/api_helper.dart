import 'dart:convert';
import 'dart:async';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'api.dart'; // berisi fungsi refreshToken()

  final GetStorage storage = GetStorage();
Future<http.Response> safeApiCall(Future<http.Response> Function() apiCall) async {
  http.Response response = await apiCall();
    print("Status code adalah ${response.statusCode}");
  if (response.statusCode == 401 || response.statusCode == 500) {
    print("jalan");
    final refreshResult = await Api.refreshToken();
    print(refreshResult.message);
    if (refreshResult.data!.token != null) {
      await storage.write('token', refreshResult.data!.token!);
      print("token baru ${storage.read('token')}");
      response = await apiCall();
      print("response ulang ${response.statusCode}");
    } else {
      throw 'Somethink went wrong.';
    }
  }

  return response;
}
