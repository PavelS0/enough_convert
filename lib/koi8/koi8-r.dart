import 'dart:convert' as cnvrt;

import 'package:enough_convert/koi8/koi8.dart';
import 'package:enough_convert/windows/windows1251.dart';

const String _koi8rSymbols = '─│┌┐└┘├┤┬┴┼▀▄█▌▐' +
    '░▒▓⌠■∙√≈≤≥ ⌡°²·÷' +
    '═║╒ё╓╔╕╖╗╘╙╚╛╜╝╞' +
    '╟╠╡Ё╢╣╤╥╦╧╨╩╪╫╬©' +
    'юабцдефгхийклмно' +
    'пярстужвьызшэщчъ' +
    'ЮАБЦДЕФГХИЙКЛМНО' +
    'ПЯРСТУЖВЬЫЗШЭЩЧЪ';

const Map<int, int> _koi8rMap = {
  0x2500: 128,
  0x2502: 129,
  0x250C: 130,
  0x2510: 131,
  0x2514: 132,
  0x2518: 133,
  0x251C: 134,
  0x2524: 135,
  0x252C: 136,
  0x2534: 137,
  0x253C: 138,
  0x2580: 139,
  0x2584: 140,
  0x2588: 141,
  0x258C: 142,
  0x2590: 143, // 16

  0x2591: 144,
  0x2592: 145,
  0x2593: 146,
  0x2320: 147,
  0x25A0: 148,
  0x2219: 149,
  0x221A: 150,
  0x2248: 151,
  0x2264: 152,
  0x2265: 153,
  0xA0: 154,
  0x2321: 155,
  0xB0: 156,
  0xB2: 157,
  0xB7: 158,
  0xF7: 159, // 16

  0x2550: 160,
  0x2551: 161,
  0x2552: 162,
  0x451: 163,
  0x2553: 164,
  0x2554: 165,
  0x2555: 166,
  0x2556: 167,
  0x2557: 168,
  0x2558: 169,
  0x2559: 170,
  0x255A: 171,
  0x255B: 172,
  0x255C: 173,
  0x255D: 174,
  0x255E: 175, // 16

  0x255F: 176,
  0x2560: 177,
  0x2561: 178,
  0x401: 179,
  0x2562: 180,
  0x2563: 181,
  0x2564: 182,
  0x2565: 183,
  0x2566: 184,
  0x2567: 185,
  0x2568: 186,
  0x2569: 187,
  0x256A: 188,
  0x256B: 189,
  0x256C: 190,
  0xA9: 191, // 16

  0x44E: 192,
  0x430: 193,
  0x431: 194,
  0x446: 195,
  0x434: 196,
  0x435: 197,
  0x444: 198,
  0x433: 199,
  0x445: 200,
  0x438: 201,
  0x439: 202,
  0x43A: 203,
  0x43B: 204,
  0x43C: 205,
  0x43D: 206,
  0x43E: 207, // 16

  0x43F: 208,
  0x44F: 209,
  0x440: 210,
  0x441: 211,
  0x442: 212,
  0x443: 213,
  0x436: 214,
  0x432: 215,
  0x44C: 216,
  0x44B: 217,
  0x437: 218,
  0x448: 219,
  0x44D: 220,
  0x449: 221,
  0x447: 222,
  0x44A: 223, //16

  0x42E: 224,
  0x410: 225,
  0x411: 226,
  0x426: 227,
  0x414: 228,
  0x415: 229,
  0x424: 230,
  0x413: 231,
  0x425: 232,
  0x418: 233,
  0x419: 234,
  0x41A: 235,
  0x41B: 236,
  0x41C: 237,
  0x41D: 238,
  0x41E: 239, // 16

  0x41F: 240,
  0x42F: 241,
  0x420: 242,
  0x421: 243,
  0x422: 244,
  0x423: 245,
  0x416: 246,
  0x412: 247,
  0x42C: 248,
  0x42B: 249,
  0x417: 250,
  0x428: 251,
  0x42D: 252,
  0x429: 253,
  0x427: 254,
  0x42A: 255, //16
};

/// Provides a windows 1251 / cp1251 codec for easy encoding and decoding.
class KOI8RCodec extends cnvrt.Encoding {
  final bool allowInvalid;

  /// Creates a new codec
  const KOI8RCodec({
    /// set [allowInvalid] to `true` for ignoring invalid data.
    /// When invalid data is allowed it  will be encoded to ? and decoded to �
    this.allowInvalid = false,
  });

  @override
  Windows1251Decoder get decoder => allowInvalid
      ? const Windows1251Decoder(allowInvalid: true)
      : const Windows1251Decoder(allowInvalid: false);

  @override
  Windows1251Encoder get encoder => allowInvalid
      ? const Windows1251Encoder(allowInvalid: true)
      : const Windows1251Encoder(allowInvalid: false);

  @override
  String get name => 'koi8-r';
}

/// Decodes windows 1251 / cp1251 data.
class KOI8RDecoder extends KOI8Decoder {
  const KOI8RDecoder({
    /// set [allowInvalid] to `true` for ignoring invalid data.
    /// When invalid data is allowed it  will be decoded to �
    bool allowInvalid = false,
  }) : super(_koi8rSymbols, allowInvalid: allowInvalid);
}

/// Encodes texts into windows 1251 data
class KOI8REncoder extends KOI8Encoder {
  const KOI8REncoder({
    /// set [allowInvalid] to `true` for ignoring invalid data.
    /// When invalid data is allowed it  will be encoded to ?
    bool allowInvalid = false,
  }) : super(_koi8rMap, allowInvalid: allowInvalid);
}
