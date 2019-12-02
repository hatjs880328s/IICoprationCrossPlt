import 'package:rebuild_flutter/DAL/api/apistruct.dart';
import 'package:rebuild_flutter/UTI/HTTP/nshttp.dart';
import 'package:rebuild_flutter/UTI/HTTP/nshttpresponse.dart';

class GitUserDAL {

  /// 获取用户信息 - userid
  Future<Map> getUserInfo(String id) async {
    var url = APIStruct.getUser.replaceAll(":id", id);
    NSHttpResponse res = await NSHTTP.startRequest(
        NSHTTPRequestType.GET, url);
    if (res.dicValue == null) {
      return {};
    }
    return res.dicValue;
  } 

  /// 获取所有用户信息
  Future<List> getAllUser() async {
    var url = APIStruct.createUser;
    NSHttpResponse res = await NSHTTP.startRequest(NSHTTPRequestType.GET, url);
    if (res.arrayValue == null) {
      return [];
    } else {
      return res.arrayValue;
    }
  }

  /// 创建用户信息
  Future<bool> createUser(Map<String, dynamic> params) async {
    var url = APIStruct.createUser;
    NSHttpResponse res = await NSHTTP.startRequest(NSHTTPRequestType.POST, url, params: params, header: {"content-type": "application/x-www-form-urlencoded"});
    if (res.anyValue == null) {
      return false;
    } 
    return res.anyValue;
  }
}