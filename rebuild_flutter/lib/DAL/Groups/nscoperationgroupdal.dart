

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
    String name,
    String groupid,
    String uid,
  ) async {

    String api = APIStruct.createCoperationGroup
      .replaceAll("{groupname}", name)
      .replaceAll("{uid}", uid)
      .replaceAll("{filename}", this.groupContentInfoFilename);

    /// 初始化一个群组model - 用户目前只有自己， file为空，不包含groupinfofile
    CoperationGroupModel groupModel = new CoperationGroupModel(
      name, 
      groupid, 
      [uid], 
      DateTime.now().millisecondsSinceEpoch.toDouble(), 
      []);
    String contentInfo = json.encode(groupModel.toJson());

    String realContent = base64Encode(utf8.encode(contentInfo));
    FileGitCommitSmallModel smallModel =
        FileGitCommitSmallModel(uid, "451145552@qq.com");
    FileGitCommitModel model =
        FileGitCommitModel(uid + "commit.", realContent, smallModel);

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