import 'dart:convert';

import 'package:coolwell_tech/common/model/register.dart';
import 'package:coolwell_tech/common/model/upload_image_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'assigned_order_model.dart';
import 'complaint_history.dart';
import 'get_assigned_job_list_model.dart';
import 'get_profile_details_model.dart';
import 'get_services_details.dart';
import 'login.dart';

class APIUtils {
  final appName = 'Coolwell';
  // static const baseURL = "http://164.92.128.14:5000";
  static const baseURL = "http://139.59.30.46";


  static const String registerURL = '/register';
  static const String logInURL = '/login';
  static const String forgotEmailURL = '/forgot';
  static const String getServicesURL = '/admin/ServiceList';
  static const String createComplaintURL = '/users/createcomplaint';
  static const String activateURL = '/verifyOtp';
  static const String profileUpdateURL = '/profile';
  static const String profileUploadImageURL = '/uploadimage';
  static const String complaintHistoryURL = '/users/getComplaintHistory';
  static const String assignedServicesURL = '/technician/AssignedJobsList';
  static const String assignedServicesDetailsURL = '/technician/AssignedJobs';
  static const String googleRegisterURL = '/googleregister';
  static const String serviceHistoryURL = '';


  Future<CommonModel> doRegisterEmail(
      String name, String phone, String email, String pass) async {
    var emailbodyData = {
      'name': name,
      'phone': phone,
      'email': email,
      'password': pass,
    };
    final response = await http.post(Uri.parse(baseURL + registerURL),
        body: emailbodyData);
    return CommonModel.fromJson(json.decode(response.body));
  }

  Future<Login> doLoginEmail(String email, String password,) async {
    var emailbodyData = {
      'email': email,
      'password': password
    };

    final response =
    await http.post(Uri.parse(baseURL + logInURL), body: emailbodyData);

    return Login.fromJson(json.decode(response.body));
  }

  Future<GetServiceDetails> getServicesDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var auth = "Bearer "+preferences.getString("token").toString();
    Map<String, String> requestHeaders = {
      'authorization': auth.toString(),
    };
    final response =
    await http.get(Uri.parse(baseURL + getServicesURL), headers: requestHeaders);
    // print(response.body);
    return GetServiceDetails.fromJson(json.decode(response.body));

  }
  Future<CommonModel> verifyOTP(
       String email, String otp) async {
    var emailbodyData = {
      'gmail': email,
      'otp': otp,
      'phone': "null",
    };
    final response = await http.post(Uri.parse(baseURL + activateURL),
        body: emailbodyData);
    // print(response.body);
    return CommonModel.fromJson(json.decode(response.body));
  }

  Future<CommonModel> updateProfileDetails(String name, String profileImage,) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var auth = "Bearer "+preferences.getString("token").toString();
    Map<String, String> requestHeaders = {
      'authorization': auth.toString(),
    };
    var emailbodyData = {
      'name': name,
      // 'address': address,
      // 'pincode': pincode,
      'profile_pic': profileImage

    };

    final response =
    await http.patch(Uri.parse(baseURL + profileUpdateURL),headers: requestHeaders, body: emailbodyData);
    // print(response.body);
    return CommonModel.fromJson(json.decode(response.body));
  }

  Future<GetProfileDetailsModel> getProfileDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var auth = "Bearer "+preferences.getString("token").toString();
    Map<String, String> requestHeaders = {
      'authorization': auth.toString(),
    };

    final response =
    await http.get(Uri.parse(baseURL + profileUpdateURL),headers: requestHeaders);
    // print(response.body);
    return GetProfileDetailsModel.fromJson(json.decode(response.body));
  }

  Future<UploadImageModel> doUpload(String front) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var request =
    http.MultipartRequest("POST", Uri.parse(baseURL + profileUploadImageURL));
    request.headers['authorization'] =
        "Bearer "+preferences.getString("token").toString();
    request.headers['Accept'] = 'application/json';

    var pic = await http.MultipartFile.fromPath("image", front);
    request.files.add(pic);
    http.Response response =
    await http.Response.fromStream(await request.send());
    return UploadImageModel.fromJson(json.decode(response.body.toString()));
  }

  Future<ComplaintHistoryModel> getComplaintDetails() async {
    var emailbodyData = {
      'type': "recent",
    };

    final response =
    await http.post(Uri.parse(baseURL + complaintHistoryURL), body: emailbodyData);

    return ComplaintHistoryModel.fromJson(json.decode(response.body));
  }

  Future<GetAssignedJobsListModel> getServiceDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var auth = "Bearer "+preferences.getString("token").toString();
    Map<String, String> requestHeaders = {
      'authorization': auth.toString(),
    };


    final response =
    await http.get(Uri.parse(baseURL + assignedServicesURL),headers: requestHeaders);
    // print(response.body);
    return GetAssignedJobsListModel.fromJson(json.decode(response.body));
  }

  Future<AssignedOrdersModel> getServiceFullDetails(String jobId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var auth = "Bearer "+preferences.getString("token").toString();
    Map<String, String> requestHeaders = {
      'authorization': auth.toString(),
    };
    var bodyData = {
      'job_id': jobId,
    };

    final response =
    await http.post(Uri.parse(baseURL + assignedServicesDetailsURL),headers: requestHeaders, body: bodyData);
    print(response.body);
    return AssignedOrdersModel.fromJson(json.decode(response.body));
  }

  Future<Login> googleRegistration(
      String name, String email, String type) async {
    var bodyData = {
      'name': name,
      'email': email,
      'type': type,
    };

    final response =
    await http.post(Uri.parse(baseURL + googleRegisterURL), body: bodyData);
    return Login.fromJson(json.decode(response.body));
  }

  Future<Login> serviceHistory(
      String date) async {
    var bodyData = {
      'name': date,
    };

    final response =
    await http.post(Uri.parse(baseURL + serviceHistoryURL), body: bodyData);
    return Login.fromJson(json.decode(response.body));
  }

}
