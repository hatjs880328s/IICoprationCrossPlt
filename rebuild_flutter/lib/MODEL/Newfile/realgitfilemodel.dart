import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'realgitfilemodel.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class RealGitFileModel {
  RealGitFileModel(this.id, this.content, this.time, this.img, this.title, this.subtitle, this.path);

  String content;
  double time;
  String img;
  String title;
  String subtitle;
  String id;
  String path;

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
    return this.title;
  }

  // 获取日期格式化信息
  String getCreateTime() {
    int lastTime = this.title.split("EXEOF").length;
    if (lastTime == 1) {
      DateTime time = DateTime.now();
      return "${time.year}年${time.month}月${time.day}日";
    }
    int millSec = int.parse(this.title.split("EXEOF").last.toString());
    DateTime time = DateTime.fromMillisecondsSinceEpoch(millSec);
    return "${time.year}年${time.month}月${time.day}日";
  }
}