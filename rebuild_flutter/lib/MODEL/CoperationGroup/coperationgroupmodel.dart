import 'package:json_annotation/json_annotation.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginglobal.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'coperationgroupmodel.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class CoperationGroupModel {
  CoperationGroupModel(
    this.folderid, 
    this.name, 
    this.description, 
    this.content, 
    this.createtime, 
    this.changetime, 
    this.users, 
    this.type, 
    this.realFiles, 
    this.realUsers);

  String folderid;
  String name;
  String description;
  String content;
  double createtime;
  double changetime;
  String users;
  int type;
  List<NSLoginModel> realUsers;
  List<RealGitFileModel> realFiles;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory CoperationGroupModel.fromJson(Map<String, dynamic> json) => _$CoperationGroupModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$CoperationGroupModelToJson(this);

  String getCreateTime() {
    var time = DateTime.fromMillisecondsSinceEpoch(this.createtime.toInt());
    return "${time.year}.${time.month}.${time.day}";
  }

  /// 判定创建者是否是自己
  Future<bool> isSelfCreator() async {
    // var user = await NSLoginGlobal.getInstance().getUserInfo();
    // var realuid = user.userid;
    // return realuid == this.users.first;
    return false;
  }

}