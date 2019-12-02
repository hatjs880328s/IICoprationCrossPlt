import 'package:json_annotation/json_annotation.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginglobal.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginmodel.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'foldermodel.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class FolderModel {
  FolderModel(this.folderid, this.name, this.description, this.content, this.createtime, this.changetime, this.users, this.type);

  String folderid;
  String name;
  String description;
  String content;
  double createtime;
  double changetime;
  String users;
  int type;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory FolderModel.fromJson(Map<String, dynamic> json) => _$FolderModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$FolderModelToJson(this);

  /// 判定是否是自己创建
  Future<bool> isSelfCreate() async {
    NSLoginModel model = await NSLoginGlobal.getInstance().getUserInfo();
    return users.split(',').first.contains(model.userid);
  }

  // 获取标题
  String getTitleInfo() {
    return this.name.split("EXEOF").first;
  }

  // 获取日期格式化信息
  String getCreateTime() {
    //var realTime = DateTime.fromMillisecondsSinceEpoch(this.)
    int lastTime = this.name.split("EXEOF").length;
    if (lastTime == 1) {
      DateTime time = DateTime.now();
      return "${time.year}年${time.month}月${time.day}日";
    }
    int millSec = int.parse(this.name.split("EXEOF").last.toString());
    DateTime time = DateTime.fromMillisecondsSinceEpoch(millSec);
    return "${time.year}年${time.month}月${time.day}日";
  }
}