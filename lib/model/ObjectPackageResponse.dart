/// status : true
/// message : "data founded"
/// data : [{"object_id":8,"object_name":"Cuci Bantal/Guling","pack_id":30,"pack_name":"Kasur","object_price":25000,"object_price_disc":23500,"object_description":"Harga terlampir adalah harga per Item","object_image":""},{"object_id":10,"object_name":"Kasur Queen + 1 Singgle","pack_id":30,"pack_name":"Kasur","object_price":420000,"object_price_disc":394800,"object_description":"Pembersihan kasur secara menyeluruh dan mendalam","object_image":""},{"object_id":11,"object_name":"Kasur Super King (2 Sisi)","pack_id":30,"pack_name":"Kasur","object_price":545000,"object_price_disc":512300,"object_description":"Pembersihan kasur secara menyeluruh dan mendalam Ukuran (200 x 200)","object_image":""},{"object_id":12,"object_name":"Kasur King 180 x 200","pack_id":30,"pack_name":"Kasur","object_price":350000,"object_price_disc":329000,"object_description":"Pembersihan kasur secara menyeluruh dan mendalam Ukuran (180 x 200)","object_image":"https://ugo-clean.s3.ap-southeast-1.amazonaws.com/174979643160047.jpg"},{"object_id":13,"object_name":"Kasur King 1 + Queen 1 Double","pack_id":30,"pack_name":"Kasur","object_price":515000,"object_price_disc":484100,"object_description":"Pembersihan kasur secara menyeluruh dan mendalam","object_image":""},{"object_id":14,"object_name":"Kasur Queen 160 x 200","pack_id":30,"pack_name":"Kasur","object_price":280000,"object_price_disc":263200,"object_description":"Pembersihan kasur secara menyeluruh dan mendalam","object_image":""},{"object_id":15,"object_name":"Kasur Queen (2 SIsi)","pack_id":30,"pack_name":"Kasur","object_price":480000,"object_price_disc":451200,"object_description":"Pembersihan kasur secara menyeluruh dan mendalam","object_image":""},{"object_id":16,"object_name":"Kasur Single 90 x 200","pack_id":30,"pack_name":"Kasur","object_price":225000,"object_price_disc":211500,"object_description":"Pembersihan kasur secara menyeluruh dan mendalam","object_image":"https://ugo-clean.s3.ap-southeast-1.amazonaws.com/174979677510864.jpeg"},{"object_id":17,"object_name":"Kasur Singgle 2 SIsi","pack_id":30,"pack_name":"Kasur","object_price":325000,"object_price_disc":305500,"object_description":"Pembersihan kasur secara menyeluruh dan mendalam","object_image":"https://ugo-clean.s3.ap-southeast-1.amazonaws.com/174979746599409.webp"},{"object_id":18,"object_name":"Cuci Bantal / Guling (1 pcs)","pack_id":30,"pack_name":"Kasur","object_price":25000,"object_price_disc":23500,"object_description":"Pembersihan kasur secara menyeluruh dan mendalam","object_image":""}]

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
/// object_price : 25000
/// object_price_disc : 23500
/// object_description : "Harga terlampir adalah harga per Item"
/// object_image : ""

class Data {
  Data({
      num? objectId, 
      String? objectName, 
      num? packId, 
      String? packName, 
      num? objectPrice, 
      num? objectPriceDisc, 
      String? objectDescription, 
      String? objectImage,}){
    _objectId = objectId;
    _objectName = objectName;
    _packId = packId;
    _packName = packName;
    _objectPrice = objectPrice;
    _objectPriceDisc = objectPriceDisc;
    _objectDescription = objectDescription;
    _objectImage = objectImage;
}

  Data.fromJson(dynamic json) {
    _objectId = json['object_id'];
    _objectName = json['object_name'];
    _packId = json['pack_id'];
    _packName = json['pack_name'];
    _objectPrice = json['object_price'];
    _objectPriceDisc = json['object_price_disc'];
    _objectDescription = json['object_description'];
    _objectImage = json['object_image'];
  }
  num? _objectId;
  String? _objectName;
  num? _packId;
  String? _packName;
  num? _objectPrice;
  num? _objectPriceDisc;
  String? _objectDescription;
  String? _objectImage;
Data copyWith({  num? objectId,
  String? objectName,
  num? packId,
  String? packName,
  num? objectPrice,
  num? objectPriceDisc,
  String? objectDescription,
  String? objectImage,
}) => Data(  objectId: objectId ?? _objectId,
  objectName: objectName ?? _objectName,
  packId: packId ?? _packId,
  packName: packName ?? _packName,
  objectPrice: objectPrice ?? _objectPrice,
  objectPriceDisc: objectPriceDisc ?? _objectPriceDisc,
  objectDescription: objectDescription ?? _objectDescription,
  objectImage: objectImage ?? _objectImage,
);
  num? get objectId => _objectId;
  String? get objectName => _objectName;
  num? get packId => _packId;
  String? get packName => _packName;
  num? get objectPrice => _objectPrice;
  num? get objectPriceDisc => _objectPriceDisc;
  String? get objectDescription => _objectDescription;
  String? get objectImage => _objectImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['object_id'] = _objectId;
    map['object_name'] = _objectName;
    map['pack_id'] = _packId;
    map['pack_name'] = _packName;
    map['object_price'] = _objectPrice;
    map['object_price_disc'] = _objectPriceDisc;
    map['object_description'] = _objectDescription;
    map['object_image'] = _objectImage;
    return map;
  }

}