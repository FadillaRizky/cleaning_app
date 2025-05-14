import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cleaning_app/model/DetailPackageResponse.dart';
import 'package:cleaning_app/model/DetailUserResponse.dart';
import 'package:cleaning_app/model/DurationPackageResponse.dart';
import 'package:cleaning_app/model/ListCategoryPackageResponse.dart';
import 'package:cleaning_app/model/RefreshTokenResponse.dart';
import 'package:cleaning_app/model/RegisterResponse.dart';
import 'package:cleaning_app/model/UpdatePhotoProfileResponse.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'api_helper.dart';
import 'model/ListPackageResponse.dart';
import 'model/LoginResponse.dart';
import 'model/UpdateDetailUserResponse.dart';

class ApiWrapper {
  static const int timeoutDuration = 120; // 2 minutes

  // static Future<T> loginWithTimeout<T>({
  //   required String url,
  //   required Future<http.MultipartRequest> Function() requestBuilder,
  //   required T Function(String body) parser,
  // }) async {
  //   try {
  //     // final connectivityResult = await Connectivity().checkConnectivity();
  //     // if (connectivityResult == ConnectivityResult.none) {
  //     //   throw 'Tidak ada koneksi internet';
  //     // }
  //
  //     final request = await requestBuilder();
  //
  //     final streamedResponse = await request.send().timeout(Duration(seconds: timeoutDuration));
  //     final response = await http.Response.fromStream(streamedResponse);
  //
  //     if (response.statusCode == 200) {
  //       return parser(response.body);
  //     }
  //
  //     // Try to parse error response
  //     try {
  //       final errorBody = json.decode(response.body);
  //       throw _formatErrorMessage(errorBody);
  //     } catch (e) {
  //       if (e is String) throw e;
  //
  //       if (response.statusCode == 401) {
  //         throw 'Email atau password salah';
  //       } else if (response.statusCode >= 500) {
  //         throw 'Server Error';
  //       }
  //       throw 'Gagal request: ${response.statusCode}';
  //     }
  //   } on TimeoutException {
  //     throw 'Request timeout setelah $timeoutDuration detik';
  //   } catch (e) {
  //     if (e is String) throw e;
  //     throw e.toString();
  //   }
  // }
}

class Api {
  static GetStorage storage = GetStorage();
  static const String baseUrl = 'https://client.utilize-go.com/api';

