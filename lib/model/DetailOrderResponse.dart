class DetailOrderResponse {
  final bool? status;
  final String? message;
  final DetailOrderData? data;

  DetailOrderResponse({
    this.status,
    this.message,
    this.data,
  });

  factory DetailOrderResponse.fromJson(Map<String, dynamic> json) {
    return DetailOrderResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? DetailOrderData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class DetailOrderData {
  final int? orderId;
  final String? paymentType;
  final String? propertyType;
  final String? picName;
  final String? picPhone;
  final String? propertyAddress;
  final String? propertyCity;
  final List<DataPack> dataPack;
  final String? dueDate;
  final String? category;
  final String? dueTime;
  final num? tax;
  final num? nominalTax;
  final num? ttlBasicPrice;
  final num? platformCharge;
  final num? propertyCharge;
  final num? ttlDiscPercent;
  final num? ttlDiscNominal;
  final num? ttlSellingNominal;
  final String? orderNotes;
  final String? orderStatus;
  final String? mitraGender;
  final String? partnerName;
  final String? partnerPhone;
  final String? partnerPhoto;

  DetailOrderData({
    this.orderId,
    this.paymentType,
    this.propertyType,
    this.picName,
    this.picPhone,
    this.propertyAddress,
    this.propertyCity,
    this.dataPack = const [],
    this.dueDate,
    this.category,
    this.dueTime,
    this.tax,
    this.nominalTax,
    this.ttlBasicPrice,
    this.platformCharge,
    this.propertyCharge,
    this.ttlDiscPercent,
    this.ttlDiscNominal,
    this.ttlSellingNominal,
    this.orderNotes,
    this.orderStatus,
    this.mitraGender,
    this.partnerName,
    this.partnerPhone,
    this.partnerPhoto,
  });

  factory DetailOrderData.fromJson(Map<String, dynamic> json) {
    return DetailOrderData(
      orderId: json['orderid'] as int?,
      paymentType: json['payment_type'] as String?,
      propertyType: json['property_type'] as String?,
      picName: json['pic_name'] as String?,
      picPhone: json['pic_phone'] as String?,
      propertyAddress: json['property_address'] as String?,
      propertyCity: json['property_city'] as String?,
      dataPack: (json['data_pack'] as List?)
              ?.map((e) => DataPack.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      dueDate: json['due_date'] as String?,
      category: json['category'] as String?,
      dueTime: json['due_time'] as String?,
      tax: json['tax'],
      nominalTax: json['nominal_tax'],
      ttlBasicPrice: json['ttl_basic_price'],
      platformCharge: json['platform_charge'],
      propertyCharge: json['property_charge'],
      ttlDiscPercent: json['ttl_disc_percent'],
      ttlDiscNominal: json['ttl_disc_nominal'],
      ttlSellingNominal: json['ttl_selling_nominal'],
      orderNotes: json['order_notes'] as String?,
      orderStatus: json['order_status'] as String?,
      mitraGender: json['mitra_gender'] as String?,
      partnerName: json['partner_name'] as String?,
      partnerPhone: json['partner_phone'] as String?,
      partnerPhoto: json['partner_photo'] as String?,
    );
  }
}

class DataPack {
  final int? packId;
  final String? packName;
  final String? packCategory;
  final String? packHour;
  final num? packPrice;
  final List<DataObject> dataObject;

  DataPack({
    this.packId,
    this.packName,
    this.packCategory,
    this.packHour,
    this.packPrice,
    this.dataObject = const [],
  });

  factory DataPack.fromJson(Map<String, dynamic> json) {
    return DataPack(
      packId: json['pack_id'] as int?,
      packName: json['pack_name'] as String?,
      packCategory: json['pack_category'] as String?,
      packHour: json['pack_hour']?.toString(),
      packPrice: json['pack_price'],
      dataObject: (json['data_object'] as List?)
              ?.map((e) => DataObject.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class DataObject {
  final int? objectId;
  final int? qty;
  final String? objectName;
  final num? objectPrice;

  DataObject({
    this.objectId,
    this.qty,
    this.objectName,
    this.objectPrice,
  });

  factory DataObject.fromJson(Map<String, dynamic> json) {
    return DataObject(
      objectId: json['object_id'] as int?,
      qty: json['qty'] as int?,
      objectName: json['object_name'] as String?,
      objectPrice: json['object_price'] is String
          ? num.tryParse(json['object_price'])
          : json['object_price'],
    );
  }
}
