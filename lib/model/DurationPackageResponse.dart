class DurationPackageResponse {
final bool? status;
final String? message;
final List<Data>? data;
const DurationPackageResponse({this.status , this.message , this.data });
DurationPackageResponse copyWith({bool? status, String? message, List<Data>? data}){
return DurationPackageResponse(
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

static DurationPackageResponse fromJson(Map<String , Object?> json){
    return DurationPackageResponse(
            status:json['status'] == null ? null : json['status'] as bool,
message:json['message'] == null ? null : json['message'] as String,
data:json['data'] == null ? null : (json['data'] as List).map<Data>((data)=> Data.fromJson(data  as Map<String,Object?>)).toList()
    );
}

@override
String toString(){
    return '''DurationPackageResponse(
                status:$status,
message:$message,
data:${data.toString()}
    ) ''';
}

@override
bool operator ==(Object other){
    return other is DurationPackageResponse && 
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
final int? phId;
final int? packId;
final int? packHour;
final int? packPrice;
final int? packPriceDisc;
const Data({this.phId , this.packId , this.packHour , this.packPrice , this.packPriceDisc });
Data copyWith({int? phId, int? packId, int? packHour, int? packPrice, int? packPriceDisc}){
return Data(
            phId:phId ?? this.phId,
packId:packId ?? this.packId,
packHour:packHour ?? this.packHour,
packPrice:packPrice ?? this.packPrice,
packPriceDisc:packPriceDisc ?? this.packPriceDisc
        );
        }
        
Map<String,Object?> toJson(){
    return {
            'ph_id': phId,
'pack_id': packId,
'pack_hour': packHour,
'pack_price': packPrice,
'pack_price_disc': packPriceDisc
    };
}

static Data fromJson(Map<String , Object?> json){
    return Data(
            phId:json['ph_id'] == null ? null : json['ph_id'] as int,
packId:json['pack_id'] == null ? null : json['pack_id'] as int,
packHour:json['pack_hour'] == null ? null : json['pack_hour'] as int,
packPrice:json['pack_price'] == null ? null : json['pack_price'] as int,
packPriceDisc:json['pack_price_disc'] == null ? null : json['pack_price_disc'] as int
    );
}

@override
String toString(){
    return '''Data(
                phId:$phId,
packId:$packId,
packHour:$packHour,
packPrice:$packPrice,
packPriceDisc:$packPriceDisc
    ) ''';
}

@override
bool operator ==(Object other){
    return other is Data && 
        other.runtimeType == runtimeType &&
        other.phId == phId && 
other.packId == packId && 
other.packHour == packHour && 
other.packPrice == packPrice && 
other.packPriceDisc == packPriceDisc;
}
      
@override
int get hashCode {
    return Object.hash(
                runtimeType,
                phId, 
packId, 
packHour, 
packPrice, 
packPriceDisc
    );
}
    
}
      
      
  
     