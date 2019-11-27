import 'dart:convert';

import 'package:rebuild_flutter/BLL/gitbll/gitfileprogressbll.dart';
import 'package:rebuild_flutter/DAL/gitdal/gitfileprogressdal.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/IIWaitAni/iiwaitani.dart';

/// 文件移动bll
class GitFileMoveProgressBLL {

  var netdal = GitFileProgressDAL();

  String folderStr = '/GroupInfoFile';

  GitFileProgressBLL filebll = GitFileProgressBLL();

  /// 文件移动
  Future<bool> moveFileProgress(RealGitFileModel originModel, CoperationGroupModel currentFolder) async {
    // 1.先添加
    await filebll.createFile(true, currentFolder, originModel.content, originModel.title, originModel.subtitle);
    // 2.后移除  
    await this.filebll.deleteOneFile(originModel);
    // alert
    IIWaitAni.showWait('处理完毕');
  }
}