import 'dart:convert';

import 'package:rebuild_flutter/BLL/gitbll/gitfileprogressbll.dart';
import 'package:rebuild_flutter/DAL/gitdal/gitfiledal.dart';
import 'package:rebuild_flutter/DAL/gitdal/gitfileprogressdal.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/IIWaitAni/iiwaitani.dart';

/// 文件移动bll
class GitFileMoveProgressBLL {

  var netdal = GitFileProgressDAL();

  String folderStr = '/GroupInfoFile';

  GitFileProgressBLL filebll = GitFileProgressBLL();

  /// 文件移动
  Future<bool> moveFileProgress(RealGitFileModel originModel, FolderModel currentFolder) async {
    originModel.folderid = currentFolder.folderid;
    var result = await GitFileDAL().updateFile(originModel.toJson());
    return result;
  }
}