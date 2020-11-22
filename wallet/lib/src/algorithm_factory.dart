import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import "package:hex/hex.dart";
import "package:ed25519_hd_key/ed25519_hd_key.dart";
import 'package:bip39/bip39.dart' as bip39;
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:jose/jose.dart';
import 'package:pem/pem.dart';
import "package:pointycastle/export.dart";
import 'package:secp256k1/secp256k1.dart';
import 'package:x509/x509.dart';

import 'keystore_item.dart';

class AlgorithmFactory {
  static Future<dynamic> create(String algorithm, String mnemonic) async {
    if (algorithm.toUpperCase() == 'ED25519') {
      return await getEd25519(mnemonic);
    } else if (algorithm.toUpperCase() == 'ES256K') {
      return getES256K(mnemonic);
    } else if (algorithm.toUpperCase() == 'P256') {
      return getP256(mnemonic);
    } else if (algorithm.toUpperCase() == 'P384') {
      return getP384(mnemonic);
    } else if (algorithm.toUpperCase() == 'RSA2048') {
      return getP384(mnemonic);
    }

    return 'algorithm_not_found';
  }

  static Future<KeyPairContainer> getRSA2048(String mnemonic) {
    var keygen = RSAKeyGenerator();
    var kp = keygen.generateKeyPair();
    final pub = kp.publicKey as RSAPublicKey;
    final pvk = kp.privateKey as RSAPrivateKey;

    var key = AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>(pub, pvk);
    var kpContainer = KeyPairContainer(key.privateKey, key.publicKey);
// https://github.com/PointyCastle/pointycastle/blob/master/lib/src/utils.dart
    final pem =
        encodePemBlock(PemLabel.privateKey, encodeBigInt(key.privateKey.d));
    kpContainer.pem = pem;
    kpContainer.jwk = JsonWebKey.fromPem(pem).toJson();
    return Future.value(kpContainer);
  }

  // Reference: https://gist.github.com/haarts/d083c6d73b415ac3b50141b240e55f70
  static Future<KeyPairContainer> getP256(String mnemonic) {
    var domainParams = ECCurve_secp256r1();
    var params = ECKeyGeneratorParameters(domainParams);

    var random = FortunaRandom();
    random.seed(KeyParameter(bip39.mnemonicToSeed(mnemonic)));

    var keygen = ECKeyGenerator();
    keygen.init(ParametersWithRandom(params, random));

    var kp = keygen.generateKeyPair();
    final pub = kp.publicKey as ECPublicKey;
    final pvk = kp.privateKey as ECPrivateKey;

    var key = AsymmetricKeyPair<ECPublicKey, ECPrivateKey>(pub, pvk);
    var kpContainer = KeyPairContainer(key.privateKey, key.publicKey);
// https://github.com/PointyCastle/pointycastle/blob/master/lib/src/utils.dart
    final pem =
        encodePemBlock(PemLabel.privateKey, encodeBigInt(key.privateKey.d));
    kpContainer.pem = pem;
    kpContainer.jwk = JsonWebKey.fromPem(pem).toJson();
    return Future.value(kpContainer);
  }

  // Reference: https://gist.github.com/haarts/d083c6d73b415ac3b50141b240e55f70
  static Future<KeyPairContainer> getP384(String mnemonic) {
    var domainParams = ECCurve_secp384r1();
    var params = ECKeyGeneratorParameters(domainParams);

    var random = FortunaRandom();
    random.seed(KeyParameter(bip39.mnemonicToSeed(mnemonic)));

    var keygen = ECKeyGenerator();
    keygen.init(ParametersWithRandom(params, random));

    var kp = keygen.generateKeyPair();
    final pub = kp.publicKey as ECPublicKey;
    final pvk = kp.privateKey as ECPrivateKey;

    var key = AsymmetricKeyPair<ECPublicKey, ECPrivateKey>(pub, pvk);
    var kpContainer = KeyPairContainer(key.privateKey, key.publicKey);
// https://github.com/PointyCastle/pointycastle/blob/master/lib/src/utils.dart
    final pem =
        encodePemBlock(PemLabel.privateKey, encodeBigInt(key.privateKey.d));
    kpContainer.pem = pem;
    kpContainer.jwk = JsonWebKey.fromPem(pem).toJson();
    return Future.value(kpContainer);
  }

/*
* return type ECPair
 */
  static Future<KeyPairContainer> getES256K(String mnemonic) {
    var seed = bip39.mnemonicToSeed(mnemonic);
    var kp = ECPair.fromPrivateKey(
        Utf8Encoder().convert(HDWallet.fromSeed(seed).privKey).sublist(0, 32));
    var kpContainer = KeyPairContainer(kp.privateKey, kp.publicKey);

    final pem = encodePemBlock(PemLabel.privateKey, kp.privateKey);
    kpContainer.pem = pem;
    kpContainer.jwk = JsonWebKey.fromPem(pem).toJson();
    return Future.value(kpContainer);
  }

  /*
  * Gets EdDSA key pair
  * return type KeyData
  */
  static Future<KeyPairContainer> getEd25519(String mnemonic) async {
    var seed = bip39.mnemonicToSeedHex(mnemonic);
    var key = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    var kpContainer =
        KeyPairContainer(key.key, ED25519_HD_KEY.getBublickKey(key.key));

    final pem = encodePemBlock(PemLabel.privateKey, key.key);
    kpContainer.pem = pem;
    kpContainer.jwk = JsonWebKey.fromPem(pem).toJson();
    return kpContainer;
  }

  /// Decode a BigInt from bytes in big-endian encoding.
  static BigInt decodeBigInt(List<int> bytes) {
    BigInt result = BigInt.from(0);
    for (var i = 0; i < bytes.length; i++) {
      result += BigInt.from(bytes[bytes.length - i - 1]) << (8 * i);
    }
    return result;
  }

  /// Encode a BigInt into bytes using big-endian encoding.
  static Uint8List encodeBigInt(BigInt number) {
    // Not handling negative numbers. Decide how you want to do that.
    int size = (number.bitLength + 7) >> 3;
    var result = Uint8List(size);
    for (var i = 0; i < size; i++) {
      result[size - i - 1] = (number & BigInt.from(0xff)).toInt();
      number = number >> 8;
    }
    return result;
  }
}
