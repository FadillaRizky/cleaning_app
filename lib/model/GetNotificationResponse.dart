/// status : true
/// message : "data founded"
/// data : [{"notif_id":1,"client_id":24,"title":"trial","detail":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lore","status":"0","created_at":"2025-06-13T08:27:35.000000Z","updated_at":"2025-06-13T08:29:36.000000Z","deleted_at":null,"created_by":null,"updated_by":null,"deleted_by":null}]

class GetNotificationResponse {
  GetNotificationResponse({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetNotificationResponse.fromJson(dynamic json) {
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
GetNotificationResponse copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => GetNotificationResponse(  status: status ?? _status,
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

/// notif_id : 1
/// client_id : 24
/// title : "trial"
/// detail : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lore"
/// status : "0"
/// created_at : "2025-06-13T08:27:35.000000Z"
/// updated_at : "2025-06-13T08:29:36.000000Z"
/// deleted_at : null
/// created_by : null
/// updated_by : null
/// deleted_by : null

class Data {
  Data({
      num? notifId, 
      num? clientId, 
      String? title, 
      String? detail, 
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      dynamic deletedAt, 
      dynamic createdBy, 
      dynamic updatedBy, 
      dynamic deletedBy,}){
    _notifId = notifId;
    _clientId = clientId;
    _title = title;
    _detail = detail;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _createdBy = createdBy;
    _updatedBy = updatedBy;
    _deletedBy = deletedBy;
}

  Data.fromJson(dynamic json) {
    _notifId = json['notif_id'];
    _clientId = json['client_id'];
    _title = json['title'];
    _detail = json['detail'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _createdBy = json['created_by'];
    _updatedBy = json['updated_by'];
    _deletedBy = json['deleted_by'];
  }
  num? _notifId;
  num? _clientId;
  String? _title;
  String? _detail;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  dynamic _createdBy;
  dynamic _updatedBy;
  dynamic _deletedBy;
Data copyWith({  num? notifId,
  num? clientId,
  String? title,
  String? detail,
  String? status,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
  dynamic createdBy,
  dynamic updatedBy,
  dynamic deletedBy,
}) => Data(  notifId: notifId ?? _notifId,
  clientId: clientId ?? _clientId,
  title: title ?? _title,
  detail: detail ?? _detail,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
  createdBy: createdBy ?? _createdBy,
  updatedBy: updatedBy ?? _updatedBy,
  deletedBy: deletedBy ?? _deletedBy,
);
  num? get notifId => _notifId;
  num? get clientId => _clientId;
  String? get title => _title;
  String? get detail => _detail;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  dynamic get createdBy => _createdBy;
  dynamic get updatedBy => _updatedBy;
  dynamic get deletedBy => _deletedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['notif_id'] = _notifId;
    map['client_id'] = _clientId;
    map['title'] = _title;
    map['detail'] = _detail;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    map['created_by'] = _createdBy;
    map['updated_by'] = _updatedBy;
    map['deleted_by'] = _deletedBy;
    return map;
  }

}