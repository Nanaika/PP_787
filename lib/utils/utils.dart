extension StringExtensions on String {
  /// Капитализация первой буквы строки
  String capitalizeFirst() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
