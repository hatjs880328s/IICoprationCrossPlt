
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';
import 'package:rebuild_flutter/DAL/newlist/newlistdal.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';

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

  /*
   * 创建一个文件 
   * 
   * 1.创建文件的标题 为    realtitle + time 使用分隔符隔开，获取数据时需要处理
   * 2.创建内容时，是一个model,tojson.tostring()
   */
  Future createFile(
    String content, 
    String title,
      String userid, 
      String folderid,
      String filename) async {

        NewListDAL dal = NewListDAL();
        String title = filename + "EXEOF" + DateTime.now().millisecondsSinceEpoch.toString();
        RealGitFileModel realmodel = RealGitFileModel(
          content, 
          DateTime.now().millisecondsSinceEpoch, 
          "", 
          title, 
          content.substring(0, content.length > 10 ? 10 : content.length - 1));
        await dal.createFile(realmodel.toJson().toString(), userid, folderid, title);
  }
}