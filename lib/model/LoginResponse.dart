/// status : "success"
/// message : "Login successful"
/// data : {"first_name":"rizky","last_name":null,"phone_number":"085158426044","email":"fadiillarizky294@gmail.com"}
/// token : "77|huJyu9jwtIp7k0wl5boqUXXWFMpAf6upb6xMU3SY0a0ff1a3"
/// refresh_token : "78|EocqwRTfhH3e936zw6HqUNIEWBMgsMbGM8bQn6uCa8e39f16"

class LoginResponse {
  LoginResponse({
      String? status, 
      String? message, 
      Data? data, 
      String? token, 
      String? refreshToken,}){
    _status = status;
    _message = message;
    _data = data;
    _token = token;
    _refreshToken = refreshToken;
}

  LoginResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _token = json['token'];
    _refreshToken = json['refresh_token'];
  }
  String? _status;
  String? _message;
  Data? _data;
  String? _token;
  String? _refreshToken;
LoginResponse copyWith({  String? status,
  String? message,
  Data? data,
  String? token,
  String? refreshToken,
}) => LoginResponse(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
  token: token ?? _token,
  refreshToken: refreshToken ?? _refreshToken,
);
  String? get status => _status;
  String? get message => _message;
  Data? get data => _data;
  String? get token => _token;
  String? get refreshToken => _refreshToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['token'] = _token;
    map['refresh_token'] = _refreshToken;
    return map;
  }

}

/// first_name : "rizky"
/// last_name : null
/// phone_number : "085158426044"
/// email : "fadiillarizky294@gmail.com"

class Data {
  Data({
      String? firstName, 
      dynamic lastName, 
      String? phoneNumber, 
      String? email,}){
    _firstName = firstName;
    _lastName = lastName;
    _phoneNumber = phoneNumber;
    _email = email;
}

  Data.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _phoneNumber = json['phone_number'];
    _email = json['email'];
  }
  String? _firstName;
  dynamic _lastName;
  String? _phoneNumber;
  String? _email;
Data copyWith({  String? firstName,
  dynamic lastName,
  String? phoneNumber,
  String? email,
}) => Data(  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  phoneNumber: phoneNumber ?? _phoneNumber,
  email: email ?? _email,
);
  String? get firstName => _firstName;
  dynamic get lastName => _lastName;
  String? get phoneNumber => _phoneNumber;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['phone_number'] = _phoneNumber;
    map['email'] = _email;
    return map;
  }

}