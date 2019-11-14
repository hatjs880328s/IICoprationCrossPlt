class APIStruct {
  /*
   目前的目录结构为：project/userid/folder/file.txt
  */
  static String authHeaderInfo = "QmVhcmVyIGNkMDBkNzEwMTRhZDhiNjZlNGQ0Yzk2OTgyYTdlYTBhZWJlNzNkNTE=";

  static String authSubInfo = "application/vnd.github.squirrel-girl-preview";

  /// 获取某人的所有文件夹[需要自己处理path,此url只到uid之前]
  static String gitAPINormalURL = "https://api.github.com/repos/hatjs880328s/FlutterContent/contents/";

}