import 'package:enough_convert/base.dart';

/// Provides a KOI codepage decoder.
class KOI8Decoder extends BaseDecoder {
  /// Creates a new KOI codepage decoder.
  /// The [symbols] need to be exactly `128` characters long.
  /// Set [allowedInvalid] to true in case invalid characters sequences should be at least readable.
  const KOI8Decoder(String symbols, {bool allowInvalid = false})
      : super(symbols, 0x7F, allowInvalid: allowInvalid);
}

/// Provides a simple, non chunkable iso-8859-XX encoder.
class KOI8Encoder extends BaseEncoder {
  /// Creates a new KOI codepage encoder.
  /// Set [allowedInvalid] to true in case invalid characters should be translated to question marks.
  const KOI8Encoder(Map<int, int> encodingMap, {bool allowInvalid = false})
      : super(encodingMap, 0x7F, allowInvalid: allowInvalid);
}
