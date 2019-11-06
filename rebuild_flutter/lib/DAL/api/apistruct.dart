class APIStruct {
  /*
   目前的目录结构为：project/userid/folder/file.txt
  */
  static String authHeaderInfo = "QmVhcmVyIGNkMDBkNzEwMTRhZDhiNjZlNGQ0Yzk2OTgyYTdlYTBhZWJlNzNkNTE=";

  static String authSubInfo = "application/vnd.github.squirrel-girl-preview";




  /// 获取某人的所有文件夹
  static String getFolderapi = "https://api.github.com/repos/hatjs880328s/FlutterContent/contents/{uid}/Folders/";

  /// 获取某人的最新文件夹下面的数据
  static String getNewestFileListapi = "https://api.github.com/repos/hatjs880328s/FlutterContent/contents/{uid}/Folders/最新";

  /// 获取某人的某个文件夹下面的数据
  static String getSomeoneFolderFileListapi = "https://api.github.com/repos/hatjs880328s/FlutterContent/contents/{uid}/Folders/{fid}";

  /// 创建一个文件
  static String createFile = "https://api.github.com/repos/hatjs880328s/FlutterContent/contents/{uid}/{folderorgroup}/{folderid}/{filename}";

  /// 获取某一个文件详细内容的api
  static String getOneItemapi = "https://api.github.com/repos/hatjs880328s/FlutterContent/contents/";




  /// 创建一个文件夹
  static String createFolder = "https://api.github.com/repos/hatjs880328s/FlutterContent/contents/{uid}/Folders/{foldername}/{filename}";




  /// 创建一个协同组
  static String createCoperationGroup = "https://api.github.com/repos/hatjs880328s/FlutterContent/contents/{uid}/Groups/{groupname}/{filename}";

  /// 获取某个协同组信息
  static String getCoperitionGroups = "https://api.github.com/repos/hatjs880328s/FlutterContent/contents/{uid}/Groups/{coperid}/{filename}";

  /// 获取所有协同组
  static String getALLCoperitionGroups = "https://api.github.com/repos/hatjs880328s/FlutterContent/contents/{uid}/Groups";

}