import 'package:json_annotation/json_annotation.dart';
import 'package:rebuild_flutter/MODEL/Newfile/filegitcommitsmallmodel.dart';
/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'filegitcommitmodel.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class FileGitCommitModel {
  FileGitCommitModel(
    this.message, 
    this.content, 
    this.committer,
    this.sha
    );

  manualInit(String message, String content, FileGitCommitSmallModel model) {
    this.content = content;
    this.message = message;
    this.committer = model;
  }

  manualInitHaveSha(String message, String content, FileGitCommitSmallModel model, String sha) {
    this.content = content;
    this.message = message;
    this.committer = model;
    this.sha = sha;
  }

  String message;
  String content;
  FileGitCommitSmallModel committer;
  String sha;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory FileGitCommitModel.fromJson(Map<String, dynamic> json) => _$FileGitCommitModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$FileGitCommitModelToJson(this);
}
