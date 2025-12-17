class DetailOrderResponse {
  final bool? status;
  final String? message;
  final Data? data;
  const DetailOrderResponse({this.status, this.message, this.data});
  DetailOrderResponse copyWith({bool? status, String? message, Data? data}) {
    return DetailOrderResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data);
  }

  Map<String, Object?> toJson() {
    return {'status': status, 'message': message, 'data': data?.toJson()};
  }

  static DetailOrderResponse fromJson(Map<String, Object?> json) {
    return DetailOrderResponse(
        status: json['status'] == null ? null : json['status'] as bool,
        message: json['message'] == null ? null : json['message'] as String,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, Object?>));
  }

  @override
  String toString() {
    return '''DetailOrderResponse(
                status:$status,
message:$message,
data:${data.toString()}
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is DetailOrderResponse &&
        other.runtimeType == runtimeType &&
        other.status == status &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, status, message, data);
  }
}

class Data {
  final int? orderid;
  final String? paymentType;
  final String? propertyType;
  final String? picName;
  final String? picPhone;
  final String? propertyAddress;
  final String? propertyCity;
  final List<DataPack>? dataPack;
  final String? dueDate;
  final String? category;
  final String? dueTime;
  final double? tax;
  final int? nominalTax;
  final int? ttlBasicPrice;
  final int? platformCharge;
  final int? propertyCharge;
  final double? ttlDiscPercent;
  final int? ttlDiscNominal;
  final int? ttlSellingNominal;
  final String? orderNotes;
  final String? orderStatus;
  final String? mitraGender;
  final String? partnerName;
  final String? partnerPhone;
  final String? partnerPhoto;
  final List<DataDocuments>? dataDocuments;
  final int? clientRating;
  final dynamic clientReview;
  final int? clientUpdate;
  final String? finishAt;
  const Data(
      {this.orderid,
      this.paymentType,
      this.propertyType,
      this.picName,
      this.picPhone,
      this.propertyAddress,
      this.propertyCity,
      this.dataPack,
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
      this.dataDocuments,
      this.clientRating,
      this.clientReview,
      this.clientUpdate,
      this.finishAt});
  Data copyWith(
      {int? orderid,
      String? paymentType,
      String? propertyType,
      String? picName,
      String? picPhone,
      String? propertyAddress,
      String? propertyCity,
      List<DataPack>? dataPack,
      String? dueDate,
      String? category,
      String? dueTime,
      double? tax,
      int? nominalTax,
      int? ttlBasicPrice,
      int? platformCharge,
      int? propertyCharge,
      double? ttlDiscPercent,
      int? ttlDiscNominal,
      int? ttlSellingNominal,
      String? orderNotes,
      String? orderStatus,
      String? mitraGender,
      String? partnerName,
      String? partnerPhone,
      String? partnerPhoto,
      List<DataDocuments>? dataDocuments,
      int? clientRating,
      dynamic? clientReview,
      int? clientUpdate,
      String? finishAt}) {
    return Data(
        orderid: orderid ?? this.orderid,
        paymentType: paymentType ?? this.paymentType,
        propertyType: propertyType ?? this.propertyType,
        picName: picName ?? this.picName,
        picPhone: picPhone ?? this.picPhone,
        propertyAddress: propertyAddress ?? this.propertyAddress,
        propertyCity: propertyCity ?? this.propertyCity,
        dataPack: dataPack ?? this.dataPack,
        dueDate: dueDate ?? this.dueDate,
        category: category ?? this.category,
        dueTime: dueTime ?? this.dueTime,
        tax: tax ?? this.tax,
        nominalTax: nominalTax ?? this.nominalTax,
        ttlBasicPrice: ttlBasicPrice ?? this.ttlBasicPrice,
        platformCharge: platformCharge ?? this.platformCharge,
        propertyCharge: propertyCharge ?? this.propertyCharge,
        ttlDiscPercent: ttlDiscPercent ?? this.ttlDiscPercent,
        ttlDiscNominal: ttlDiscNominal ?? this.ttlDiscNominal,
        ttlSellingNominal: ttlSellingNominal ?? this.ttlSellingNominal,
        orderNotes: orderNotes ?? this.orderNotes,
        orderStatus: orderStatus ?? this.orderStatus,
        mitraGender: mitraGender ?? this.mitraGender,
        partnerName: partnerName ?? this.partnerName,
        partnerPhone: partnerPhone ?? this.partnerPhone,
        partnerPhoto: partnerPhoto ?? this.partnerPhoto,
        dataDocuments: dataDocuments ?? this.dataDocuments,
        clientRating: clientRating ?? this.clientRating,
        clientReview: clientReview ?? this.clientReview,
        clientUpdate: clientUpdate ?? this.clientUpdate,
        finishAt: finishAt ?? this.finishAt);
  }

  Map<String, Object?> toJson() {
    return {
      'orderid': orderid,
      'payment_type': paymentType,
      'property_type': propertyType,
      'pic_name': picName,
      'pic_phone': picPhone,
      'property_address': propertyAddress,
      'property_city': propertyCity,
      'data_pack':
          dataPack?.map<Map<String, dynamic>>((data) => data.toJson()).toList(),
      'due_date': dueDate,
      'category': category,
      'due_time': dueTime,
      'tax': tax,
      'nominal_tax': nominalTax,
      'ttl_basic_price': ttlBasicPrice,
      'platform_charge': platformCharge,
      'property_charge': propertyCharge,
      'ttl_disc_percent': ttlDiscPercent,
      'ttl_disc_nominal': ttlDiscNominal,
      'ttl_selling_nominal': ttlSellingNominal,
      'order_notes': orderNotes,
      'order_status': orderStatus,
      'mitra_gender': mitraGender,
      'partner_name': partnerName,
      'partner_phone': partnerPhone,
      'partner_photo': partnerPhoto,
      'data_documents': dataDocuments
          ?.map<Map<String, dynamic>>((data) => data.toJson())
          .toList(),
      'client_rating': clientRating,
      'client_review': clientReview,
      'client_update': clientUpdate,
      'finish_at': finishAt
    };
  }

  static Data fromJson(Map<String, Object?> json) {
    return Data(
        orderid: json['orderid'] == null ? null : json['orderid'] as int,
        paymentType: json['payment_type'] == null
            ? null
            : json['payment_type'] as String,
        propertyType: json['property_type'] == null
            ? null
            : json['property_type'] as String,
        picName: json['pic_name'] == null ? null : json['pic_name'] as String,
        picPhone:
            json['pic_phone'] == null ? null : json['pic_phone'] as String,
        propertyAddress: json['property_address'] == null
            ? null
            : json['property_address'] as String,
        propertyCity: json['property_city'] == null
            ? null
            : json['property_city'] as String,
        dataPack: json['data_pack'] == null
            ? null
            : (json['data_pack'] as List)
                .map<DataPack>(
                    (item) => DataPack.fromJson(item as Map<String, Object?>))
                .toList(),
        dueDate: json['due_date'] == null ? null : json['due_date'] as String,
        category: json['category'] == null ? null : json['category'] as String,
        dueTime: json['due_time'] == null ? null : json['due_time'] as String,
        tax: json['tax'] == null ? null : (json['tax'] as num).toDouble(),
        nominalTax:
            json['nominal_tax'] == null ? null : json['nominal_tax'] as int,
        ttlBasicPrice: json['ttl_basic_price'] == null
            ? null
            : json['ttl_basic_price'] as int,
        platformCharge: json['platform_charge'] == null
            ? null
            : json['platform_charge'] as int,
        propertyCharge: json['property_charge'] == null
            ? null
            : json['property_charge'] as int,
        ttlDiscPercent: json['ttl_disc_percent'] == null
            ? null
            : (json['ttl_disc_percent'] as num).toDouble(),
        ttlDiscNominal: json['ttl_disc_nominal'] == null
            ? null
            : json['ttl_disc_nominal'] as int,
        ttlSellingNominal: json['ttl_selling_nominal'] == null
            ? null
            : json['ttl_selling_nominal'] as int,
        orderNotes:
            json['order_notes'] == null ? null : json['order_notes'] as String,
        orderStatus: json['order_status'] == null
            ? null
            : json['order_status'] as String,
        mitraGender: json['mitra_gender'] == null
            ? null
            : json['mitra_gender'] as String,
        partnerName: json['partner_name'] == null
            ? null
            : json['partner_name'] as String,
        partnerPhone: json['partner_phone'] == null
            ? null
            : json['partner_phone'] as String,
        partnerPhoto: json['partner_photo'] == null
            ? null
            : json['partner_photo'] as String,
        dataDocuments: json['data_documents'] == null
            ? null
            : (json['data_documents'] as List)
                .map<DataDocuments>((item) =>
                    DataDocuments.fromJson(item as Map<String, Object?>))
                .toList(),
        clientRating:
            json['client_rating'] == null ? null : json['client_rating'] as int,
        clientReview: json['client_review'] as dynamic,
        clientUpdate:
            json['client_update'] == null ? null : json['client_update'] as int,
        finishAt:
            json['finish_at'] == null ? null : json['finish_at'] as String);
  }

  @override
  String toString() {
    return '''Data(
                orderid:$orderid,
paymentType:$paymentType,
propertyType:$propertyType,
picName:$picName,
picPhone:$picPhone,
propertyAddress:$propertyAddress,
propertyCity:$propertyCity,
dataPack:${dataPack.toString()},
dueDate:$dueDate,
category:$category,
dueTime:$dueTime,
tax:$tax,
nominalTax:$nominalTax,
ttlBasicPrice:$ttlBasicPrice,
platformCharge:$platformCharge,
propertyCharge:$propertyCharge,
ttlDiscPercent:$ttlDiscPercent,
ttlDiscNominal:$ttlDiscNominal,
ttlSellingNominal:$ttlSellingNominal,
orderNotes:$orderNotes,
orderStatus:$orderStatus,
mitraGender:$mitraGender,
partnerName:$partnerName,
partnerPhone:$partnerPhone,
partnerPhoto:$partnerPhoto,
dataDocuments:${dataDocuments.toString()},
clientRating:$clientRating,
clientReview:$clientReview,
clientUpdate:$clientUpdate,
finishAt:$finishAt
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Data &&
        other.runtimeType == runtimeType &&
        other.orderid == orderid &&
        other.paymentType == paymentType &&
        other.propertyType == propertyType &&
        other.picName == picName &&
        other.picPhone == picPhone &&
        other.propertyAddress == propertyAddress &&
        other.propertyCity == propertyCity &&
        other.dataPack == dataPack &&
        other.dueDate == dueDate &&
        other.category == category &&
        other.dueTime == dueTime &&
        other.tax == tax &&
        other.nominalTax == nominalTax &&
        other.ttlBasicPrice == ttlBasicPrice &&
        other.platformCharge == platformCharge &&
        other.propertyCharge == propertyCharge &&
        other.ttlDiscPercent == ttlDiscPercent &&
        other.ttlDiscNominal == ttlDiscNominal &&
        other.ttlSellingNominal == ttlSellingNominal &&
        other.orderNotes == orderNotes &&
        other.orderStatus == orderStatus &&
        other.mitraGender == mitraGender &&
        other.partnerName == partnerName &&
        other.partnerPhone == partnerPhone &&
        other.partnerPhoto == partnerPhoto &&
        other.dataDocuments == dataDocuments &&
        other.clientRating == clientRating &&
        other.clientReview == clientReview &&
        other.clientUpdate == clientUpdate &&
        other.finishAt == finishAt;
  }

  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        orderid,
        paymentType,
        propertyType,
        picName,
        picPhone,
        propertyAddress,
        propertyCity,
        dataPack,
        dueDate,
        category,
        dueTime,
        tax,
        nominalTax,
        ttlBasicPrice,
        platformCharge,
        propertyCharge,
        ttlDiscPercent,
        ttlDiscNominal,
        ttlSellingNominal);
  }
}

