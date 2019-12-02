import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// document: https://pub.dev/packages/sqflite#-readme-tab-


class NewListLocalDAL {

  Database db;

  bool openDBAlready = false;

  String tabName = "FileAndFolderTab";

  /// 打开数据库
  Future<void> _openDB() async {
    if (openDBAlready) { return; }
    var dbpath = await getDatabasesPath();
    String path = join(dbpath, 'rebuild_flutter.db');
    db = await openDatabase(path);
    openDBAlready = true;
  }

  /// 关闭数据库
  Future<void> closeDB() async {
    await db.close();
  }

  /*
   * 创建文件数据表 
   */
  Future<void> createNewListTab() async {
    await _openDB();
    // String sql = "CREATE TABLE IF NOT EXISTS " + tabName +
    // " (fileid varchar(70) PRIMARY KEY, name varchar(70), description varchar(100),  content TEXT, time REAL, title varchar(100), subtitle varchar(100))";
    // this.db.execute(sql);
  }

  /// 插入数据【事务处理】Returns the last inserted record id
  Future<void> insertInfo(RealGitFileModel model) async {
    await _openDB();
    // String sql = "insert into " + tabName + 
    // "  values ('${model.fileid}', '${model.content}', ${model.time}, '${model.title}', '${model.subtitle}')";
    // await db.transaction((txn) async {
    //   await txn.rawInsert(sql);
    // });
  }

  /// 更新数据
  Future<void> updateInfo(RealGitFileModel model, String id) async {
    await _openDB();
    String sql = "update " + tabName + " set content = '${model.content}' where id = '$id'";
    await db.rawUpdate(sql);
  }

  /// 查找
  Future<List<Map>> getInfo(String whereSql) async {
    await _openDB();
    String sql =  "select * from " + tabName + " " + whereSql;
    List<Map> result = await db.rawQuery(sql);
    return result;
  }

  /// 删除
  Future<bool> deleteInfo(String whereSql) async {
    await _openDB();
    String sql = "delete from $tabName $whereSql";
    int result = await db.rawDelete(sql);
    return result == 1;
  }
  
}