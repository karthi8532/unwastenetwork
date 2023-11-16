import 'package:intl/intl.dart';

class AppConstants{
 // static const String LIVE_URL="http://assistlysolutions.com/ndl/";

  static const String LOGINDESC = "Enter your mobile number and password to login\nto your account";
  static String cdate = "2023-11-15";// DateFormat("yyyy-MM-dd").format(DateTime.now());//2023-07-15";
  //static String cdate =  "2023-07-20";
  //static String cdatetime = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());

  static const String LIVE_URL="https://unwastenetwork.in/";
  static const String LOGIN_API = '${LIVE_URL}api/auth/login';
  static const String CHECKJOURNYORNOT = '${LIVE_URL}api/route-assigning/check-open-journey';
  static const String GETDRIVERASSIGNROUTE = '${LIVE_URL}api/route-assigning/get-driver-assigned-route';
  static const String JOURNYSTART = '${LIVE_URL}api/journey-log/create';
  static const String STARTTRACKING = '${LIVE_URL}api/vehicle/save-tracking';
  static const String APARTMENTLIST = '${LIVE_URL}api/route-assigning/get-driver-assigned-apartment';
  static const String WASTAGELOGCREATE = '${LIVE_URL}api/wastage-log/create';
  static const String COMPLETEJOURNYLIST = '${LIVE_URL}api/route-assigning/get-completed-apartment-list-day';
  static const String UNITMASTER = '${LIVE_URL}api/weight-unit/list';
  static const String ENDJOURNEY = '${LIVE_URL}api/journey-log/edit';
}