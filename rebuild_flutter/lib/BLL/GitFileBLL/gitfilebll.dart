import 'dart:io';
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';
import 'package:rebuild_flutter/DAL/newlist/newlistdal.dart';

class GitFileBLL {

  /*
   *获取用户最新数据信息 [目前没有处理缓存]
   */
  Future<List<FolderModel>> getNewestInfosWithUserid() async {
    NewListDAL dal = NewListDAL();
    List<dynamic> res = await dal.getUserNewestFileList("shanwzh");
    List<FolderModel> list = [];
    for (int i = 0  ; i < res.length ; i++) {
      FolderModel model = FolderModel.fromJson(res[i]);
      list.add(model);
    }
    return list;
  }
}