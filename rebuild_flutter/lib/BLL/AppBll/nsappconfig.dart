import 'package:rebuild_flutter/DAL/newlist/newlistlocaldal.dart';

/*
 * app启动服务类
 */
class NSAPPConfig {

  /// 基础服务启动与表创建
  static Future<void> startService() async {
    NewListLocalDAL dal = NewListLocalDAL();
    await dal.createNewListTab();
  }
}