class DataDocuments {
  final String? imgBefore1;
  final String? imgBefore2;
  final String? imgAfter1;
  final String? imgAfter2;
  const DataDocuments(
      {this.imgBefore1, this.imgBefore2, this.imgAfter1, this.imgAfter2});
  DataDocuments copyWith(
      {String? imgBefore1,
      String? imgBefore2,
      String? imgAfter1,
      String? imgAfter2}) {
    return DataDocuments(
        imgBefore1: imgBefore1 ?? this.imgBefore1,
        imgBefore2: imgBefore2 ?? this.imgBefore2,
        imgAfter1: imgAfter1 ?? this.imgAfter1,
        imgAfter2: imgAfter2 ?? this.imgAfter2);
  }

  Map<String, Object?> toJson() {
    return {
      'img_before1': imgBefore1,
      'img_before2': imgBefore2,
      'img_after1': imgAfter1,
      'img_after2': imgAfter2
    };
  }

  static DataDocuments fromJson(Map<String, Object?> json) {
    return DataDocuments(
        imgBefore1:
            json['img_before1'] == null ? null : json['img_before1'] as String,
        imgBefore2:
            json['img_before2'] == null ? null : json['img_before2'] as String,
        imgAfter1:
            json['img_after1'] == null ? null : json['img_after1'] as String,
        imgAfter2:
            json['img_after2'] == null ? null : json['img_after2'] as String);
  }

