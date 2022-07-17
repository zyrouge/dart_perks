import 'dart:io';
import 'model.dart';

/// [PerksFileAdapter] uses a file to store all the data.
class PerksFileAdapter extends PerksAdapter {
  PerksFileAdapter(this.path);

  final String path;

  @override
  Future<String> read() async =>
      await file.exists() ? await file.readAsString() : '';

  @override
  Future<void> write(final String data) async {
    if (!(await file.exists())) {
      await file.create(recursive: true);
    }
    await file.writeAsString(data);
  }

  File get file => File(path);
}

/// [PerksFileSyncAdapter] is same as [PerksFileAdapter] but everything is synchronous.
class PerksFileSyncAdapter extends PerksSyncAdapter {
  PerksFileSyncAdapter(this.path);

  final String path;

  @override
  String read() => file.existsSync() ? file.readAsStringSync() : '';

  @override
  void write(final String data) {
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    file.writeAsStringSync(data);
  }

  File get file => File(path);
}
