import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:rebuild_flutter/DAL/Groups/nscoperationgroupdal.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginglobal.dart';
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';
import 'package:rebuild_flutter/UTI/COMMON/nsdataextension.dart';
import 'package:uuid/uuid.dart';

class CoperationGroupBLL {
  NSCoperationGroupDAL dal = NSCoperationGroupDAL();

  /// 创建一个协同群组
  Future<bool> createGroup(
    String name
  ) async {
    String groupid = Uuid().v1();
    var userinfo = await NSLoginGlobal.getInstance().getUserInfo();
    return await this.dal.createGroup(name, groupid, userinfo.uid);
  }

  /// 获取某个协同组下面的文件
  Future<List<String>> getGroups(String coperid) async {
    var userinfo = await NSLoginGlobal.getInstance().getUserInfo();
    dynamic model =  await this.dal.getCoperitionGroups(userinfo.uid, coperid);
    RealGitFileModel models = RealGitFileModel.fromJson(model);
    var base64Content = models.content.replaceAll("\n", "");
    var realstr = NSDataExtension().base64Decodes(base64Content);
    var realModel = CoperationGroupModel.fromJson(json.decode(realstr));
    return realModel.files;
  }

  /// 获取所有协同组信息
  Future<List<FolderModel>> getallGroups() async {
    var model = await NSLoginGlobal.getInstance().getUserInfo();
    List<dynamic> res = await dal.getALLCoperitionGroups(model.uid);
    List<FolderModel> list = [];
    for (int i = 0  ; i < res.length ; i++) {
      FolderModel model = FolderModel.fromJson(res[i]);
      list.add(model);
    }
    return list;
  }
}