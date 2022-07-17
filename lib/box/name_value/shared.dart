import 'dart:convert';

typedef PerksNameValueMap<T> = Map<String, T>;

abstract class PerksNameValueMapUtils {
  static PerksNameValueMap<T> decodePerksNameValueMap<T>(final String data) =>
      data.isNotEmpty
          ? (json.decode(data) as Map<dynamic, dynamic>).cast<String, T>()
          : <String, T>{};

  static String encodePerksNameValueMap<T>(final PerksNameValueMap<T> data) =>
      json.encode(data);
}
