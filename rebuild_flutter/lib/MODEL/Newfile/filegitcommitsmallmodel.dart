import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'filegitcommitsmallmodel.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class FileGitCommitSmallModel {
  FileGitCommitSmallModel(
    this.name, 
    this.email);

  manualInit(String name, String email) {
    this.name = name;
    this.email = email;
  }

  String name;
  String email;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory FileGitCommitSmallModel.fromJson(Map<String, dynamic> json) => _$FileGitCommitSmallModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$FileGitCommitSmallModelToJson(this);
}
