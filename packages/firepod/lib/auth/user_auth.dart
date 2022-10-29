class UserAuth {
  static const UserAuth none = UserAuth(uuid: '', name: '', email: '');

  final String uuid;
  final String name;
  final String email;

  const UserAuth({
    required this.uuid,
    required this.name,
    required this.email,
  });
}
