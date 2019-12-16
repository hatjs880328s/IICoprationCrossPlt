import 'package:fish_redux/fish_redux.dart';
import 'package:rebuild_flutter/DAL/gitdal/coperationfilecouldedit.dart';
import 'package:rebuild_flutter/DAL/gitdal/gituserdal.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginglobal.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/filelockmodel.dart';

class CoperationFileLockBLL {

  /// 判定是否可以编辑
  Future<Tuple3<bool, String, String>> couldEdit(String fileid) async {
    var userModel = await NSLoginGlobal.getInstance().getUserInfo();
    var dal = CoperationFileCouldEdit();
    Map<String, dynamic> maps = await dal.fileCouldEdit(fileid, userModel.userid);
    FileLockModel result = FileLockModel.fromJson(maps);
    Map<String, dynamic> userInfo = await GitUserDAL().getUserInfo(result.whoEdit);
    NSLoginModel editUsermodel = NSLoginModel.fromJson(userInfo);
    return Tuple3(result.result, result.whoEdit, editUsermodel.nickname);
  }

  /// 解除文件锁定
  Future<bool> unlockfile(String fileid) async {
    var dal = CoperationFileCouldEdit();
    bool result = await dal.fileUnlock(fileid);
    return result;
  }
}