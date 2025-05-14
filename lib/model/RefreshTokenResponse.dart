/// status : true
/// message : "token berhasil diperbaharui"
/// data : {"first_name":"fadila","last_name":"gusnadi","email":"fadilla@gmail.com","token":"211|RxAE0hXMhBYv7NPXRIl0z9P0USgio2P8xUfspLlme71f4fae"}

class RefreshTokenResponse {
  RefreshTokenResponse({
      bool? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  RefreshTokenResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
RefreshTokenResponse copyWith({  bool? status,
  String? message,
  Data? data,
}) => RefreshTokenResponse(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// first_name : "fadila"
/// last_name : "gusnadi"
/// email : "fadilla@gmail.com"
/// token : "211|RxAE0hXMhBYv7NPXRIl0z9P0USgio2P8xUfspLlme71f4fae"

class Data {
  Data({
      String? firstName, 
      String? lastName, 
      String? email, 
      String? token,}){
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _token = token;
}

  Data.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _token = json['token'];
  }
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _token;
Data copyWith({  String? firstName,
  String? lastName,
  String? email,
  String? token,
}) => Data(  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  token: token ?? _token,
);
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['token'] = _token;
    return map;
  }

}