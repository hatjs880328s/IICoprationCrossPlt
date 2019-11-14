/*
 * GIT 文件操作的dal ✅
 * 
 * 1.文件创建(文件夹创建是创建一个文件包含在此文件夹下) ✅
 * 
 * 2.文件更新 ✅
 * 
 * 3.文件内容获取 ✅
 * 
 * 4.文件删除 ✘
 */
import 'dart:core';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rebuild_flutter/DAL/api/apistruct.dart';
import 'package:rebuild_flutter/MODEL/Newfile/filegitcommitmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/filegitcommitsmallmodel.dart';
import 'package:rebuild_flutter/UTI/HTTP/nshttp.dart';
import 'package:rebuild_flutter/UTI/HTTP/nshttpextension.dart';

class GitFileProgressDAL {

  String headerContentType = "application/json";

  void _alertError() {
    Fluttertoast.showToast(msg: "网络异常，请稍后再试", gravity: ToastGravity.CENTER);
  }

  /// 创建一个文件 path: 路径； fileContent: 文件内容（base64编码过后）; creatorName: 创建者姓名 ； creatorEmail: 创建者邮箱
  Future<bool> createFile(String path, String fileContent, String creatorName,
      String creatorEmail) async {
    try {
      FileGitCommitSmallModel smallModel =
          FileGitCommitSmallModel(creatorName, creatorEmail);
      FileGitCommitModel model = FileGitCommitModel(
          creatorName + "commit.", fileContent, smallModel, "");
      String url = APIStruct.gitAPINormalURL + path;
      Map<String, dynamic> headers = NSHTTPExtension().getNormalGitHeader();
      headers["content-type"] = headerContentType;
      Response res = await NSHTTP.startRequest(
          NSHTTPRequestType.PUT, url, headers, model.toJson());
      if (res.data != null) {
        return true;
      }
      return false;
    } on Exception {
      _alertError();
      return false;
    }
  }

  /// 更新一个文件 path: 路径； fileContent: 文件内容（base64编码过后）; creatorName: 更新者姓名 ； creatorEmail: 更新者邮箱 ; sha: 更新文件必要字段
  Future<bool> updateFile(String path, String fileContent, String creatorName,
      String creatorEmail, String sha) async {
    try {
      FileGitCommitSmallModel smallModel =
          FileGitCommitSmallModel(creatorName, creatorEmail);
      FileGitCommitModel model = FileGitCommitModel(
          creatorName + "update.", fileContent, smallModel, sha);
      String url = APIStruct.gitAPINormalURL + path;
      Map<String, dynamic> headers = NSHTTPExtension().getNormalGitHeader();
      headers["content-type"] = headerContentType;
      Response res = await NSHTTP.startRequest(
          NSHTTPRequestType.PUT, url, headers, model.toJson());
      if (res.data != null) {
        return true;
      }
      return false;
    } on Exception {
      _alertError();
      return false;
    }
  }

  /// 根据path，获取一个目录下的所有内容
  Future<dynamic> getFileInfo(String path) async {
    try {
      String url = APIStruct.gitAPINormalURL + path;
      Response res = await NSHTTP.startRequest(
          NSHTTPRequestType.GET, url, NSHTTPExtension().getNormalGitHeader());
      return res.data;
    } on Exception {
      _alertError();
      return {};
    }
  }
}
