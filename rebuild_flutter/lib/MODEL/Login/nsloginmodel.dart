import 'package:json_annotation/json_annotation.dart';
/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'nsloginmodel.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class NSLoginModel {
  NSLoginModel(
    this.uid, 
    this.nickname, 
    this.icon);

  manualInit(String uid, String nickname, String icon) {
    this.uid = uid;
    this.nickname = nickname;
    this.icon = icon;
  }

  String uid;
  String nickname;
  String icon;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory NSLoginModel.fromJson(Map<String, dynamic> json) => _$NSLoginModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$NSLoginModelToJson(this);
}
