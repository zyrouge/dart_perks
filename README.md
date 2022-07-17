# Perks

Perks is a simple-to-use persistent/non-persistent data storage.

## Links

-   [GitHub](https://github.com/zyrouge/dart_perks)
-   [Documentation](https://pub.dev/documentation/perks/latest/)

## Usage

-   Adapters take care of read and write operations.
-   Boxes abstract adapters to provide a way to perform operations on the data.

### Available Adapters

-   `PerksFileAdapter` - Asynchronous file based storage.
-   `PerksFileSyncAdapter` - Synchronous file based storage.
-   `PerksMemoryAdapter` - Synchronous memory based storage.

### Available Boxes

-   `PerksNameValueBox` - Asynchronous Name-Value (or Key-Value) paired database schema.
-   `PerksNameValueSyncBox` - Synchronous Name-Value (or Key-Value) paired database schema.
-   `PerksStringBox` - Asynchronous storage where data is stored as a single string.
-   `PerksStringSyncBox` - Synchronous storage where data is stored as a single string.

### Example

```dart
import 'package:perks/perks.dart';

final PerksNameValueBox<String> database = PerksNameValueBox<dynamic>(
    adapter: PerksFileAdapter('data.db'),
);

await database.set('hello', 'world');
print('Value of hello: ${await database.get('hello')}');
```

# LICENSE

[MIT](./LICENSE)
