/*
 * 文件夹的操作
 * 
 * 1.创建文件夹,附带一个默认的folderinfofile文件
 * 2.更新文件夹
 *  
 */
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rebuild_flutter/DAL/api/apistruct.dart';
import 'package:rebuild_flutter/MODEL/Newfile/filegitcommitmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/filegitcommitsmallmodel.dart';
import 'package:rebuild_flutter/UTI/HTTP/nshttp.dart';
import 'package:rebuild_flutter/UTI/HTTP/nshttpextension.dart';

class FolderDAL {
  String folderContentInfoFilename = "FolderInfoFile";

  /// 创建一个文件夹 - uid & foldername
  Future<void> createNewFolder(String name, String uid) async {
    String api = APIStruct.createFolder
      .replaceAll("{foldername}", name)
      .replaceAll("{uid}", uid)
      .replaceAll("{filename}", this.folderContentInfoFilename);

    String realContent = base64Encode(utf8.encode(""));
    FileGitCommitSmallModel smallModel =
        FileGitCommitSmallModel(uid, "451145552@qq.com");
    FileGitCommitModel model =
        FileGitCommitModel(uid + "commit.", realContent, smallModel);

    Map<String, dynamic> headers = NSHTTPExtension().getNormalGitHeader();
    headers["content-type"] = "application/json";
    Response res = await NSHTTP.startRequest(
        NSHTTPRequestType.PUT, api, headers, model.toJson());
    print(res.data);
    return true;
  }

  /*
     * 获取某个用户下的所有文件夹
     */
    Future<List<dynamic>> getUserFolders(String userid) async {
      try {
        String url = APIStruct.getFolderapi.replaceAll("{uid}", userid);
        Response res = await NSHTTP.startRequest(NSHTTPRequestType.GET, url, NSHTTPExtension().getNormalGitHeader());
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
        Response res = await NSHTTP.startRequest(NSHTTPRequestType.GET, url, NSHTTPExtension().getNormalGitHeader());
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
        Response res = await NSHTTP.startRequest(NSHTTPRequestType.GET, url, NSHTTPExtension().getNormalGitHeader());
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
        Response res = await NSHTTP.startRequest(NSHTTPRequestType.GET, url, NSHTTPExtension().getNormalGitHeader());
        return res.data;
      } on Exception {
        Fluttertoast.showToast(msg: "网络异常，请稍后再试", gravity: ToastGravity.CENTER);
        return {};
      }
    }
}
