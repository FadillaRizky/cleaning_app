class UpdateAddressResponse {
final bool? status;
final String? message;
final Data? data;
const UpdateAddressResponse({this.status , this.message , this.data });
UpdateAddressResponse copyWith({bool? status, String? message, Data? data}){
return UpdateAddressResponse(
            status:status ?? this.status,
message:message ?? this.message,
data:data ?? this.data
        );
        }
        
Map<String,Object?> toJson(){
    return {
            'status': status,
'message': message,
'data': data?.toJson()
    };
}

static UpdateAddressResponse fromJson(Map<String , Object?> json){
    return UpdateAddressResponse(
            status:json['status'] == null ? null : json['status'] as bool,
message:json['message'] == null ? null : json['message'] as String,
data:json['data'] == null ? null : Data.fromJson(json['data']  as Map<String,Object?>)
    );
}

@override
String toString(){
    return '''UpdateAddressResponse(
                status:$status,
message:$message,
data:${data.toString()}
    ) ''';
}

@override
bool operator ==(Object other){
    return other is UpdateAddressResponse && 
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
final int? id;
final int? clientId;
final String? isDefault;
final String? picName;
final String? picPhone;
final String? propertyType;
final int? propertyCharge;
final String? lat;
final String? long;
final String? propertyAddress;
final String? description;
final dynamic createdBy;
final dynamic updatedBy;
final dynamic deletedBy;
final String? createdAt;
final String? updatedAt;
final dynamic deletedAt;
const Data({this.id , this.clientId , this.isDefault , this.picName , this.picPhone , this.propertyType , this.propertyCharge , this.lat , this.long , this.propertyAddress , this.description , this.createdBy , this.updatedBy , this.deletedBy , this.createdAt , this.updatedAt , this.deletedAt });
Data copyWith({int? id, int? clientId, String? isDefault, String? picName, String? picPhone, String? propertyType, int? propertyCharge, String? lat, String? long, String? propertyAddress, String? description, dynamic? createdBy, dynamic? updatedBy, dynamic? deletedBy, String? createdAt, String? updatedAt, dynamic? deletedAt}){
return Data(
            id:id ?? this.id,
clientId:clientId ?? this.clientId,
isDefault:isDefault ?? this.isDefault,
picName:picName ?? this.picName,
picPhone:picPhone ?? this.picPhone,
propertyType:propertyType ?? this.propertyType,
propertyCharge:propertyCharge ?? this.propertyCharge,
lat:lat ?? this.lat,
long:long ?? this.long,
propertyAddress:propertyAddress ?? this.propertyAddress,
description:description ?? this.description,
createdBy:createdBy ?? this.createdBy,
updatedBy:updatedBy ?? this.updatedBy,
deletedBy:deletedBy ?? this.deletedBy,
createdAt:createdAt ?? this.createdAt,
updatedAt:updatedAt ?? this.updatedAt,
deletedAt:deletedAt ?? this.deletedAt
        );
        }
        
Map<String,Object?> toJson(){
    return {
            'id': id,
'client_id': clientId,
'is_default': isDefault,
'pic_name': picName,
'pic_phone': picPhone,
'property_type': propertyType,
'property_charge': propertyCharge,
'lat': lat,
'long': long,
'property_address': propertyAddress,
'description': description,
'created_by': createdBy,
'updated_by': updatedBy,
'deleted_by': deletedBy,
'created_at': createdAt,
'updated_at': updatedAt,
'deleted_at': deletedAt
    };
}

static Data fromJson(Map<String , Object?> json){
    return Data(
            id:json['id'] == null ? null : json['id'] as int,
clientId:json['client_id'] == null ? null : json['client_id'] as int,
isDefault:json['is_default'] == null ? null : json['is_default'] as String,
picName:json['pic_name'] == null ? null : json['pic_name'] as String,
picPhone:json['pic_phone'] == null ? null : json['pic_phone'] as String,
propertyType:json['property_type'] == null ? null : json['property_type'] as String,
propertyCharge:json['property_charge'] == null ? null : json['property_charge'] as int,
lat:json['lat'] == null ? null : json['lat'] as String,
long:json['long'] == null ? null : json['long'] as String,
propertyAddress:json['property_address'] == null ? null : json['property_address'] as String,
description:json['description'] == null ? null : json['description'] as String,
createdBy:json['created_by'] as dynamic,
updatedBy:json['updated_by'] as dynamic,
deletedBy:json['deleted_by'] as dynamic,
createdAt:json['created_at'] == null ? null : json['created_at'] as String,
updatedAt:json['updated_at'] == null ? null : json['updated_at'] as String,
deletedAt:json['deleted_at'] as dynamic
    );
}

@override
String toString(){
    return '''Data(
                id:$id,
clientId:$clientId,
isDefault:$isDefault,
picName:$picName,
picPhone:$picPhone,
propertyType:$propertyType,
propertyCharge:$propertyCharge,
lat:$lat,
long:$long,
propertyAddress:$propertyAddress,
description:$description,
createdBy:$createdBy,
updatedBy:$updatedBy,
deletedBy:$deletedBy,
createdAt:$createdAt,
updatedAt:$updatedAt,
deletedAt:$deletedAt
    ) ''';
}

@override
bool operator ==(Object other){
    return other is Data && 
        other.runtimeType == runtimeType &&
        other.id == id && 
other.clientId == clientId && 
other.isDefault == isDefault && 
other.picName == picName && 
other.picPhone == picPhone && 
other.propertyType == propertyType && 
other.propertyCharge == propertyCharge && 
other.lat == lat && 
other.long == long && 
other.propertyAddress == propertyAddress && 
other.description == description && 
other.createdBy == createdBy && 
other.updatedBy == updatedBy && 
other.deletedBy == deletedBy && 
other.createdAt == createdAt && 
other.updatedAt == updatedAt && 
other.deletedAt == deletedAt;
}
      
@override
int get hashCode {
    return Object.hash(
                runtimeType,
                id, 
clientId, 
isDefault, 
picName, 
picPhone, 
propertyType, 
propertyCharge, 
lat, 
long, 
propertyAddress, 
description, 
createdBy, 
updatedBy, 
deletedBy, 
createdAt, 
updatedAt, 
deletedAt
    );
}
    
}
      
      
  
     