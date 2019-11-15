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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rebuild_flutter/DAL/gitdal/gitfileprogressdal.dart';
import 'package:rebuild_flutter/DAL/newlist/newlistlocaldal.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginglobal.dart';
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';
import 'package:uuid/uuid.dart';
import 'package:convert/src/hex.dart';
import 'package:crypto/crypto.dart';

class GitFileProgressBLL {
  /// net - dal
  GitFileProgressDAL dal = GitFileProgressDAL();

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
    // 0.识别是否有重名的
    for (int i = 0; i < folderInfo.files.length; i++) {
      if (folderInfo.files[i].title == fileTitle) {
        Fluttertoast.showToast(
          msg: "请修改名字，目前有此名字的文件",
          gravity: ToastGravity.CENTER,
        );
        return;
      }
    }
    // 1.获取用户id - 创建path
    var usermodel = await NSLoginGlobal.getInstance().getUserInfo();
    String uid = usermodel.uid;
    String uemail = "451145552@qq.com";
    String path =
        this.createPath(fileTitle, folderInfo.name, uid, isNormalFolder);
    // 2.构造提交作为内容的model并base64编码 【RealGitFileModel】
    RealGitFileModel fileModel = RealGitFileModel(
        new Uuid().v1(),
        fileContent,
        DateTime.now().millisecondsSinceEpoch.toDouble(),
        "", // img ignore
        fileTitle,
        fileSubtitle,
        path);
    String base64realContent =
        base64Encode(utf8.encode(json.encode(fileModel.toJson())));
    // 3.通过dal创建此文件
    bool createResult =
        await this.dal.createFile(path, base64realContent, uid, uemail);
    if (!createResult) {
      return;
    }
    // 5.更新folderinfo信息
    CoperationGroupModel newFolderModel = folderInfo;
    RealGitFileModel newFileModel = fileModel;
    newFileModel.content = "";
    newFolderModel.files.add(newFileModel);
    // 6.通过当前bll更新folderinfo信息
    await this.updateOneFolder(newFolderModel);
    Fluttertoast.showToast(
      msg: "创建成功",
    );
  }

  /// 创建具体文件的path - 用户id, 文件夹name， 文件name, 普通文件夹|协同文件夹
  String createPath(
      String fileName, String folderName, String uid, bool isnormalFolder) {
    String normalFolder = "Folders";
    String coperationFolder = "Groups";
    if (isnormalFolder) {
      //普通文件夹
      return "$uid/$normalFolder/$folderName/$fileName";
    } else {
      //协同文件夹
      return "$uid/$coperationFolder/$folderName/$fileName";
    }
  }

  /// 创建folder -path - 用户id, 文件夹name, 普通文件夹|协同文件夹
  String createFolderPath(String folderName, String uid, bool isnormalFolder) {
    String normalFolder = "Folders";
    String coperationFolder = "Groups";
    if (isnormalFolder) {
      //普通文件夹
      return "$uid/$normalFolder/$folderName";
    } else {
      //协同文件夹
      return "$uid/$coperationFolder/$folderName";
    }
  }

  /// 根据api接口返回的model - 创建一个git 信息model,包含sha,包含业务model信息
  FolderModel createFolderModel(Map maps) {
    return FolderModel.fromJson(maps);
  }

  /// 创建一个文件夹 普通|协同 (创建一个包含在此文件夹下的文件而已) [如果重名这里会失败]
  Future<void> createFolder(bool isnormalFolder, String folderName) async {
    // 0.处理文件path
    var usermodel = await NSLoginGlobal.getInstance().getUserInfo();
    String uid = usermodel.uid;
    String uemail = "451145552@qq.com";
    String path =
        this.createPath(defaultFolderFileName, folderName, uid, isnormalFolder);
    // 1.初始化一个文件夹model CoperationGroupModel
    CoperationGroupModel groupModel = new CoperationGroupModel(
        folderName,
        Uuid().v1(),
        [uid],
        DateTime.now().millisecondsSinceEpoch.toDouble(),
        [],
        path,
        []);
    // 2.dal创建文件夹
    String contentInfo = json.encode(groupModel.toJson());
    String realContent = base64Encode(utf8.encode(contentInfo));
    var createResult =
        await this.dal.createFile(path, realContent, uid, uemail);
    if (!createResult) {
      return;
    }
    // 3.创建 | 更新 gen 文件
    await this.createGenFolderInfo(isnormalFolder, groupModel);
  }

  /// 更新一个文件（还需要更新所在文件夹下的folderinfo文件）
  Future<void> updateOneFile(
      bool isNormalFolder,
      String fileContent,
      String fileTitle,
      String fileSubtitle,
      RealGitFileModel oldFileModel,
      CoperationGroupModel oldfolderInfo) async {
    var titleIsChange = oldFileModel.title != fileTitle;
    // 0.获取用户id * 获取网络旧model的sha值PATH值
    var usermodel = await NSLoginGlobal.getInstance().getUserInfo();
    String uid = usermodel.uid;
    String uemail = "451145552@qq.com";
    Map oldItemMaps = await this.dal.getFileInfo(oldFileModel.path);
    FolderModel netOldModel = this.createFolderModel(oldItemMaps);
    String sha = netOldModel.sha;
    String oldPath = netOldModel.path;
    // 1.更新这个新的itemmodel
    var newItem = oldFileModel;
    newItem.title = fileTitle;
    newItem.subtitle = fileSubtitle;
    newItem.content = fileContent;
    var path =
        this.createPath(fileTitle, oldfolderInfo.name, uid, isNormalFolder);
    newItem.path = path;
    newItem.time = DateTime.now().millisecondsSinceEpoch.toDouble();
    // 2.base64编码新的model 【RealGitFileModel】,并获取sha值
    String base64realContent =
        base64Encode(utf8.encode(json.encode(newItem.toJson())));
    // 3.通过dal更新此文件 [这里应该是删除，新建]
    if (titleIsChange) {
      await this.dal.deleteOneFile(oldPath, sha, uid, uemail);
      await this.dal.createFile(newItem.path, base64realContent, uid, uemail);
    } else {
      await this
          .dal
          .updateFile(newItem.path, base64realContent, uid, uemail, sha);
      // 1.获取此文件的path生成db的id值
      var content = Utf8Encoder().convert(newItem.path);
      var digest = md5.convert(content);
      String md5Str = hex.encode(digest.bytes);
      await this.localDal.updateInfo(newItem, md5Str);
    }
    // 4.更新folderinfo信息[根据id替换掉原来的files数组中数据即可]
    CoperationGroupModel newFolderModel = oldfolderInfo;
    newItem.content = "";
    for (int i = 0; i < oldfolderInfo.files.length; i++) {
      if (oldfolderInfo.files[i].id == newItem.id) {
        oldfolderInfo.files.removeAt(i);
        oldfolderInfo.files.add(newItem);
        break;
      }
    }
    // 5.通过当前bll更新folderinfo信息
    await this.updateOneFolder(newFolderModel);
  }

  /// 更新一个文件夹(更新这个文件夹下的folderinfo)
  Future<void> updateOneFolder(CoperationGroupModel newFolderinfo) async {
    // 1.获取folderinfo的sha
    Map result = await this.dal.getFileInfo(newFolderinfo.path);
    FolderModel gitResultModel = this.createFolderModel(result);
    String folderSha = gitResultModel.sha;
    // 2.通过dal更新folderinfo
    var usermodel = await NSLoginGlobal.getInstance().getUserInfo();
    String uid = usermodel.uid;
    String uemail = "451145552@qq.com";
    String base64realFolderContent =
        base64Encode(utf8.encode(json.encode(newFolderinfo.toJson())));
    await this.dal.updateFile(
        newFolderinfo.path, base64realFolderContent, uid, uemail, folderSha);
  }

  /// 获取一个文件的信息(需要此文件的path信息)
  Future<RealGitFileModel> getFileContent(RealGitFileModel itemModel) async {
    // 1.获取此文件的path生成db的id值
    var content = Utf8Encoder().convert(itemModel.path);
    var digest = md5.convert(content);
    String md5Str = hex.encode(digest.bytes);
    // 2.从本地获取，是否存在此信息
    String wheresql = "where id = '$md5Str'";
    List<Map> result = await this.localDal.getInfo(wheresql);
    if (result.length > 0) {
      RealGitFileModel model = RealGitFileModel.fromJson(result.first);
      if (model != null) {
        return model;
      }
    }
    // 3.没有则从网络获取 [获取下来的首先是gitmodel -> content -> base64decode -> realgitfilemodel]
    Map item = await this.dal.getFileInfo(itemModel.path);
    FolderModel newmodel = FolderModel.fromJson(item);
    var data = base64Decode(newmodel.content.replaceAll("\n", ""));
    String contents = utf8.decode(data);
    Map infos = json.decode(contents);
    RealGitFileModel realnewmodel = RealGitFileModel.fromJson(infos);
    // 4.存入数据库[变更id]
    realnewmodel.id = md5Str;
    this.localDal.insertInfo(realnewmodel);
    // 5.返回
    return realnewmodel;
  }

  /// 获取此用户所有的普通文件夹|协同文件夹 列表
  Future<CoperationGroupModel> getOneUsersAllFolders(
      bool isNormalFolder) async {
    // 1.获取path
    var usermodel = await NSLoginGlobal.getInstance().getUserInfo();
    String uid = usermodel.uid;
    String genPath = this.createGenFolderInfoPath(isNormalFolder, uid);
    // 2.获取此path下的信息[由于是文件夹列表，response返回的是一个list]
    Map maps = await this.dal.getFileInfo(genPath);
    FolderModel newmodel = FolderModel.fromJson(maps);
    var data = base64Decode(newmodel.content.replaceAll("\n", ""));
    String contents = utf8.decode(data);
    Map infos = json.decode(contents);
    CoperationGroupModel realnewmodel = CoperationGroupModel.fromJson(infos);
    return realnewmodel;
  }

  /// 获取一个文件夹下面的所有的文件信息（文件不含具体信息，但有摘要）
  Future<CoperationGroupModel> getOneFolderFileLists(
      bool isNormalFolder, String folderName) async {
    // 1.获取path
    var usermodel = await NSLoginGlobal.getInstance().getUserInfo();
    String uid = usermodel.uid;
    String folderRealPath = this.createPath(
        this.defaultFolderFileName, folderName, uid, isNormalFolder);
    // 2.没有则从网络获取 [获取下来的首先是gitmodel -> content -> base64decode -> realgitfilemodel]
    Map item = await this.dal.getFileInfo(folderRealPath);
    FolderModel newmodel = FolderModel.fromJson(item);
    var data = base64Decode(newmodel.content.replaceAll("\n", ""));
    String contents = utf8.decode(data);
    Map infos = json.decode(contents);
    CoperationGroupModel realnewmodel = CoperationGroupModel.fromJson(infos);
    return realnewmodel;
  }

  /// 创建一个 “最新” 文件夹下的文件
  Future<void> createNewestFolderFile(
    String fileContent,
    String title,
    String subTitle,
  ) async {
    // 1.获取最新文件夹
    var itemName = "最新";
    var result = await this.getOneFolderFileLists(true, itemName);
    // 2.创建之
    await this.createFile(true, result, fileContent, title, subTitle);
  }

  /// 获取gen文件的path
  String createGenFolderInfoPath(bool isnormalfolder, String uid) {
    String normalFolder = "Folders";
    String coperationFolder = "Groups";
    if (isnormalfolder) {
      //普通文件夹gen文件
      return "$uid/$normalFolder/$defaultFolderFileName";
    } else {
      //协同文件夹gen文件
      return "$uid/$coperationFolder/$defaultFolderFileName";
    }
  }

  /// 判定是否存在gen文件信息 true: 存在
  Future<CoperationGroupModel> analyzeISExistGenFolderInfo(
      bool isNormalFolder) async {
    var userinfo = await NSLoginGlobal.getInstance().getUserInfo();
    var path = this.createGenFolderInfoPath(isNormalFolder, userinfo.uid);
    Map exist = await this.dal.getFileInfo(path);
    if (exist.keys.length == 0) {
      return null;
    } else {
      FolderModel newmodel = FolderModel.fromJson(exist);
      var data = base64Decode(newmodel.content.replaceAll("\n", ""));
      String contents = utf8.decode(data);
      Map infos = json.decode(contents);
      CoperationGroupModel realnewmodel = CoperationGroupModel.fromJson(infos);
      return realnewmodel;
    }
  }

  /// 创建 * 更新  gen-folderinfo （创建某种文件夹的同时修改之）
  Future<void> createGenFolderInfo(
      bool isnormalfolder, CoperationGroupModel folderModel) async {
    String normalFolder = "Folders";
    String coperationFolder = "Groups";
    var userinfo = await NSLoginGlobal.getInstance().getUserInfo();
    var folderName = isnormalfolder ? normalFolder : coperationFolder;
    var oldGenModel = await this.analyzeISExistGenFolderInfo(isnormalfolder);
    if (oldGenModel != null) {
      // 更新
      // 1.将文件夹转为filemodel
      // 2.构造gen folderinfo(将文件添加进去)
      oldGenModel.dirs.add(folderModel);
      // 3.获取sha
      await this.updateOneFolder(oldGenModel);
    } else {
      // 新建
      // 0.获取path
      var path = this.createGenFolderInfoPath(isnormalfolder, userinfo.uid);
      // 1.构造gen-folderinfo this.name, this.id, this.users, this.time, this.files, this.path
      CoperationGroupModel genModel = CoperationGroupModel(
          folderName,
          Uuid().v1(),
          [],
          DateTime.now().millisecondsSinceEpoch.toDouble(),
          [],
          path,
          [folderModel]);
      String base64realFolderContent =
          base64Encode(utf8.encode(json.encode(genModel.toJson())));
      // 3.创建之
      await this.dal.createFile(
          path, base64realFolderContent, userinfo.uid, "451145552@qq.com");
    }
  }
}
