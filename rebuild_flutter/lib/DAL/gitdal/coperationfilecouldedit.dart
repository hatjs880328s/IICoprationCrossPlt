import 'package:rebuild_flutter/DAL/api/apistruct.dart';
import 'package:rebuild_flutter/UTI/HTTP/nshttp.dart';
import 'package:rebuild_flutter/UTI/HTTP/nshttpresponse.dart';

/// 协作文件 - dal
class CoperationFileCouldEdit {

  /// 获取协同文件是否可以编辑
  Future<Map> fileCouldEdit(String fileid, String userid) async {
    var url = APIStruct.fileCouldEdit.replaceAll(':fileid', fileid).replaceAll(':userid', userid);
    NSHttpResponse res = await NSHTTP.startRequest(
        NSHTTPRequestType.GET, url);
    if (res.dicValue == null) {
      return {};
    }
    return res.dicValue;
  } 

  /// 文件解除锁定
  Future<bool> fileUnlock(String fileid) async {
    var url = APIStruct.fileUnlock.replaceAll(':fileid', fileid);
    NSHttpResponse res = await NSHTTP.startRequest(NSHTTPRequestType.DELETE, url);
    if (res.dicValue != null) {
      return res.dicValue['result'];
    }
    return false;
  }
}