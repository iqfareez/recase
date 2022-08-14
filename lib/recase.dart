/// An instance of text to be re-cased.
class ReCase {
  final RegExp _upperAlphaRegex = RegExp(r'[A-Z]');

  final symbolSet = {' ', '.', '/', '_', '\\', '-'};

  late String originalText;
  late List<String> _words;

  ReCase(String text) {
    this.originalText = text;
    this._words = _groupIntoWords(text);
  }

  List<String> _groupIntoWords(String text) {
    StringBuffer sb = StringBuffer();
    List<String> words = [];
    bool isAllCaps = text.toUpperCase() == text;

    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      String? nextChar = i + 1 == text.length ? null : text[i + 1];

      if (symbolSet.contains(char)) {
        continue;
      }

      sb.write(char);

      bool isEndOfWord = nextChar == null ||
          (_upperAlphaRegex.hasMatch(nextChar) && !isAllCaps) ||
          symbolSet.contains(nextChar);

      if (isEndOfWord) {
        words.add(sb.toString());
        sb.clear();
      }
    }

    return words;
  }

  /// camelCase
  String get camelCase => _getCamelCase();

  /// CONSTANT_CASE
  String get constantCase => _getConstantCase();

  /// Sentence case
  String get sentenceCase => _getSentenceCase();

  /// snake_case
  String get snakeCase => _getSnakeCase();

  /// dot.case
  String get dotCase => _getSnakeCase(separator: '.');

  /// param-case
  String get paramCase => _getSnakeCase(separator: '-');

  /// path/case
  String get pathCase => _getSnakeCase(separator: '/');

  /// PascalCase
  String get pascalCase => _getPascalCase();

  /// Header-Case
  String get headerCase => _getPascalCase(separator: '-');

  /// Title Case
  String get titleCase => _getPascalCase(separator: ' ');

  String _getCamelCase({String separator: ''}) {
    List<String> words = this._words.map(_upperCaseFirstLetter).toList();
    if (_words.isNotEmpty) {
      words[0] = words[0].toLowerCase();
    }

    return words.join(separator);
  }

  String _getConstantCase({String separator: '_'}) {
    List<String> words = this._words.map((word) => word.toUpperCase()).toList();

    return words.join(separator);
  }

  String _getPascalCase({String separator: ''}) {
    List<String> words = this._words.map(_upperCaseFirstLetter).toList();
    words = words.map(_uppercaseRomanCharacter).toList();
    words = words.map(_reservedWords).toList();

    // words but excluding the first word
    if (_words.isNotEmpty) {
      List<String> wordsSublist = words.sublist(1, words.length);
      words = [words[0], ...wordsSublist.map(_englishSpecialTerm)];
    }

    return words.join(separator);
  }

  String _getSentenceCase({String separator: ' '}) {
    List<String> words = this._words.map((word) => word.toLowerCase()).toList();
    if (_words.isNotEmpty) {
      words[0] = _upperCaseFirstLetter(words[0]);
    }

    return words.join(separator);
  }

  String _getSnakeCase({String separator: '_'}) {
    List<String> words = this._words.map((word) => word.toLowerCase()).toList();

    return words.join(separator);
  }

  String _upperCaseFirstLetter(String word) {
    return '${word.substring(0, 1).toUpperCase()}${word.substring(1).toLowerCase()}';
  }

  /// Uppercase letter if roman character is found.
  String _uppercaseRomanCharacter(String word) {
    // list of number in romans
    List<String> romanNumerals = [
      'I',
      'II',
      'III',
      'IV',
      'V',
      'VI',
      'VII',
      'VIII'
    ];

    if (romanNumerals.contains(word.toUpperCase())) {
      return word.toUpperCase();
    }
    return word;
  }

  /// Reserved terms that always CAPS
  String _reservedWords(String word) {
    List<String> terms = ['ENM', 'IT'];

    if (terms.contains(word.toUpperCase())) {
      return word.toUpperCase();
    }
    return word; // return untouched
  }

  /// English terms that don't need capitalization
  String _englishSpecialTerm(String word) {
    List<String> englishTerms = [
      'a',
      'an',
      'and',
      'as',
      'at',
      'but',
      'of',
      'for',
      'to',
      'in',
      'the',
    ];
    if (englishTerms.contains(word.toLowerCase())) {
      return word.toLowerCase();
    }
    return word; // return untouched
  }
}

extension StringReCase on String {
  String get camelCase => ReCase(this).camelCase;

  String get constantCase => ReCase(this).constantCase;

  String get sentenceCase => ReCase(this).sentenceCase;

  String get snakeCase => ReCase(this).snakeCase;

  String get dotCase => ReCase(this).dotCase;

  String get paramCase => ReCase(this).paramCase;

  String get pathCase => ReCase(this).pathCase;

  String get pascalCase => ReCase(this).pascalCase;

  String get headerCase => ReCase(this).headerCase;

  String get titleCase => ReCase(this).titleCase;
}
