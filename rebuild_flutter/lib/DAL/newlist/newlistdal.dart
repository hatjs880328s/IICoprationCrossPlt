import 'package:rebuild_flutter/UTI/HTTP/nshttp.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:rebuild_flutter/DAL/api/apistruct.dart';

class NewListDAL {
    /*
     * base64解码
     */
    String base64Decodes(String base64Str) {
      var result = base64Decode(base64Str);
      return utf8.decode(result);
    }

    /*
     * 获取通用header
     */
    Map<String, dynamic> getNormalGitHeader() {
      Map<String, dynamic> header = {
        "Authorization": this.base64Decodes(APIStruct.authHeaderInfo),
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

    /*
     *获取某人的最新文件夹下面的数据 
     */
    Future<List<dynamic>> getUserNewestFileList(String userid) async {
      String url = APIStruct.getNewestFileListapi.replaceAll("{uid}", userid);
      Response res = await NSHTTP.startRequest(NSHTTPRequestType.GET, url, this.getNormalGitHeader());
      return res.data;
    }
}