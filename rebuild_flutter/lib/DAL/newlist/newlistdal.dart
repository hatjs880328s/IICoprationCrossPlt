import 'package:fluttertoast/fluttertoast.dart';
import 'package:rebuild_flutter/MODEL/Newfile/filegitcommitsmallmodel.dart';
import 'package:rebuild_flutter/UTI/HTTP/nshttp.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:rebuild_flutter/DAL/api/apistruct.dart';
import 'package:rebuild_flutter/MODEL/Newfile/filegitcommitmodel.dart';

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
      try {
        String url = APIStruct.getFolderapi + userid;
        Response res = await NSHTTP.startRequest(NSHTTPRequestType.GET, url, this.getNormalGitHeader());
        return res.data;
      } on Exception {
        Fluttertoast.showToast(msg: "网络异常，请稍后再试", gravity: ToastGravity.CENTER);
        return [];
      }
    }

    /*
     *获取某人的最新文件夹下面的数据 
     */
    Future<List<dynamic>> getUserNewestFileList(String userid) async {
      try {
        String url = APIStruct.getNewestFileListapi.replaceAll("{uid}", userid);
        Response res = await NSHTTP.startRequest(NSHTTPRequestType.GET, url, this.getNormalGitHeader());
        return res.data;
      } on Exception {
        Fluttertoast.showToast(msg: "网络异常，请稍后再试", gravity: ToastGravity.CENTER);
        return [];
      }
    }

    /*
     *获取某人的某个文件夹下面的数据 
     */
    Future<List<dynamic>> getUserFolderFileList(String userid, String folder) async {
      try {
        String url = APIStruct.getSomeoneFolderFileListapi.replaceAll("{uid}", userid).replaceAll("{fid}", folder);
        Response res = await NSHTTP.startRequest(NSHTTPRequestType.GET, url, this.getNormalGitHeader());
        return res.data;
      } on Exception {
        Fluttertoast.showToast(msg: "网络异常，请稍后再试", gravity: ToastGravity.CENTER);
        return [];
      }
    }

    /// 根据path，获取一个文件的内容
    Future<Map> getOneItem(String path) async {
      try {
        String url = APIStruct.getOneItemapi + path;
        Response res = await NSHTTP.startRequest(NSHTTPRequestType.GET, url, this.getNormalGitHeader());
        return res.data;
      } on Exception {
        Fluttertoast.showToast(msg: "网络异常，请稍后再试", gravity: ToastGravity.CENTER);
        return {};
      }
    }

    /*
     * 创建一个文件，返回结果为bool 
     * 切记content是在此处进行的base64编码
    */
    Future<bool> createFile (
      String content, 
      String userid, 
      String folderid,
      String filename) async {
        String realContent = base64Encode(utf8.encode(content));
        FileGitCommitSmallModel smallModel = FileGitCommitSmallModel(userid, "451145552@qq.com");
        FileGitCommitModel model = FileGitCommitModel(userid + "commit.", realContent, smallModel);

        String api = APIStruct.createFile.
        replaceAll("{uid}", userid).
        replaceAll("{folderid}", folderid).
        replaceAll("{filename}", filename);

        Map<String, dynamic> headers = getNormalGitHeader();
        headers["content-type"] = "application/json";
        Response res = await NSHTTP.startRequest(NSHTTPRequestType.PUT, api, headers, model.toJson());
        print(res.data);
        return true;
    }
}