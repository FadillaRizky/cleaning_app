/// status : true
/// message : "data founded"
/// data : [{"id":1,"topup_date":"2025-05-12 00:00:00","topup_nominal":500000,"topup_receipt":"https://ugo-clean.s3.ap-southeast-1.amazonaws.com/174702290662207.jpg"},{"id":2,"topup_date":"2025-05-12 00:00:00","topup_nominal":300000,"topup_receipt":"https://ugo-clean.s3.ap-southeast-1.amazonaws.com/174702306764959.jpg"},{"id":3,"topup_date":"2025-05-12 00:00:00","topup_nominal":200000,"topup_receipt":"https://ugo-clean.s3.ap-southeast-1.amazonaws.com/174702336997498.jpg"},{"id":4,"topup_date":"2025-05-12 00:00:00","topup_nominal":200000,"topup_receipt":""},{"id":5,"topup_date":"2025-05-12 00:00:00","topup_nominal":23000,"topup_receipt":""},{"id":6,"topup_date":"2025-05-22 00:00:00","topup_nominal":23000,"topup_receipt":""}]

class UploadBuktiTopupResponse {
  UploadBuktiTopupResponse({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  UploadBuktiTopupResponse.fromJson(dynamic json) {
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
UploadBuktiTopupResponse copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => UploadBuktiTopupResponse(  status: status ?? _status,
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

/// id : 1
/// topup_date : "2025-05-12 00:00:00"
/// topup_nominal : 500000
/// topup_receipt : "https://ugo-clean.s3.ap-southeast-1.amazonaws.com/174702290662207.jpg"

class Data {
  Data({
      num? id, 
      String? topupDate, 
      num? topupNominal, 
      String? topupReceipt,}){
    _id = id;
    _topupDate = topupDate;
    _topupNominal = topupNominal;
    _topupReceipt = topupReceipt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _topupDate = json['topup_date'];
    _topupNominal = json['topup_nominal'];
    _topupReceipt = json['topup_receipt'];
  }
  num? _id;
  String? _topupDate;
  num? _topupNominal;
  String? _topupReceipt;
Data copyWith({  num? id,
  String? topupDate,
  num? topupNominal,
  String? topupReceipt,
}) => Data(  id: id ?? _id,
  topupDate: topupDate ?? _topupDate,
  topupNominal: topupNominal ?? _topupNominal,
  topupReceipt: topupReceipt ?? _topupReceipt,
);
  num? get id => _id;
  String? get topupDate => _topupDate;
  num? get topupNominal => _topupNominal;
  String? get topupReceipt => _topupReceipt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['topup_date'] = _topupDate;
    map['topup_nominal'] = _topupNominal;
    map['topup_receipt'] = _topupReceipt;
    return map;
  }

}