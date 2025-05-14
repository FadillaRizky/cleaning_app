/// status : true
/// message : "data berhasil ditemukan"
/// data : {"pack":{"pack_id":3,"pack_category":"Daily Cleaning","pack_name":"Setrika","pack_duration":2,"pack_price":120000,"pack_object_description":"Layanan kebersihan rutin yang dilakukan setiap hari untuk menjaga kebersihan dan kerapian sebuah hunian. Tujuannya adalah untuk mencegah penumpukan kotoran, debu, dan sampah, serta menciptakan lingkungan yang bersih, sehat, dan nyaman.","pack_global_description":"Menyetrikan dan merapihkan pakaian menggunakan peralatan milik peribadi Pelanggan","pack_job_description":"Pengerjaan\r\n\r\nLayanan ini meliputi:\r\n\r\na\tMenyetrika dan melipat pakaian\r\na\tMerapikan pakaian ke dalam lemari\r\n\r\nLayanan ini tidak termasuk:\r\n×\tMencuci pakaian\r\n×\tMengangkat dan menjemur pakaian\r\n×\tMenyediakan setrika dan papan setrika\r\n×\tMenyetrika pakaian renang dan pakaian lainnya yang tidak boleh disetrika\r\n\r\n•\tHarga yang tertera sudah termasuk asuransi.\r\n•\tUtilize’s-GO tidak bertanggung jawab atas transaksi yang terjadi di luar aplikasi.\r\n•\tDengan melakukan pemesanan, Pelanggan telah setuju dengan aturan dan ketentuan yang berlaku.","pack_procedure_description":"Panduan Estimasi Durasi\r\n\r\nBerikut pakaian yang termasuk dalam layanan setrika berikut estimasi pengerjaan","pack_banner_path":"https://ugo-clean.s3.ap-southeast-1.amazonaws.com/17458293117629.jpeg","pack_status":1,"pack_created_by":null,"pack_updated_by":1,"pack_deleted_by":null,"pack_created_at":"2025-03-04T17:26:27.000000Z","pack_updated_at":"2025-04-28T15:36:01.000000Z","pack_deleted_at":null,"pack_deleted_reason":null},"pdesc":[{"pdesc_id":101,"pack_id":3,"pdesc_title":"Kemeja","pdesc_detail":"Durasi: ±3 Menit","pdesc_img_path":"assets/img/promo/1741642525.jpg","pdesc_created_by":1,"pdesc_updated_by":1,"pdesc_deleted_by":null,"pdesc_created_at":"2025-03-11T04:35:25.000000Z","pdesc_updated_at":"2025-03-11T04:38:20.000000Z","pdesc_deleted_at":null,"pdesc_deleted_reason":null},{"pdesc_id":102,"pack_id":3,"pdesc_title":"KAOS","pdesc_detail":"Durasi: ±2 Menit","pdesc_img_path":"assets/img/promo/1741642680.jpeg","pdesc_created_by":1,"pdesc_updated_by":null,"pdesc_deleted_by":null,"pdesc_created_at":"2025-03-11T04:38:00.000000Z","pdesc_updated_at":"2025-03-11T04:38:00.000000Z","pdesc_deleted_at":null,"pdesc_deleted_reason":null},{"pdesc_id":103,"pack_id":3,"pdesc_title":"Jeans","pdesc_detail":"Durasi: ±3 Menit","pdesc_img_path":"assets/img/promo/1741642877.jpeg","pdesc_created_by":1,"pdesc_updated_by":null,"pdesc_deleted_by":null,"pdesc_created_at":"2025-03-11T04:41:17.000000Z","pdesc_updated_at":"2025-03-11T04:41:17.000000Z","pdesc_deleted_at":null,"pdesc_deleted_reason":null},{"pdesc_id":104,"pack_id":3,"pdesc_title":"Gamis","pdesc_detail":"Durasi: ±5 Menit","pdesc_img_path":"assets/img/promo/1741642989.webp","pdesc_created_by":1,"pdesc_updated_by":null,"pdesc_deleted_by":null,"pdesc_created_at":"2025-03-11T04:43:09.000000Z","pdesc_updated_at":"2025-03-11T04:43:09.000000Z","pdesc_deleted_at":null,"pdesc_deleted_reason":null},{"pdesc_id":105,"pack_id":3,"pdesc_title":"Seprei","pdesc_detail":"Durasi: ±5 Menit","pdesc_img_path":"assets/img/promo/1741643275.webp","pdesc_created_by":1,"pdesc_updated_by":1,"pdesc_deleted_by":null,"pdesc_created_at":"2025-03-11T04:47:40.000000Z","pdesc_updated_at":"2025-03-11T04:47:55.000000Z","pdesc_deleted_at":null,"pdesc_deleted_reason":null}]}

