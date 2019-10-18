import 'package:rebuild_flutter/UTI/HTTP/nshttp.dart';
import 'package:dio/dio.dart';
import 'package:rebuild_flutter/DAL/api/apistruct.dart';

class NewListDAL {

    /*
     * 获取通用header
     */
    Map<String, dynamic> getNormalGitHeader() {
      Map<String, dynamic> header = {
        "Authorization": APIStruct.authHeaderInfo,
        "Accept": APIStruct.authSubInfo
      }; 
      return header;
    }

    /*
     * 获取某个用户下的所有文件夹
     */
    Future<List<dynamic>> getUserFolders(String userid) async {
      String url = APIStruct.getFolderapi + userid;
      Response res = await NSHTTP.startRequest(NSHTTPRequestType.GET, url, this.getNormalGitHeader());
      return res.data;
    }
}