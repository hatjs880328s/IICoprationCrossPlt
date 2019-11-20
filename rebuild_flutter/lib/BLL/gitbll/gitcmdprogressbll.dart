import 'dart:convert';

import 'package:rebuild_flutter/DAL/gitdal/gitfileprogressdal.dart';
import 'package:rebuild_flutter/MODEL/CMD/gitcmdmodel.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginglobal.dart';
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';

enum CMDType {
  invite, inviteresult
}

/// 命令处理
class GitCMDProgressBLL {

  /// 此用户自己的指令文件
  var currentUserInfosFileName = "CurrentUserInfosFile";

  /// dal
  var netdal = GitFileProgressDAL();

  /// 处理邀请指令
  Future<bool> progressInviteCMD(bool agress, GitCMDModel origincmd, List<GitCMDModel> origincmds) async {
    // 0.将这个协同组信息同步到自己的文件夹下

    // 1.删除自己 cmd-file中消息
    // a path
    var usermodel = await NSLoginGlobal.getInstance().getUserInfo();
    var uid = usermodel.uid;
    var path = '$uid/${this.currentUserInfosFileName}';
    // b new content
    origincmds.remove(origincmd);
    var base64content = base64Encode(utf8.encode(json.encode(origincmds)));
    // c sha
    Map oldinfo = await this.netdal.getFileInfo(path);
    if (oldinfo.keys.length == 0) { return false; }
    FolderModel foldermodel = FolderModel.fromJson(oldinfo);
    var sha = foldermodel.sha;
    var result = await this.netdal.updateFile(path, base64content, uid, usermodel.nickname, sha);
    if (!result) { return false; }
    // 2.告知邀请人，发送一个【结果指令消息】
    // a sender path
    var senderpath = '${origincmd.sender.uid}/${this.currentUserInfosFileName}';
    // b sender old content
    Map senderoldinfo = await this.netdal.getFileInfo(senderpath);
    if (senderoldinfo.keys.length == 0) { return false; }
    FolderModel sendercontent = FolderModel.fromJson(senderoldinfo);
    var sendersha = sendercontent.sha;
    List<GitCMDModel> sendercmds = json.decode((sendercontent.content));
    // c new content 
    var time = DateTime.now().millisecondsSinceEpoch.toDouble();
    GitCMDModel sendernewcmdmodel = GitCMDModel(usermodel, origincmd.sender, CMDType.inviteresult, time, origincmd.group);
    sendercmds.add(sendernewcmdmodel);
    var base64contentinfo = base64Encode(utf8.encode(json.encode(sendercmds)));
    // d send the cmd 2 origin-sender
    var senderresult = await this.netdal.updateFile(senderpath, base64contentinfo, usermodel.uid, usermodel.nickname, sendersha);
    if (!senderresult) { return false; }
    // 3.如果是同意加入； 遍历所有成员，更改所有成员的协同组文件信息
  }
}