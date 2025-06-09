/// status : true
/// message : "succesed added data"
/// data : {"client_id":24,"pic_name":"rizky","pic_phone":"085158426044","property_type":"rumah","lat":"-6175625422346442","long":"10682712431903494","property_address":"Jawa Tengah, Wonogiri, Jatisrono, Rejosari","description":"Jegoh, RT 03/04 , Utara Masjid Baiturrahim","updated_at":"2025-06-02T08:46:56.000000Z","created_at":"2025-06-02T08:46:56.000000Z","id":20}

class StoreAddressResponse {
  StoreAddressResponse({
      bool? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  StoreAddressResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
StoreAddressResponse copyWith({  bool? status,
  String? message,
  Data? data,
}) => StoreAddressResponse(  status: status ?? _status,
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

/// client_id : 24
/// pic_name : "rizky"
/// pic_phone : "085158426044"
/// property_type : "rumah"
/// lat : "-6175625422346442"
/// long : "10682712431903494"
/// property_address : "Jawa Tengah, Wonogiri, Jatisrono, Rejosari"
/// description : "Jegoh, RT 03/04 , Utara Masjid Baiturrahim"
/// updated_at : "2025-06-02T08:46:56.000000Z"
/// created_at : "2025-06-02T08:46:56.000000Z"
/// id : 20

class Data {
  Data({
      num? clientId, 
      String? picName, 
      String? picPhone, 
      String? propertyType, 
      String? lat, 
      String? long, 
      String? propertyAddress, 
      String? description, 
      String? updatedAt, 
      String? createdAt, 
      num? id,}){
    _clientId = clientId;
    _picName = picName;
    _picPhone = picPhone;
    _propertyType = propertyType;
    _lat = lat;
    _long = long;
    _propertyAddress = propertyAddress;
    _description = description;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
}

  Data.fromJson(dynamic json) {
    _clientId = json['client_id'];
    _picName = json['pic_name'];
    _picPhone = json['pic_phone'];
    _propertyType = json['property_type'];
    _lat = json['lat'];
    _long = json['long'];
    _propertyAddress = json['property_address'];
    _description = json['description'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }
  num? _clientId;
  String? _picName;
  String? _picPhone;
  String? _propertyType;
  String? _lat;
  String? _long;
  String? _propertyAddress;
  String? _description;
  String? _updatedAt;
  String? _createdAt;
  num? _id;
Data copyWith({  num? clientId,
  String? picName,
  String? picPhone,
  String? propertyType,
  String? lat,
  String? long,
  String? propertyAddress,
  String? description,
  String? updatedAt,
  String? createdAt,
  num? id,
}) => Data(  clientId: clientId ?? _clientId,
  picName: picName ?? _picName,
  picPhone: picPhone ?? _picPhone,
  propertyType: propertyType ?? _propertyType,
  lat: lat ?? _lat,
  long: long ?? _long,
  propertyAddress: propertyAddress ?? _propertyAddress,
  description: description ?? _description,
  updatedAt: updatedAt ?? _updatedAt,
  createdAt: createdAt ?? _createdAt,
  id: id ?? _id,
);
  num? get clientId => _clientId;
  String? get picName => _picName;
  String? get picPhone => _picPhone;
  String? get propertyType => _propertyType;
  String? get lat => _lat;
  String? get long => _long;
  String? get propertyAddress => _propertyAddress;
  String? get description => _description;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  num? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['client_id'] = _clientId;
    map['pic_name'] = _picName;
    map['pic_phone'] = _picPhone;
    map['property_type'] = _propertyType;
    map['lat'] = _lat;
    map['long'] = _long;
    map['property_address'] = _propertyAddress;
    map['description'] = _description;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }

}