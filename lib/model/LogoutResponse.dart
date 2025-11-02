class LogoutResponse {
  final bool? status;
  final String? message;
  const LogoutResponse({this.status, this.message});
  LogoutResponse copyWith({bool? status, String? message}) {
    return LogoutResponse(
        status: status ?? this.status, message: message ?? this.message);
  }

  Map<String, Object?> toJson() {
    return {'status': status, 'message': message};
  }

  static LogoutResponse fromJson(Map<String, Object?> json) {
    return LogoutResponse(
        status: json['status'] == null ? null : json['status'] as bool,
        message: json['message'] == null ? null : json['message'] as String);
  }

  @override
  String toString() {
    return '''LogoutResponse(
                status:$status,
message:$message
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is LogoutResponse &&
        other.runtimeType == runtimeType &&
        other.status == status &&
        other.message == message;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, status, message);
  }
}
