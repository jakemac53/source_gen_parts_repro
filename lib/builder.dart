import 'dart:async';

import 'package:build/build.dart';

Builder create([BuilderOptions _]) => MyBuilder();

class MyBuilder extends Builder {
  @override
  Future<void> build(BuildStep buildStep) async {
    final input = buildStep.inputId;

    await buildStep.resolver.isLibrary(input);

    if (input.path.endsWith('input.dart')) {
      final output = input.changeExtension('.custom.dart');
      print('MyBuilder $input -> $output');

      await buildStep.writeAsString(output, '''
part of 'input.dart';

class Bar {}
      ''');
    }
  }

  @override
  Map<String, List<String>> get buildExtensions => const {
        '.dart': ['.custom.dart']
      };
}
