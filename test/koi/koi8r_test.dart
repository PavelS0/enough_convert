import 'dart:convert' as convert;

import 'package:enough_convert/koi8/koi8r.dart';
import 'package:test/test.dart';

void main() {
  group('Codec tests', () {
    test('name', () {
      expect(KOI8RCodec().name, 'koi8-r');
    });
    test('Decoder/encoder classes', () {
      expect(KOI8RCodec().encoder, isA<KOI8REncoder>());
      expect(KOI8RCodec().decoder, isA<KOI8RDecoder>());
    });
  });

  group('Decoder tests', () {
    test('Decode ascii', () {
      final bytes = convert.ascii.encode('hello world');
      expect(KOI8RDecoder().convert(bytes), 'hello world');
    });

    test('Decode koi8-r', () {
      expect(KOI8RDecoder().convert([0xF0, 0xD2, 0xC9, 0xD7, 0xC5, 0xF4]),
          'ПривеТ');
      final bytes =
          KOI8REncoder().convert('Рад приветствовать Вас в нашем тесте!');
      expect(KOI8RDecoder().convert(bytes),
          'Рад приветствовать Вас в нашем тесте!');
    });

    test('Decode koi8-r with invalid value when invalid input is allowed', () {
      expect(
          KOI8RDecoder(allowInvalid: true)
              .convert([0xF0, 0xD2, 0xC9, 0xD7, 0xC5, 0xF4, 0xFF1]),
          'ПривеТ�');
    });

    test('Decode koi8-r with invalid value when invalid input is not allowed',
        () {
      expect(
          () => KOI8RDecoder()
              .convert([0xF0, 0xD2, 0xC9, 0xD7, 0xC5, 0xF4, 0xFF1]),
          throwsA(isA<FormatException>()));
    });
  });

  group('Encoder tests', () {
    test('encode ascii', () {
      final bytes = KOI8REncoder().convert('hello world');
      expect(bytes, convert.latin1.encode('hello world'));
    });

    test('encode koi8-r', () {
      final bytes =
          KOI8REncoder().convert('Рад приветствовать Вас в нашем тесте!');
      expect(bytes.any((element) => element > 0xFF), false);
      expect(KOI8RDecoder().convert(bytes),
          'Рад приветствовать Вас в нашем тесте!');
    });

    test('encode more koi8-r ', () {
      final encoder = KOI8REncoder();
      final decoder = KOI8RDecoder();
      final v = decoder.symbols.substring(26, 27);
      print(v);
      var bytes = encoder.convert(decoder.symbols);
      var expected = List.generate(0xFF - 0x7F, (index) => index + 0x80);
      /*  for (var i = 0; i < decoder.symbols.length; i++) {
        if (decoder.symbols.codeUnitAt(i) == 0x3F) {
          // ?
          expected[i] = 0x3F;
        }
      } */
      //bytes[26]
      expect(bytes, expected);
    });

    test('encode koi8-r with invalid value when invalid input is allowed', () {
      var bytes = KOI8REncoder(allowInvalid: true).convert('йз�');
      expect(KOI8RDecoder().convert(bytes), 'йз?');
    });

    test('encode koi8-r with invalid value when invalid input is not allowed',
        () {
      expect(
          () => KOI8REncoder().convert('йз�'), throwsA(isA<FormatException>()));
    });
  });
}
