class BannerResponse {
  final bool? status;
  final String? message;
  final List<Data>? data;
  const BannerResponse({this.status, this.message, this.data});
  BannerResponse copyWith({bool? status, String? message, List<Data>? data}) {
    return BannerResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data);
  }

  Map<String, Object?> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.map<Map<String, dynamic>>((data) => data.toJson()).toList()
    };
  }

  static BannerResponse fromJson(Map<String, Object?> json) {
    return BannerResponse(
        status: json['status'] == null ? null : json['status'] as bool,
        message: json['message'] == null ? null : json['message'] as String,
        data: json['data'] == null
            ? null
            : (json['data'] as List)
                .map<Data>(
                    (data) => Data.fromJson(data as Map<String, Object?>))
                .toList());
  }

  @override
  String toString() {
    return '''BannerResponse(
                status:$status,
message:$message,
data:${data.toString()}
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is BannerResponse &&
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
  final int? id;
  final String? bannerName;
  final String? bannerDescription;
  final String? bannerPath;
  final String? bannerStatus;
  final String? createdAt;
  final int? createdBy;
  final String? updatedAt;
  final int? updatedBy;
  final dynamic deletedAt;
  final dynamic deletedBy;
  const Data(
      {this.id,
      this.bannerName,
      this.bannerDescription,
      this.bannerPath,
      this.bannerStatus,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.deletedAt,
      this.deletedBy});
  Data copyWith(
      {int? id,
      String? bannerName,
      String? bannerDescription,
      String? bannerPath,
      String? bannerStatus,
      String? createdAt,
      int? createdBy,
      String? updatedAt,
      int? updatedBy,
      dynamic? deletedAt,
      dynamic? deletedBy}) {
    return Data(
        id: id ?? this.id,
        bannerName: bannerName ?? this.bannerName,
        bannerDescription: bannerDescription ?? this.bannerDescription,
        bannerPath: bannerPath ?? this.bannerPath,
        bannerStatus: bannerStatus ?? this.bannerStatus,
        createdAt: createdAt ?? this.createdAt,
        createdBy: createdBy ?? this.createdBy,
        updatedAt: updatedAt ?? this.updatedAt,
        updatedBy: updatedBy ?? this.updatedBy,
        deletedAt: deletedAt ?? this.deletedAt,
        deletedBy: deletedBy ?? this.deletedBy);
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'banner_name': bannerName,
      'banner_description': bannerDescription,
      'banner_path': bannerPath,
      'banner_status': bannerStatus,
      'created_at': createdAt,
      'created_by': createdBy,
      'updated_at': updatedAt,
      'updated_by': updatedBy,
      'deleted_at': deletedAt,
      'deleted_by': deletedBy
    };
  }

  static Data fromJson(Map<String, Object?> json) {
    return Data(
        id: json['id'] == null ? null : json['id'] as int,
        bannerName:
            json['banner_name'] == null ? null : json['banner_name'] as String,
        bannerDescription: json['banner_description'] == null
            ? null
            : json['banner_description'] as String,
        bannerPath:
            json['banner_path'] == null ? null : json['banner_path'] as String,
        bannerStatus: json['banner_status'] == null
            ? null
            : json['banner_status'] as String,
        createdAt:
            json['created_at'] == null ? null : json['created_at'] as String,
        createdBy:
            json['created_by'] == null ? null : json['created_by'] as int,
        updatedAt:
            json['updated_at'] == null ? null : json['updated_at'] as String,
        updatedBy:
            json['updated_by'] == null ? null : json['updated_by'] as int,
        deletedAt: json['deleted_at'] as dynamic,
        deletedBy: json['deleted_by'] as dynamic);
  }

  @override
  String toString() {
    return '''Data(
                id:$id,
bannerName:$bannerName,
bannerDescription:$bannerDescription,
bannerPath:$bannerPath,
bannerStatus:$bannerStatus,
createdAt:$createdAt,
createdBy:$createdBy,
updatedAt:$updatedAt,
updatedBy:$updatedBy,
deletedAt:$deletedAt,
deletedBy:$deletedBy
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Data &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.bannerName == bannerName &&
        other.bannerDescription == bannerDescription &&
        other.bannerPath == bannerPath &&
        other.bannerStatus == bannerStatus &&
        other.createdAt == createdAt &&
        other.createdBy == createdBy &&
        other.updatedAt == updatedAt &&
        other.updatedBy == updatedBy &&
        other.deletedAt == deletedAt &&
        other.deletedBy == deletedBy;
  }

  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        id,
        bannerName,
        bannerDescription,
        bannerPath,
        bannerStatus,
        createdAt,
        createdBy,
        updatedAt,
        updatedBy,
        deletedAt,
        deletedBy);
  }
}
