import 'package:perks/perks.dart';
import 'package:test/test.dart';
import '../../utils.dart';

void main() {
  test('Name-Value Box', () async {
    final PerksNameValueBox<String> box = PerksNameValueBox<String>(
      adapter: PerksFileAdapter('$testDataDir/json_box.json'),
    );

    final PerksNameValueMap<String> currentData = <String, String>{};

    await box.clear();
    await compareBoxData(box, currentData);

    currentData['hello'] = 'world';
    await box.set('hello', 'world');
    await compareBoxData(box, currentData);

    currentData['goodbye'] = '_world';
    await box.set('goodbye', '_world');
    await compareBoxData(box, currentData);

    currentData.remove('goodbye');
    await box.delete('goodbye');
    await compareBoxData(box, currentData);

    currentData.clear();
    await box.clear();
    await compareBoxData(box, currentData);
  });
}

Future<void> compareBoxData(
  final PerksNameValueBox<String> box,
  final PerksNameValueMap<String> data,
) async {
  final PerksNameValueMap<String> all = await box.all();
  expect(all.length, data.length);
  for (final String key in all.keys) {
    expect(all[key], data[key]);
    expect(await box.get(key), data[key]);
  }
}
