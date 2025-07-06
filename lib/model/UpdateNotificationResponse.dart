/// status : true
/// message : "data founded"
/// data : {"notif_id":1,"client_id":24,"title":"trial","detail":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lore","status":"1","created_at":"2025-06-13T08:27:35.000000Z","updated_at":"2025-06-25T05:57:51.000000Z","deleted_at":null,"created_by":null,"updated_by":24,"deleted_by":null}

class UpdateNotificationResponse {
  UpdateNotificationResponse({
      bool? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  UpdateNotificationResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
UpdateNotificationResponse copyWith({  bool? status,
  String? message,
  Data? data,
}) => UpdateNotificationResponse(  status: status ?? _status,
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

/// notif_id : 1
/// client_id : 24
/// title : "trial"
/// detail : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lore"
/// status : "1"
/// created_at : "2025-06-13T08:27:35.000000Z"
/// updated_at : "2025-06-25T05:57:51.000000Z"
/// deleted_at : null
/// created_by : null
/// updated_by : 24
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
      num? updatedBy, 
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
  num? _updatedBy;
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
  num? updatedBy,
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
  num? get updatedBy => _updatedBy;
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