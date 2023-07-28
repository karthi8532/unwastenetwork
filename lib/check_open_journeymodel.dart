class CheckOpenJourneyModel {
  bool? success;
  String? status;
  int? statusCode;
  Data? data;
  String? message;
  Null? pagination;
  String? serverTimezone;
  String? serverDateTime;

  CheckOpenJourneyModel(
      {this.success,
      this.status,
      this.statusCode,
      this.data,
      this.message,
      this.pagination,
      this.serverTimezone,
      this.serverDateTime});

  CheckOpenJourneyModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    statusCode = json['status_code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['pagination'] = this.pagination;
    data['serverTimezone'] = this.serverTimezone;
    data['serverDateTime'] = this.serverDateTime;
    return data;
  }
}

class Data {
  String? isOpenJourney;
  var journeyLogId;
  String? message;
  var vehicleId;
  String? unloadPoint;
  var unloadId;

  Data(
      {this.isOpenJourney,
      this.journeyLogId,
      this.message,
      this.vehicleId,
      this.unloadPoint,
      this.unloadId});

  Data.fromJson(Map<String, dynamic> json) {
    isOpenJourney = json['is_open_journey'];
    journeyLogId = json['journey_log_id'];
    message = json['message'];
    vehicleId = json['vehicle_id'];
    unloadPoint = json['unload_point'];
    unloadId = json['unload_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_open_journey'] = this.isOpenJourney;
    data['journey_log_id'] = this.journeyLogId;
    data['message'] = this.message;
    data['vehicle_id'] = this.vehicleId;
    data['unload_point'] = this.unloadPoint;
    data['unload_id'] = this.unloadId;
    return data;
  }
}