  @override
  String toString() {
    return '''DataDocuments(
                imgBefore1:$imgBefore1,
imgBefore2:$imgBefore2,
imgAfter1:$imgAfter1,
imgAfter2:$imgAfter2
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is DataDocuments &&
        other.runtimeType == runtimeType &&
        other.imgBefore1 == imgBefore1 &&
        other.imgBefore2 == imgBefore2 &&
        other.imgAfter1 == imgAfter1 &&
        other.imgAfter2 == imgAfter2;
  }

  @override
  int get hashCode {
    return Object.hash(
        runtimeType, imgBefore1, imgBefore2, imgAfter1, imgAfter2);
  }
}

class DataPack {
  final int? packId;
  final String? packName;
  final String? packCategory;
  final String? packHour;
  final int? packPrice;
  final List<DataObject>? dataObject;
  const DataPack(
      {this.packId,
      this.packName,
      this.packCategory,
      this.packHour,
      this.packPrice,
      this.dataObject});
  DataPack copyWith(
      {int? packId,
      String? packName,
      String? packCategory,
      String? packHour,
      int? packPrice,
      List<DataObject>? dataObject}) {
    return DataPack(
        packId: packId ?? this.packId,
        packName: packName ?? this.packName,
        packCategory: packCategory ?? this.packCategory,
        packHour: packHour ?? this.packHour,
        packPrice: packPrice ?? this.packPrice,
        dataObject: dataObject ?? this.dataObject);
  }

  Map<String, Object?> toJson() {
    return {
      'pack_id': packId,
      'pack_name': packName,
      'pack_category': packCategory,
      'pack_hour': packHour,
      'pack_price': packPrice,
      'data_object': dataObject
          ?.map<Map<String, dynamic>>((data) => data.toJson())
          .toList()
    };
  }

  static DataPack fromJson(Map<String, Object?> json) {
    return DataPack(
      packId: json['pack_id'] == null ? null : json['pack_id'] as int,
      packName: json['pack_name'] == null ? null : json['pack_name'] as String,
      packCategory: json['pack_category'] == null
          ? null
          : json['pack_category'] as String,
      packHour: json['pack_hour'] == null ? null : json['pack_hour'] as String,
      packPrice: json['pack_price'] == null ? null : json['pack_price'] as int,
      dataObject: json['data_object'] == null
          ? null
          : (json['data_object'] as List)
              .map<DataObject>(
                  (item) => DataObject.fromJson(item as Map<String, Object?>))
              .toList(),
    );
  }

  @override
  String toString() {
    return '''DataPack(
                packId:$packId,
packName:$packName,
packCategory:$packCategory,
packHour:$packHour,
packPrice:$packPrice,
dataObject:${dataObject.toString()}
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is DataPack &&
        other.runtimeType == runtimeType &&
        other.packId == packId &&
        other.packName == packName &&
        other.packCategory == packCategory &&
        other.packHour == packHour &&
        other.packPrice == packPrice &&
        other.dataObject == dataObject;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, packId, packName, packCategory, packHour,
        packPrice, dataObject);
  }
}

