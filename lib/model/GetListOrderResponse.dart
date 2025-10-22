class GetListOrderResponse {
final bool? status;
final String? message;
final List<Data>? data;
const GetListOrderResponse({this.status , this.message , this.data });
GetListOrderResponse copyWith({bool? status, String? message, List<Data>? data}){
return GetListOrderResponse(
            status:status ?? this.status,
message:message ?? this.message,
data:data ?? this.data
        );
        }
        
Map<String,Object?> toJson(){
    return {
            'status': status,
'message': message,
'data': data?.map<Map<String,dynamic>>((data)=> data.toJson()).toList()
    };
}

static GetListOrderResponse fromJson(Map<String , Object?> json){
    return GetListOrderResponse(
            status:json['status'] == null ? null : json['status'] as bool,
message:json['message'] == null ? null : json['message'] as String,
data:json['data'] == null ? null : (json['data'] as List).map<Data>((data)=> Data.fromJson(data  as Map<String,Object?>)).toList()
    );
}

@override
String toString(){
    return '''GetListOrderResponse(
                status:$status,
message:$message,
data:${data.toString()}
    ) ''';
}

@override
bool operator ==(Object other){
    return other is GetListOrderResponse && 
        other.runtimeType == runtimeType &&
        other.status == status && 
other.message == message && 
other.data == data;
}
      
@override
int get hashCode {
    return Object.hash(
                runtimeType,
                status, 
message, 
data
    );
}
    
}
      
      
class Data {
final int? orderid;
final String? categoryImage;
final String? category;
final String? dueDate;
final String? dueTime;
final String? orderStatus;
const Data({this.orderid , this.categoryImage , this.category , this.dueDate , this.dueTime , this.orderStatus });
Data copyWith({int? orderid, String? categoryImage, String? category, String? dueDate, String? dueTime, String? orderStatus}){
return Data(
            orderid:orderid ?? this.orderid,
categoryImage:categoryImage ?? this.categoryImage,
category:category ?? this.category,
dueDate:dueDate ?? this.dueDate,
dueTime:dueTime ?? this.dueTime,
orderStatus:orderStatus ?? this.orderStatus
        );
        }
        
Map<String,Object?> toJson(){
    return {
            'orderid': orderid,
'category_image': categoryImage,
'category': category,
'due_date': dueDate,
'due_time': dueTime,
'order_status': orderStatus
    };
}

static Data fromJson(Map<String , Object?> json){
    return Data(
            orderid:json['orderid'] == null ? null : json['orderid'] as int,
categoryImage:json['category_image'] == null ? null : json['category_image'] as String,
category:json['category'] == null ? null : json['category'] as String,
dueDate:json['due_date'] == null ? null : json['due_date'] as String,
dueTime:json['due_time'] == null ? null : json['due_time'] as String,
orderStatus:json['order_status'] == null ? null : json['order_status'] as String
    );
}

@override
String toString(){
    return '''Data(
                orderid:$orderid,
categoryImage:$categoryImage,
category:$category,
dueDate:$dueDate,
dueTime:$dueTime,
orderStatus:$orderStatus
    ) ''';
}

@override
bool operator ==(Object other){
    return other is Data && 
        other.runtimeType == runtimeType &&
        other.orderid == orderid && 
other.categoryImage == categoryImage && 
other.category == category && 
other.dueDate == dueDate && 
other.dueTime == dueTime && 
other.orderStatus == orderStatus;
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
orderStatus
    );
}
    
}
      
      
  
     