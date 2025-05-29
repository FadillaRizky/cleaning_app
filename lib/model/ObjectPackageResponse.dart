/// status : true
/// message : "data founded"
/// data : [{"object_id":8,"object_name":"Cuci Bantal/Guling","pack_id":30,"pack_name":"Kasur","object_price":"56000","object_description":"Harga terlampir adalah harga per Item","object_image":""},{"object_id":9,"object_name":"Cuci Karpet","pack_id":30,"pack_name":"Kasur","object_price":"75000","object_description":"Cuci Karpet ukuran 160 X 210 harga per item","object_image":""},{"object_id":10,"object_name":"Cuci kasur Super King","pack_id":30,"pack_name":"Kasur","object_price":"360000","object_description":"Pembersihan kasur secara menyeluruh dan mendalam","object_image":""},{"object_id":11,"object_name":"Cuci Kasur Super King (2 Sisi)","pack_id":30,"pack_name":"Kasur","object_price":"470000","object_description":"Pembersihan kasur secara menyeluruh dan mendalam Ukuran (200 x 200)","object_image":""},{"object_id":12,"object_name":"Cuci Kasur King","pack_id":30,"pack_name":"Kasur","object_price":"315000","object_description":"Pembersihan kasur secara menyeluruh dan mendalam Ukuran (180 x 200)","object_image":""},{"object_id":13,"object_name":"Cuci Kasur King 2 SIsi","pack_id":30,"pack_name":"Kasur","object_price":"392000","object_description":"Pembersihan kasur secara menyeluruh dan mendalam","object_image":""},{"object_id":14,"object_name":"Cuci Kasur Queen","pack_id":30,"pack_name":"Kasur","object_price":"262000","object_description":"Pembersihan kasur secara menyeluruh dan mendalam","object_image":""},{"object_id":15,"object_name":"Cuci Kasur Queen 2 SIsi","pack_id":30,"pack_name":"Kasur","object_price":"341000","object_description":"Pembersihan kasur secara menyeluruh dan mendalam","object_image":""},{"object_id":16,"object_name":"Cuci Kasur Single","pack_id":30,"pack_name":"Kasur","object_price":"210000","object_description":"Pembersihan kasur secara menyeluruh dan mendalam","object_image":""},{"object_id":17,"object_name":"Cuci Kasur Singgle 2 SIsi","pack_id":30,"pack_name":"Kasur","object_price":"315000","object_description":"Pembersihan kasur secara menyeluruh dan mendalam","object_image":""},{"object_id":18,"object_name":"Cuci Bantal / Guling","pack_id":30,"pack_name":"Kasur","object_price":"56000","object_description":"Pembersihan kasur secara menyeluruh dan mendalam","object_image":""}]

class ObjectPackageResponse {
  ObjectPackageResponse({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  ObjectPackageResponse.fromJson(dynamic json) {
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
ObjectPackageResponse copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => ObjectPackageResponse(  status: status ?? _status,
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

/// object_id : 8
/// object_name : "Cuci Bantal/Guling"
/// pack_id : 30
/// pack_name : "Kasur"
/// object_price : "56000"
/// object_description : "Harga terlampir adalah harga per Item"
/// object_image : ""

class Data {
  Data({
      num? objectId, 
      String? objectName, 
      num? packId, 
      String? packName, 
      String? objectPrice, 
      String? objectDescription, 
      String? objectImage,}){
    _objectId = objectId;
    _objectName = objectName;
    _packId = packId;
    _packName = packName;
    _objectPrice = objectPrice;
    _objectDescription = objectDescription;
    _objectImage = objectImage;
}

  Data.fromJson(dynamic json) {
    _objectId = json['object_id'];
    _objectName = json['object_name'];
    _packId = json['pack_id'];
    _packName = json['pack_name'];
    _objectPrice = json['object_price'];
    _objectDescription = json['object_description'];
    _objectImage = json['object_image'];
  }
  num? _objectId;
  String? _objectName;
  num? _packId;
  String? _packName;
  String? _objectPrice;
  String? _objectDescription;
  String? _objectImage;
Data copyWith({  num? objectId,
  String? objectName,
  num? packId,
  String? packName,
  String? objectPrice,
  String? objectDescription,
  String? objectImage,
}) => Data(  objectId: objectId ?? _objectId,
  objectName: objectName ?? _objectName,
  packId: packId ?? _packId,
  packName: packName ?? _packName,
  objectPrice: objectPrice ?? _objectPrice,
  objectDescription: objectDescription ?? _objectDescription,
  objectImage: objectImage ?? _objectImage,
);
  num? get objectId => _objectId;
  String? get objectName => _objectName;
  num? get packId => _packId;
  String? get packName => _packName;
  String? get objectPrice => _objectPrice;
  String? get objectDescription => _objectDescription;
  String? get objectImage => _objectImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['object_id'] = _objectId;
    map['object_name'] = _objectName;
    map['pack_id'] = _packId;
    map['pack_name'] = _packName;
    map['object_price'] = _objectPrice;
    map['object_description'] = _objectDescription;
    map['object_image'] = _objectImage;
    return map;
  }

}