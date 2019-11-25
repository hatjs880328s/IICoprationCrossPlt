import 'dart:convert';

import 'package:rebuild_flutter/DAL/gitdal/gitfileprogressdal.dart';
import 'package:rebuild_flutter/MODEL/CMD/gitcmdmodel.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginglobal.dart';
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';
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

  /// dal
  var netdal = GitFileProgressDAL();

  /// gen folder name
  var genfoldername = "GroupInfoFile";

  /// 处理邀请指令
  Future<bool> progressInviteCMD(
      bool agress, GitCMDModel origincmd, List<GitCMDModel> origincmds) async {
    // 0.将这个协同组信息同步到自己的文件夹下
    if (agress) {
      var stepone = await this.copyOldGroupInfo2SelfGroups(origincmd);
      if (!stepone) {
        return false;
      }
    }
    // 1.删除自己 cmd-file中消息
    var steptwo = await this.deleteSelfCMD(origincmd, origincmds);
    print('step 2: $steptwo');
    // 2.告知邀请人，发送一个【结果指令消息】
    var step3 = await this.sendNewCMD2Sender(origincmd,
        agress == true ? CMDType.inviteresultok : CMDType.inviteresultno);
    print('step 3: $step3');
    // 3.如果是同意加入,将自己的用户信息添加到当前群组的创建者 folderinfo中；
    var step4 = await addSelf2SpecifiedGroupUserList(origincmd);
    print('step 4: $step4');
    return true;
  }

  /// 获取某人的协同组 - gen folder model * foldermodel
  Future<Map<String, dynamic>> getSenderCoperationGroupModel(String uid) async {
    var path = '$uid/Groups/${this.genfoldername}';
    Map result = await this.netdal.getFileInfo(path);
    if (result.keys.length == 0) {
      return {"group": null, "folder": null};
    }
    FolderModel model = FolderModel.fromJson(result);
    CoperationGroupModel resultmodel = CoperationGroupModel.fromJson(json
        .decode(utf8.decode(base64Decode(model.content.replaceAll("\n", "")))));
    return {"group": resultmodel, "folder": model};
  }

  /// 获取某人的协同组内层信息 - gen folder model * foldermodel
  Future<Map<String, dynamic>> getSenderDeepCoperationGroupModel(String uid, String groupname) async {
    var path = '$uid/Groups/$groupname/${this.genfoldername}';
    Map result = await this.netdal.getFileInfo(path);
    if (result.keys.length == 0) {
      return {"group": null, "folder": null};
    }
    FolderModel model = FolderModel.fromJson(result);
    CoperationGroupModel resultmodel = CoperationGroupModel.fromJson(json
        .decode(utf8.decode(base64Decode(model.content.replaceAll("\n", "")))));
    return {"group": resultmodel, "folder": model};
  }

  /// 将目标协同组信息拷贝到自己的gen-folder中
  Future<bool> copyOldGroupInfo2SelfGroups(GitCMDModel cmd) async {
    // 1 获取邀请的组信息
    var infos = await this.getSenderCoperationGroupModel(cmd.sender.uid);
    CoperationGroupModel itemGroup = infos['group'];
    CoperationGroupModel realItemGroup;
    for (CoperationGroupModel eachitem in itemGroup.dirs) {
      if (eachitem.id == cmd.group.id) {
        realItemGroup = eachitem;
      }
    }
    // 2 获取自己的gen folder info [自己的有可能为空，需要创建]
    var selfGroup = await this.getSenderCoperationGroupModel(cmd.receiver.uid);
    var path = '${cmd.receiver.uid}/Groups/${this.genfoldername}';
    if (selfGroup['group'] == null) {
      //新建
      var newGroup = CoperationGroupModel(
        "Groups",
        Uuid().v1(),
        [],
        DateTime.now().millisecondsSinceEpoch.toDouble(),
        [],
        path,
        [realItemGroup],
      );
      var base64Str = base64Encode(utf8.encode(json.encode(newGroup)));
      var result = await this.netdal.createFile(path, base64Str, cmd.receiver.uid, cmd.receiver.nickname);
      return result;
    } else {
      //更新
      var selfRealGroup = selfGroup['group'];
      var selfFolder = selfGroup['folder'];
      // 3 处理新的content
      for (CoperationGroupModel eachitem in selfRealGroup.dirs) {
        if (eachitem.id == realItemGroup.id) {
          selfRealGroup.dirs.remove(eachitem);
          break;
        }
      }
      selfRealGroup.dirs.add(realItemGroup);
      // 4 base64 content
      var base64Str = base64Encode(utf8.encode(json.encode(selfRealGroup)));
      var result = await this.netdal.updateFile(path, base64Str,
          cmd.receiver.uid, cmd.receiver.nickname, selfFolder.sha);
      return result;
    }
  }

  /// 处理完自己的指令，将这一条指令删除即可
  Future<bool> deleteSelfCMD(
      GitCMDModel origincmd, List<GitCMDModel> origincmds) async {
    // a path
    var path = '${origincmd.receiver.uid}/${this.currentUserInfosFileName}';
    // b new content
    origincmds.remove(origincmd);
    var base64content = base64Encode(utf8.encode(json.encode(origincmds)));
    // c sha
    Map oldinfo = await this.netdal.getFileInfo(path);
    if (oldinfo.keys.length == 0) {
      return false;
    }
    FolderModel foldermodel = FolderModel.fromJson(oldinfo);
    var sha = foldermodel.sha;
    var result = await this.netdal.updateFile(path, base64content,
        origincmd.receiver.uid, origincmd.receiver.nickname, sha);
    return result;
  }

  /// 处理完自己数据需要发送一条指令给原来的邀请方
  Future<bool> sendNewCMD2Sender(GitCMDModel origincmd, CMDType realcmd) async {
    // z new cmd
    var time = DateTime.now().millisecondsSinceEpoch.toDouble();
    GitCMDModel sendernewcmdmodel = GitCMDModel(
        origincmd.receiver, origincmd.sender, realcmd, time, origincmd.group);
    // a sender path
    var senderpath = '${origincmd.sender.uid}/${this.currentUserInfosFileName}';
    // b sender old content [这里有可能也没有数据，需要新建]
    Map senderoldinfo = await this.netdal.getFileInfo(senderpath);
    if (senderoldinfo.keys.length == 0) {
      //新建
      var content = [sendernewcmdmodel];
      var base64contentinfo = base64Encode(utf8.encode(json.encode(content)));
      var result = await this.netdal.createFile(senderpath, base64contentinfo, origincmd.receiver.uid, origincmd.receiver.nickname);
      return result;
    }
    // 更新
    List<GitCMDModel> sendercmds = [];
    FolderModel sendercontent = FolderModel.fromJson(senderoldinfo);
    var sendersha = sendercontent.sha;
    List<dynamic> maplist = json.decode((utf8.decode(base64Decode(sendercontent.content.replaceAll("\n", "")))));
    for (Map eachmap in maplist) {
      var model = GitCMDModel.fromJson(eachmap);
      sendercmds.add(model);
    }
    // c new content
    sendercmds.add(sendernewcmdmodel);
    var base64contentinfo = base64Encode(utf8.encode(json.encode(sendercmds)));
    // d send the cmd 2 origin-sender
    var senderresult = await this.netdal.updateFile(
        senderpath,
        base64contentinfo,
        origincmd.receiver.uid,
        origincmd.receiver.nickname,
        sendersha);
    return senderresult;
  }

  /// 将自己的信息添加到创建者的group-folderinfo中
  Future<bool> addSelf2SpecifiedGroupUserList(GitCMDModel originCMD) async {
    // 1. path
    var path = '${originCMD.sender.uid}/Groups/${originCMD.group.name}/${this.genfoldername}';
    var bigDic = await this.getSenderDeepCoperationGroupModel(originCMD.sender.uid, originCMD.group.name);
    FolderModel shaInfo = bigDic['folder'];
    CoperationGroupModel contentInfo = bigDic['group'];
    // 2. 获取原来文件的sha
    var sha = shaInfo.sha;
    // 3. 拼接content 并更新,将自己加到用户列表中
    var selfUid = await NSLoginGlobal.getInstance().getUserInfo();
    var realSelfUid = selfUid.uid;
    contentInfo.users.add(realSelfUid);
    var base64Content = base64Encode(utf8.encode(json.encode(contentInfo)));
    // 4. 更新
    bool result = await this.netdal.updateFile(path, base64Content, realSelfUid, selfUid.nickname, sha);
    return result;
  }
}
