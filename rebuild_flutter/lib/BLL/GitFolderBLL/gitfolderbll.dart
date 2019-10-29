
import 'package:rebuild_flutter/BLL/LoginBll/loginbll.dart';
import 'package:rebuild_flutter/DAL/Folder/folderdal.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginglobal.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';

/// 创建文件夹 - 信息
class GitFolderBLL {

  var dal = FolderDAL();

  /// 创建一个文件夹
  Future<void> createFolder(String foldername) async {
    NSLoginModel umodel = await LoginBll().getUserInfo();
    await dal.createNewFolder(foldername, umodel.uid);
  }

  /*
   *获取用户最新数据信息 [目前没有处理缓存]
   */
  Future<List<FolderModel>> getNewestInfosWithUserid() async {
    FolderDAL dal = FolderDAL();
    var model = await NSLoginGlobal.getInstance().getUserInfo();
    List<dynamic> res = await dal.getUserNewestFileList(model.uid);
    List<FolderModel> list = [];
    for (int i = 0  ; i < res.length ; i++) {
      FolderModel model = FolderModel.fromJson(res[i]);
      list.add(model);
    }
    return list;
  }

  /*
   *获取用户某个文件夹下的数据信息 [目前没有处理缓存]
   */
  Future<List<FolderModel>> getSomeoneFolderInfosWithUserid(String folderid) async {
    FolderDAL dal = FolderDAL();
    var model = await NSLoginGlobal.getInstance().getUserInfo();
    List<dynamic> res = await dal.getUserFolderFileList(model.uid, folderid);
    List<FolderModel> list = [];
    for (int i = 0  ; i < res.length ; i++) {
      FolderModel model = FolderModel.fromJson(res[i]);
      list.add(model);
    }
    return list;
  }

  /*
   *获取用户文件夹信息 [目前没有处理缓存]
   */
  Future<List<FolderModel>> getUserFolders() async {
    FolderDAL dal = FolderDAL();
    var model = await NSLoginGlobal.getInstance().getUserInfo();
    List<dynamic> res = await dal.getUserFolders(model.uid);
    List<FolderModel> list = [];
    for (int i = 0  ; i < res.length ; i++) {
      FolderModel model = FolderModel.fromJson(res[i]);
      list.add(model);
    }
    return list;
  }
}