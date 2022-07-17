import 'package:perks/perks.dart';
import 'package:test/test.dart';
import '../utils.dart';

void main() {
  final Map<String, PerksAdapter> adapters = <String, PerksAdapter>{
    'File Adapter': PerksFileAdapter('$testDataDir/file_adapter.txt'),
  };

  for (final MapEntry<String, PerksAdapter> x in adapters.entries) {
    test(x.key, () async {
      final PerksAdapter adapter = x.value;

      String currentData = '';
      await adapter.write(currentData);
      expect(await adapter.read(), currentData);

      currentData = 'HelloWorld';
      await adapter.write(currentData);
      expect(await adapter.read(), currentData);

      currentData = 'GoodbyeWorld';
      await adapter.write(currentData);
      expect(await adapter.read(), currentData);

      currentData = '';
      await adapter.write(currentData);
      expect(await adapter.read(), currentData);
    });
  }
}
