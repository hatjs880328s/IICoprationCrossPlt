import 'package:json_annotation/json_annotation.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'coperationgroupmodel.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class CoperationGroupModel {
  CoperationGroupModel(this.name, this.id, this.users, this.time, this.files, this.path);

  String name;
  String id;
  List<String> users;
  double time;
  List<RealGitFileModel> files;
  String path;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory CoperationGroupModel.fromJson(Map<String, dynamic> json) => _$CoperationGroupModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$CoperationGroupModelToJson(this);

  /// 根据自身创建一个fileModel gen folder使用
  RealGitFileModel establishFileModel() {

    //RealGitFileModel(this.id, this.content, this.time, this.img, this.title, this.subtitle, this.path);
    RealGitFileModel filemodel = RealGitFileModel(
      this.id,
      "",
      this.time,
      "",
      this.name,
      "",
      this.path,
    );

    return filemodel;
  }

}