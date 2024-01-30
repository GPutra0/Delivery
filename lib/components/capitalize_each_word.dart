String capitalizeEachWord(String input) {
  List<String> words = input.split(' ');
  List<String> capitalizedWords = words.map((word) {
    return word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '';
  }).toList();
  return capitalizedWords.join(' ');
}
