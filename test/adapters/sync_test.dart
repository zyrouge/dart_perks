import 'package:perks/perks.dart';
import 'package:test/test.dart';
import '../utils.dart';

void main() {
  final Map<String, PerksSyncAdapter> adapters = <String, PerksSyncAdapter>{
    'File Adapter': PerksFileSyncAdapter('$testDataDir/file_sync_adapter.txt'),
    'Memory Adapter': PerksMemoryAdapter('$testDataDir/memory_adapter.txt'),
  };

  for (final MapEntry<String, PerksSyncAdapter> x in adapters.entries) {
    test('${x.key} (Sync)', () async {
      final PerksSyncAdapter adapter = x.value;

      String currentData = '';
      adapter.write(currentData);
      expect(adapter.read(), currentData);

      currentData = 'HelloWorld';
      adapter.write(currentData);
      expect(adapter.read(), currentData);

      currentData = 'GoodbyeWorld';
      adapter.write(currentData);
      expect(adapter.read(), currentData);

      currentData = '';
      adapter.write(currentData);
      expect(adapter.read(), currentData);
    });
  }
}
