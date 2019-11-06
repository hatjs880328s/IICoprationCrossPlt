import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:rebuild_flutter/DAL/Groups/nscoperationgroupdal.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginglobal.dart';
import 'package:rebuild_flutter/MODEL/Newfile/filegitcommitmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/filegitcommitsmallmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';
import 'package:rebuild_flutter/UTI/COMMON/nsdataextension.dart';
import 'package:uuid/uuid.dart';

class CoperationGroupBLL {
  NSCoperationGroupDAL dal = NSCoperationGroupDAL();

  /// 创建一个协同群组
  Future<bool> createGroup(
    String name,
    CoperationGroupModel updatedModel
  ) async {
    String groupid = Uuid().v1();
    var userinfo = await NSLoginGlobal.getInstance().getUserInfo();

    /// 初始化一个群组model - 用户目前只有自己， file为空，不包含groupinfofile
    CoperationGroupModel groupModel = new CoperationGroupModel(
      name, 
      groupid, 
      [userinfo.uid], 
      DateTime.now().millisecondsSinceEpoch.toDouble(), 
      []);

    String contentInfo = json.encode(groupModel.toJson());

    String realContent = base64Encode(utf8.encode(contentInfo));
    FileGitCommitSmallModel smallModel =
        FileGitCommitSmallModel(userinfo.uid, "451145552@qq.com");
    FileGitCommitModel model =
        FileGitCommitModel(userinfo.uid + "commit.", realContent, smallModel, "");

    return await this.dal.createGroup(name, userinfo.uid, model);
  }

   /// 更新一个协同群组的gourpinfo
  Future<bool> updateGroupInfo(
    String name,
    CoperationGroupModel updatedModel,
    String modelSha
  ) async {
    var userinfo = await NSLoginGlobal.getInstance().getUserInfo();

    String contentInfo = json.encode(updatedModel.toJson());

    String realContent = base64Encode(utf8.encode(contentInfo));
    FileGitCommitSmallModel smallModel =
        FileGitCommitSmallModel(userinfo.uid, "451145552@qq.com");
    FileGitCommitModel model =
        FileGitCommitModel(userinfo.uid + "commit.", realContent, smallModel, modelSha);

    return await this.dal.createGroup(name, userinfo.uid, model);
  }

  /// 获取某个协同组下面的文件
  Future<CoperationGroupModel> getGroups(String coperid) async {
    var userinfo = await NSLoginGlobal.getInstance().getUserInfo();
    dynamic model =  await this.dal.getCoperitionGroups(userinfo.uid, coperid);
    RealGitFileModel models = RealGitFileModel.fromJson(model);
    var base64Content = models.content.replaceAll("\n", "");
    var realstr = NSDataExtension().base64Decodes(base64Content);
    var realModel = CoperationGroupModel.fromJson(json.decode(realstr));
    return realModel;
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