/// status : true
/// message : "data berhasil di temukan"
/// data : [{"orderid":1,"pack_id":3,"pack_category":"Daily Cleaning","pack_name":"Setrika","pack_banner_path":"https://ugo-clean.s3.ap-southeast-1.amazonaws.com/174854348895133.jpg","pack_hour":"2","due_date":"2025-05-28","due_time":"11:00:00","client_id":24,"first_name":null,"last_name":null,"partner_id":null,"sub_total":100000,"discount":null,"nominal_discount":0,"nominal_after_discount":100000,"tax":11,"nominal_tax":11000,"grand_total":111000,"order_notes":"order test","order_status":"open","created_at":"2025-06-05T09:50:11.000000Z","created_by":"Rizkyy"},{"orderid":2,"pack_id":31,"pack_category":"Deep Cleaning","pack_name":"Sofa","pack_banner_path":"https://ugo-clean.s3.ap-southeast-1.amazonaws.com/174854407112666.webp","pack_hour":"0","due_date":"2025-05-29","due_time":"10:00:00","client_id":24,"first_name":null,"last_name":null,"partner_id":null,"sub_total":1095000,"discount":2,"nominal_discount":21900,"nominal_after_discount":1073100,"tax":11,"nominal_tax":118041,"grand_total":1191141,"order_notes":"aaaa","order_status":"open","created_at":"2025-06-05T09:50:40.000000Z","created_by":"Rizkyy"},{"orderid":2,"pack_id":30,"pack_category":"Deep Cleaning","pack_name":"Kasur","pack_banner_path":"https://ugo-clean.s3.ap-southeast-1.amazonaws.com/174854401179972.jpg","pack_hour":"0","due_date":"2025-05-29","due_time":"10:00:00","client_id":24,"first_name":null,"last_name":null,"partner_id":null,"sub_total":1095000,"discount":2,"nominal_discount":21900,"nominal_after_discount":1073100,"tax":11,"nominal_tax":118041,"grand_total":1191141,"order_notes":"aaaa","order_status":"open","created_at":"2025-06-05T09:50:40.000000Z","created_by":"Rizkyy"}]

