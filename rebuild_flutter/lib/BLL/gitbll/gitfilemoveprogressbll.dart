import 'dart:convert';

import 'package:rebuild_flutter/DAL/gitdal/gitfileprogressdal.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginglobal.dart';
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';

/// 文件移动bll
class GitFileMoveProgressBLL {

  var netdal = GitFileProgressDAL();

  /// 文件移动
  Future<bool> moveFileProgress(RealGitFileModel originModel, CoperationGroupModel currentFolder) async {
    // 1.先添加
    // a.创建path
    var addPath = '${currentFolder.path}/${originModel.title}';
    var oldPath = originModel.path;
    // b.创建content
    originModel.path = addPath;
    var base64Content = base64Encode(utf8.encode(jsonEncode(originModel)));
    // c.uid
    var user = await NSLoginGlobal.getInstance().getUserInfo();
    // d.执行dal
    var result = await this.netdal.createFile(addPath, base64Content, user.uid, user.nickname);
    if (!result) {
      return false;
    }

    // 2.后移除  
    // a.创建path
    var deletePath = oldPath;
    // b.获取sha
    Map<dynamic, dynamic> originContent = await this.netdal.getFileInfo(deletePath);
    FolderModel foldermodel = FolderModel.fromJson(originContent);
    var sha = foldermodel.sha;
    // c.删除
    var setp2Result = await this.netdal.deleteOneFile(deletePath, sha, user.uid, user.nickname);
    return setp2Result;
  }
}