extension FlattenListExtension<U> on List<Iterable<U>> {
  List<U> flatten() {
    return expand((e) => e).toList();
  }
}
