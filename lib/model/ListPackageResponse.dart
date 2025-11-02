class ListPackageResponse {
final bool? status;
final String? message;
final List<Data>? data;
const ListPackageResponse({this.status , this.message , this.data });
ListPackageResponse copyWith({bool? status, String? message, List<Data>? data}){
return ListPackageResponse(
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

static ListPackageResponse fromJson(Map<String , Object?> json){
    return ListPackageResponse(
            status:json['status'] == null ? null : json['status'] as bool,
message:json['message'] == null ? null : json['message'] as String,
data:json['data'] == null ? null : (json['data'] as List).map<Data>((data)=> Data.fromJson(data  as Map<String,Object?>)).toList()
    );
}

@override
String toString(){
    return '''ListPackageResponse(
                status:$status,
message:$message,
data:${data.toString()}
    ) ''';
}

@override
bool operator ==(Object other){
    return other is ListPackageResponse && 
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
final int? packId;
final String? packCategory;
final String? packName;
final String? packGlobalDescription;
final String? packObjectDescription;
final String? packJobDescription;
final String? packProcedureDescription;
final String? packBannerPath;
final dynamic discPercentage;
final String? createdBy;
final String? updatedBy;
const Data({this.packId , this.packCategory , this.packName , this.packGlobalDescription , this.packObjectDescription , this.packJobDescription , this.packProcedureDescription , this.packBannerPath , this.discPercentage , this.createdBy , this.updatedBy });
Data copyWith({int? packId, String? packCategory, String? packName, String? packGlobalDescription, String? packObjectDescription, String? packJobDescription, String? packProcedureDescription, String? packBannerPath, dynamic? discPercentage, String? createdBy, String? updatedBy}){
return Data(
            packId:packId ?? this.packId,
packCategory:packCategory ?? this.packCategory,
packName:packName ?? this.packName,
packGlobalDescription:packGlobalDescription ?? this.packGlobalDescription,
packObjectDescription:packObjectDescription ?? this.packObjectDescription,
packJobDescription:packJobDescription ?? this.packJobDescription,
packProcedureDescription:packProcedureDescription ?? this.packProcedureDescription,
packBannerPath:packBannerPath ?? this.packBannerPath,
discPercentage:discPercentage ?? this.discPercentage,
createdBy:createdBy ?? this.createdBy,
updatedBy:updatedBy ?? this.updatedBy
        );
        }
        
Map<String,Object?> toJson(){
    return {
            'pack_id': packId,
'pack_category': packCategory,
'pack_name': packName,
'pack_global_description': packGlobalDescription,
'pack_object_description': packObjectDescription,
'pack_job_description': packJobDescription,
'pack_procedure_description': packProcedureDescription,
'pack_banner_path': packBannerPath,
'disc_percentage': discPercentage,
'created_by': createdBy,
'updated_by': updatedBy
    };
}

static Data fromJson(Map<String , Object?> json){
    return Data(
            packId:json['pack_id'] == null ? null : json['pack_id'] as int,
packCategory:json['pack_category'] == null ? null : json['pack_category'] as String,
packName:json['pack_name'] == null ? null : json['pack_name'] as String,
packGlobalDescription:json['pack_global_description'] == null ? null : json['pack_global_description'] as String,
packObjectDescription:json['pack_object_description'] == null ? null : json['pack_object_description'] as String,
packJobDescription:json['pack_job_description'] == null ? null : json['pack_job_description'] as String,
packProcedureDescription:json['pack_procedure_description'] == null ? null : json['pack_procedure_description'] as String,
packBannerPath:json['pack_banner_path'] == null ? null : json['pack_banner_path'] as String,
discPercentage:json['disc_percentage'] as dynamic,
createdBy:json['created_by'] == null ? null : json['created_by'] as String,
updatedBy:json['updated_by'] == null ? null : json['updated_by'] as String
    );
}

@override
String toString(){
    return '''Data(
                packId:$packId,
packCategory:$packCategory,
packName:$packName,
packGlobalDescription:$packGlobalDescription,
packObjectDescription:$packObjectDescription,
packJobDescription:$packJobDescription,
packProcedureDescription:$packProcedureDescription,
packBannerPath:$packBannerPath,
discPercentage:$discPercentage,
createdBy:$createdBy,
updatedBy:$updatedBy
    ) ''';
}

@override
bool operator ==(Object other){
    return other is Data && 
        other.runtimeType == runtimeType &&
        other.packId == packId && 
other.packCategory == packCategory && 
other.packName == packName && 
other.packGlobalDescription == packGlobalDescription && 
other.packObjectDescription == packObjectDescription && 
other.packJobDescription == packJobDescription && 
other.packProcedureDescription == packProcedureDescription && 
other.packBannerPath == packBannerPath && 
other.discPercentage == discPercentage && 
other.createdBy == createdBy && 
other.updatedBy == updatedBy;
}
      
@override
int get hashCode {
    return Object.hash(
                runtimeType,
                packId, 
packCategory, 
packName, 
packGlobalDescription, 
packObjectDescription, 
packJobDescription, 
packProcedureDescription, 
packBannerPath, 
discPercentage, 
createdBy, 
updatedBy
    );
}
    
}
      
      
  
     