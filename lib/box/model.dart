import '../perks.dart';

/// Boxes provide an abstraction over adapters and add additional functionalities.

/// [PerksBox] provides an abstraction over [PerksAdapter]
/// and all the operation are asynchronous.
abstract class PerksBox<T extends PerksAdapter> {
  PerksBox(this.adapter);

  final T adapter;
}

/// [PerksSyncBox] provides an abstraction over [PerksSyncAdapter]
/// and all the operation are synchronous.
abstract class PerksSyncBox<T extends PerksSyncAdapter> {
  PerksSyncBox(this.adapter);

  final T adapter;
}
