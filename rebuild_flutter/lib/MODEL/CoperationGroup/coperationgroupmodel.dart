import 'package:json_annotation/json_annotation.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginglobal.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'coperationgroupmodel.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class CoperationGroupModel {
  CoperationGroupModel(this.name, this.id, this.users, this.time, this.files, this.path, this.dirs);

  String name;
  String id;
  List<String> users;
  double time;
  List<RealGitFileModel> files;
  List<CoperationGroupModel> dirs;
  String path;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory CoperationGroupModel.fromJson(Map<String, dynamic> json) => _$CoperationGroupModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$CoperationGroupModelToJson(this);

  String getCreateTime() {
    var time = DateTime.fromMillisecondsSinceEpoch(this.time.toInt());
    return "${time.year}.${time.month}.${time.day}";
  }

  /// 判定创建者是否是自己
  Future<bool> isSelfCreator() async {
    var user = await NSLoginGlobal.getInstance().getUserInfo();
    var realuid = user.uid;
    return realuid == this.users.first;
  }

}