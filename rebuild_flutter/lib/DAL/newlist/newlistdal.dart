import 'package:fluttertoast/fluttertoast.dart';
import 'package:rebuild_flutter/MODEL/Newfile/filegitcommitsmallmodel.dart';
import 'package:rebuild_flutter/UTI/COMMON/nsdataextension.dart';
import 'package:rebuild_flutter/UTI/HTTP/nshttp.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:rebuild_flutter/DAL/api/apistruct.dart';
import 'package:rebuild_flutter/MODEL/Newfile/filegitcommitmodel.dart';
import 'package:rebuild_flutter/UTI/HTTP/nshttpextension.dart';

class NewListDAL {

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

        Map<String, dynamic> headers = NSHTTPExtension().getNormalGitHeader();
        headers["content-type"] = "application/json";
        Response res = await NSHTTP.startRequest(NSHTTPRequestType.PUT, api, headers, model.toJson());
        print(res.data);
        return true;
    }
}