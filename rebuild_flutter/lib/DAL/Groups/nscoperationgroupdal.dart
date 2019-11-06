

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rebuild_flutter/DAL/api/apistruct.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/filegitcommitmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/filegitcommitsmallmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';
import 'package:rebuild_flutter/UTI/HTTP/nshttp.dart';
import 'package:rebuild_flutter/UTI/HTTP/nshttpextension.dart';
import 'package:uuid/uuid.dart';

/*
 * 协同组dal 
 */
class NSCoperationGroupDAL {

  String groupContentInfoFilename = "GroupInfoFile";

  /// 创建 & 更新 一个协同组
  Future<bool> createGroup(
    String groupname,
    String uid,
    FileGitCommitModel model,
  ) async {

    String api = APIStruct.createCoperationGroup
      .replaceAll("{groupname}", groupname)
      .replaceAll("{uid}", uid)
      .replaceAll("{filename}", this.groupContentInfoFilename);

    Map<String, dynamic> headers = NSHTTPExtension().getNormalGitHeader();
    headers["content-type"] = "application/json";
    try {
      Response res = await NSHTTP.startRequest(
        NSHTTPRequestType.PUT, api, headers, model.toJson());
      print(res.data);
    } on Exception {
      Fluttertoast.showToast(
        msg: "网络异常，请稍后再试"
      );
      return false;
    }
    return true;
  }

  /// 获取某个协同组下面的文件
  Future<dynamic> getCoperitionGroups(String uid, String coperid) async{
    var uri = APIStruct.getCoperitionGroups
    .replaceAll("{uid}", uid)
    .replaceAll("{filename}", this.groupContentInfoFilename)
    .replaceAll("{coperid}", coperid);
    try {
      Response res = await NSHTTP.startRequest(NSHTTPRequestType.GET, uri, NSHTTPExtension().getNormalGitHeader());
      return res.data;
    } on Exception {
      Fluttertoast.showToast(
        msg: "网络异常，请稍后再试"
      );
    }
  }


  /// 获取协同组
  Future<dynamic> getALLCoperitionGroups(String uid) async{
    var uri = APIStruct.getALLCoperitionGroups.replaceAll("{uid}", uid); 
    try {
      Response res = await NSHTTP.startRequest(NSHTTPRequestType.GET, uri, NSHTTPExtension().getNormalGitHeader());
      return res.data;
    } on Exception {
      Fluttertoast.showToast(
        msg: "网络异常，请稍后再试"
      );
    }
  }
  
}