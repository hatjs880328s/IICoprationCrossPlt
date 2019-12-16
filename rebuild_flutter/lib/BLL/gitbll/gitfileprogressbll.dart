/*

所有关于git api操作的bll都在这里 

1.创建一个文件（创建文件的同时，更新文件夹下的folderinfo） ✅

2.创建一个文件夹（普通|协同组）(创建文件夹的同时，创建下面的folerinfo) ✅
2'.创建文件夹的同时需要更新文件夹根目录的folderinfo

3.更新一个文件（同时更新文件夹下的folderinfo）✅

4.更新一个文件夹（更新文件夹下的folderinfo文件） ✅

5.删除文件|文件夹 ✘

6.获取一个文件信息 ✅

7.获取一个文件夹下所有文件列表 ✅

8.获取一个用户下所有文件夹列表（区分普通|协同） ✅
 
 */
import 'dart:convert';
import 'package:rebuild_flutter/BLL/gitbll/coperationfilelockbll.dart';
import 'package:rebuild_flutter/DAL/gitdal/gitfiledal.dart';
import 'package:rebuild_flutter/DAL/gitdal/gitfolderdal.dart';
import 'package:rebuild_flutter/DAL/newlist/newlistlocaldal.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginglobal.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';
import 'package:uuid/uuid.dart';

class GitFileProgressBLL {

  /// db - dal
  NewListLocalDAL localDal = NewListLocalDAL();

  /// 文件夹自动生成的文件名字
  String defaultFolderFileName = "GroupInfoFile";

  /// 创建一个文件
  /// 文件名称 fileName,
  /// 文件夹model: folderInfo ,
  /// 内容： fileContent,
  /// 标题： fileTitle ,
  /// 是否是普通文件夹下的文件： isNormalFolder
  Future<void> createFile(bool isNormalFolder, CoperationGroupModel folderInfo,
      String fileContent, String fileTitle, String fileSubtitle) async {

    var usermodel = await NSLoginGlobal.getInstance().getUserInfo();
    RealGitFileModel filemodel = RealGitFileModel(
      fileContent,
      DateTime.now().millisecondsSinceEpoch.toDouble(),
      '',
      fileTitle,
      fileSubtitle,
      Uuid().v1(),
      folderInfo.folderid,
      DateTime.now().millisecondsSinceEpoch.toDouble(),
      '',
      usermodel.userid
    );  
    var result = await GitFileDAL().createFile(filemodel.toJson());  
    return result;
  }


  /// 创建一个文件夹 普通|协同 (创建一个包含在此文件夹下的文件而已)
  Future<void> createFolder(bool isnormalFolder, String folderName) async {
    var usermodel = await NSLoginGlobal.getInstance().getUserInfo();
    String uid = usermodel.userid;
    var folder = FolderModel(
      Uuid().v1(),
      folderName,
      '',
      '',
      DateTime.now().millisecondsSinceEpoch.toDouble(),
      DateTime.now().millisecondsSinceEpoch.toDouble(),
      uid,
      isnormalFolder ? 0 : 1
    );
    var result = await GitFolderDAL().createFolder(folder.toJson());
    return result;
  }

  /// 更新一个文件（还需要更新所在文件夹下的folderinfo文件）
  Future<bool> updateOneFile(
      String fileContent,
      String fileTitle,
      String fileSubtitle,
      RealGitFileModel oldFileModel) async {

        var newFileModel = oldFileModel;
        newFileModel.name = fileTitle;
        newFileModel.description = fileSubtitle;
        newFileModel.content = fileContent;

        var result = await GitFileDAL().updateFile(newFileModel.toJson());
        var unlock = await CoperationFileLockBLL().unlockfile(newFileModel.fileid);
        return result && unlock;
  }

  /// 获取一个文件的信息(需要此文件的path信息)
  Future<RealGitFileModel> getFileContent(RealGitFileModel itemModel) async {
    Map result = await GitFileDAL().getUserInfo(itemModel.fileid);
    RealGitFileModel realnewmodel = RealGitFileModel.fromJson(result);
    return realnewmodel;
  }

  /// 获取此用户所有的普通文件夹|协同文件夹 列表
  Future<List<FolderModel>> getOneUsersAllFolders(
      bool isNormalFolder) async {
    // 1.获取path
    var usermodel = await NSLoginGlobal.getInstance().getUserInfo();
    String uid = usermodel.userid;
    List listresult = await GitFolderDAL().getOneUserFolders(uid, isNormalFolder ? 0 : 1);
    List<FolderModel> result = [];
    for (Map eachmap in listresult) {
      FolderModel eachfolder = FolderModel.fromJson(eachmap);
      result.add(eachfolder);
    }
    return result;
  }

  /// 获取一个文件夹下面的所有的文件信息（文件不含具体信息，但有摘要）[realuid为null则表示时自己的文件，否则就是指定人的文件]
  Future<List<RealGitFileModel>> getOneFolderFileLists(String folderid) async {
    List<RealGitFileModel> result = [];
    var list = await GitFolderDAL().getOneFolderFiles(folderid);
    for (Map eachmap in list) {
      RealGitFileModel model = RealGitFileModel.fromJson(eachmap);
      result.add(model);
    }
    return result;
  }

  /// 获取一个协同组信息 【协同组 & users & files】
  Future<CoperationGroupModel> getOneCoperationGroupInfo(String folderid) async {
    var group = await GitFolderDAL().getOneCoperationFolderFiles(folderid);
    CoperationGroupModel result = CoperationGroupModel.fromJson(group);
    return result;
  }

  /// 获取最新文件夹下文件列表
  Future<List<RealGitFileModel>> getNewestFileLists() async {
    NSLoginModel umodel = await NSLoginGlobal.getInstance().getUserInfo();
    List<RealGitFileModel> result = [];
    var list = await GitFileDAL().getallNewestFiles(umodel.userid);
    for (Map eachmap in list) {
      RealGitFileModel model = RealGitFileModel.fromJson(eachmap);
      result.add(model);
    }
    return result;
  }

  /// 创建一个 “最新” 文件夹下的文件 - folderid为空即可
  Future<void> createNewestFolderFile(
    String fileContent,
    String title,
    String subTitle,
  ) async {
    var usermodel = await NSLoginGlobal.getInstance().getUserInfo();
    RealGitFileModel filemodel = RealGitFileModel(
      fileContent,
      DateTime.now().millisecondsSinceEpoch.toDouble(),
      '',
      title,
      subTitle,
      Uuid().v1(),
      '',
      DateTime.now().millisecondsSinceEpoch.toDouble(),
      '',
      usermodel.userid
    );  
    var result = await GitFileDAL().createFile(filemodel.toJson());  
    return result;
  }

  /// 删除文件 [1.先删文件 2.后处理folder]
  Future<bool> deleteOneFile(RealGitFileModel currentItem) async {
    var delete = await GitFileDAL().deleteFile(currentItem.fileid);
    return delete;
  }
}
