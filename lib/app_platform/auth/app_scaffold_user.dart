import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_scaffold_user.freezed.dart';
part 'app_scaffold_user.g.dart';

@freezed
class AppScaffoldUser with _$AppScaffoldUser {
  const factory AppScaffoldUser({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required bool authenticated,
  }) = _AppScaffoldUser;

  const AppScaffoldUser._();

  factory AppScaffoldUser.fromJson(Map<String, dynamic> json) =>
      _$AppScaffoldUserFromJson(json);

  factory AppScaffoldUser.empty() {
    return const AppScaffoldUser(
      id: '',
      firstName: '',
      lastName: '',
      authenticated: false,
      email: '',
    );
  }

  String get name => '$firstName $lastName'.trim();
}
