class RatingResponse {
  final bool? status;
  final String? message;
  final Data? data;
  const RatingResponse({this.status, this.message, this.data});
  RatingResponse copyWith({bool? status, String? message, Data? data}) {
    return RatingResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data);
  }

  Map<String, Object?> toJson() {
    return {'status': status, 'message': message, 'data': data?.toJson()};
  }

  static RatingResponse fromJson(Map<String, Object?> json) {
    return RatingResponse(
        status: json['status'] == null ? null : json['status'] as bool,
        message: json['message'] == null ? null : json['message'] as String,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, Object?>));
  }

  @override
  String toString() {
    return '''RatingResponse(
                status:$status,
message:$message,
data:${data.toString()}
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is RatingResponse &&
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
  final dynamic orderid;
  final dynamic categoryImage;
  final dynamic category;
  final dynamic dueDate;
  final dynamic dueTime;
  final dynamic orderStatus;
  final int? clientRating;
  final String? clientReview;
  final int? clientUpdate;
  final int? partnerAttribute;
  const Data(
      {this.orderid,
      this.categoryImage,
      this.category,
      this.dueDate,
      this.dueTime,
      this.orderStatus,
      this.clientRating,
      this.clientReview,
      this.clientUpdate,
      this.partnerAttribute});
  Data copyWith(
      {dynamic? orderid,
      dynamic? categoryImage,
      dynamic? category,
      dynamic? dueDate,
      dynamic? dueTime,
      dynamic? orderStatus,
      int? clientRating,
      String? clientReview,
      int? clientUpdate,
      int? partnerAttribute}) {
    return Data(
        orderid: orderid ?? this.orderid,
        categoryImage: categoryImage ?? this.categoryImage,
        category: category ?? this.category,
        dueDate: dueDate ?? this.dueDate,
        dueTime: dueTime ?? this.dueTime,
        orderStatus: orderStatus ?? this.orderStatus,
        clientRating: clientRating ?? this.clientRating,
        clientReview: clientReview ?? this.clientReview,
        clientUpdate: clientUpdate ?? this.clientUpdate,
        partnerAttribute: partnerAttribute ?? this.partnerAttribute);
  }

  Map<String, Object?> toJson() {
    return {
      'orderid': orderid,
      'category_image': categoryImage,
      'category': category,
      'due_date': dueDate,
      'due_time': dueTime,
      'order_status': orderStatus,
      'client_rating': clientRating,
      'client_review': clientReview,
      'client_update': clientUpdate,
      'partner_attribute': partnerAttribute
    };
  }

  static Data fromJson(Map<String, Object?> json) {
    return Data(
        orderid: json['orderid'] as dynamic,
        categoryImage: json['category_image'] as dynamic,
        category: json['category'] as dynamic,
        dueDate: json['due_date'] as dynamic,
        dueTime: json['due_time'] as dynamic,
        orderStatus: json['order_status'] as dynamic,
        clientRating:
            json['client_rating'] == null ? null : json['client_rating'] as int,
        clientReview: json['client_review'] == null
            ? null
            : json['client_review'] as String,
        clientUpdate:
            json['client_update'] == null ? null : json['client_update'] as int,
        partnerAttribute: json['partner_attribute'] == null
            ? null
            : json['partner_attribute'] as int);
  }

  @override
  String toString() {
    return '''Data(
                orderid:$orderid,
categoryImage:$categoryImage,
category:$category,
dueDate:$dueDate,
dueTime:$dueTime,
orderStatus:$orderStatus,
clientRating:$clientRating,
clientReview:$clientReview,
clientUpdate:$clientUpdate,
partnerAttribute:$partnerAttribute
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Data &&
        other.runtimeType == runtimeType &&
        other.orderid == orderid &&
        other.categoryImage == categoryImage &&
        other.category == category &&
        other.dueDate == dueDate &&
        other.dueTime == dueTime &&
        other.orderStatus == orderStatus &&
        other.clientRating == clientRating &&
        other.clientReview == clientReview &&
        other.clientUpdate == clientUpdate &&
        other.partnerAttribute == partnerAttribute;
  }

  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        orderid,
        categoryImage,
        category,
        dueDate,
        dueTime,
        orderStatus,
        clientRating,
        clientReview,
        clientUpdate,
        partnerAttribute);
  }
}
