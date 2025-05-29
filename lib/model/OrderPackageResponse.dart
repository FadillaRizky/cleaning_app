/// status : true
/// message : "added data successfully"
/// data : {"order":{"orderid":5,"pack_id":3,"pack_name":"Setrika","pack_hour":4,"due_date":"2025-05-29","due_time":"10:00:00","client_id":24,"first_name":null,"last_name":null,"partner_id":null,"property_address":"Jl. Flamboyan II, Wonogiri","sub_total":300000,"discount":2,"nominal_discount":6000,"nominal_after_discount":294000,"tax":11,"nominal_tax":32340,"grand_total":326340,"order_notes":"aaaa","order_status":"open","created_at":"2025-05-28T13:18:32.000000Z","created_by":"Trial User"},"order_detail":[{"od_id":7,"orderid":5,"object_id":2,"object_price":100000,"created_at":"2025-05-28T13:18:32.000000Z","created_by":null,"updated_at":"2025-05-28T13:18:32.000000Z","updated_by":null,"canceled_at":null,"canceled_by":null},{"od_id":8,"orderid":5,"object_id":4,"object_price":150000,"created_at":"2025-05-28T13:18:32.000000Z","created_by":null,"updated_at":"2025-05-28T13:18:32.000000Z","updated_by":null,"canceled_at":null,"canceled_by":null},{"od_id":9,"orderid":5,"object_id":5,"object_price":200000,"created_at":"2025-05-28T13:18:32.000000Z","created_by":null,"updated_at":"2025-05-28T13:18:32.000000Z","updated_by":null,"canceled_at":null,"canceled_by":null}]}

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

/// order : {"orderid":5,"pack_id":3,"pack_name":"Setrika","pack_hour":4,"due_date":"2025-05-29","due_time":"10:00:00","client_id":24,"first_name":null,"last_name":null,"partner_id":null,"property_address":"Jl. Flamboyan II, Wonogiri","sub_total":300000,"discount":2,"nominal_discount":6000,"nominal_after_discount":294000,"tax":11,"nominal_tax":32340,"grand_total":326340,"order_notes":"aaaa","order_status":"open","created_at":"2025-05-28T13:18:32.000000Z","created_by":"Trial User"}
/// order_detail : [{"od_id":7,"orderid":5,"object_id":2,"object_price":100000,"created_at":"2025-05-28T13:18:32.000000Z","created_by":null,"updated_at":"2025-05-28T13:18:32.000000Z","updated_by":null,"canceled_at":null,"canceled_by":null},{"od_id":8,"orderid":5,"object_id":4,"object_price":150000,"created_at":"2025-05-28T13:18:32.000000Z","created_by":null,"updated_at":"2025-05-28T13:18:32.000000Z","updated_by":null,"canceled_at":null,"canceled_by":null},{"od_id":9,"orderid":5,"object_id":5,"object_price":200000,"created_at":"2025-05-28T13:18:32.000000Z","created_by":null,"updated_at":"2025-05-28T13:18:32.000000Z","updated_by":null,"canceled_at":null,"canceled_by":null}]

class Data {
  Data({
      Order? order, 
      List<OrderDetail>? orderDetail,}){
    _order = order;
    _orderDetail = orderDetail;
}

  Data.fromJson(dynamic json) {
    _order = json['order'] != null ? Order.fromJson(json['order']) : null;
    if (json['order_detail'] != null) {
      _orderDetail = [];
      json['order_detail'].forEach((v) {
        _orderDetail?.add(OrderDetail.fromJson(v));
      });
    }
  }
  Order? _order;
  List<OrderDetail>? _orderDetail;
Data copyWith({  Order? order,
  List<OrderDetail>? orderDetail,
}) => Data(  order: order ?? _order,
  orderDetail: orderDetail ?? _orderDetail,
);
  Order? get order => _order;
  List<OrderDetail>? get orderDetail => _orderDetail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_order != null) {
      map['order'] = _order?.toJson();
    }
    if (_orderDetail != null) {
      map['order_detail'] = _orderDetail?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// od_id : 7
/// orderid : 5
/// object_id : 2
/// object_price : 100000
/// created_at : "2025-05-28T13:18:32.000000Z"
/// created_by : null
/// updated_at : "2025-05-28T13:18:32.000000Z"
/// updated_by : null
/// canceled_at : null
/// canceled_by : null

class OrderDetail {
  OrderDetail({
      num? odId, 
      num? orderid, 
      num? objectId, 
      num? objectPrice, 
      String? createdAt, 
      dynamic createdBy, 
      String? updatedAt, 
      dynamic updatedBy, 
      dynamic canceledAt, 
      dynamic canceledBy,}){
    _odId = odId;
    _orderid = orderid;
    _objectId = objectId;
    _objectPrice = objectPrice;
    _createdAt = createdAt;
    _createdBy = createdBy;
    _updatedAt = updatedAt;
    _updatedBy = updatedBy;
    _canceledAt = canceledAt;
    _canceledBy = canceledBy;
}

  OrderDetail.fromJson(dynamic json) {
    _odId = json['od_id'];
    _orderid = json['orderid'];
    _objectId = json['object_id'];
    _objectPrice = json['object_price'];
    _createdAt = json['created_at'];
    _createdBy = json['created_by'];
    _updatedAt = json['updated_at'];
    _updatedBy = json['updated_by'];
    _canceledAt = json['canceled_at'];
    _canceledBy = json['canceled_by'];
  }
  num? _odId;
  num? _orderid;
  num? _objectId;
  num? _objectPrice;
  String? _createdAt;
  dynamic _createdBy;
  String? _updatedAt;
  dynamic _updatedBy;
  dynamic _canceledAt;
  dynamic _canceledBy;
OrderDetail copyWith({  num? odId,
  num? orderid,
  num? objectId,
  num? objectPrice,
  String? createdAt,
  dynamic createdBy,
  String? updatedAt,
  dynamic updatedBy,
  dynamic canceledAt,
  dynamic canceledBy,
}) => OrderDetail(  odId: odId ?? _odId,
  orderid: orderid ?? _orderid,
  objectId: objectId ?? _objectId,
  objectPrice: objectPrice ?? _objectPrice,
  createdAt: createdAt ?? _createdAt,
  createdBy: createdBy ?? _createdBy,
  updatedAt: updatedAt ?? _updatedAt,
  updatedBy: updatedBy ?? _updatedBy,
  canceledAt: canceledAt ?? _canceledAt,
  canceledBy: canceledBy ?? _canceledBy,
);
  num? get odId => _odId;
  num? get orderid => _orderid;
  num? get objectId => _objectId;
  num? get objectPrice => _objectPrice;
  String? get createdAt => _createdAt;
  dynamic get createdBy => _createdBy;
  String? get updatedAt => _updatedAt;
  dynamic get updatedBy => _updatedBy;
  dynamic get canceledAt => _canceledAt;
  dynamic get canceledBy => _canceledBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['od_id'] = _odId;
    map['orderid'] = _orderid;
    map['object_id'] = _objectId;
    map['object_price'] = _objectPrice;
    map['created_at'] = _createdAt;
    map['created_by'] = _createdBy;
    map['updated_at'] = _updatedAt;
    map['updated_by'] = _updatedBy;
    map['canceled_at'] = _canceledAt;
    map['canceled_by'] = _canceledBy;
    return map;
  }

}

