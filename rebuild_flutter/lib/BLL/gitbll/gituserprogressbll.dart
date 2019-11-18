import 'dart:convert';

import 'package:rebuild_flutter/DAL/gitdal/gitfileprogressdal.dart';
/**
 * git user progress bll
 * 
 * 1.获取所有用户信息
 * 
 * 2.新增用户信息
 * 
 */

import 'package:rebuild_flutter/MODEL/Login/nsloginmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';

class GitUserProgressBLL {

  /// 用户信息文件名字
  var userInfosFileName = "GlobalUserInfos";

  /// dal
  var netdal = GitFileProgressDAL();

  /// 新建一个用户的时候同步用户信息到网络
  Future<bool> createNewUser2Git(NSLoginModel userInfo) async {
    // 1.判断是否存在这个文件
    Map userInfos = await this.netdal.getFileInfo(this.userInfosFileName);
    // 2.更新一有的文件
    if (userInfos.keys.length != 0) {
      FolderModel netModel = FolderModel.fromJson(userInfos);
      var sha = netModel.sha;
      // a.获取content值，并重新组织用户信息
      var data = base64Decode(netModel.content.replaceAll("\n", ""));
      String contents = utf8.decode(data);
      List<dynamic> infos = json.decode(contents);
      List<NSLoginModel> users = [];
      for (Map eachmap in infos) {
        NSLoginModel eachUser = NSLoginModel.fromJson(eachmap);
        // b.排重
        if (eachUser.uid == userInfo.uid) {
          continue;
        }
        users.add(eachUser);
      }
      users.add(userInfo);
      var jsonData = json.encode(users);
      var dataInfo = utf8.encode(jsonData);
      String base64Str = base64Encode(dataInfo);
      // c.更新信息
      var result = await this.netdal.updateFile(this.userInfosFileName, base64Str, userInfo.uid, userInfo.nickname, sha);
      return result;
    }
    // 3.创建一个新的文件   
    var jsonData = json.encode([userInfo]);
    var dataInfo = utf8.encode(jsonData);
    String base64Str = base64Encode(dataInfo); 
    var result = await this.netdal.createFile(this.userInfosFileName, base64Str, userInfo.uid, userInfo.nickname);
    return result;
  } 

  /// 获取用户信息 - 根据用户id
  Future<NSLoginModel> getUserInfo(String userid) async  {
    Map info = await this.netdal.getFileInfo(this.userInfosFileName);
    // 1. 通过 foldermodel - 获取content
    FolderModel gitmodel = FolderModel.fromJson(info);
    // 2. 解析model
    var data = base64Decode(gitmodel.content.replaceAll("\n", ""));
    var strInfo = utf8.decode(data);
    List<dynamic> listinfo = json.decode(strInfo);
    // 3.循环取出所有的model
    for (Map eachitem in listinfo) {
      NSLoginModel model = NSLoginModel.fromJson(eachitem);      
      if (userid == model.uid) {
        return model;
      }
    }
    return null;
  }

}