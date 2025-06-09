/// status : true
/// message : "data founded"
/// data : [{"traction_date":"2025-06-05","traction_nominal":500000,"traction_type":"TOPUP"},{"traction_date":"2025-06-05","traction_nominal":1500000,"traction_type":"TOPUP"},{"traction_date":"2025-06-05","traction_nominal":111000,"traction_type":"EXPENSE"},{"traction_date":"2025-06-05","traction_nominal":1191141,"traction_type":"EXPENSE"},{"traction_date":"2025-06-07","traction_nominal":252370,"traction_type":"EXPENSE"},{"traction_date":"2025-06-07","traction_nominal":316350,"traction_type":"EXPENSE"},{"traction_date":"2025-06-07","traction_nominal":2000000,"traction_type":"TOPUP"},{"traction_date":"2025-06-07","traction_nominal":310023,"traction_type":"EXPENSE"},{"traction_date":"2025-06-07","traction_nominal":316350,"traction_type":"EXPENSE"},{"traction_date":"2025-06-07","traction_nominal":295260,"traction_type":"EXPENSE"},{"traction_date":"2025-06-07","traction_nominal":289355,"traction_type":"EXPENSE"},{"traction_date":"2025-06-07","traction_nominal":5000000,"traction_type":"TOPUP"},{"traction_date":"2025-06-07","traction_nominal":1191141,"traction_type":"EXPENSE"},{"traction_date":"2025-06-07","traction_nominal":1191141,"traction_type":"EXPENSE"},{"traction_date":"2025-06-07","traction_nominal":1191141,"traction_type":"EXPENSE"},{"traction_date":"2025-06-07","traction_nominal":111000,"traction_type":"EXPENSE"},{"traction_date":"2025-06-07","traction_nominal":111000,"traction_type":"EXPENSE"},{"traction_date":"2025-06-07","traction_nominal":1191141,"traction_type":"EXPENSE"},{"traction_date":"2025-06-07","traction_nominal":111000,"traction_type":"EXPENSE"}]

class HistoryTransaksiResponse {
  HistoryTransaksiResponse({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  HistoryTransaksiResponse.fromJson(dynamic json) {
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
HistoryTransaksiResponse copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => HistoryTransaksiResponse(  status: status ?? _status,
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

/// traction_date : "2025-06-05"
/// traction_nominal : 500000
/// traction_type : "TOPUP"

class Data {
  Data({
      String? tractionDate, 
      num? tractionNominal, 
      String? tractionType,}){
    _tractionDate = tractionDate;
    _tractionNominal = tractionNominal;
    _tractionType = tractionType;
}

  Data.fromJson(dynamic json) {
    _tractionDate = json['traction_date'];
    _tractionNominal = json['traction_nominal'];
    _tractionType = json['traction_type'];
  }
  String? _tractionDate;
  num? _tractionNominal;
  String? _tractionType;
Data copyWith({  String? tractionDate,
  num? tractionNominal,
  String? tractionType,
}) => Data(  tractionDate: tractionDate ?? _tractionDate,
  tractionNominal: tractionNominal ?? _tractionNominal,
  tractionType: tractionType ?? _tractionType,
);
  String? get tractionDate => _tractionDate;
  num? get tractionNominal => _tractionNominal;
  String? get tractionType => _tractionType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['traction_date'] = _tractionDate;
    map['traction_nominal'] = _tractionNominal;
    map['traction_type'] = _tractionType;
    return map;
  }

}