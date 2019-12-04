import 'dart:convert';

import 'package:rebuild_flutter/DAL/gitdal/gitcmddal.dart';
import 'package:rebuild_flutter/MODEL/CMD/gitcmdmodel.dart';
import 'package:rebuild_flutter/MODEL/CMD/gitcmdshowmodel.dart';
import 'package:uuid/uuid.dart';

enum CMDType {
  //邀请
  invite,
  //同意
  inviteresultok,
  //拒绝
  inviteresultno
}

/// 命令处理 - 处理邀请指令
class GitCMDProgressBLL {
  /// 此用户自己的指令文件
  var currentUserInfosFileName = "CurrentUserInfosFile";

  /// gen folder name
  var genfoldername = "GroupInfoFile";

  /// 处理邀请指令
  Future<bool> progressInviteCMD(
      bool agress, GitCMDShowModel origincmd) async {
    var oldCMDID = origincmd.cmdid;
    var newCmd = GitCMDModel(
      agress ? 1 : 2, 
      origincmd.reveiver, 
      origincmd.sender,
      Uuid().v1(),
      DateTime.now().millisecondsSinceEpoch.toDouble(),
      origincmd.groupid
    );
    var result = await GitCMDDal().progressCMD(oldCMDID, newCmd.toJson());
    return result;
  }
}
