import 'package:rebuild_flutter/DAL/newlist/newlistlocaldal.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSShare/nsahresdk.dart';

/*
 * app启动服务类
 */
class NSAPPConfig {

  /// 基础服务启动与表创建
  static Future<void> startService() async {

    /// 表创建
    NewListLocalDAL dal = NewListLocalDAL();
    await dal.createNewListTab();

    /// mod注册
    NSShareSDK().sharesdkConfig();
  }
}