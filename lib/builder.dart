import 'dart:async';

import 'package:build/build.dart';

Builder create([BuilderOptions _]) => MyBuilder();
Builder create2([BuilderOptions _]) => MyBuilder('.custom2.dart', 'Bar2');

class MyBuilder extends Builder {
  final String className;
  final String outputExt;

  MyBuilder([this.outputExt = '.custom.dart', this.className = 'Bar']);

  @override
  Future<void> build(BuildStep buildStep) async {
    final input = buildStep.inputId;

    final output = input.changeExtension(outputExt);
    print('isLibrary: ${await buildStep.resolver.isLibrary(input)}');

    if (input.path.endsWith('input.dart')) {
      await buildStep.writeAsString(output, '''
part of 'input.dart';

class $className {}
      ''');
    }
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        '.dart': [outputExt]
      };
}
