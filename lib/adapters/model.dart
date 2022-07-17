/// Adapters are responsible for handling all the processed data.
/// Often times, it is writing to a disk, or a similar operating.

/// [PerksAdapter] implements `read` and `write` operation but are asynchronous.
abstract class PerksAdapter {
  Future<String> read();
  Future<void> write(final String data);
}

/// [PerksSyncAdapter] implements `read` and `write` operation but are synchronous.
abstract class PerksSyncAdapter {
  String read();
  void write(final String data);
}
