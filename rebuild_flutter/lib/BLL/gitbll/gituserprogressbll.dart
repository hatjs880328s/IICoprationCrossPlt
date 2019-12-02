import 'dart:convert';

import 'package:rebuild_flutter/BLL/gitbll/gitcmdprogressbll.dart';
import 'package:rebuild_flutter/DAL/gitdal/gitcmddal.dart';
import 'package:rebuild_flutter/DAL/gitdal/gitfileprogressdal.dart';
import 'package:rebuild_flutter/DAL/gitdal/gituserdal.dart';
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
import 'package:uuid/uuid.dart';

class GitUserProgressBLL {

  /// 用户信息文件名字
  var userInfosFileName = "GlobalUserInfos";

  /// 此用户自己的指令文件
  var currentUserInfosFileName = "CurrentUserInfosFile";

  /// dal
  var netdal = GitFileProgressDAL();

  /// 新建一个用户的时候同步用户信息到网络
  Future<bool> createNewUser2Git(NSLoginModel userInfo) async {
    var result = await GitUserDAL().createUser(userInfo.toJson());
    return result;
  } 

  /// 获取用户信息 - 根据用户id
  Future<List<NSLoginModel>> getALLUserInfo() async  {
    List<NSLoginModel> result = [];
    List<dynamic> listinfo = await GitUserDAL().getAllUser();
    // 3.循环取出所有的model
    for (Map eachitem in listinfo) {
      NSLoginModel model = NSLoginModel.fromJson(eachitem);      
      result.add(model);
    }
    return result;
    
  }

  ///邀请某人进群 - 根据被邀请用户nsloginmodel
  Future<bool> inviteSomeOne2Group(
    NSLoginModel receiver,
    CoperationGroupModel group,
    ) async {
    var selfUser = await NSLoginGlobal.getInstance().getUserInfo();
    var timeNow = DateTime.now().millisecondsSinceEpoch.toDouble();
    var newCMD = GitCMDModel(CMDType.invite.index, selfUser.userid, receiver.userid, Uuid().v1(), timeNow, group.id);
    var result = await GitCMDDal().createCMD(newCMD.toJson());
    return result;
  }

  /// 获取所有的自己的指令消息
  Future<List<GitCMDModel>> getOwnCMDs() async {
    var model = await NSLoginGlobal.getInstance().getUserInfo();
    var uid = model.userid;
    List<GitCMDModel> result = [];
    var lists = await GitCMDDal().getCMDInfo(uid);
    for (Map eachMap in lists) {
      GitCMDModel model = GitCMDModel.fromJson(eachMap);
      result.add(model);
    }
    return result;
  }
}