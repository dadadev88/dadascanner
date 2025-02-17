extension StringExtension on String {
  String capitalizeWords() {
    return this.split(' ').map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }
      return word;
    }).join(' ');
  }

  String padWithZeros(int n) {
    return this.padLeft(n, '0');
  }
}