class DataObject {
  final dynamic objectId;
  final dynamic qty;
  final dynamic objectName;
  final dynamic objectPrice;
  const DataObject(
      {this.objectId, this.qty, this.objectName, this.objectPrice});
  DataObject copyWith(
      {dynamic? objectId,
      dynamic? qty,
      dynamic? objectName,
      dynamic? objectPrice}) {
    return DataObject(
        objectId: objectId ?? this.objectId,
        qty: qty ?? this.qty,
        objectName: objectName ?? this.objectName,
        objectPrice: objectPrice ?? this.objectPrice);
  }

  Map<String, Object?> toJson() {
    return {
      'object_id': objectId,
      'qty': qty,
      'object_name': objectName,
      'object_price': objectPrice
    };
  }

  static DataObject fromJson(Map<String, Object?> json) {
    return DataObject(
        objectId: json['object_id'] as dynamic,
        qty: json['qty'] as dynamic,
        objectName: json['object_name'] as dynamic,
        objectPrice: json['object_price'] as dynamic);
  }

  @override
  String toString() {
    return '''DataObject(
                objectId:$objectId,
qty:$qty,
objectName:$objectName,
objectPrice:$objectPrice
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is DataObject &&
        other.runtimeType == runtimeType &&
        other.objectId == objectId &&
        other.qty == qty &&
        other.objectName == objectName &&
        other.objectPrice == objectPrice;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, objectId, qty, objectName, objectPrice);
  }
}
