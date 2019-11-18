import 'dart:convert';

import 'package:rebuild_flutter/DAL/gitdal/gitfileprogressdal.dart';
import 'package:rebuild_flutter/MODEL/CMD/gitcmdmodel.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginglobal.dart';
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

  /// 此用户自己的指令文件
  var currentUserInfosFileName = "CurrentUserInfosFile";

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
        // b.排重（直接返回true即可）
        if (eachUser.uid == userInfo.uid) {
          return true;
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

  ///邀请某人进群 - 根据用户id
  Future<bool> inviteSomeOne2Group(
    NSLoginModel receiver,
    CoperationGroupModel group,
    ) async {
    // 1.创建path
    String path = "/${receiver.uid}/${this.currentUserInfosFileName}";
    // 2.获取此path下的文件，如果存在则获取其sha
    Map maps = await this.netdal.getFileInfo(path);
    if (maps.keys.length != 0) {
      // a 处理元数据
      FolderModel gitmodel = FolderModel.fromJson(maps);
      var jsondata = base64Decode(gitmodel.content.replaceAll("\n", ""));
      var strInfo = utf8.decode(jsondata);
      List<dynamic> listresult = json.decode(strInfo);
      List<GitCMDModel> result = [];
      for (Map eachcmd in listresult) {
        GitCMDModel cmd = GitCMDModel.fromJson(eachcmd);
        result.add(cmd);
      }
      var sha = gitmodel.sha;
      // b 创建新数据
      var selfUser = await NSLoginGlobal.getInstance().getUserInfo();
      var timeNow = DateTime.now().millisecondsSinceEpoch.toDouble();
      var newCMD = GitCMDModel(selfUser, receiver, 'invite', timeNow, group);
      // c 拼接并编码
      listresult.add(newCMD);
      var jsonStr = json.encode(listresult);
      var base64Content = base64Encode(utf8.encode(jsonStr));
      // d 上传
      var updateresult = this.netdal.updateFile(path, base64Content, selfUser.uid, selfUser.nickname, sha);
      return updateresult;
    }
    // 3.不存在就创建此文件
    // a 创建新cmd并编码
    var selfUser = await NSLoginGlobal.getInstance().getUserInfo();
    var timeNow = DateTime.now().millisecondsSinceEpoch.toDouble();
    var newCMD = GitCMDModel(selfUser, receiver, 'invite', timeNow, group);
    var jsonStr = json.encode([newCMD]);
    var base64Content = base64Encode(utf8.encode(jsonStr));
    var createresult = this.netdal.createFile(path, base64Content, selfUser.uid, selfUser.nickname);
    return createresult;
  }
}