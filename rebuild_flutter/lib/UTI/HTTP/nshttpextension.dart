import 'package:rebuild_flutter/DAL/api/apistruct.dart';
import 'package:rebuild_flutter/UTI/COMMON/nsdataextension.dart';

class NSHTTPExtension {
  /*
     * 获取通用header
     */
    Map<String, dynamic> getNormalGitHeader() {
      Map<String, dynamic> header = {
        "Authorization": NSDataExtension().base64Decodes(APIStruct.authHeaderInfo),
        "Accept": APIStruct.authSubInfo
      }; 
      return header;
    }
}