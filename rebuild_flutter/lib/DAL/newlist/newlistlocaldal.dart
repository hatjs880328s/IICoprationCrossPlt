import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// document: https://pub.dev/packages/sqflite#-readme-tab-


class NewListLocalDAL {

  Database db;

  /// 打开数据库
  Future<void> openDB() async {
    var dbpath = await getDatabasesPath();
    String path = join(dbpath, 'rebuild_flutter.db');
    db = await openDatabase(path);
  }

  /// 关闭数据库
  Future<void> closeDB() async {
    await db.close();
  }

  /*
   * 创建文件数据表 
   */
  Future<void> createNewListTab() async {
    await openDB();
    String sql = "CREATE TABLE IF NOT EXISTS FileAndFolderTab" +
    " (id varchar(100) PRIMARY KEY, content TEXT, time REAL, title varchar(100), subtitle varchar(100))";
    this.db.execute(sql);
  }

  
}