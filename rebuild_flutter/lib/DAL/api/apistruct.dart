class APIStruct {
  /*
   目前的目录结构为：project/userid/folder/file.txt
  */
  static String authHeaderInfo = "QmVhcmVyIGNkMDBkNzEwMTRhZDhiNjZlNGQ0Yzk2OTgyYTdlYTBhZWJlNzNkNTE=";

  static String authSubInfo = "application/vnd.github.squirrel-girl-preview";

  /// 获取某人的所有文件夹
  static String getFolderapi = "https://api.github.com/repos/hatjs880328s/FlutterContent/contents/";

  /// 获取某人的最新文件夹下面的数据
  static String getNewestFileListapi = "https://api.github.com/repos/hatjs880328s/FlutterContent/contents/{uid}/最新";

  /// 获取某人的某个文件夹下面的数据
  static String getSomeoneFolderFileListapi = "https://api.github.com/repos/hatjs880328s/FlutterContent/contents/{uid}/{fid}";

  /// 创建一个文件
  static String createFile = "https://api.github.com/repos/hatjs880328s/FlutterContent/contents/{uid}/{folderid}/{filename}";

  /// 获取某一个文件详细内容的api
  static String getOneItemapi = "https://api.github.com/repos/hatjs880328s/FlutterContent/contents/";
}