class DetailPackageResponse {
  DetailPackageResponse({
      bool? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  DetailPackageResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
DetailPackageResponse copyWith({  bool? status,
  String? message,
  Data? data,
}) => DetailPackageResponse(  status: status ?? _status,
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

/// pack : {"pack_id":3,"pack_category":"Daily Cleaning","pack_name":"Setrika","pack_duration":2,"pack_price":120000,"pack_object_description":"Layanan kebersihan rutin yang dilakukan setiap hari untuk menjaga kebersihan dan kerapian sebuah hunian. Tujuannya adalah untuk mencegah penumpukan kotoran, debu, dan sampah, serta menciptakan lingkungan yang bersih, sehat, dan nyaman.","pack_global_description":"Menyetrikan dan merapihkan pakaian menggunakan peralatan milik peribadi Pelanggan","pack_job_description":"Pengerjaan\r\n\r\nLayanan ini meliputi:\r\n\r\na\tMenyetrika dan melipat pakaian\r\na\tMerapikan pakaian ke dalam lemari\r\n\r\nLayanan ini tidak termasuk:\r\n×\tMencuci pakaian\r\n×\tMengangkat dan menjemur pakaian\r\n×\tMenyediakan setrika dan papan setrika\r\n×\tMenyetrika pakaian renang dan pakaian lainnya yang tidak boleh disetrika\r\n\r\n•\tHarga yang tertera sudah termasuk asuransi.\r\n•\tUtilize’s-GO tidak bertanggung jawab atas transaksi yang terjadi di luar aplikasi.\r\n•\tDengan melakukan pemesanan, Pelanggan telah setuju dengan aturan dan ketentuan yang berlaku.","pack_procedure_description":"Panduan Estimasi Durasi\r\n\r\nBerikut pakaian yang termasuk dalam layanan setrika berikut estimasi pengerjaan","pack_banner_path":"https://ugo-clean.s3.ap-southeast-1.amazonaws.com/17458293117629.jpeg","pack_status":1,"pack_created_by":null,"pack_updated_by":1,"pack_deleted_by":null,"pack_created_at":"2025-03-04T17:26:27.000000Z","pack_updated_at":"2025-04-28T15:36:01.000000Z","pack_deleted_at":null,"pack_deleted_reason":null}
/// pdesc : [{"pdesc_id":101,"pack_id":3,"pdesc_title":"Kemeja","pdesc_detail":"Durasi: ±3 Menit","pdesc_img_path":"assets/img/promo/1741642525.jpg","pdesc_created_by":1,"pdesc_updated_by":1,"pdesc_deleted_by":null,"pdesc_created_at":"2025-03-11T04:35:25.000000Z","pdesc_updated_at":"2025-03-11T04:38:20.000000Z","pdesc_deleted_at":null,"pdesc_deleted_reason":null},{"pdesc_id":102,"pack_id":3,"pdesc_title":"KAOS","pdesc_detail":"Durasi: ±2 Menit","pdesc_img_path":"assets/img/promo/1741642680.jpeg","pdesc_created_by":1,"pdesc_updated_by":null,"pdesc_deleted_by":null,"pdesc_created_at":"2025-03-11T04:38:00.000000Z","pdesc_updated_at":"2025-03-11T04:38:00.000000Z","pdesc_deleted_at":null,"pdesc_deleted_reason":null},{"pdesc_id":103,"pack_id":3,"pdesc_title":"Jeans","pdesc_detail":"Durasi: ±3 Menit","pdesc_img_path":"assets/img/promo/1741642877.jpeg","pdesc_created_by":1,"pdesc_updated_by":null,"pdesc_deleted_by":null,"pdesc_created_at":"2025-03-11T04:41:17.000000Z","pdesc_updated_at":"2025-03-11T04:41:17.000000Z","pdesc_deleted_at":null,"pdesc_deleted_reason":null},{"pdesc_id":104,"pack_id":3,"pdesc_title":"Gamis","pdesc_detail":"Durasi: ±5 Menit","pdesc_img_path":"assets/img/promo/1741642989.webp","pdesc_created_by":1,"pdesc_updated_by":null,"pdesc_deleted_by":null,"pdesc_created_at":"2025-03-11T04:43:09.000000Z","pdesc_updated_at":"2025-03-11T04:43:09.000000Z","pdesc_deleted_at":null,"pdesc_deleted_reason":null},{"pdesc_id":105,"pack_id":3,"pdesc_title":"Seprei","pdesc_detail":"Durasi: ±5 Menit","pdesc_img_path":"assets/img/promo/1741643275.webp","pdesc_created_by":1,"pdesc_updated_by":1,"pdesc_deleted_by":null,"pdesc_created_at":"2025-03-11T04:47:40.000000Z","pdesc_updated_at":"2025-03-11T04:47:55.000000Z","pdesc_deleted_at":null,"pdesc_deleted_reason":null}]

class Data {
  Data({
      Pack? pack, 
      List<Pdesc>? pdesc,}){
    _pack = pack;
    _pdesc = pdesc;
}

  Data.fromJson(dynamic json) {
    _pack = json['pack'] != null ? Pack.fromJson(json['pack']) : null;
    if (json['pdesc'] != null) {
      _pdesc = [];
      json['pdesc'].forEach((v) {
        _pdesc?.add(Pdesc.fromJson(v));
      });
    }
  }
  Pack? _pack;
  List<Pdesc>? _pdesc;
Data copyWith({  Pack? pack,
  List<Pdesc>? pdesc,
}) => Data(  pack: pack ?? _pack,
  pdesc: pdesc ?? _pdesc,
);
  Pack? get pack => _pack;
  List<Pdesc>? get pdesc => _pdesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_pack != null) {
      map['pack'] = _pack?.toJson();
    }
    if (_pdesc != null) {
      map['pdesc'] = _pdesc?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// pdesc_id : 101
/// pack_id : 3
/// pdesc_title : "Kemeja"
/// pdesc_detail : "Durasi: ±3 Menit"
/// pdesc_img_path : "assets/img/promo/1741642525.jpg"
/// pdesc_created_by : 1
/// pdesc_updated_by : 1
/// pdesc_deleted_by : null
/// pdesc_created_at : "2025-03-11T04:35:25.000000Z"
/// pdesc_updated_at : "2025-03-11T04:38:20.000000Z"
/// pdesc_deleted_at : null
/// pdesc_deleted_reason : null

class Pdesc {
  Pdesc({
      num? pdescId, 
      num? packId, 
      String? pdescTitle, 
      String? pdescDetail, 
      String? pdescImgPath, 
      num? pdescCreatedBy, 
      num? pdescUpdatedBy, 
      dynamic pdescDeletedBy, 
      String? pdescCreatedAt, 
      String? pdescUpdatedAt, 
      dynamic pdescDeletedAt, 
      dynamic pdescDeletedReason,}){
    _pdescId = pdescId;
    _packId = packId;
    _pdescTitle = pdescTitle;
    _pdescDetail = pdescDetail;
    _pdescImgPath = pdescImgPath;
    _pdescCreatedBy = pdescCreatedBy;
    _pdescUpdatedBy = pdescUpdatedBy;
    _pdescDeletedBy = pdescDeletedBy;
    _pdescCreatedAt = pdescCreatedAt;
    _pdescUpdatedAt = pdescUpdatedAt;
    _pdescDeletedAt = pdescDeletedAt;
    _pdescDeletedReason = pdescDeletedReason;
}

  Pdesc.fromJson(dynamic json) {
    _pdescId = json['pdesc_id'];
    _packId = json['pack_id'];
    _pdescTitle = json['pdesc_title'];
    _pdescDetail = json['pdesc_detail'];
    _pdescImgPath = json['pdesc_img_path'];
    _pdescCreatedBy = json['pdesc_created_by'];
    _pdescUpdatedBy = json['pdesc_updated_by'];
    _pdescDeletedBy = json['pdesc_deleted_by'];
    _pdescCreatedAt = json['pdesc_created_at'];
    _pdescUpdatedAt = json['pdesc_updated_at'];
    _pdescDeletedAt = json['pdesc_deleted_at'];
    _pdescDeletedReason = json['pdesc_deleted_reason'];
  }
  num? _pdescId;
  num? _packId;
  String? _pdescTitle;
  String? _pdescDetail;
  String? _pdescImgPath;
  num? _pdescCreatedBy;
  num? _pdescUpdatedBy;
  dynamic _pdescDeletedBy;
  String? _pdescCreatedAt;
  String? _pdescUpdatedAt;
  dynamic _pdescDeletedAt;
  dynamic _pdescDeletedReason;
Pdesc copyWith({  num? pdescId,
  num? packId,
  String? pdescTitle,
  String? pdescDetail,
  String? pdescImgPath,
  num? pdescCreatedBy,
  num? pdescUpdatedBy,
  dynamic pdescDeletedBy,
  String? pdescCreatedAt,
  String? pdescUpdatedAt,
  dynamic pdescDeletedAt,
  dynamic pdescDeletedReason,
}) => Pdesc(  pdescId: pdescId ?? _pdescId,
  packId: packId ?? _packId,
  pdescTitle: pdescTitle ?? _pdescTitle,
  pdescDetail: pdescDetail ?? _pdescDetail,
  pdescImgPath: pdescImgPath ?? _pdescImgPath,
  pdescCreatedBy: pdescCreatedBy ?? _pdescCreatedBy,
  pdescUpdatedBy: pdescUpdatedBy ?? _pdescUpdatedBy,
  pdescDeletedBy: pdescDeletedBy ?? _pdescDeletedBy,
  pdescCreatedAt: pdescCreatedAt ?? _pdescCreatedAt,
  pdescUpdatedAt: pdescUpdatedAt ?? _pdescUpdatedAt,
  pdescDeletedAt: pdescDeletedAt ?? _pdescDeletedAt,
  pdescDeletedReason: pdescDeletedReason ?? _pdescDeletedReason,
);
  num? get pdescId => _pdescId;
  num? get packId => _packId;
  String? get pdescTitle => _pdescTitle;
  String? get pdescDetail => _pdescDetail;
  String? get pdescImgPath => _pdescImgPath;
  num? get pdescCreatedBy => _pdescCreatedBy;
  num? get pdescUpdatedBy => _pdescUpdatedBy;
  dynamic get pdescDeletedBy => _pdescDeletedBy;
  String? get pdescCreatedAt => _pdescCreatedAt;
  String? get pdescUpdatedAt => _pdescUpdatedAt;
  dynamic get pdescDeletedAt => _pdescDeletedAt;
  dynamic get pdescDeletedReason => _pdescDeletedReason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pdesc_id'] = _pdescId;
    map['pack_id'] = _packId;
    map['pdesc_title'] = _pdescTitle;
    map['pdesc_detail'] = _pdescDetail;
    map['pdesc_img_path'] = _pdescImgPath;
    map['pdesc_created_by'] = _pdescCreatedBy;
    map['pdesc_updated_by'] = _pdescUpdatedBy;
    map['pdesc_deleted_by'] = _pdescDeletedBy;
    map['pdesc_created_at'] = _pdescCreatedAt;
    map['pdesc_updated_at'] = _pdescUpdatedAt;
    map['pdesc_deleted_at'] = _pdescDeletedAt;
    map['pdesc_deleted_reason'] = _pdescDeletedReason;
    return map;
  }

}

/// pack_id : 3
/// pack_category : "Daily Cleaning"
/// pack_name : "Setrika"
/// pack_duration : 2
/// pack_price : 120000
/// pack_object_description : "Layanan kebersihan rutin yang dilakukan setiap hari untuk menjaga kebersihan dan kerapian sebuah hunian. Tujuannya adalah untuk mencegah penumpukan kotoran, debu, dan sampah, serta menciptakan lingkungan yang bersih, sehat, dan nyaman."
/// pack_global_description : "Menyetrikan dan merapihkan pakaian menggunakan peralatan milik peribadi Pelanggan"
/// pack_job_description : "Pengerjaan\r\n\r\nLayanan ini meliputi:\r\n\r\na\tMenyetrika dan melipat pakaian\r\na\tMerapikan pakaian ke dalam lemari\r\n\r\nLayanan ini tidak termasuk:\r\n×\tMencuci pakaian\r\n×\tMengangkat dan menjemur pakaian\r\n×\tMenyediakan setrika dan papan setrika\r\n×\tMenyetrika pakaian renang dan pakaian lainnya yang tidak boleh disetrika\r\n\r\n•\tHarga yang tertera sudah termasuk asuransi.\r\n•\tUtilize’s-GO tidak bertanggung jawab atas transaksi yang terjadi di luar aplikasi.\r\n•\tDengan melakukan pemesanan, Pelanggan telah setuju dengan aturan dan ketentuan yang berlaku."
/// pack_procedure_description : "Panduan Estimasi Durasi\r\n\r\nBerikut pakaian yang termasuk dalam layanan setrika berikut estimasi pengerjaan"
/// pack_banner_path : "https://ugo-clean.s3.ap-southeast-1.amazonaws.com/17458293117629.jpeg"
/// pack_status : 1
/// pack_created_by : null
/// pack_updated_by : 1
/// pack_deleted_by : null
/// pack_created_at : "2025-03-04T17:26:27.000000Z"
/// pack_updated_at : "2025-04-28T15:36:01.000000Z"
/// pack_deleted_at : null
/// pack_deleted_reason : null

class Pack {
  Pack({
      num? packId, 
      String? packCategory, 
      String? packName, 
      num? packDuration, 
      num? packPrice, 
      String? packObjectDescription, 
      String? packGlobalDescription, 
      String? packJobDescription, 
      String? packProcedureDescription, 
      String? packBannerPath, 
      num? packStatus, 
      dynamic packCreatedBy, 
      num? packUpdatedBy, 
      dynamic packDeletedBy, 
      String? packCreatedAt, 
      String? packUpdatedAt, 
      dynamic packDeletedAt, 
      dynamic packDeletedReason,}){
    _packId = packId;
    _packCategory = packCategory;
    _packName = packName;
    _packDuration = packDuration;
    _packPrice = packPrice;
    _packObjectDescription = packObjectDescription;
    _packGlobalDescription = packGlobalDescription;
    _packJobDescription = packJobDescription;
    _packProcedureDescription = packProcedureDescription;
    _packBannerPath = packBannerPath;
    _packStatus = packStatus;
    _packCreatedBy = packCreatedBy;
    _packUpdatedBy = packUpdatedBy;
    _packDeletedBy = packDeletedBy;
    _packCreatedAt = packCreatedAt;
    _packUpdatedAt = packUpdatedAt;
    _packDeletedAt = packDeletedAt;
    _packDeletedReason = packDeletedReason;
}

  Pack.fromJson(dynamic json) {
    _packId = json['pack_id'];
    _packCategory = json['pack_category'];
    _packName = json['pack_name'];
    _packDuration = json['pack_duration'];
    _packPrice = json['pack_price'];
    _packObjectDescription = json['pack_object_description'];
    _packGlobalDescription = json['pack_global_description'];
    _packJobDescription = json['pack_job_description'];
    _packProcedureDescription = json['pack_procedure_description'];
    _packBannerPath = json['pack_banner_path'];
    _packStatus = json['pack_status'];
    _packCreatedBy = json['pack_created_by'];
    _packUpdatedBy = json['pack_updated_by'];
    _packDeletedBy = json['pack_deleted_by'];
    _packCreatedAt = json['pack_created_at'];
    _packUpdatedAt = json['pack_updated_at'];
    _packDeletedAt = json['pack_deleted_at'];
    _packDeletedReason = json['pack_deleted_reason'];
  }
  num? _packId;
  String? _packCategory;
  String? _packName;
  num? _packDuration;
  num? _packPrice;
  String? _packObjectDescription;
  String? _packGlobalDescription;
  String? _packJobDescription;
  String? _packProcedureDescription;
  String? _packBannerPath;
  num? _packStatus;
  dynamic _packCreatedBy;
  num? _packUpdatedBy;
  dynamic _packDeletedBy;
  String? _packCreatedAt;
  String? _packUpdatedAt;
  dynamic _packDeletedAt;
  dynamic _packDeletedReason;
Pack copyWith({  num? packId,
  String? packCategory,
  String? packName,
  num? packDuration,
  num? packPrice,
  String? packObjectDescription,
  String? packGlobalDescription,
  String? packJobDescription,
  String? packProcedureDescription,
  String? packBannerPath,
  num? packStatus,
  dynamic packCreatedBy,
  num? packUpdatedBy,
  dynamic packDeletedBy,
  String? packCreatedAt,
  String? packUpdatedAt,
  dynamic packDeletedAt,
  dynamic packDeletedReason,
}) => Pack(  packId: packId ?? _packId,
  packCategory: packCategory ?? _packCategory,
  packName: packName ?? _packName,
  packDuration: packDuration ?? _packDuration,
  packPrice: packPrice ?? _packPrice,
  packObjectDescription: packObjectDescription ?? _packObjectDescription,
  packGlobalDescription: packGlobalDescription ?? _packGlobalDescription,
  packJobDescription: packJobDescription ?? _packJobDescription,
  packProcedureDescription: packProcedureDescription ?? _packProcedureDescription,
  packBannerPath: packBannerPath ?? _packBannerPath,
  packStatus: packStatus ?? _packStatus,
  packCreatedBy: packCreatedBy ?? _packCreatedBy,
  packUpdatedBy: packUpdatedBy ?? _packUpdatedBy,
  packDeletedBy: packDeletedBy ?? _packDeletedBy,
  packCreatedAt: packCreatedAt ?? _packCreatedAt,
  packUpdatedAt: packUpdatedAt ?? _packUpdatedAt,
  packDeletedAt: packDeletedAt ?? _packDeletedAt,
  packDeletedReason: packDeletedReason ?? _packDeletedReason,
);
  num? get packId => _packId;
  String? get packCategory => _packCategory;
  String? get packName => _packName;
  num? get packDuration => _packDuration;
  num? get packPrice => _packPrice;
  String? get packObjectDescription => _packObjectDescription;
  String? get packGlobalDescription => _packGlobalDescription;
  String? get packJobDescription => _packJobDescription;
  String? get packProcedureDescription => _packProcedureDescription;
  String? get packBannerPath => _packBannerPath;
  num? get packStatus => _packStatus;
  dynamic get packCreatedBy => _packCreatedBy;
  num? get packUpdatedBy => _packUpdatedBy;
  dynamic get packDeletedBy => _packDeletedBy;
  String? get packCreatedAt => _packCreatedAt;
  String? get packUpdatedAt => _packUpdatedAt;
  dynamic get packDeletedAt => _packDeletedAt;
  dynamic get packDeletedReason => _packDeletedReason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pack_id'] = _packId;
    map['pack_category'] = _packCategory;
    map['pack_name'] = _packName;
    map['pack_duration'] = _packDuration;
    map['pack_price'] = _packPrice;
    map['pack_object_description'] = _packObjectDescription;
    map['pack_global_description'] = _packGlobalDescription;
    map['pack_job_description'] = _packJobDescription;
    map['pack_procedure_description'] = _packProcedureDescription;
    map['pack_banner_path'] = _packBannerPath;
    map['pack_status'] = _packStatus;
    map['pack_created_by'] = _packCreatedBy;
    map['pack_updated_by'] = _packUpdatedBy;
    map['pack_deleted_by'] = _packDeletedBy;
    map['pack_created_at'] = _packCreatedAt;
    map['pack_updated_at'] = _packUpdatedAt;
    map['pack_deleted_at'] = _packDeletedAt;
    map['pack_deleted_reason'] = _packDeletedReason;
    return map;
  }

}