class GetListOrderResponse {
  GetListOrderResponse({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetListOrderResponse.fromJson(dynamic json) {
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
GetListOrderResponse copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => GetListOrderResponse(  status: status ?? _status,
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

/// orderid : 1
/// pack_id : 3
/// pack_category : "Daily Cleaning"
/// pack_name : "Setrika"
/// pack_banner_path : "https://ugo-clean.s3.ap-southeast-1.amazonaws.com/174854348895133.jpg"
/// pack_hour : "2"
/// due_date : "2025-05-28"
/// due_time : "11:00:00"
/// client_id : 24
/// first_name : null
/// last_name : null
/// partner_id : null
/// sub_total : 100000
/// discount : null
/// nominal_discount : 0
/// nominal_after_discount : 100000
/// tax : 11
/// nominal_tax : 11000
/// grand_total : 111000
/// order_notes : "order test"
/// order_status : "open"
/// created_at : "2025-06-05T09:50:11.000000Z"
/// created_by : "Rizkyy"

class Data {
  Data({
      num? orderid, 
      num? packId, 
      String? packCategory, 
      String? packName, 
      String? packBannerPath, 
      String? packHour, 
      String? dueDate, 
      String? dueTime, 
      num? clientId, 
      dynamic firstName, 
      dynamic lastName, 
      dynamic partnerId, 
      num? subTotal, 
      dynamic discount, 
      num? nominalDiscount, 
      num? nominalAfterDiscount, 
      num? tax, 
      num? nominalTax, 
      num? grandTotal, 
      String? orderNotes, 
      String? orderStatus, 
      String? createdAt, 
      String? createdBy,}){
    _orderid = orderid;
    _packId = packId;
    _packCategory = packCategory;
    _packName = packName;
    _packBannerPath = packBannerPath;
    _packHour = packHour;
    _dueDate = dueDate;
    _dueTime = dueTime;
    _clientId = clientId;
    _firstName = firstName;
    _lastName = lastName;
    _partnerId = partnerId;
    _subTotal = subTotal;
    _discount = discount;
    _nominalDiscount = nominalDiscount;
    _nominalAfterDiscount = nominalAfterDiscount;
    _tax = tax;
    _nominalTax = nominalTax;
    _grandTotal = grandTotal;
    _orderNotes = orderNotes;
    _orderStatus = orderStatus;
    _createdAt = createdAt;
    _createdBy = createdBy;
}

  Data.fromJson(dynamic json) {
    _orderid = json['orderid'];
    _packId = json['pack_id'];
    _packCategory = json['pack_category'];
    _packName = json['pack_name'];
    _packBannerPath = json['pack_banner_path'];
    _packHour = json['pack_hour'];
    _dueDate = json['due_date'];
    _dueTime = json['due_time'];
    _clientId = json['client_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _partnerId = json['partner_id'];
    _subTotal = json['sub_total'];
    _discount = json['discount'];
    _nominalDiscount = json['nominal_discount'];
    _nominalAfterDiscount = json['nominal_after_discount'];
    _tax = json['tax'];
    _nominalTax = json['nominal_tax'];
    _grandTotal = json['grand_total'];
    _orderNotes = json['order_notes'];
    _orderStatus = json['order_status'];
    _createdAt = json['created_at'];
    _createdBy = json['created_by'];
  }
  num? _orderid;
  num? _packId;
  String? _packCategory;
  String? _packName;
  String? _packBannerPath;
  String? _packHour;
  String? _dueDate;
  String? _dueTime;
  num? _clientId;
  dynamic _firstName;
  dynamic _lastName;
  dynamic _partnerId;
  num? _subTotal;
  dynamic _discount;
  num? _nominalDiscount;
  num? _nominalAfterDiscount;
  num? _tax;
  num? _nominalTax;
  num? _grandTotal;
  String? _orderNotes;
  String? _orderStatus;
  String? _createdAt;
  String? _createdBy;
Data copyWith({  num? orderid,
  num? packId,
  String? packCategory,
  String? packName,
  String? packBannerPath,
  String? packHour,
  String? dueDate,
  String? dueTime,
  num? clientId,
  dynamic firstName,
  dynamic lastName,
  dynamic partnerId,
  num? subTotal,
  dynamic discount,
  num? nominalDiscount,
  num? nominalAfterDiscount,
  num? tax,
  num? nominalTax,
  num? grandTotal,
  String? orderNotes,
  String? orderStatus,
  String? createdAt,
  String? createdBy,
}) => Data(  orderid: orderid ?? _orderid,
  packId: packId ?? _packId,
  packCategory: packCategory ?? _packCategory,
  packName: packName ?? _packName,
  packBannerPath: packBannerPath ?? _packBannerPath,
  packHour: packHour ?? _packHour,
  dueDate: dueDate ?? _dueDate,
  dueTime: dueTime ?? _dueTime,
  clientId: clientId ?? _clientId,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  partnerId: partnerId ?? _partnerId,
  subTotal: subTotal ?? _subTotal,
  discount: discount ?? _discount,
  nominalDiscount: nominalDiscount ?? _nominalDiscount,
  nominalAfterDiscount: nominalAfterDiscount ?? _nominalAfterDiscount,
  tax: tax ?? _tax,
  nominalTax: nominalTax ?? _nominalTax,
  grandTotal: grandTotal ?? _grandTotal,
  orderNotes: orderNotes ?? _orderNotes,
  orderStatus: orderStatus ?? _orderStatus,
  createdAt: createdAt ?? _createdAt,
  createdBy: createdBy ?? _createdBy,
);
  num? get orderid => _orderid;
  num? get packId => _packId;
  String? get packCategory => _packCategory;
  String? get packName => _packName;
  String? get packBannerPath => _packBannerPath;
  String? get packHour => _packHour;
  String? get dueDate => _dueDate;
  String? get dueTime => _dueTime;
  num? get clientId => _clientId;
  dynamic get firstName => _firstName;
  dynamic get lastName => _lastName;
  dynamic get partnerId => _partnerId;
  num? get subTotal => _subTotal;
  dynamic get discount => _discount;
  num? get nominalDiscount => _nominalDiscount;
  num? get nominalAfterDiscount => _nominalAfterDiscount;
  num? get tax => _tax;
  num? get nominalTax => _nominalTax;
  num? get grandTotal => _grandTotal;
  String? get orderNotes => _orderNotes;
  String? get orderStatus => _orderStatus;
  String? get createdAt => _createdAt;
  String? get createdBy => _createdBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderid'] = _orderid;
    map['pack_id'] = _packId;
    map['pack_category'] = _packCategory;
    map['pack_name'] = _packName;
    map['pack_banner_path'] = _packBannerPath;
    map['pack_hour'] = _packHour;
    map['due_date'] = _dueDate;
    map['due_time'] = _dueTime;
    map['client_id'] = _clientId;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['partner_id'] = _partnerId;
    map['sub_total'] = _subTotal;
    map['discount'] = _discount;
    map['nominal_discount'] = _nominalDiscount;
    map['nominal_after_discount'] = _nominalAfterDiscount;
    map['tax'] = _tax;
    map['nominal_tax'] = _nominalTax;
    map['grand_total'] = _grandTotal;
    map['order_notes'] = _orderNotes;
    map['order_status'] = _orderStatus;
    map['created_at'] = _createdAt;
    map['created_by'] = _createdBy;
    return map;
  }

}