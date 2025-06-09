/// status : true
/// message : "data founded"
/// data : {"orderid":22,"property_type":"rumah","pic_name":"Rizky","pic_phone":"085158426044","property_address":"Jawa Tengah, Wonogiri, Jatisrono, Rejosari","data_pack":[{"pack_id":30,"pack_name":"Kasur","pack_category":"Deep Cleaning","pack_hour":"0","pack_price":435000,"data_object":[{"object_id":9,"object_name":"Cuci Karpet","object_price":"45000"},{"object_id":10,"object_name":"Cuci kasur Super King","object_price":"360000"}]}],"due_date":"2025-06-20","category":"Deep Cleaning","due_time":"11:30:00","discount":2,"order_notes":null,"sub_total":435000,"nominal_discount":8700,"nominal_after_discount":426300,"tax":11,"nominal_tax":46893,"grand_total":473193,"order_status":"open","mitra_gender":"random"}

class DetailOrderResponse {
  DetailOrderResponse({
      bool? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  DetailOrderResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
DetailOrderResponse copyWith({  bool? status,
  String? message,
  Data? data,
}) => DetailOrderResponse(  status: status ?? _status,
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

/// orderid : 22
/// property_type : "rumah"
/// pic_name : "Rizky"
/// pic_phone : "085158426044"
/// property_address : "Jawa Tengah, Wonogiri, Jatisrono, Rejosari"
/// data_pack : [{"pack_id":30,"pack_name":"Kasur","pack_category":"Deep Cleaning","pack_hour":"0","pack_price":435000,"data_object":[{"object_id":9,"object_name":"Cuci Karpet","object_price":"45000"},{"object_id":10,"object_name":"Cuci kasur Super King","object_price":"360000"}]}]
/// due_date : "2025-06-20"
/// category : "Deep Cleaning"
/// due_time : "11:30:00"
/// discount : 2
/// order_notes : null
/// sub_total : 435000
/// nominal_discount : 8700
/// nominal_after_discount : 426300
/// tax : 11
/// nominal_tax : 46893
/// grand_total : 473193
/// order_status : "open"
/// mitra_gender : "random"

class Data {
  Data({
      num? orderid, 
      String? propertyType, 
      String? picName, 
      String? picPhone, 
      String? propertyAddress, 
      List<DataPack>? dataPack, 
      String? dueDate, 
      String? category, 
      String? dueTime, 
      num? discount, 
      dynamic orderNotes, 
      num? subTotal, 
      num? nominalDiscount, 
      num? nominalAfterDiscount, 
      num? tax, 
      num? nominalTax, 
      num? grandTotal, 
      String? orderStatus, 
      String? mitraGender,}){
    _orderid = orderid;
    _propertyType = propertyType;
    _picName = picName;
    _picPhone = picPhone;
    _propertyAddress = propertyAddress;
    _dataPack = dataPack;
    _dueDate = dueDate;
    _category = category;
    _dueTime = dueTime;
    _discount = discount;
    _orderNotes = orderNotes;
    _subTotal = subTotal;
    _nominalDiscount = nominalDiscount;
    _nominalAfterDiscount = nominalAfterDiscount;
    _tax = tax;
    _nominalTax = nominalTax;
    _grandTotal = grandTotal;
    _orderStatus = orderStatus;
    _mitraGender = mitraGender;
}

  Data.fromJson(dynamic json) {
    _orderid = json['orderid'];
    _propertyType = json['property_type'];
    _picName = json['pic_name'];
    _picPhone = json['pic_phone'];
    _propertyAddress = json['property_address'];
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
    _subTotal = json['sub_total'];
    _nominalDiscount = json['nominal_discount'];
    _nominalAfterDiscount = json['nominal_after_discount'];
    _tax = json['tax'];
    _nominalTax = json['nominal_tax'];
    _grandTotal = json['grand_total'];
    _orderStatus = json['order_status'];
    _mitraGender = json['mitra_gender'];
  }
  num? _orderid;
  String? _propertyType;
  String? _picName;
  String? _picPhone;
  String? _propertyAddress;
  List<DataPack>? _dataPack;
  String? _dueDate;
  String? _category;
  String? _dueTime;
  num? _discount;
  dynamic _orderNotes;
  num? _subTotal;
  num? _nominalDiscount;
  num? _nominalAfterDiscount;
  num? _tax;
  num? _nominalTax;
  num? _grandTotal;
  String? _orderStatus;
  String? _mitraGender;
Data copyWith({  num? orderid,
  String? propertyType,
  String? picName,
  String? picPhone,
  String? propertyAddress,
  List<DataPack>? dataPack,
  String? dueDate,
  String? category,
  String? dueTime,
  num? discount,
  dynamic orderNotes,
  num? subTotal,
  num? nominalDiscount,
  num? nominalAfterDiscount,
  num? tax,
  num? nominalTax,
  num? grandTotal,
  String? orderStatus,
  String? mitraGender,
}) => Data(  orderid: orderid ?? _orderid,
  propertyType: propertyType ?? _propertyType,
  picName: picName ?? _picName,
  picPhone: picPhone ?? _picPhone,
  propertyAddress: propertyAddress ?? _propertyAddress,
  dataPack: dataPack ?? _dataPack,
  dueDate: dueDate ?? _dueDate,
  category: category ?? _category,
  dueTime: dueTime ?? _dueTime,
  discount: discount ?? _discount,
  orderNotes: orderNotes ?? _orderNotes,
  subTotal: subTotal ?? _subTotal,
  nominalDiscount: nominalDiscount ?? _nominalDiscount,
  nominalAfterDiscount: nominalAfterDiscount ?? _nominalAfterDiscount,
  tax: tax ?? _tax,
  nominalTax: nominalTax ?? _nominalTax,
  grandTotal: grandTotal ?? _grandTotal,
  orderStatus: orderStatus ?? _orderStatus,
  mitraGender: mitraGender ?? _mitraGender,
);
  num? get orderid => _orderid;
  String? get propertyType => _propertyType;
  String? get picName => _picName;
  String? get picPhone => _picPhone;
  String? get propertyAddress => _propertyAddress;
  List<DataPack>? get dataPack => _dataPack;
  String? get dueDate => _dueDate;
  String? get category => _category;
  String? get dueTime => _dueTime;
  num? get discount => _discount;
  dynamic get orderNotes => _orderNotes;
  num? get subTotal => _subTotal;
  num? get nominalDiscount => _nominalDiscount;
  num? get nominalAfterDiscount => _nominalAfterDiscount;
  num? get tax => _tax;
  num? get nominalTax => _nominalTax;
  num? get grandTotal => _grandTotal;
  String? get orderStatus => _orderStatus;
  String? get mitraGender => _mitraGender;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderid'] = _orderid;
    map['property_type'] = _propertyType;
    map['pic_name'] = _picName;
    map['pic_phone'] = _picPhone;
    map['property_address'] = _propertyAddress;
    if (_dataPack != null) {
      map['data_pack'] = _dataPack?.map((v) => v.toJson()).toList();
    }
    map['due_date'] = _dueDate;
    map['category'] = _category;
    map['due_time'] = _dueTime;
    map['discount'] = _discount;
    map['order_notes'] = _orderNotes;
    map['sub_total'] = _subTotal;
    map['nominal_discount'] = _nominalDiscount;
    map['nominal_after_discount'] = _nominalAfterDiscount;
    map['tax'] = _tax;
    map['nominal_tax'] = _nominalTax;
    map['grand_total'] = _grandTotal;
    map['order_status'] = _orderStatus;
    map['mitra_gender'] = _mitraGender;
    return map;
  }

}

/// pack_id : 30
/// pack_name : "Kasur"
/// pack_category : "Deep Cleaning"
/// pack_hour : "0"
/// pack_price : 435000
/// data_object : [{"object_id":9,"object_name":"Cuci Karpet","object_price":"45000"},{"object_id":10,"object_name":"Cuci kasur Super King","object_price":"360000"}]

class DataPack {
  DataPack({
      num? packId, 
      String? packName, 
      String? packCategory, 
      String? packHour, 
      num? packPrice, 
      List<DataObject>? dataObject,}){
    _packId = packId;
    _packName = packName;
    _packCategory = packCategory;
    _packHour = packHour;
    _packPrice = packPrice;
    _dataObject = dataObject;
}

  DataPack.fromJson(dynamic json) {
    _packId = json['pack_id'];
    _packName = json['pack_name'];
    _packCategory = json['pack_category'];
    _packHour = json['pack_hour'];
    _packPrice = json['pack_price'];
    if (json['data_object'] != null) {
      _dataObject = [];
      json['data_object'].forEach((v) {
        _dataObject?.add(DataObject.fromJson(v));
      });
    }
  }
  num? _packId;
  String? _packName;
  String? _packCategory;
  String? _packHour;
  num? _packPrice;
  List<DataObject>? _dataObject;
DataPack copyWith({  num? packId,
  String? packName,
  String? packCategory,
  String? packHour,
  num? packPrice,
  List<DataObject>? dataObject,
}) => DataPack(  packId: packId ?? _packId,
  packName: packName ?? _packName,
  packCategory: packCategory ?? _packCategory,
  packHour: packHour ?? _packHour,
  packPrice: packPrice ?? _packPrice,
  dataObject: dataObject ?? _dataObject,
);
  num? get packId => _packId;
  String? get packName => _packName;
  String? get packCategory => _packCategory;
  String? get packHour => _packHour;
  num? get packPrice => _packPrice;
  List<DataObject>? get dataObject => _dataObject;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pack_id'] = _packId;
    map['pack_name'] = _packName;
    map['pack_category'] = _packCategory;
    map['pack_hour'] = _packHour;
    map['pack_price'] = _packPrice;
    if (_dataObject != null) {
      map['data_object'] = _dataObject?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// object_id : 9
/// object_name : "Cuci Karpet"
/// object_price : "45000"

class DataObject {
  DataObject({
      num? objectId, 
      String? objectName, 
      String? objectPrice,}){
    _objectId = objectId;
    _objectName = objectName;
    _objectPrice = objectPrice;
}

  DataObject.fromJson(dynamic json) {
    _objectId = json['object_id'];
    _objectName = json['object_name'];
    _objectPrice = json['object_price'];
  }
  num? _objectId;
  String? _objectName;
  String? _objectPrice;
DataObject copyWith({  num? objectId,
  String? objectName,
  String? objectPrice,
}) => DataObject(  objectId: objectId ?? _objectId,
  objectName: objectName ?? _objectName,
  objectPrice: objectPrice ?? _objectPrice,
);
  num? get objectId => _objectId;
  String? get objectName => _objectName;
  String? get objectPrice => _objectPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['object_id'] = _objectId;
    map['object_name'] = _objectName;
    map['object_price'] = _objectPrice;
    return map;
  }

}