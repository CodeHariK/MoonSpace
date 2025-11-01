import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:moonspace/helper/extensions/theme_ext.dart';
import 'package:moonspace/helper/stream/debounce.dart';
import 'package:stack_trace/stack_trace.dart';

const String
        //
        reset =
        "\x1B[0m",
    fBlack = "\x1B[30m",
    fRed = "\x1B[31m",
    fGreen = "\x1B[32m",
    fYellow = "\x1B[33m",
    fBlue = "\x1B[34m",
    fMagenta = "\x1B[35m",
    fCyan = "\x1B[36m",
    fWhite = "\x1B[37m",
    bBlack = "\x1B[40m",
    bRed = "\x1B[41m",
    bGreen = "\x1B[42m",
    bYellow = "\x1B[43m",
    bBlue = "\x1B[44m",
    bMagenta = "\x1B[45m",
    bCyan = "\x1B[46m",
    bWhite = "\x1B[47m";

const List<String> color = [
  //
  bRed + fWhite,
  bMagenta + fYellow,
  bWhite + fBlack,
  bYellow + fBlack,
  bBlue + fWhite,
  bGreen + fBlack,
  bBlack + fYellow,
];

List<Map<String, String>> logs = [];

void dividerline() {
  debugLog('$fWhite  ■  ∙  ÷  =  ≡  ─  ×  ☼  ■  ∙  ÷  =  ≡  ─  ×  ☼  $reset');
}

final logStream = createDebounceFunc(2000, (e) => dividerline());

final JsonEncoder _encoder = JsonEncoder.withIndent('  ', (object) {
  return object.toString();
});

dynamic beautifyMap(dynamic obj) {
  if (obj is Map /*obj.runtimeType.toString().contains("Map")*/ ) {
    // final dividerline = {
    //   'Deco': Map.fromEntries(
    //     obj.entries.where((e) => e.value != null).map(
    //           (e) => MapEntry(
    //             e.key,
    //             e.value?.toString(),
    //           ),
    //         ),
    //   ),
    // };

    // return _encoder.convert(dividerline);

    return _encoder.convert(obj);
  }
  return obj.toString();
}

String _stack(bool s) {
  Trace st = Trace.from(StackTrace.current).terse;
  List<String> frame2 = st.frames[2].toString().split(" ");
  String fileHash = color.elementAt(
    (frame2[0].codeUnits.fold<int>(
          0,
          (previousValue, element) => previousValue + element,
        ) %
        color.length),
  );
  if (s) {
    // log("  🍪 ${color['fYellow']} ${st.frames.length > 4 ? "[${st.frames[4].member}] -> " : ""}<${st.frames[3].member}> -> (${st.frames[2].member}) ->${color['bBlack']} ${("${frame2[0]}:${frame2[1].split(":").first}").replaceAll("../../lib", "E:\\_Temp\\tamannaah\\lib").replaceAll("package:monkey", "E:\\_Temp\\cracker\\lib").replaceAll("/", "\\")} $reset");
    debugLog(
      '$fileHash ${("${frame2[0]}:${frame2[1].split(":").first}").replaceAll("../../lib", "E:\\_Temp\\tamannaah\\lib").replaceAll("package:monkey", "E:\\_Temp\\cracker\\lib").replaceAll("/", "\\")} ',
    );
  }
  return '$fileHash ${frame2[0].split('/').last.split('.').first.toUpperCase()} $reset';
}

taco(dynamic obj, {String name = '', bool stack = false}) {
  debugLog("\x1B[2J\x1B[0;0H");

  if (kDebugMode) {
    if (stack) _stack(stack);
    String text = beautifyMap(obj);
    logs.add({"Taco $name": text});
    logStream.add({"Taco $name": text});
    debugLog(
      "  🌮 ${_stack(false)} ${name == '' ? '' : '$name : '} $fBlack $text $reset",
    );
    // log(text);
  }
}

lava(dynamic obj, {String name = '', bool stack = false}) {
  if (kDebugMode) {
    if (stack) _stack(stack);
    String text = beautifyMap(obj);
    logs.add({"Lava $name": text});
    logStream.add({"Lava $name": text});
    debugLog(
      "  🌋 ${_stack(false)} ${name == '' ? '' : '$name : '} $fRed $text $reset",
    );
    // log(text);
  }
}

unicorn(dynamic obj, {String name = '', bool stack = false}) {
  if (kDebugMode) {
    if (stack) _stack(stack);
    String text = beautifyMap(obj);
    logs.add({"Unicorn $name": text});
    logStream.add({"Unicorn $name": text});
    debugLog(
      "  🦄 ${_stack(false)} $fMagenta ${name == '' ? '' : '$name : '} $text $reset",
    );
    // log(text);
  }
}

dino(dynamic obj, {String name = '', bool stack = false}) {
  if (kDebugMode) {
    if (stack) _stack(stack);
    String text = beautifyMap(obj);
    logs.add({"Dino $name": text});
    logStream.add({"Dino $name": text});
    debugLog(
      "  🦖 ${_stack(false)} ${name == '' ? '' : '$name : '} $text $reset",
    );
    // log(text);$fGreen $text $reset");
    // log(text);
  }
}

owl(dynamic obj, {String name = '', bool stack = false}) {
  if (kDebugMode) {
    if (stack) _stack(stack);
    String text = beautifyMap(obj);
    logs.add({"Owl $name": text});
    logStream.add({"Owl $name": text});
    debugLog(
      "  🦉 ${_stack(false)} ${name == '' ? '' : '$name : '} $fCyan $text $reset",
    );
    // log(text);
  }
}

void debugLog(String value) {
  if (Device.isIos) {
    log(value);
  } else {
    debugPrint(value);
  }
}
