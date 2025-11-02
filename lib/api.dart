import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cleaning_app/model/BannerResponse.dart';
import 'package:cleaning_app/model/CancelOrderResponse.dart';
import 'package:cleaning_app/model/DetailOrderResponse.dart';
import 'package:cleaning_app/model/DetailPackageResponse.dart';
import 'package:cleaning_app/model/DetailUserResponse.dart';
import 'package:cleaning_app/model/DurationPackageResponse.dart';
import 'package:cleaning_app/model/GetListOrderResponse.dart';
import 'package:cleaning_app/model/GetSaldoResponse.dart';
import 'package:cleaning_app/model/HistoryTransaksiResponse.dart';
import 'package:cleaning_app/model/ListCategoryPackageResponse.dart';
import 'package:cleaning_app/model/LogoutResponse.dart';
import 'package:cleaning_app/model/ObjectPackageResponse.dart';
import 'package:cleaning_app/model/OrderPackageResponse.dart';
import 'package:cleaning_app/model/PropertyAddressResponse.dart';
import 'package:cleaning_app/model/RefreshTokenResponse.dart';
import 'package:cleaning_app/model/RegisterResponse.dart';
import 'package:cleaning_app/model/StoreAddressResponse.dart';
import 'package:cleaning_app/model/UpdateAddressResponse.dart';
import 'package:cleaning_app/model/UpdatePhotoProfileResponse.dart';
import 'package:cleaning_app/model/UploadBuktiTopupResponse.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'api_helper.dart';
import 'model/DeleteAddressResponse.dart';
import 'model/GetNotificationResponse.dart';
import 'model/ListPackageResponse.dart';
import 'model/LoginResponse.dart';
import 'model/UpdateDetailUserResponse.dart';
import 'model/UpdateNotificationResponse.dart';

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
  
  static Future<LogoutResponse> logout() async {
    try {
      var url = "$baseUrl/partner/logout";
      final response = await safeApiCall(() async {
        final token = await storage.read('token');
        return await http
            .get(
              Uri.parse(url),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              },
            )
            .timeout(const Duration(seconds: 10));
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        return LogoutResponse.fromJson(jsonDecode(response.body));
      } else {
        throw "Unable to Logout :${response.body}";
      }
    } on TimeoutException {
      throw 'Request Time Out. Silakan periksa koneksi Anda.';
    } catch (e) {
      print('Error Logout: $e');
      throw e;
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
      ).timeout(const Duration(seconds: 20));

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
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 400) {
        print(result.status);
        return result;
      } else if (response.statusCode == 401) {
        throw 'Email atau nomor HP ini sudah digunakan. Silakan gunakan data lain.';
      } else {
        throw 'HTTP error: ${response.statusCode} - ${result.message ?? "Unable to submit Register"}';
      }
    } on TimeoutException catch (_) {
      throw 'Connection timeout. Please check your internet connection.';
    } catch (e) {
      print('Registrasi gagal: $e');
      throw 'Registrasi gagal: $e';
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
        ).timeout(const Duration(seconds: 20));
      });

      if (response.statusCode == 200) {
        final decodedBody = utf8.decode(response.bodyBytes);
      final data = jsonDecode(decodedBody);
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

  static Future<ListPackageResponse> getPackageList(String category) async {
    try {
      final url = "$baseUrl/packages?category=$category";

      final response = await safeApiCall(() async {
        final token = await storage.read('token');
        return await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ).timeout(const Duration(seconds: 20));
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

  static Future<ObjectPackageResponse> getObjectPackage(String pack_id) async {
    try {
      final url = "$baseUrl/packages/objects?pack_id=$pack_id";

      final response = await safeApiCall(() async {
        final token = await storage.read('token');
        return await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ).timeout(const Duration(seconds: 20));
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ObjectPackageResponse.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        throw 'Gagal request Object Package: ${errorData['message'] ?? 'Unknown error'}';
      }
    } on TimeoutException {
      throw 'Request Time Out. Silakan periksa koneksi Anda.';
    } catch (e) {
      print('Error Get Object Package: $e');
      throw 'Terjadi kesalahan saat mengambil data Object Package.';
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
        ).timeout(const Duration(seconds: 20));
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
      final url = "$baseUrl/packages/hours/$id";

      final response = await safeApiCall(() async {
        final token = await storage.read('token');
        return await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ).timeout(const Duration(seconds: 20));
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Duration package response: $data");
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

  static Future<PropertyAddressResponse> getAddress() async {
    try {
      final url = "$baseUrl/client/properties";

      final response = await safeApiCall(() async {
        final token = await storage.read('token');
        return await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ).timeout(const Duration(seconds: 20));
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return PropertyAddressResponse.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        throw 'Gagal request Address: ${errorData['message'] ?? 'Unknown error'}';
      }
    } on TimeoutException {
      throw 'Request Time Out. Silakan periksa koneksi Anda.';
    } catch (e) {
      print('Error Get Address Package: $e');
      throw 'Terjadi kesalahan saat mengambil data Address Package.';
    }
  }

  static Future<StoreAddressResponse> storeAddress(
      Map<String, dynamic> data) async {
    try {
      final url = "$baseUrl/client/property/store";

      final response = await safeApiCall(() async {
        final token = await storage.read('token');
        return await http
            .post(Uri.parse(url),
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer $token',
                },
                body: jsonEncode(data))
            .timeout(const Duration(seconds: 20));
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return StoreAddressResponse.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        throw 'Gagal store Address: ${errorData['message'] ?? 'Unknown error'}';
      }
    } on TimeoutException {
      throw 'Request Time Out. Silakan periksa koneksi Anda.';
    } catch (e) {
      print('Error Store Address: $e');
      throw 'Terjadi kesalahan saat kirim data Address.';
    }
  }

  static Future<StoreAddressResponse> updateAddress(
      Map<String, dynamic> data) async {
    try {
      final url = "$baseUrl/client/property/update";

      final response = await safeApiCall(() async {
        final token = await storage.read('token');
        return await http
            .put(Uri.parse(url),
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer $token',
                },
                body: jsonEncode(data))
            .timeout(const Duration(seconds: 20));
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return StoreAddressResponse.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        throw 'Gagal Update Address: ${errorData['message'] ?? 'Unknown error'}';
      }
    } on TimeoutException {
      throw 'Request Time Out. Silakan periksa koneksi Anda.';
    } catch (e) {
      print('Error Update Address: $e');
      throw 'Terjadi kesalahan saat update data Address.';
    }
  }

  static Future<DeleteAddressResponse> deleteAddress(
      Map<String, dynamic> data) async {
    try {
      final url = "$baseUrl/client/property/delete";

      final response = await safeApiCall(() async {
        final token = await storage.read('token');
        return await http
            .post(Uri.parse(url),
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer $token',
                },
                body: jsonEncode(data))
            .timeout(const Duration(seconds: 20));
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return DeleteAddressResponse.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        throw 'Gagal Delete Address: ${errorData['message'] ?? 'Unknown error'}';
      }
    } on TimeoutException {
      throw 'Request Time Out. Silakan periksa koneksi Anda.';
    } catch (e) {
      print('Error Get Address Package: $e');
      throw 'Terjadi kesalahan saat Delete data Address .';
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
  

  static Future<UpdateDetailUserResponse> updateDetailUser(
      Map<String, String> dataUser) async {
    try {
      var url = "$baseUrl/user/update";
      final response = await safeApiCall(() async {
        final token = await storage.read('token');
        return await http
            .put(Uri.parse(url),
                headers: {
                  // 'Content-Type': 'application/json',
                  'Authorization': 'Bearer $token',
                },
                body: dataUser)
            .timeout(const Duration(seconds: 20));
      });

      final result =
          UpdateDetailUserResponse.fromJson(jsonDecode(response.body));
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
        ).timeout(const Duration(seconds: 20));
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

  static Future<UploadBuktiTopupResponse> uploadBuktiTopup(
      String date, String nominal, File documentFile) async {
    try {
      final token = await storage.read('token');
      var url = "$baseUrl/client/topup";
      var request = await http.MultipartRequest('post', Uri.parse(url));
      request.headers["Content-type"] = 'application/json';
      request.headers["Authorization"] = 'Bearer $token';

      request.fields['topup_date'] = date;
      request.fields['topup_nominal'] = nominal;
      request.files.add(await http.MultipartFile.fromPath(
        'topup_receipt',
        documentFile.path,
      ));
      print('File path: ${documentFile.path}');
      print('File exists: ${await documentFile.exists()}');

      var response = await request.send();
      var responseJson = await http.Response.fromStream(response);
      print('Status code: ${response.statusCode}');
      print('Response body: ${responseJson.body}');
      if (response.statusCode == 200) {
        return UploadBuktiTopupResponse.fromJson(jsonDecode(responseJson.body));
      } else {
        throw "Unable to upload Image";
      }
    } catch (e) {
      print(e);
      throw Exception("Failed to upload document: $e");
    }
  }

  static Future<GetSaldoResponse> getSaldo() async {
    try {
      final url = "$baseUrl/client/balance";

      final response = await safeApiCall(() async {
        final token = await storage.read('token');
        return await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ).timeout(const Duration(seconds: 20));
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return GetSaldoResponse.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        throw 'Gagal Get Saldo: ${errorData['message'] ?? 'Unknown error'}';
      }
    } on TimeoutException {
      throw 'Request Time Out. Silakan periksa koneksi Anda.';
    } catch (e) {
      print('Error Get Saldo: $e');
      throw 'Terjadi kesalahan saat mengambil data Get Saldo.';
    }
  }

  static Future<OrderPackageResponse> orderPackage(
    Map<String, dynamic> data,
    File? images,
  ) async {
    try {
      var url = "$baseUrl/orders/store";
      final response = await safeApiCall(() async {
        final token = await storage.read('token');

        var request = http.MultipartRequest('POST', Uri.parse(url))
          ..headers['Authorization'] = 'Bearer $token';

        data.forEach((key, value) {
          // if (value != null && value.toString().isNotEmpty) {
          //   request.fields[key] = value.toString();
          // }
          request.fields[key] = value.toString();
        });

        if (images != null) {
          request.files.add(
          await http.MultipartFile.fromPath('receipt_document', images.path),
        );
        }

        final streamedResponse = await request.send().timeout(
              const Duration(seconds: 20),
            );

        return await http.Response.fromStream(streamedResponse);
      });

      // final response = await safeApiCall(() async {
      //   final token = await storage.read('token');
      //   print(token);
      //   return await http
      //       .post(Uri.parse(url),
      //           headers: {
      //             'Content-Type': 'application/json',
      //             'Authorization': 'Bearer $token',
      //           },
      //           body: jsonEncode(data))
      //       .timeout(const Duration(seconds: 20));
      // });
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return OrderPackageResponse.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        throw 'Gagal Order package: ${errorData['message'] ?? 'Unknown error'}';
      }
    } on TimeoutException {
      throw 'Request Time Out. Silakan periksa koneksi Anda.';
    } catch (e) {
      print('Error Order package: $e');
      throw 'Terjadi kesalahan saat Order package : $e';
    }
  }

  static Future<GetListOrderResponse> getListOrder() async {
    try {
      final url = "$baseUrl/orders";

      final response = await safeApiCall(() async {
        final token = await storage.read('token');
        return await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ).timeout(const Duration(seconds: 20));
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return GetListOrderResponse.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        throw 'Gagal Get List Order: ${errorData['message'] ?? 'Unknown error'}';
      }
    } on TimeoutException {
      throw 'Request Time Out. Silakan periksa koneksi Anda.';
    } catch (e) {
      print('Error Get Saldo: $e');
      throw 'Terjadi kesalahan saat mengambil data Get List Order.';
    }
  }

  static Future<CancelOrderResponse> cancelOrder(
      Map<String, dynamic> data) async {
    try {
      final url = "$baseUrl/orders/cancel";

      final response = await safeApiCall(() async {
        final token = await storage.read('token');
        return await http
            .post(Uri.parse(url),
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer $token',
                },
                body: jsonEncode(data))
            .timeout(const Duration(seconds: 20));
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return CancelOrderResponse.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        throw 'Gagal Cancel Order: ${errorData['message'] ?? 'Unknown error'}';
      }
    } on TimeoutException {
      throw 'Request Time Out. Silakan periksa koneksi Anda.';
    } catch (e) {
      print('Error Get Address Package: $e');
      throw 'Terjadi kesalahan saat Cancel Order';
    }
  }

  static Future<DetailOrderResponse> getDetailOrder(String id) async {
    try {
      final url = "$baseUrl/orders/detail/$id";

      final response = await safeApiCall(() async {
        final token = await storage.read('token');
        return await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ).timeout(const Duration(seconds: 20));
      });
      print("Status code 2: ${response.statusCode}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        return DetailOrderResponse.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        throw 'Gagal Get Detail Order: ${errorData['message'] ?? 'Unknown error'}';
      }
    } on TimeoutException {
      throw 'Request Time Out. Silakan periksa koneksi Anda.';
    } catch (e) {
      print('Error Get Detail Order: $e');
      throw 'Terjadi kesalahan saat mengambil data Get Detail Order.';
    }
  }

  static Future<HistoryTransaksiResponse> getHistoryTransaksi() async {
    try {
      final url = "$baseUrl/client/tractions";

      final response = await safeApiCall(() async {
        final token = await storage.read('token');
        return await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ).timeout(const Duration(seconds: 20));
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return HistoryTransaksiResponse.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        throw 'Gagal Get History Transaksi: ${errorData['message'] ?? 'Unknown error'}';
      }
    } on TimeoutException {
      throw 'Request Time Out. Silakan periksa koneksi Anda.';
    } catch (e) {
      print('Error Get Saldo: $e');
      throw 'Terjadi kesalahan saat mengambil History Transaksi.';
    }
  }

  static Future<GetNotificationResponse> getNotification() async {
    try {
      final url = "$baseUrl/notif";

      final response = await safeApiCall(() async {
        final token = await storage.read('token');
        return await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ).timeout(const Duration(seconds: 20));
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return GetNotificationResponse.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        throw 'Gagal Get Notification: ${errorData['message'] ?? 'Unknown error'}';
      }
    } on TimeoutException {
      throw 'Request Time Out. Silakan periksa koneksi Anda.';
    } catch (e) {
      print('Error Get Saldo: $e');
      throw 'Terjadi kesalahan saat mengambil data Get Notification.';
    }
  }

  static Future<UpdateNotificationResponse> updateNotification(
      String id) async {
    try {
      final url = "$baseUrl/notif/status/update?id=$id";

      final response = await safeApiCall(() async {
        final token = await storage.read('token');
        return await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ).timeout(const Duration(seconds: 20));
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return UpdateNotificationResponse.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        throw 'Gagal Get Notification: ${errorData['message'] ?? 'Unknown error'}';
      }
    } on TimeoutException {
      throw 'Request Time Out. Silakan periksa koneksi Anda.';
    } catch (e) {
      print('Error Get Notification: $e');
      throw 'Terjadi kesalahan saat mengambil data Get Notification.';
    }
  }

  static Future<BannerResponse> getBanner() async {
    try {
      final url = "$baseUrl/packages/banners";

      final response = await safeApiCall(() async {
        final token = await storage.read('token');
        return await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ).timeout(const Duration(seconds: 20));
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return BannerResponse.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        throw 'Gagal Get Banner: ${errorData['message'] ?? 'Unknown error'}';
      }
    } on TimeoutException {
      throw 'Request Time Out. Silakan periksa koneksi Anda.';
    } catch (e) {
      print('Error Get Banner: $e');
      throw 'Terjadi kesalahan saat mengambil data Get Banner.';
    }
  }
}
