class LoginSupport {
  static const LoginSupport none = LoginSupport();

  final bool googleEnabled;
  final bool emailEnabled;
  final bool twitterEnabled;
  final bool facebookEnabled;
  final bool appleEnabled;
  final bool phoneEnabled;
  final bool emailLinkEnabled;

  const LoginSupport({
    this.googleEnabled = false,
    this.emailEnabled = false,
    this.twitterEnabled = false,
    this.facebookEnabled = false,
    this.appleEnabled = false,
    this.phoneEnabled = false,
    this.emailLinkEnabled = false,
  });
}
