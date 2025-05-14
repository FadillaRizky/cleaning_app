/// status : "success"
/// message : "avatar berhasil diupdate"
/// data : {"avatar_path":"https://ugo-clean.s3.ap-southeast-1.amazonaws.com/174496007719606.jpg"}

class UpdatePhotoProfileResponse {
  UpdatePhotoProfileResponse({
      String? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  UpdatePhotoProfileResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _status;
  String? _message;
  Data? _data;
UpdatePhotoProfileResponse copyWith({  String? status,
  String? message,
  Data? data,
}) => UpdatePhotoProfileResponse(  status: status ?? _status,
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

/// avatar_path : "https://ugo-clean.s3.ap-southeast-1.amazonaws.com/174496007719606.jpg"

class Data {
  Data({
      String? avatarPath,}){
    _avatarPath = avatarPath;
}

  Data.fromJson(dynamic json) {
    _avatarPath = json['avatar_path'];
  }
  String? _avatarPath;
Data copyWith({  String? avatarPath,
}) => Data(  avatarPath: avatarPath ?? _avatarPath,
);
  String? get avatarPath => _avatarPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['avatar_path'] = _avatarPath;
    return map;
  }

}