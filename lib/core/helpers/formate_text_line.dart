List<String> formatText(String text) {
  return text
      .split('*')
      .where((line) => line.trim().isNotEmpty)
      .map((line) => '* $line')
      .toList();
}
