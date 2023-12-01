class ScaffoldAppUser {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final bool authenticated;

  ScaffoldAppUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.authenticated,
  });

  factory ScaffoldAppUser.empty() {
    return ScaffoldAppUser(
      id: '',
      firstName: '',
      lastName: '',
      authenticated: false,
      email: '',
    );
  }
  String get name => '$firstName $lastName'.trim();
}
