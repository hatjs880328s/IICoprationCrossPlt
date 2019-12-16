class APIStruct {
  /*
   目前的目录结构为：project/userid/folder/file.txt
  */
  static String authHeaderInfo = "QmVhcmVyIGNkMDBkNzEwMTRhZDhiNjZlNGQ0Yzk2OTgyYTdlYTBhZWJlNzNkNTE=";

  static String authSubInfo = "application/vnd.github.squirrel-girl-preview";

  /// 获取某人的所有文件夹[需要自己处理path,此url只到uid之前]
  static String gitAPINormalURL = "https://api.github.com/repos/hatjs880328s/FlutterContent/contents/";

  /// 远程服务API-IP 
  /// debug: http://127.0.0.1:8081/
  /// release: http://106.54.5.12:8081/
  static String remoteServerIP = 'http://106.54.5.12:8081/';


  /// user处理
  static String createUser = '${APIStruct.remoteServerIP}user';

  /// 获取 & 更新用户信息
  static String getUser = '${APIStruct.remoteServerIP}user/:id';



  /// CMD创建
  static String createCMD = '${APIStruct.remoteServerIP}CMD';

  /// 获取 & 更新CMD信息
  static String getCMD = '${APIStruct.remoteServerIP}CMD/:id';

  /// 指令的处理
  static String progressCMD = '${APIStruct.remoteServerIP}CMD/:id';



  /// file创建
  static String createFile = '${APIStruct.remoteServerIP}file';

  /// 获取 & 更新file信息
  static String getFile = '${APIStruct.remoteServerIP}file/:id';

  /// 获取此用户最新文件夹下files - folderid = ''
  static String getNewestsFile = '${APIStruct.remoteServerIP}files/:id';



  /// 文件夹创建
  static String createFolder = '${APIStruct.remoteServerIP}folder';

  /// 获取 & 更新文件夹信息
  static String getFolder = '${APIStruct.remoteServerIP}folder/:id';

  /// 获取某个文件夹下的所有文件
  static String getOneFoldersFiles = '${APIStruct.remoteServerIP}folder/content/:id';

  /// 根据用户id获取此用户所有的文件夹 - 需要区分普通&协同
  static String getOneUserFolders = '${APIStruct.remoteServerIP}folders/:id/:type';

  /// 获取协同组信息
  static String getCoperationFolder = '${APIStruct.remoteServerIP}coperationgroup/:id';



  /// 文件是否可以编辑
  static String fileCouldEdit = '${APIStruct.remoteServerIP}editfile/:fileid/:userid';

  /// 文件接触编辑锁
  static String fileUnlock = '${APIStruct.remoteServerIP}editfile/:fileid';

}