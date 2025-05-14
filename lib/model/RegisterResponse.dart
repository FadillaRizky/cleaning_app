/// status : "success"
/// message : "data berhasil dimasukan"
/// data : {"first_name":"daban","last_name":null,"phone_number":"08345345444","email":"daban@mail.com"}

class RegisterResponse {
  RegisterResponse({
      String? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  RegisterResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _status;
  String? _message;
  Data? _data;
RegisterResponse copyWith({  String? status,
  String? message,
  Data? data,
}) => RegisterResponse(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  String? get status => _status;
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

/// first_name : "daban"
/// last_name : null
/// phone_number : "08345345444"
/// email : "daban@mail.com"

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