import 'package:perks/perks.dart';
import 'package:test/test.dart';
import '../../utils.dart';

void main() {
  test('Name-Value Sync-Box', () {
    final PerksNameValueSyncBox<String> box = PerksNameValueSyncBox<String>(
      adapter: PerksFileSyncAdapter('$testDataDir/json_box.json'),
    );

    final PerksNameValueMap<String> currentData = <String, String>{};

    box.clear();
    compareBoxData(box, currentData);

    currentData['hello'] = 'world';
    box.set('hello', 'world');
    compareBoxData(box, currentData);

    currentData['goodbye'] = '_world';
    box.set('goodbye', '_world');
    compareBoxData(box, currentData);

    currentData.remove('goodbye');
    box.delete('goodbye');
    compareBoxData(box, currentData);

    currentData.clear();
    box.clear();
    compareBoxData(box, currentData);
  });
}

void compareBoxData(
  final PerksNameValueSyncBox<String> box,
  final PerksNameValueMap<String> data,
) {
  final PerksNameValueMap<String> all = box.all();
  expect(all.length, data.length);
  for (final String key in all.keys) {
    expect(all[key], data[key]);
    expect(box.get(key), data[key]);
  }
}
