class SortingFunctions {
  void sort() {
    // Define the custom language alphabet
    String languageAlphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    // Create a mapping of each character to its position
    Map<String, int> alphabetOrder = {for (int i = 0; i < languageAlphabet.length; i++) languageAlphabet[i]: i};

    // Function to get the position of a character
    int getCharPosition(String char) {
      return alphabetOrder[char.toUpperCase()] ?? double.infinity.toInt();
    }

    // Function to compare two strings
    int customComparator(String a, String b) {
      int length = a.length < b.length ? a.length : b.length;
      for (int i = 0; i < length; i++) {
        int posA = getCharPosition(a[i]);
        int posB = getCharPosition(b[i]);
        if (posA != posB) {
          return posA.compareTo(posB);
        }
      }
      return a.length.compareTo(b.length);
    }

    // Sample list of strings
    List<String> strings = ['Banana', 'Apple', 'Cherry', 'Date'];

    // Sort the list using the custom comparator
    strings.sort(customComparator);
  }
}