  static Future<LoginResponse> login(Map<String, String> dataUser) async {
    try {
      var url = "$baseUrl/user/login";
      var response = await http.post(Uri.parse(url), body: dataUser).timeout(
          const Duration(
              seconds: 5)); // Increased timeout for better reliability

      final result = LoginResponse.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200 || response.statusCode == 400) {
        return result;
      } else {
        throw 'HTTP error: ${response.statusCode} - ${result.message ?? "Unable to submit Login"}';
      }
    } on TimeoutException catch (_) {
      throw 'Connection timeout. Please check your internet connection.';
    } catch (e) {
      print('Login API Error: $e');
      throw 'An unexpected error occurred during login.';
    }
  }

  static Future<RefreshTokenResponse> refreshToken() async {
    try {
      final token = await storage.read('refresh_token');
      print("refresh token ${token}");
      var url = "$baseUrl/user/refresh-token";
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 10));

      final result = RefreshTokenResponse.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200 || response.statusCode == 400) {
        return result;
      } else {
        throw 'HTTP error: ${response.statusCode} - ${result.message ?? "Unable to submit Login"}';
      }
    } on TimeoutException catch (_) {
      throw 'Connection timeout. Please check your internet connection.';
    } catch (e) {
      print('Refresh Token Error: $e');
      throw 'An unexpected error occurred during Refresh Token.';
    }
  }

  static Future<RegisterResponse> register(Map<String, String> dataUser) async {
    try {
      var url = "$baseUrl/user/register";
      var response = await http.post(Uri.parse(url), body: dataUser).timeout(
          const Duration(
              seconds: 5)); // Increased timeout for better reliability

      final result = RegisterResponse.fromJson(jsonDecode(response.body));
      print("ssss $dataUser");
      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 400) {
        print(result.status);
        return result;
      } else {
        throw 'HTTP error: ${response.statusCode} - ${result.message ?? "Unable to submit Register"}';
      }
    } on TimeoutException catch (_) {
      throw 'Connection timeout. Please check your internet connection.';
    } catch (e) {
      print('Register API Error: $e');
      throw 'An unexpected error occurred during login.';
    }
  }

  static Future<ListCategoryPackageResponse> getCategoryPackageList() async {
    try {
      final url = "$baseUrl/packages/categories";

      final response = await safeApiCall(() async {
        final token = await storage.read('token');
        return await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ).timeout(const Duration(seconds: 10));
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ListCategoryPackageResponse.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        throw 'Gagal request List Package: ${errorData['message'] ?? 'Unknown error'}';
      }
    } on TimeoutException {
      throw 'Request Time Out. Silakan periksa koneksi Anda.';
    } catch (e) {
      print('Error Get List Category Package: $e');
      throw 'Terjadi kesalahan saat mengambil data category List Package.';
    }
  }

  static Future<ListPackageResponse> getPackageList() async {
    try {
      final url = "$baseUrl/packages";

      final response = await safeApiCall(() async {
        final token = await storage.read('token');
        return await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ).timeout(const Duration(seconds: 10));
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ListPackageResponse.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        throw 'Gagal request List Package: ${errorData['message'] ?? 'Unknown error'}';
      }
    } on TimeoutException {
      throw 'Request Time Out. Silakan periksa koneksi Anda.';
    } catch (e) {
      print('Error Get List Package: $e');
      throw 'Terjadi kesalahan saat mengambil data List Package.';
    }
  }

  static Future<DetailPackageResponse> getDetailPackage(String id) async {
    try {
      final url = "$baseUrl/packages/detail/$id";

      final response = await safeApiCall(() async {
        final token = await storage.read('token');
        return await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ).timeout(const Duration(seconds: 10));
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DetailPackageResponse.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        throw 'Gagal request Detail Package: ${errorData['message'] ?? 'Unknown error'}';
      }
    } on TimeoutException {
      throw 'Request Time Out. Silakan periksa koneksi Anda.';
    } catch (e) {
      print('Error Get Detail Package: $e');
      throw 'Terjadi kesalahan saat mengambil data Detail Package.';
    }
  }

  static Future<DurationPackageResponse> getDurationPackage(String id) async {
    try {
      final url = "$baseUrl/packages/hours?pack_id=$id";

      final response = await safeApiCall(() async {
        final token = await storage.read('token');
        return await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ).timeout(const Duration(seconds: 10));
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DurationPackageResponse.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        throw 'Gagal request Duration: ${errorData['message'] ?? 'Unknown error'}';
      }
    } on TimeoutException {
      throw 'Request Time Out. Silakan periksa koneksi Anda.';
    } catch (e) {
      print('Error Get Duration Package: $e');
      throw 'Terjadi kesalahan saat mengambil data Duration Package.';
    }
  }


  static Future<UpdatePhotoProfileResponse> updateAvatar(
      File avatarFile) async {
    try {
      final token = await storage.read('token');
      var url = "$baseUrl/user/update/avatar";
      var request = await http.MultipartRequest('post', Uri.parse(url));
      request.headers["Content-type"] = 'application/json';
      request.headers["Authorization"] = 'Bearer $token';

      request.files.add(await http.MultipartFile.fromPath(
        'avatar_image',
        avatarFile.path,
      ));
      print('File path: ${avatarFile.path}');
      print('File exists: ${await avatarFile.exists()}');

      var response = await request.send();
      var responseJson = await http.Response.fromStream(response);
      print('Status code: ${response.statusCode}');
      print('Response body: ${responseJson.body}');
      if (response.statusCode == 200) {
        return UpdatePhotoProfileResponse.fromJson(
            jsonDecode(responseJson.body));
      } else {
        throw "Unable to update Image";
      }
    } catch (e) {
      print(e);
      throw Exception("Failed to update issue: $e");
    }
  }

  static Future<UpdateDetailUserResponse> updateDetailUser(Map<String, String> dataUser) async {
    try {
      var url = "$baseUrl/user/update";
      final response = await safeApiCall(() async {
        final token = await storage.read('token');
        return await http.put(
          Uri.parse(url),
          headers: {
            // 'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
            body: dataUser
        ).timeout(const Duration(seconds: 10));
      });

      final result = UpdateDetailUserResponse.fromJson(jsonDecode(response.body));
      print("data $dataUser");
      if (response.statusCode == 200 || response.statusCode == 400) {
        print(result.status);
        return result;
      } else {
        throw 'HTTP error: ${response.statusCode} - ${result.message ?? "Unable to update Detail User"}';
      }
    } on TimeoutException catch (_) {
      throw 'Connection timeout. Please check your internet connection.';
    } catch (e) {
      print('Update Detail User Error: $e');
      throw 'An unexpected error occurred during Update.';
    }
  }

  static Future<DetailUserResponse> getDetailUser() async {
    try {
      final url = "$baseUrl/user";
print("---");
      final response = await safeApiCall(() async {
        final token = await storage.read('token');
        return await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ).timeout(const Duration(seconds: 10));
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DetailUserResponse.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        throw 'Gagal request Detail User: ${errorData['message'] ?? 'Unknown error'}';
      }
    } on TimeoutException {
      throw 'Request Time Out. Silakan periksa koneksi Anda.';
    } catch (e) {
      print('Error Get Detail User: $e');
      throw 'Terjadi kesalahan saat mengambil data Detail User.';
    }
  }


}
