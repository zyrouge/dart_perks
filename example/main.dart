// ignore_for_file: avoid_print

import 'package:perks/perks.dart';

Future<void> main() async {
  final PerksNameValueBox<dynamic> database = PerksNameValueBox<dynamic>(
    adapter: PerksFileAdapter('./test_data/example_nv.db'),
  );

  await database.set('username', 'test_user');
  print('Value of username: ${await database.get('username')}');
  await printDatabase(database);

  await database.set('counter', 0);
  print('Value of counter: ${await database.get('counter')}');
  await database.set('counter', 10);
  print('Value of counter after updating: ${await database.get('counter')}');
  await printDatabase(database);

  await database.clear();
  print('Cleared the database!');
  await printDatabase(database);
}

Future<void> printDatabase(final PerksNameValueBox<dynamic> database) async {
  print(
    'Database content: ${PerksNameValueMapUtils.encodePerksNameValueMap(await database.all())}',
  );
}
