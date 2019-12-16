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
}