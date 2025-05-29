/// status : true
/// message : "data founded"
/// data : {"total_balance":3348558,"total_expend":0}

class GetSaldoResponse {
  GetSaldoResponse({
      bool? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetSaldoResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
GetSaldoResponse copyWith({  bool? status,
  String? message,
  Data? data,
}) => GetSaldoResponse(  status: status ?? _status,
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

/// total_balance : 3348558
/// total_expend : 0

class Data {
  Data({
      num? totalBalance, 
      num? totalExpend,}){
    _totalBalance = totalBalance;
    _totalExpend = totalExpend;
}

  Data.fromJson(dynamic json) {
    _totalBalance = json['total_balance'];
    _totalExpend = json['total_expend'];
  }
  num? _totalBalance;
  num? _totalExpend;
Data copyWith({  num? totalBalance,
  num? totalExpend,
}) => Data(  totalBalance: totalBalance ?? _totalBalance,
  totalExpend: totalExpend ?? _totalExpend,
);
  num? get totalBalance => _totalBalance;
  num? get totalExpend => _totalExpend;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_balance'] = _totalBalance;
    map['total_expend'] = _totalExpend;
    return map;
  }

}