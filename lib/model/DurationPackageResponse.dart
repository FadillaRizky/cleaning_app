/// status : true
/// message : "data berhasil di temukan"
/// data : [{"ph_id":4,"pack_id":4,"pack_hour":2,"pack_price":200000,"pack_price_disc":190000},{"ph_id":5,"pack_id":4,"pack_hour":3,"pack_price":300000,"pack_price_disc":285000},{"ph_id":6,"pack_id":4,"pack_hour":4,"pack_price":100000,"pack_price_disc":95000}]

class DurationPackageResponse {
  DurationPackageResponse({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  DurationPackageResponse.fromJson(dynamic json) {
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
DurationPackageResponse copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => DurationPackageResponse(  status: status ?? _status,
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

/// ph_id : 4
/// pack_id : 4
/// pack_hour : 2
/// pack_price : 200000
/// pack_price_disc : 190000

class Data {
  Data({
      num? phId, 
      num? packId, 
      num? packHour, 
      num? packPrice, 
      num? packPriceDisc,}){
    _phId = phId;
    _packId = packId;
    _packHour = packHour;
    _packPrice = packPrice;
    _packPriceDisc = packPriceDisc;
}

  Data.fromJson(dynamic json) {
    _phId = json['ph_id'];
    _packId = json['pack_id'];
    _packHour = json['pack_hour'];
    _packPrice = json['pack_price'];
    _packPriceDisc = json['pack_price_disc'];
  }
  num? _phId;
  num? _packId;
  num? _packHour;
  num? _packPrice;
  num? _packPriceDisc;
Data copyWith({  num? phId,
  num? packId,
  num? packHour,
  num? packPrice,
  num? packPriceDisc,
}) => Data(  phId: phId ?? _phId,
  packId: packId ?? _packId,
  packHour: packHour ?? _packHour,
  packPrice: packPrice ?? _packPrice,
  packPriceDisc: packPriceDisc ?? _packPriceDisc,
);
  num? get phId => _phId;
  num? get packId => _packId;
  num? get packHour => _packHour;
  num? get packPrice => _packPrice;
  num? get packPriceDisc => _packPriceDisc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ph_id'] = _phId;
    map['pack_id'] = _packId;
    map['pack_hour'] = _packHour;
    map['pack_price'] = _packPrice;
    map['pack_price_disc'] = _packPriceDisc;
    return map;
  }

}