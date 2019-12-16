import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'realgitfilemodel.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class RealGitFileModel {
  RealGitFileModel(this.content, this.createtime, this.images, 
  this.name, this.description, this.fileid, this.folderid, this.changetime, this.currentowner, this.creator);

  String content;
  String images;
  String name;
  String description;
  String fileid;
  String folderid;
  double createtime;
  double changetime;
  String currentowner;
  String creator;



  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory RealGitFileModel.fromJson(Map<String, dynamic> json) => _$RealGitFileModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$RealGitFileModelToJson(this);

  // 获取标题
  String getTitleInfo() {
    return this.name;
  }

  // 获取创建时间
  String getCreateTime() {
    var timeStr = DateTime.fromMillisecondsSinceEpoch(this.createtime.toInt());
    return "${timeStr.year}年${timeStr.month}月${timeStr.day}日";
  }

  // 获取最后修改时间
  String getLstChangeTime() {
    var timeStr = DateTime.fromMillisecondsSinceEpoch(this.changetime.toInt());
    return "${timeStr.year}年${timeStr.month}月${timeStr.day}日";
  }
}