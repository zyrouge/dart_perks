import '../../adapters/exports.dart';
import '../model.dart';
import 'shared.dart';

typedef PerksNameValueSyncTransactionFn<T> = PerksNameValueMap<T> Function(
  PerksNameValueMap<T> data,
);

/// [PerksNameValueSyncBox] is same as [PerksNameValueBox] but everything is synchronous.
class PerksNameValueSyncBox<T> extends PerksSyncBox<PerksSyncAdapter> {
  PerksNameValueSyncBox({
    required final PerksSyncAdapter adapter,
    this.cache = true,
  }) : super(adapter);

  final bool cache;
  PerksNameValueMap<T>? _cache;

  void set(final String key, final T value) {
    transaction((final PerksNameValueMap<T> data) {
      data[key] = value;
      return data;
    });
  }

  T? get(final String key) {
    final PerksNameValueMap<T> data = all();
    return data[key];
  }

  T? delete(final String key) {
    T? value;
    transaction((final PerksNameValueMap<T> data) {
      value = data.remove(key);
      return data;
    });
    return value;
  }

  PerksNameValueMap<T> clear() {
    late final PerksNameValueMap<T> value;
    transaction((final PerksNameValueMap<T> data) {
      value = data;
      return <String, T>{};
    });
    return value;
  }

  void transaction(final PerksNameValueSyncTransactionFn<T> fn) {
    overwrite(fn(all()));
  }

  PerksNameValueMap<T> all() {
    if (_cache != null) return _cache!;

    final String data = adapter.read();
    final PerksNameValueMap<T> parsed =
        PerksNameValueMapUtils.decodePerksNameValueMap(data);
    _maybeCache(parsed);
    return parsed;
  }

  void overwrite(final PerksNameValueMap<T> data) {
    adapter.write(PerksNameValueMapUtils.encodePerksNameValueMap(data));
    _maybeCache(data);
  }

  void _maybeCache(final PerksNameValueMap<T> data) {
    if (!cache) return;
    _cache = data;
  }
}
