class DetailUserResponse {
  final String? status;
  final String? message;
  final Data? data;
  const DetailUserResponse({this.status, this.message, this.data});
  DetailUserResponse copyWith({String? status, String? message, Data? data}) {
    return DetailUserResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data);
  }

  Map<String, Object?> toJson() {
    return {'status': status, 'message': message, 'data': data?.toJson()};
  }

  static DetailUserResponse fromJson(Map<String, Object?> json) {
    return DetailUserResponse(
        status: json['status'] == null ? null : json['status'] as String,
        message: json['message'] == null ? null : json['message'] as String,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, Object?>));
  }

  @override
  String toString() {
    return '''DetailUserResponse(
                status:$status,
message:$message,
data:${data.toString()}
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is DetailUserResponse &&
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
  final String? firstName;
  final String? lastName;
  final String? email;
  final dynamic bornPlace;
  final dynamic bod;
  final dynamic religion;
  final dynamic ktpAddress;
  final dynamic avatarPath;
  final int? discMember;
  const Data(
      {this.firstName,
      this.lastName,
      this.email,
      this.bornPlace,
      this.bod,
      this.religion,
      this.ktpAddress,
      this.avatarPath,
      this.discMember});
  Data copyWith(
      {String? firstName,
      String? lastName,
      String? email,
      dynamic? bornPlace,
      dynamic? bod,
      dynamic? religion,
      dynamic? ktpAddress,
      dynamic? avatarPath,
      int? discMember}) {
    return Data(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        bornPlace: bornPlace ?? this.bornPlace,
        bod: bod ?? this.bod,
        religion: religion ?? this.religion,
        ktpAddress: ktpAddress ?? this.ktpAddress,
        avatarPath: avatarPath ?? this.avatarPath,
        discMember: discMember ?? this.discMember);
  }

  Map<String, Object?> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'born_place': bornPlace,
      'bod': bod,
      'religion': religion,
      'ktp_address': ktpAddress,
      'avatar_path': avatarPath,
      'disc_member': discMember
    };
  }

  static Data fromJson(Map<String, Object?> json) {
    return Data(
        firstName:
            json['first_name'] == null ? null : json['first_name'] as String,
        lastName:
            json['last_name'] == null ? null : json['last_name'] as String,
        email: json['email'] == null ? null : json['email'] as String,
        bornPlace: json['born_place'] as dynamic,
        bod: json['bod'] as dynamic,
        religion: json['religion'] as dynamic,
        ktpAddress: json['ktp_address'] as dynamic,
        avatarPath: json['avatar_path'] as dynamic,
        discMember:
            json['disc_member'] == null ? null : json['disc_member'] as int);
  }

  @override
  String toString() {
    return '''Data(
                firstName:$firstName,
lastName:$lastName,
email:$email,
bornPlace:$bornPlace,
bod:$bod,
religion:$religion,
ktpAddress:$ktpAddress,
avatarPath:$avatarPath,
discMember:$discMember
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Data &&
        other.runtimeType == runtimeType &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.bornPlace == bornPlace &&
        other.bod == bod &&
        other.religion == religion &&
        other.ktpAddress == ktpAddress &&
        other.avatarPath == avatarPath &&
        other.discMember == discMember;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, firstName, lastName, email, bornPlace, bod,
        religion, ktpAddress, avatarPath, discMember);
  }
}
