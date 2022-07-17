import 'model.dart';

/// [PerksMemoryAdapter] uses memory to store all the data.
class PerksMemoryAdapter extends PerksSyncAdapter {
  PerksMemoryAdapter([this._data = '']);

  String _data;

  @override
  String read() => _data;

  @override
  void write(final String data) {
    _data = data;
  }
}
