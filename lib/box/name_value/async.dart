import '../../adapters/exports.dart';
import '../model.dart';
import 'shared.dart';

typedef PerksNameValueTransactionFn<T> = Future<PerksNameValueMap<T>> Function(
  PerksNameValueMap<T> data,
);

/// [PerksNameValueBox] is a Key-Value or Name-Value paired database.
/// Everything is stored as json internally.
class PerksNameValueBox<T> extends PerksBox<PerksAdapter> {
  PerksNameValueBox({
    required final PerksAdapter adapter,
    this.cache = true,
  }) : super(adapter);

  final bool cache;
  PerksNameValueMap<T>? _cache;

  Future<void> set(final String key, final T value) async {
    await transaction((final PerksNameValueMap<T> data) async {
      data[key] = value;
      return data;
    });
  }

  Future<T?> get(final String key) async {
    final PerksNameValueMap<T> data = await all();
    return data[key];
  }

  Future<T?> delete(final String key) async {
    T? value;
    await transaction((final PerksNameValueMap<T> data) async {
      value = data.remove(key);
      return data;
    });
    return value;
  }

  Future<PerksNameValueMap<T>> clear() async {
    late final PerksNameValueMap<T> value;
    await transaction((final PerksNameValueMap<T> data) async {
      value = data;
      return <String, T>{};
    });
    return value;
  }

  Future<void> transaction(final PerksNameValueTransactionFn<T> fn) async {
    await overwrite(await fn(await all()));
  }

  Future<PerksNameValueMap<T>> all() async {
    if (_cache != null) return _cache!;

    final String data = await adapter.read();
    final PerksNameValueMap<T> parsed =
        PerksNameValueMapUtils.decodePerksNameValueMap(data);
    _maybeCache(parsed);
    return parsed;
  }

  Future<void> overwrite(final PerksNameValueMap<T> data) async {
    await adapter.write(PerksNameValueMapUtils.encodePerksNameValueMap(data));
    _maybeCache(data);
  }

  void _maybeCache(final PerksNameValueMap<T> data) {
    if (!cache) return;
    _cache = data;
  }
}
