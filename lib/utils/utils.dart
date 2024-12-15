extension StringExtensions on String {
  /// Капитализация первой буквы строки
  String capitalizeFirst() {
    if (this.isEmpty) return this;
    return this[0].toUpperCase() + this.substring(1);
  }
}