/// orderid : 5
/// pack_id : 3
/// pack_name : "Setrika"
/// pack_hour : 4
/// due_date : "2025-05-29"
/// due_time : "10:00:00"
/// client_id : 24
/// first_name : null
/// last_name : null
/// partner_id : null
/// property_address : "Jl. Flamboyan II, Wonogiri"
/// sub_total : 300000
/// discount : 2
/// nominal_discount : 6000
/// nominal_after_discount : 294000
/// tax : 11
/// nominal_tax : 32340
/// grand_total : 326340
/// order_notes : "aaaa"
/// order_status : "open"
/// created_at : "2025-05-28T13:18:32.000000Z"
/// created_by : "Trial User"

class Order {
  Order({
      num? orderid, 
      num? packId, 
      String? packName, 
      num? packHour, 
      String? dueDate, 
      String? dueTime, 
      num? clientId, 
      dynamic firstName, 
      dynamic lastName, 
      dynamic partnerId, 
      String? propertyAddress, 
      num? subTotal, 
      num? discount, 
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
    _packName = packName;
    _packHour = packHour;
    _dueDate = dueDate;
    _dueTime = dueTime;
    _clientId = clientId;
    _firstName = firstName;
    _lastName = lastName;
    _partnerId = partnerId;
    _propertyAddress = propertyAddress;
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

  Order.fromJson(dynamic json) {
    _orderid = json['orderid'];
    _packId = json['pack_id'];
    _packName = json['pack_name'];
    _packHour = json['pack_hour'];
    _dueDate = json['due_date'];
    _dueTime = json['due_time'];
    _clientId = json['client_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _partnerId = json['partner_id'];
    _propertyAddress = json['property_address'];
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
  String? _packName;
  num? _packHour;
  String? _dueDate;
  String? _dueTime;
  num? _clientId;
  dynamic _firstName;
  dynamic _lastName;
  dynamic _partnerId;
  String? _propertyAddress;
  num? _subTotal;
  num? _discount;
  num? _nominalDiscount;
  num? _nominalAfterDiscount;
  num? _tax;
  num? _nominalTax;
  num? _grandTotal;
  String? _orderNotes;
  String? _orderStatus;
  String? _createdAt;
  String? _createdBy;
Order copyWith({  num? orderid,
  num? packId,
  String? packName,
  num? packHour,
  String? dueDate,
  String? dueTime,
  num? clientId,
  dynamic firstName,
  dynamic lastName,
  dynamic partnerId,
  String? propertyAddress,
  num? subTotal,
  num? discount,
  num? nominalDiscount,
  num? nominalAfterDiscount,
  num? tax,
  num? nominalTax,
  num? grandTotal,
  String? orderNotes,
  String? orderStatus,
  String? createdAt,
  String? createdBy,
}) => Order(  orderid: orderid ?? _orderid,
  packId: packId ?? _packId,
  packName: packName ?? _packName,
  packHour: packHour ?? _packHour,
  dueDate: dueDate ?? _dueDate,
  dueTime: dueTime ?? _dueTime,
  clientId: clientId ?? _clientId,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  partnerId: partnerId ?? _partnerId,
  propertyAddress: propertyAddress ?? _propertyAddress,
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
  String? get packName => _packName;
  num? get packHour => _packHour;
  String? get dueDate => _dueDate;
  String? get dueTime => _dueTime;
  num? get clientId => _clientId;
  dynamic get firstName => _firstName;
  dynamic get lastName => _lastName;
  dynamic get partnerId => _partnerId;
  String? get propertyAddress => _propertyAddress;
  num? get subTotal => _subTotal;
  num? get discount => _discount;
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
    map['pack_name'] = _packName;
    map['pack_hour'] = _packHour;
    map['due_date'] = _dueDate;
    map['due_time'] = _dueTime;
    map['client_id'] = _clientId;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['partner_id'] = _partnerId;
    map['property_address'] = _propertyAddress;
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