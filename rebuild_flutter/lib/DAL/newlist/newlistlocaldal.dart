//import 'package:sqflite/sqflite.dart';

class NewListLocalDAL {

  /*
   * 创建文件数据表 
   */
  Future<void> createNewListTab() async {
    // 获取数据库文件的存储路径
    // var databasesPath = await getDatabasesPath();
    // String path = databasesPath.//join(databasesPath, 'demo.db');

//根据数据库文件路径和数据库版本号创建数据库表
    // var db = await openDatabase(path, version: 1,
    //     onCreate: (Database db, int version) async {
    //   await db.execute('''
    //       CREATE TABLE $tableBook (
    //         $columnId INTEGER PRIMARY KEY, 
    //         $columnName TEXT, 
    //         $columnAuthor TEXT, 
    //         $columnPrice REAL, 
    //         $columnPublishingHouse TEXT)
    //       ''');
    // });
  }
}