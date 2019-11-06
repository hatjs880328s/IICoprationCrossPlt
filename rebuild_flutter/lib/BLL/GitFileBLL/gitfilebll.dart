
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:rebuild_flutter/DAL/Folder/folderdal.dart';
import 'package:rebuild_flutter/DAL/newlist/newlistlocaldal.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginglobal.dart';
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';
import 'package:rebuild_flutter/DAL/newlist/newlistdal.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';
import 'package:uuid/uuid.dart';
import 'package:crypto/crypto.dart';

class GitFileBLL {

  /// db - dal
  NewListLocalDAL localDal = NewListLocalDAL();

  /*
   * 创建一个文件 
   * 
   * 1.创建文件的标题 为    realtitle + time 使用分隔符隔开，获取数据时需要处理
   * 2.创建内容时，是一个model,tojson.tostring()
   */
  Future createFile(
    String content, 
      String folderid,
      String filename) async {

        var model = await NSLoginGlobal.getInstance().getUserInfo();
        String uid = model.uid;
        NewListDAL dal = NewListDAL();
        String title = filename + "EXEOF" + DateTime.now().millisecondsSinceEpoch.toString();
        RealGitFileModel realmodel = RealGitFileModel(
          new Uuid().v1(),
          content, 
          DateTime.now().millisecondsSinceEpoch.toDouble(), 
          "", 
          title, 
          content.substring(0, content.length > 10 ? 10 : content.length - 1));
        await dal.createFile(json.encode(realmodel.toJson()), uid, folderid, title);
  }

  /*
   * 获取一个文件的具体内容 
   * 
   * 本地数据使用 - 根据path的md5（就是item的id)查找本地数据库
   * 网络数据，获取下来需要存储到本地数据库，path的md5值就是id,需要设置
   */
  Future<RealGitFileModel> getOneFileContent(String path) async {
    var content = Utf8Encoder().convert(path);
    var digest = md5.convert(content);
    String md5Str = hex.encode(digest.bytes);

    //先从本地取
    String wheresql = "where id = '$md5Str'";
    List<Map> result = await this.localDal.getInfo(wheresql);
    if (result.length > 0) {
      RealGitFileModel model = RealGitFileModel.fromJson(result.first);
      if (model != null) { return model; }
    }
    //再从网络取[获取下来的首先是gitmodel -> content -> base64decode -> realgitfilemodel]
    FolderDAL dal = FolderDAL();
    Map item = await dal.getOneItem(path);
    FolderModel newmodel = FolderModel.fromJson(item);
    
    var data = base64Decode(newmodel.content.replaceAll("\n", ""));
    String contents = utf8.decode(data);
    Map infos = json.decode(contents);
    //插入数据库
    RealGitFileModel realnewmodel = RealGitFileModel.fromJson(infos);
    realnewmodel.id = md5Str;
    this.localDal.insertInfo(realnewmodel);
    //返回
    return realnewmodel;
  }
}