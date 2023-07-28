class ApartmentModel {
  bool? success;
  String? status;
  int? statusCode;
  List<Data>? data;
  String? message;
  dynamic? pagination;
  String? serverTimezone;
  String? serverDateTime;

  ApartmentModel(
      {this.success,
        this.status,
        this.statusCode,
        this.data,
        this.message,
        this.pagination,
        this.serverTimezone,
        this.serverDateTime});

  ApartmentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    pagination = json['pagination'];
    serverTimezone = json['serverTimezone'];
    serverDateTime = json['serverDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['pagination'] = this.pagination;
    data['serverTimezone'] = this.serverTimezone;
    data['serverDateTime'] = this.serverDateTime;
    return data;
  }
}

class Data {
  int? wastageLogAddedApartmentCount;
  int? totalApartmentCount;
  List<Apartment>? apartment;

  Data(
      {this.wastageLogAddedApartmentCount,
        this.totalApartmentCount,
        this.apartment});

  Data.fromJson(Map<String, dynamic> json) {
    wastageLogAddedApartmentCount = json['wastage_log_added_apartment_count'];
    totalApartmentCount = json['total_apartment_count'];
    if (json['apartment'] != null) {
      apartment = <Apartment>[];
      json['apartment'].forEach((v) {
        apartment!.add(new Apartment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wastage_log_added_apartment_count'] =
        this.wastageLogAddedApartmentCount;
    data['total_apartment_count'] = this.totalApartmentCount;
    if (this.apartment != null) {
      data['apartment'] = this.apartment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Apartment {
  int? id;
  String? name;
  String? address;
  String? area;
  String? email;
  String? contactNo;
  dynamic? whatsappNo;
  String? qrCode;
  String? lat;
  String? lng;
  int? status;
  int? userId;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  int? priority;

  Apartment(
      {this.id,
        this.name,
        this.address,
        this.area,
        this.email,
        this.contactNo,
        this.whatsappNo,
        this.qrCode,
        this.lat,
        this.lng,
        this.status,
        this.userId,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.priority});

  Apartment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    area = json['area'];
    email = json['email'];
    contactNo = json['contact_no'];
    whatsappNo = json['whatsapp_no'];
    qrCode = json['qr_code'];
    lat = json['lat'];
    lng = json['lng'];
    status = json['status'];
    userId = json['user_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['area'] = this.area;
    data['email'] = this.email;
    data['contact_no'] = this.contactNo;
    data['whatsapp_no'] = this.whatsappNo;
    data['qr_code'] = this.qrCode;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['priority'] = this.priority;
    return data;
  }
}
