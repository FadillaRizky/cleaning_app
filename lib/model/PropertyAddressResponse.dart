/// status : true
/// message : "data founded"
/// data : [{"id":18,"client_id":24,"pic_name":"anto","pic_phone":"08212212312","property_type":"rumah","lat":"-9123121","long":"08123121","property_address":"jl. semak belukar","description":"rumah hunian bebas banjir","created_by":null,"updated_by":null,"created_at":"2025-04-18T17:24:21.000000Z","updated_at":"2025-05-12T02:38:41.000000Z"},{"id":19,"client_id":24,"pic_name":"anto","pic_phone":"08212212312","property_type":"rumah","lat":"-9123121","long":"08123121","property_address":"jl. semak belukar","description":"rumah hunian bebas banjir","created_by":null,"updated_by":null,"created_at":"2025-04-19T22:17:41.000000Z","updated_at":"2025-05-12T02:38:42.000000Z"}]

class PropertyAddressResponse {
  PropertyAddressResponse({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  PropertyAddressResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;
PropertyAddressResponse copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => PropertyAddressResponse(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 18
/// client_id : 24
/// pic_name : "anto"
/// pic_phone : "08212212312"
/// property_type : "rumah"
/// lat : "-9123121"
/// long : "08123121"
/// property_address : "jl. semak belukar"
/// description : "rumah hunian bebas banjir"
/// created_by : null
/// updated_by : null
/// created_at : "2025-04-18T17:24:21.000000Z"
/// updated_at : "2025-05-12T02:38:41.000000Z"

class Data {
  Data({
      num? id, 
      num? clientId, 
      String? picName, 
      String? picPhone, 
      String? propertyType, 
      String? lat, 
      String? long, 
      String? propertyAddress, 
      String? description, 
      dynamic createdBy, 
      dynamic updatedBy, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _clientId = clientId;
    _picName = picName;
    _picPhone = picPhone;
    _propertyType = propertyType;
    _lat = lat;
    _long = long;
    _propertyAddress = propertyAddress;
    _description = description;
    _createdBy = createdBy;
    _updatedBy = updatedBy;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _clientId = json['client_id'];
    _picName = json['pic_name'];
    _picPhone = json['pic_phone'];
    _propertyType = json['property_type'];
    _lat = json['lat'];
    _long = json['long'];
    _propertyAddress = json['property_address'];
    _description = json['description'];
    _createdBy = json['created_by'];
    _updatedBy = json['updated_by'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _clientId;
  String? _picName;
  String? _picPhone;
  String? _propertyType;
  String? _lat;
  String? _long;
  String? _propertyAddress;
  String? _description;
  dynamic _createdBy;
  dynamic _updatedBy;
  String? _createdAt;
  String? _updatedAt;
Data copyWith({  num? id,
  num? clientId,
  String? picName,
  String? picPhone,
  String? propertyType,
  String? lat,
  String? long,
  String? propertyAddress,
  String? description,
  dynamic createdBy,
  dynamic updatedBy,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  clientId: clientId ?? _clientId,
  picName: picName ?? _picName,
  picPhone: picPhone ?? _picPhone,
  propertyType: propertyType ?? _propertyType,
  lat: lat ?? _lat,
  long: long ?? _long,
  propertyAddress: propertyAddress ?? _propertyAddress,
  description: description ?? _description,
  createdBy: createdBy ?? _createdBy,
  updatedBy: updatedBy ?? _updatedBy,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  num? get clientId => _clientId;
  String? get picName => _picName;
  String? get picPhone => _picPhone;
  String? get propertyType => _propertyType;
  String? get lat => _lat;
  String? get long => _long;
  String? get propertyAddress => _propertyAddress;
  String? get description => _description;
  dynamic get createdBy => _createdBy;
  dynamic get updatedBy => _updatedBy;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['client_id'] = _clientId;
    map['pic_name'] = _picName;
    map['pic_phone'] = _picPhone;
    map['property_type'] = _propertyType;
    map['lat'] = _lat;
    map['long'] = _long;
    map['property_address'] = _propertyAddress;
    map['description'] = _description;
    map['created_by'] = _createdBy;
    map['updated_by'] = _updatedBy;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}