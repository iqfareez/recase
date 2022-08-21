# ReCase

## My changes

- Optimize **Title Case**
  - Roman character UPPERCASE
  - Reserved keywords UPPERCASE
  - English preposition lowercase

## Contributing

1. Fork this repository.
1. Open file `lib/recase.dart`.
1. Modify the entry in `_englishSpecialTerm` function. The list contains English prepositions that should be lowercase all the time, except when it is located at the beginning of a sentence.
1. Or, modify the words in `_reservedWords` function. It is the phrase that has always been capitalized. Eg: IT.
1. `romanNumerals`. Roman numerals. I guess no need to add too much numbers in this entry. However, if it is need, feel free to do so.
1. Use online tools like https://convertcase.net/ to verify the Title Case.
1. Run test in `test/recase_test.dart` (Only the **Title Case** group).
1. Open a PR for your fixes.

---

Changes the case of the input text to the desire case convention.

    import 'package:recase/recase.dart';

    void main() {
      ReCase rc = new ReCase('Just_someSample-text');

      print(rc.camelCase); // Prints 'justSomeSampleText'
      print(rc.constantCase); // Prints 'JUST_SOME_SAMPLE_TEXT'
    }

String extensions are also available.

    import 'package:recase/recase.dart';

    void main() {
      String sample = 'Just_someSample-text';

      print(sample.camelCase); // Prints 'justSomeSampleText'
      print(sample.constantCase); // Prints 'JUST_SOME_SAMPLE_TEXT'
    }

_This feature is available in version 3.0.0, and requires at least Dart 2.6_

Supports:

- snake_case
- dot.case
- path/case
- param-case
- PascalCase
- Header-Case
- Title Case
- camelCase
- Sentence case
- CONSTANT_CASE
