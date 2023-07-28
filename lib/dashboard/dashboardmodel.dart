class DashboardModel {
  bool? success;
  String? status;
  int? statusCode;
  Data? data;
  String? message;
  String? serverTimezone;
  String? serverDateTime;

  DashboardModel(
      {this.success,
        this.status,
        this.statusCode,
        this.data,
        this.message,
        this.serverTimezone,
        this.serverDateTime});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    statusCode = json['status_code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    serverTimezone = json['serverTimezone'];
    serverDateTime = json['serverDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['serverTimezone'] = this.serverTimezone;
    data['serverDateTime'] = this.serverDateTime;
    return data;
  }
}

class Data {
  int? id;
  int? rmId;
  int? driverId;
  int? vehicleId;
  String? assignDate;
  int? mode;
  int? routeStatus;
  int? status;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? routeMasterName;
  int? routeMasterUnloadPoint;
  int? wasteId;
  int? usertype;
  String? driverName;
  String? driverEmail;
  String? vehicleName;
  String? vehicleNumber;
  int? fuelType;
  int? vehicleType;
  int? routeAssignId;
  List<Apartment>? apartment;

  Data(
      {this.id,
        this.rmId,
        this.driverId,
        this.vehicleId,
        this.assignDate,
        this.mode,
        this.routeStatus,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.routeMasterName,
        this.routeMasterUnloadPoint,
        this.wasteId,
        this.usertype,
        this.driverName,
        this.driverEmail,
        this.vehicleName,
        this.vehicleNumber,
        this.fuelType,
        this.vehicleType,
        this.routeAssignId,
        this.apartment});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rmId = json['rm_id'];
    driverId = json['driver_id'];
    vehicleId = json['vehicle_id'];
    assignDate = json['assign_date'];
    mode = json['mode'];
    routeStatus = json['route_status'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    routeMasterName = json['route_master_name'];
    routeMasterUnloadPoint = json['route_master_unload_point'];
    wasteId = json['waste_id'];
    usertype = json['usertype'];
    driverName = json['driver_name'];
    driverEmail = json['driver_email'];
    vehicleName = json['vehicle_name'];
    vehicleNumber = json['vehicle_number'];
    fuelType = json['fuel_type'];
    vehicleType = json['vehicle_type'];
    routeAssignId = json['route_assign_id'];
    if (json['apartment'] != null) {
      apartment = <Apartment>[];
      json['apartment'].forEach((v) {
        apartment!.add(new Apartment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rm_id'] = this.rmId;
    data['driver_id'] = this.driverId;
    data['vehicle_id'] = this.vehicleId;
    data['assign_date'] = this.assignDate;
    data['mode'] = this.mode;
    data['route_status'] = this.routeStatus;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['route_master_name'] = this.routeMasterName;
    data['route_master_unload_point'] = this.routeMasterUnloadPoint;
    data['waste_id'] = this.wasteId;
    data['usertype'] = this.usertype;
    data['driver_name'] = this.driverName;
    data['driver_email'] = this.driverEmail;
    data['vehicle_name'] = this.vehicleName;
    data['vehicle_number'] = this.vehicleNumber;
    data['fuel_type'] = this.fuelType;
    data['vehicle_type'] = this.vehicleType;
    data['route_assign_id'] = this.routeAssignId;
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
  var whatsappNo;
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
