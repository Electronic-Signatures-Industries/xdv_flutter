import 'dart:convert';

import "package:hex/hex.dart";
import "package:ed25519_hd_key/ed25519_hd_key.dart";
import 'package:bip39/bip39.dart' as bip39;
import 'package:bitcoin_flutter/bitcoin_flutter.dart';

class AlgorithmFactory {
  static Future<dynamic> create(String algorithm, String mnemonic) async {
    if (algorithm.toUpperCase() == 'ED25519') {
      var result = await getEd25519(mnemonic);
      return {'pk': result.chainCode, 'pub': result.key};
    } else if (algorithm.toUpperCase() == 'ES256K') {
      var result = getES256K(mnemonic);
      return {'pk': result.privateKey, 'pub': result.publicKey};
    }
    return 'algorithm_not_found';
  }

/*
* return type ECPair
 */
  static ECPair getES256K(String mnemonic) {
    var seed = bip39.mnemonicToSeed(mnemonic);
    var kp = ECPair.fromPrivateKey(
        Utf8Encoder().convert(HDWallet.fromSeed(seed).privKey).sublist(0, 32));
    return kp;
  }

  /*
  * Gets EdDSA key pair
  * return type KeyData
  */
  static Future<KeyData> getEd25519(String mnemonic) async {
    var seed = bip39.mnemonicToSeedHex(mnemonic);
    return await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
  }
}
