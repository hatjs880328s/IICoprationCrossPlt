import 'package:rebuild_flutter/DAL/api/apistruct.dart';
import 'package:rebuild_flutter/UTI/HTTP/nshttp.dart';
import 'package:rebuild_flutter/UTI/HTTP/nshttpresponse.dart';

/// cmd dal
class GitCMDDal {
  /// 获取某人的所有cmd
  Future<List> getCMDInfo(String id) async {
    var url = APIStruct.getCMD.replaceAll(":id", id);
    NSHttpResponse res = await NSHTTP.startRequest(
        NSHTTPRequestType.GET, url);
    if (res.arrayValue == null) {
      return [];
    }
    return res.arrayValue;
  }

  /// 创建cmd
  Future<bool> createCMD(Map<String, dynamic> params) async {
    var url = APIStruct.createCMD;
    NSHttpResponse res = await NSHTTP.startRequest(NSHTTPRequestType.POST, 
    url, params: params, contentType: "application/x-www-form-urlencoded");
    if (res.dicValue == null) {
      return false;
    } 
    return res.dicValue['result'];
  }

  /// 指令的处理
  Future<bool> progressCMD(String oldCMDID, Map<String, dynamic> params) async {
    var url = APIStruct.progressCMD.replaceAll(":id", oldCMDID);
    NSHttpResponse res = await NSHTTP.startRequest(NSHTTPRequestType.PUT, 
    url, params: params, contentType: "application/x-www-form-urlencoded");
    if (res.dicValue == null) {
      return false;
    } 
    return res.dicValue['result'];
  }
}