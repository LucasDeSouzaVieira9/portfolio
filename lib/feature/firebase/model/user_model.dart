import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
  }) = _UserModel;
  UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fixture() => UserModel(
      id: '01G41W78657GEBEFAG6D8NDWK5',
      email: 'fakeUser@gmail.com',
      firstName: 'Daniel',
      lastName: 'Santos');
}
