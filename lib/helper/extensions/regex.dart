import 'package:flutter/rendering.dart';

RegExp signedNumRegex = RegExp(r'(?<!\S)-?\d+(?:\.\d+)?(?!\S)');

RegExp urlLauncherRegex = RegExp(r'(?:mailto|http|ftp|file|tel|sms|www).*?(?:\s|$)');

RegExp phoneNumRegex = RegExp(r'\b(\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{3}\)?[\s.\-]?\d{3}[\s.\-]?\d{4}\b');

RegExp emailRegex = RegExp(r'([a-zA-Z0-9+._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+)');

bool isWebsite(String input) {
  final RegExp urlRegex = RegExp(
    r'^((ftp|http|https):\/\/)?(www.)?(?!.*(ftp|http|https|www.))[a-zA-Z0-9_-]+(\.[a-zA-Z]+)+((\/)[\w#]+)*(\/\w+\?[a-zA-Z0-9_]+=\w+(&[a-zA-Z0-9_]+=\w+)*)?\/?$',
    caseSensitive: false,
  );

  return urlRegex.hasMatch(input);
}

List<InlineSpan> regMapper(String input, Map<RegExp, InlineSpan Function(String word)> regmap) {
  regmap.addAll({RegExp(r'.*'): (word) => TextSpan(text: word)});

  List<InlineSpan> spans = [];

  List<String> words = input.split(' ');

  for (int w = 0; w < words.length; w++) {
    String word = words[w];
    for (int i = 0; i < regmap.keys.length; i++) {
      final reg = regmap.keys.elementAt(i);
      if (reg.hasMatch(word)) {
        spans.add(regmap.values.elementAt(i).call('$word${(w == words.length - 1) ? '' : ' '}'));
        break;
      }
    }
  }

  return spans;
}
