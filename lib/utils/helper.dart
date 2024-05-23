import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

class EncryptionHelper {
  final String key;

  EncryptionHelper(this.key);

  String _generateKey(String key) {
    return md5.convert(utf8.encode(key)).toString();
  }

  Uint8List _createUint8ListFromHexString(String hex) {
    final buffer = Uint8List(hex.length ~/ 2);
    for (int i = 0; i < buffer.length; i++) {
      buffer[i] = int.parse(hex.substring(i * 2, i * 2 + 2), radix: 16);
    }
    return buffer;
  }

  String encrypt(String plainText) {
    final keyBytes = _createUint8ListFromHexString(_generateKey(key));
    final iv = IV(Uint8List(16));
    final encrypter = Encrypter(AES(Key(keyBytes), mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  String decrypt(String encryptedText) {
    final keyBytes = _createUint8ListFromHexString(_generateKey(key));
    final iv = IV(Uint8List(16));
    final encrypter = Encrypter(AES(Key(keyBytes), mode: AESMode.cbc));
    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
    return decrypted;
  }
}
