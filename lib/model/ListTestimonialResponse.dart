class ListTestimonialResponse {
  bool? status;
  String? message;
  List<TestimonialData>? data;

  ListTestimonialResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ListTestimonialResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    List<TestimonialData> testimonialList = [];

    if (json['data'] != null) {
      final mapData = json['data'] as Map<String, dynamic>;

      testimonialList = mapData.values
          .map(
            (e) => TestimonialData.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();
    }

    return ListTestimonialResponse(
      status: json['status'],
      message: json['message'],
      data: testimonialList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class TestimonialData {
  String? clientName;
  String? avatarPath;
  String? category;
  int? clientRating;
  String? clientReview;
  String? imgAfter1;
  String? imgAfter2;

  TestimonialData({
    this.clientName,
    this.avatarPath,
    this.category,
    this.clientRating,
    this.clientReview,
    this.imgAfter1,
    this.imgAfter2,
  });

  factory TestimonialData.fromJson(
    Map<String, dynamic> json,
  ) {
    return TestimonialData(
      clientName: json['client_name'],
      avatarPath: json['avatar_path'],
      category: json['category'],
      clientRating: json['client_rating'],
      clientReview: json['client_review'],
      imgAfter1: json['img_after1'],
      imgAfter2: json['img_after2'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_name': clientName,
      'avatar_path': avatarPath,
      'category': category,
      'client_rating': clientRating,
      'client_review': clientReview,
      'img_after1': imgAfter1,
      'img_after2': imgAfter2,
    };
  }
}