import 'dart:convert';

import "package:hex/hex.dart";
import "package:ed25519_hd_key/ed25519_hd_key.dart";
import 'package:bip39/bip39.dart' as bip39;
import 'package:bitcoin_flutter/bitcoin_flutter.dart';

class AlgorithmFactory {
  static create(String algorithm, String mnemonic) {
    if (algorithm.toUpperCase() == 'ED25519') {
      return getEd25519(mnemonic);
    } else if (algorithm.toUpperCase() == 'ES256K') {
      return getES256K(mnemonic);
    }
    return 'algorithm_not_found';
  }

  static ECPair getES256K(String mnemonic) {
    var seed = bip39.mnemonicToSeed(mnemonic);
    var kp = ECPair.fromPrivateKey(
        Utf8Encoder().convert(HDWallet.fromSeed(seed).privKey));
    return kp;
  }

  /*
  * Gets EdDSA key pair
  */
  static Future<KeyData> getEd25519(String mnemonic) async {
    var seed = bip39.mnemonicToSeedHex(mnemonic);
    return ED25519_HD_KEY.getMasterKeyFromSeed(seed);
  }
}
