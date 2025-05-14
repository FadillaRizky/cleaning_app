/// status : "success"
/// message : "data berhasil diupdate"
/// data : {"first_name":"Fadilla","last_name":"Rizky","email":"fadillarizky294@gmail.com","born_place":"jakarta","bod":"2004-01-02","religion":"Islam","ktp_address":"Jl. masjid raya"}

class UpdateDetailUserResponse {
  UpdateDetailUserResponse({
      String? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  UpdateDetailUserResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _status;
  String? _message;
  Data? _data;
UpdateDetailUserResponse copyWith({  String? status,
  String? message,
  Data? data,
}) => UpdateDetailUserResponse(  status: status ?? _status,
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

/// first_name : "Fadilla"
/// last_name : "Rizky"
/// email : "fadillarizky294@gmail.com"
/// born_place : "jakarta"
/// bod : "2004-01-02"
/// religion : "Islam"
/// ktp_address : "Jl. masjid raya"

class Data {
  Data({
      String? firstName, 
      String? lastName, 
      String? email, 
      String? bornPlace, 
      String? bod, 
      String? religion, 
      String? ktpAddress,}){
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _bornPlace = bornPlace;
    _bod = bod;
    _religion = religion;
    _ktpAddress = ktpAddress;
}

  Data.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _bornPlace = json['born_place'];
    _bod = json['bod'];
    _religion = json['religion'];
    _ktpAddress = json['ktp_address'];
  }
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _bornPlace;
  String? _bod;
  String? _religion;
  String? _ktpAddress;
Data copyWith({  String? firstName,
  String? lastName,
  String? email,
  String? bornPlace,
  String? bod,
  String? religion,
  String? ktpAddress,
}) => Data(  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  bornPlace: bornPlace ?? _bornPlace,
  bod: bod ?? _bod,
  religion: religion ?? _religion,
  ktpAddress: ktpAddress ?? _ktpAddress,
);
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get bornPlace => _bornPlace;
  String? get bod => _bod;
  String? get religion => _religion;
  String? get ktpAddress => _ktpAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['born_place'] = _bornPlace;
    map['bod'] = _bod;
    map['religion'] = _religion;
    map['ktp_address'] = _ktpAddress;
    return map;
  }

}