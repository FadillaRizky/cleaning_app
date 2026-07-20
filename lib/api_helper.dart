import 'dart:convert';
import 'dart:async';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'api.dart'; // berisi fungsi refreshToken()

  final GetStorage storage = GetStorage();

Future<http.Response> safeApiCall(
  Future<http.Response> Function() apiCall
  ) async {
  http.Response response = await apiCall();
  if (response.statusCode == 401 ) {
   
   try {
    print("refresh..");
      final refreshResult = await Api.refreshToken();

      final newToken = refreshResult.data?.token;
      if (newToken == null) {
        throw ApiException('Refresh token invalid');
      }

      await Api.storage.write('token', newToken);

      // retry request dengan token baru
      response = await apiCall();
    } catch (e) {
      // AUTO LOGOUT
      // await AuthService.forceLogout(
      //   message: 'Session kamu telah berakhir. Silakan login kembali.',
      // );

      // throw ApiException(
      //   'Unauthorized - session expired',
      //   statusCode: 401,
      // );
    }
  }
print("-done-");
  return response;
}
