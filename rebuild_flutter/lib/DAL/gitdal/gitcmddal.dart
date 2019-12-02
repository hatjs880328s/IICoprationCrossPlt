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
    NSHttpResponse res = await NSHTTP.startRequest(NSHTTPRequestType.POST, url, params: params, header: {"content-type": "application/x-www-form-urlencoded"});
    if (res.anyValue == null) {
      return false;
    } 
    return res.anyValue;
  }
}