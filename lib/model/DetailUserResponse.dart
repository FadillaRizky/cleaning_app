/// status : "success"
/// message : "data berhasil ditemukan"
/// data : {"first_name":"fadila","last_name":"gusnadi","email":"fadilla@gmail.com","born_place":"jakarta","bod":"2004-01-02","religion":"islam","ktp_address":"rejosari","avatar_path":"https://ugo-clean.s3.ap-southeast-1.amazonaws.com/174520469647796.jpg"}

class DetailUserResponse {
  DetailUserResponse({
      String? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  DetailUserResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _status;
  String? _message;
  Data? _data;
DetailUserResponse copyWith({  String? status,
  String? message,
  Data? data,
}) => DetailUserResponse(  status: status ?? _status,
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

/// first_name : "fadila"
/// last_name : "gusnadi"
/// email : "fadilla@gmail.com"
/// born_place : "jakarta"
/// bod : "2004-01-02"
/// religion : "islam"
/// ktp_address : "rejosari"
/// avatar_path : "https://ugo-clean.s3.ap-southeast-1.amazonaws.com/174520469647796.jpg"

class Data {
  Data({
      String? firstName, 
      String? lastName, 
      String? email, 
      String? bornPlace, 
      String? bod, 
      String? religion, 
      String? ktpAddress, 
      String? avatarPath,}){
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _bornPlace = bornPlace;
    _bod = bod;
    _religion = religion;
    _ktpAddress = ktpAddress;
    _avatarPath = avatarPath;
}

  Data.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _bornPlace = json['born_place'];
    _bod = json['bod'];
    _religion = json['religion'];
    _ktpAddress = json['ktp_address'];
    _avatarPath = json['avatar_path'];
  }
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _bornPlace;
  String? _bod;
  String? _religion;
  String? _ktpAddress;
  String? _avatarPath;
Data copyWith({  String? firstName,
  String? lastName,
  String? email,
  String? bornPlace,
  String? bod,
  String? religion,
  String? ktpAddress,
  String? avatarPath,
}) => Data(  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  bornPlace: bornPlace ?? _bornPlace,
  bod: bod ?? _bod,
  religion: religion ?? _religion,
  ktpAddress: ktpAddress ?? _ktpAddress,
  avatarPath: avatarPath ?? _avatarPath,
);
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get bornPlace => _bornPlace;
  String? get bod => _bod;
  String? get religion => _religion;
  String? get ktpAddress => _ktpAddress;
  String? get avatarPath => _avatarPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['born_place'] = _bornPlace;
    map['bod'] = _bod;
    map['religion'] = _religion;
    map['ktp_address'] = _ktpAddress;
    map['avatar_path'] = _avatarPath;
    return map;
  }

}