import '../adapters/exports.dart';
import 'model.dart';

/// [PerksStringBox] provides basic functionality of storing texts.
class PerksStringBox<T extends PerksAdapter> extends PerksBox<T> {
  PerksStringBox({
    required final T adapter,
  }) : super(adapter);

  Future<String> get() => adapter.read();
  Future<void> set(final String value) => adapter.write(value);
}

/// [PerksStringSyncBox] is same as [PerksStringBox] but everything is synchronous.
class PerksStringSyncBox<T extends PerksSyncAdapter> extends PerksSyncBox<T> {
  PerksStringSyncBox({
    required final T adapter,
  }) : super(adapter);

  String get() => adapter.read();
  void set(final String value) => adapter.write(value);
}
