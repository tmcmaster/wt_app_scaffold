extension StringExtension on String {
  String toLowerCamelCase() {
    final noSpaces = replaceAll(' ', '').replaceAll(':', '');
    return noSpaces.isNotEmpty ? noSpaces[0].toLowerCase() + noSpaces.substring(1) : '';
  }

  String toSettingsKey() {
    return '__${toUpperCase().replaceAll(' ', '_')}__';
  }
}
