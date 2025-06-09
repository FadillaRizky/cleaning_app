/// status : true
/// message : "added data successfully"
/// data : {"orderid":39,"data_pack":[{"pack_id":31,"pack_name":"Sofa","pack_category":"Deep Cleaning","pack_hour":"0","pack_price":495000,"object_id":[4,5],"object_name":["Sofa Medium (2 Seat)","Sofa Large (3 Seat)"],"object_price":["210000","285000"]},{"pack_id":30,"pack_name":"Kasur","pack_category":"Deep Cleaning","pack_hour":"0","pack_price":600000,"object_id":[9,12,16],"object_name":["Cuci Karpet","Cuci Kasur King","Cuci Kasur Single"],"object_price":["75000","315000","210000"]}],"due_date":"2025-05-29","category":"Deep Cleaning","due_time":"10:00:00","discount":2,"order_notes":"aaaa","property_address":"Jl. Flamboyan II, Wonogiri","sub_total":1095000,"nominal_discount":21900,"nominal_after_discount":1073100,"tax":11,"nominal_tax":118041,"grand_total":1191141,"order_status":"open"}

class OrderPackageResponse {
  OrderPackageResponse({
      bool? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  OrderPackageResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
OrderPackageResponse copyWith({  bool? status,
  String? message,
  Data? data,
}) => OrderPackageResponse(  status: status ?? _status,
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

/// orderid : 39
/// data_pack : [{"pack_id":31,"pack_name":"Sofa","pack_category":"Deep Cleaning","pack_hour":"0","pack_price":495000,"object_id":[4,5],"object_name":["Sofa Medium (2 Seat)","Sofa Large (3 Seat)"],"object_price":["210000","285000"]},{"pack_id":30,"pack_name":"Kasur","pack_category":"Deep Cleaning","pack_hour":"0","pack_price":600000,"object_id":[9,12,16],"object_name":["Cuci Karpet","Cuci Kasur King","Cuci Kasur Single"],"object_price":["75000","315000","210000"]}]
/// due_date : "2025-05-29"
/// category : "Deep Cleaning"
/// due_time : "10:00:00"
/// discount : 2
/// order_notes : "aaaa"
/// property_address : "Jl. Flamboyan II, Wonogiri"
/// sub_total : 1095000
/// nominal_discount : 21900
/// nominal_after_discount : 1073100
/// tax : 11
/// nominal_tax : 118041
/// grand_total : 1191141
/// order_status : "open"

class Data {
  Data({
      num? orderid, 
      List<DataPack>? dataPack, 
      String? dueDate, 
      String? category, 
      String? dueTime, 
      num? discount, 
      String? orderNotes, 
      String? propertyAddress, 
      num? subTotal, 
      num? nominalDiscount, 
      num? nominalAfterDiscount, 
      num? tax, 
      num? nominalTax, 
      num? grandTotal, 
      String? orderStatus,}){
    _orderid = orderid;
    _dataPack = dataPack;
    _dueDate = dueDate;
    _category = category;
    _dueTime = dueTime;
    _discount = discount;
    _orderNotes = orderNotes;
    _propertyAddress = propertyAddress;
    _subTotal = subTotal;
    _nominalDiscount = nominalDiscount;
    _nominalAfterDiscount = nominalAfterDiscount;
    _tax = tax;
    _nominalTax = nominalTax;
    _grandTotal = grandTotal;
    _orderStatus = orderStatus;
}

  Data.fromJson(dynamic json) {
    _orderid = json['orderid'];
    if (json['data_pack'] != null) {
      _dataPack = [];
      json['data_pack'].forEach((v) {
        _dataPack?.add(DataPack.fromJson(v));
      });
    }
    _dueDate = json['due_date'];
    _category = json['category'];
    _dueTime = json['due_time'];
    _discount = json['discount'];
    _orderNotes = json['order_notes'];
    _propertyAddress = json['property_address'];
    _subTotal = json['sub_total'];
    _nominalDiscount = json['nominal_discount'];
    _nominalAfterDiscount = json['nominal_after_discount'];
    _tax = json['tax'];
    _nominalTax = json['nominal_tax'];
    _grandTotal = json['grand_total'];
    _orderStatus = json['order_status'];
  }
  num? _orderid;
  List<DataPack>? _dataPack;
  String? _dueDate;
  String? _category;
  String? _dueTime;
  num? _discount;
  String? _orderNotes;
  String? _propertyAddress;
  num? _subTotal;
  num? _nominalDiscount;
  num? _nominalAfterDiscount;
  num? _tax;
  num? _nominalTax;
  num? _grandTotal;
  String? _orderStatus;
Data copyWith({  num? orderid,
  List<DataPack>? dataPack,
  String? dueDate,
  String? category,
  String? dueTime,
  num? discount,
  String? orderNotes,
  String? propertyAddress,
  num? subTotal,
  num? nominalDiscount,
  num? nominalAfterDiscount,
  num? tax,
  num? nominalTax,
  num? grandTotal,
  String? orderStatus,
}) => Data(  orderid: orderid ?? _orderid,
  dataPack: dataPack ?? _dataPack,
  dueDate: dueDate ?? _dueDate,
  category: category ?? _category,
  dueTime: dueTime ?? _dueTime,
  discount: discount ?? _discount,
  orderNotes: orderNotes ?? _orderNotes,
  propertyAddress: propertyAddress ?? _propertyAddress,
  subTotal: subTotal ?? _subTotal,
  nominalDiscount: nominalDiscount ?? _nominalDiscount,
  nominalAfterDiscount: nominalAfterDiscount ?? _nominalAfterDiscount,
  tax: tax ?? _tax,
  nominalTax: nominalTax ?? _nominalTax,
  grandTotal: grandTotal ?? _grandTotal,
  orderStatus: orderStatus ?? _orderStatus,
);
  num? get orderid => _orderid;
  List<DataPack>? get dataPack => _dataPack;
  String? get dueDate => _dueDate;
  String? get category => _category;
  String? get dueTime => _dueTime;
  num? get discount => _discount;
  String? get orderNotes => _orderNotes;
  String? get propertyAddress => _propertyAddress;
  num? get subTotal => _subTotal;
  num? get nominalDiscount => _nominalDiscount;
  num? get nominalAfterDiscount => _nominalAfterDiscount;
  num? get tax => _tax;
  num? get nominalTax => _nominalTax;
  num? get grandTotal => _grandTotal;
  String? get orderStatus => _orderStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderid'] = _orderid;
    if (_dataPack != null) {
      map['data_pack'] = _dataPack?.map((v) => v.toJson()).toList();
    }
    map['due_date'] = _dueDate;
    map['category'] = _category;
    map['due_time'] = _dueTime;
    map['discount'] = _discount;
    map['order_notes'] = _orderNotes;
    map['property_address'] = _propertyAddress;
    map['sub_total'] = _subTotal;
    map['nominal_discount'] = _nominalDiscount;
    map['nominal_after_discount'] = _nominalAfterDiscount;
    map['tax'] = _tax;
    map['nominal_tax'] = _nominalTax;
    map['grand_total'] = _grandTotal;
    map['order_status'] = _orderStatus;
    return map;
  }

}

/// pack_id : 31
/// pack_name : "Sofa"
/// pack_category : "Deep Cleaning"
/// pack_hour : "0"
/// pack_price : 495000
/// object_id : [4,5]
/// object_name : ["Sofa Medium (2 Seat)","Sofa Large (3 Seat)"]
/// object_price : ["210000","285000"]

class DataPack {
  DataPack({
      num? packId, 
      String? packName, 
      String? packCategory, 
      String? packHour, 
      num? packPrice, 
      List<num>? objectId, 
      List<String>? objectName, 
      List<String>? objectPrice,}){
    _packId = packId;
    _packName = packName;
    _packCategory = packCategory;
    _packHour = packHour;
    _packPrice = packPrice;
    _objectId = objectId;
    _objectName = objectName;
    _objectPrice = objectPrice;
}

  DataPack.fromJson(dynamic json) {
    _packId = json['pack_id'];
    _packName = json['pack_name'];
    _packCategory = json['pack_category'];
    _packHour = json['pack_hour'];
    _packPrice = json['pack_price'];
    _objectId = json['object_id'] != null ? json['object_id'].cast<num>() : [];
    _objectName = json['object_name'] != null ? json['object_name'].cast<String>() : [];
    _objectPrice = json['object_price'] != null ? json['object_price'].cast<String>() : [];
  }
  num? _packId;
  String? _packName;
  String? _packCategory;
  String? _packHour;
  num? _packPrice;
  List<num>? _objectId;
  List<String>? _objectName;
  List<String>? _objectPrice;
DataPack copyWith({  num? packId,
  String? packName,
  String? packCategory,
  String? packHour,
  num? packPrice,
  List<num>? objectId,
  List<String>? objectName,
  List<String>? objectPrice,
}) => DataPack(  packId: packId ?? _packId,
  packName: packName ?? _packName,
  packCategory: packCategory ?? _packCategory,
  packHour: packHour ?? _packHour,
  packPrice: packPrice ?? _packPrice,
  objectId: objectId ?? _objectId,
  objectName: objectName ?? _objectName,
  objectPrice: objectPrice ?? _objectPrice,
);
  num? get packId => _packId;
  String? get packName => _packName;
  String? get packCategory => _packCategory;
  String? get packHour => _packHour;
  num? get packPrice => _packPrice;
  List<num>? get objectId => _objectId;
  List<String>? get objectName => _objectName;
  List<String>? get objectPrice => _objectPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pack_id'] = _packId;
    map['pack_name'] = _packName;
    map['pack_category'] = _packCategory;
    map['pack_hour'] = _packHour;
    map['pack_price'] = _packPrice;
    map['object_id'] = _objectId;
    map['object_name'] = _objectName;
    map['object_price'] = _objectPrice;
    return map;
  }

}