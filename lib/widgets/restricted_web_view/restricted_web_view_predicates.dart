mixin WebViewPredicates {
  static bool Function(String) predicateList(
    List<bool Function(String)> predicateList,
  ) {
    return (String url) {
      for (final predicate in predicateList) {
        if (predicate(url)) {
          return true;
        }
      }
      return false;
    };
  }

  static bool Function(String) startsWithPredicate(List<Pattern> patternList) {
    return (String url) {
      for (final pattern in patternList) {
        if (url.startsWith(pattern)) {
          return true;
        }
      }
      return false;
    };
  }

  static bool Function(String) notStartsWithPredicate(List<Pattern> excludes) {
    return (String url) => !startsWithPredicate(excludes)(url);
  }

  static bool Function(String) containsPredicate(List<Pattern> patterns) {
    return (String url) {
      for (final pattern in patterns) {
        if (url.contains(pattern)) {
          return true;
        }
      }
      return false;
    };
  }

  static bool Function(String) notContainsPredicate(List<Pattern> excludes) {
    return (String url) => !containsPredicate(excludes)(url);
  }

  static bool Function(String) equalsPredicate(List<String> includeList) {
    return (String url) {
      for (final item in includeList) {
        if (url == item) {
          return true;
        }
      }
      return false;
    };
  }

  static bool Function(String) notEqualsPredicate(List<String> excludeList) {
    return (String url) => !equalsPredicate(excludeList)(url);
  }
}
