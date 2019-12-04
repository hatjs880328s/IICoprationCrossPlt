import 'package:json_annotation/json_annotation.dart';
/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'gitcmdshowmodel.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class GitCMDShowModel {
  GitCMDShowModel(
    this.cmdtype,
    this.sender, 
    this.reveiver, 
    this.cmdid,
    this.time,
    this.groupid,
    this.nickname,
    this.name
    );
  String cmdid;
  String sender;
  String reveiver;
  int cmdtype;
  double time;
  String groupid;
  String nickname;
  String name;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory GitCMDShowModel.fromJson(Map<String, dynamic> json) => _$GitCMDShowModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$GitCMDShowModelToJson(this);

  String getTime() {
    var date = DateTime.fromMillisecondsSinceEpoch(this.time.toInt());
    return "${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}";
  }

  /// 根据cmd指令枚举获取指令文本信息
  String getRealCMDStr() {
    switch (this.cmdtype) {
      case 0: return "邀请加入";
      case 1: return "同意回执";
      case 2: return "拒绝回执";
    }
  }
}

