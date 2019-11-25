import 'package:json_annotation/json_annotation.dart';
import 'package:rebuild_flutter/BLL/gitbll/gitcmdprogressbll.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginmodel.dart';
/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'gitcmdmodel.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class GitCMDModel {
  GitCMDModel(
    this.sender, 
    this.receiver, 
    this.cmd,
    this.time,
    this.group,
    );

  NSLoginModel sender;
  NSLoginModel receiver;
  CMDType cmd;
  double time;
  CoperationGroupModel group;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory GitCMDModel.fromJson(Map<String, dynamic> json) => _$GitCMDModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$GitCMDModelToJson(this);

  String getTime() {
    var date = DateTime.fromMillisecondsSinceEpoch(this.time.toInt());
    return "${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}";
  }

  /// 根据cmd指令枚举获取指令文本信息
  String getRealCMDStr() {
    switch (this.cmd) {
      case CMDType.invite: return "邀请指令";
      case CMDType.inviteresultno: return "拒绝指令";
      case CMDType.inviteresultok: return "接收指令";
    }
  }
}
