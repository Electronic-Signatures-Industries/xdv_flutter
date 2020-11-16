import 'dart:collection';

import 'dart:convert';
import 'package:jose/jose.dart'; // jwt

import 'package:sembast/sembast.dart';
import 'package:sembast_sqflite/sembast_sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

import 'package:wallet/src/keystore_item.dart';
import 'package:wallet/src/keystore.dart';
import 'package:wallet/wallet.dart';
import 'package:wallet_core/wallet_core.dart'; // hdwallet
// import 'package:pointycastle/pointycastle.dart';  // crypto
import 'package:cryptography/cryptography.dart' as crypto_keys; //crypto
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:path/path.dart';
//import 'package:sembast/sembast.dart'; // keystore - pouchdb
import 'package:sembast/sembast_io.dart';
import 'package:x509/x509.dart';
import 'package:pedantic/pedantic.dart';

import 'algorithm_factory.dart';
import 'package:wallet/src/algorithm_type_string.dart';

class WalletOptions {
  String password;
  String mnemonic;
}

class KeystoreDbModel {
  int _id;
  HashMap keyStoreModel;
  String keystoreSeed;
  String mnemonic;
  HashMap keypairExports;
  HashMap publicKeys;
}

var KeyStoreModel = {
  'BLS': {},
  'ES256K': {},
  'P256': {},
  'RSA': {},
  'ED25519': {},
  'Filecoin': {},
  'Vechain': {},
  'Polkadot': {}
};

abstract class KS {
  void lock();
  void load(Database db);
  void enable();
  void setKeyPair(String key, KeystoreItem kp);
  Future<KeystoreItem> getKeyPair(String key);
}

// mixin AndroidKeyStore implements KeyStore, HDWallet {
// }

// mixin SigningKeypairTypes implements List {
// }

// class WalletKeyStore implements KeyStore{
//   @override
//   enable() {
//     // TODO: implement enable
//     throw UnimplementedError();
//   }

//   @override
//   find() {
//     // TODO: implement find
//     throw UnimplementedError();
//   }

//   @override
//   lock() {
//     // TODO: implement lock
//     throw UnimplementedError();
//   }

//   @override
//   remove() {
//     // TODO: implement remove
//     throw UnimplementedError();
//   }

//   @override
//   set() {
//     // TODO: implement set
//     throw UnimplementedError();
//   }

// }

// type FilecoinSignTypes = 'filecoin' | 'lotus';
class Wallet {
  String id;

  String mnemonic;

  Database db;

  KeyStore keystore = KeyStore();

  bool test = false;

  // id: string;
  //Subject onRequestPassphraseSubscriber = new Subject<string>();
  // onRequestPassphraseWallet: Subject = new Subject<string>();
  // onSignExternal: Subject = new Subject<{
  //     isEnabled: boolean;
  //     signature: string | Buffer;
  // }>();
  // ethersWallet: any;
  // accepted: any;
  Wallet();

  Future<int> dbCreate() async {
    // File path to a file in the current directory
    var dbPath = 'xdv_wallet.db';

    // The sqflite base factory

    var factory = getDatabaseFactorySqflite(databaseFactoryFfi);

    final dbFolder = '/home/luis/Documents/projects/xdv_flutter/wallet/';
    db = await factory.openDatabase(join(dbFolder, dbPath));
    return 1;
  }

  load() async {
    // var dir = await getApplicationDocumentsDirectory();
    // if (dir) {
    // // make sure it exists
    //   await dir.create(recursive: true);
    //   load();
    // }
  }

  ///
  // Gets a key from storage
  // @param id
  // @param algorithm
  ///
  getPublicKey(String id) {
    // const content = await this.db.get(id);
    // return await JWK.asKey(JSON.parse(content.key), 'jwk');
  }

  ///
  // Sets a key in storage
  // @param id
  // @param algorithm
  // @param value
  ///
  setPublicKey(String id, AlgorithmTypeString, algorithm, Object value) {
    // if ([AlgorithmType.P256_JWK_PUBLIC, AlgorithmType.RSA_JWK_PUBLIC, AlgorithmType.ED25519_JWK_PUBLIC,
    // AlgorithmType.ES256K_JWK_PUBLIC].includes(AlgorithmType[algorithm])) {
    //     await this.db.put({
    //         _id: id,
    //         key: value
    //     });
    // }
  }

  getImportKey(String id) {
    // const content = await this.db.get(id);
    // return content;
  }

  ///
  // Sets a key in storage
  // @param id
  // @param algorithm
  // @param value
  ///
  setImportKey(String id, Object value) {
    // await this.db.put({
    //     _id: id,
    //     key: value
    // });
  }

  Future<int> create(String password, String mnemonic) async {
    var id = 'addrandom';
    // const id = Buffer.from(ethers.utils.randomBytes(100)).toString('base64');

    // Load From Existing mnemonic
    if (mnemonic.isNotEmpty) {
      this.mnemonic = bip39.generateMnemonic(strength: 128);
    }

    await dbCreate();

    keystore.load(db);

    // ED25519
    var algo = 'ed25519';
    var kp = await AlgorithmFactory.create(algo, mnemonic);
    await keystore.setKeyPair(db, algo, kp);
    var key = await keystore.fetchKeyPair(db, algo);
    print('fetched $algo: $key');
    await keystore.removeKeyPair(db, algo);
    key = await keystore.fetchKeyPair(db, algo);
    print('removed $algo: $key');

    // ED25519
    algo = 'es256k';
    kp = await AlgorithmFactory.create(algo, mnemonic);
    await keystore.setKeyPair(db, algo, kp);
    key = await keystore.fetchKeyPair(db, algo);
    print('fetched $algo: $key');
    await keystore.removeKeyPair(db, algo);
    key = await keystore.fetchKeyPair(db, algo);
    print('removed $algo: $key');

    return 1;

    // P256
    // secp256r1
    // p384
    /*kp = this.getP256();
                  keystores.P256 = kp.getPrivate('hex');
                  keyExports.P256 = await KeyConvert.getP256(kp);
                  keyExports.P256.ldJsonPublic = await KeyConvert.createLinkedDataJsonFormat(
                      LDCryptoTypes.JWK,
                      // @ts-ignore
                      { publicJwk: JSON.parse(keyExports.P256.ldSuite.publicKeyJwk) },
                      false
                  );
                  // RSA
                  kp = await Wallet.getRSA256Standalone();
                  keystores.RSA = kp.toJSON(true);
                  keyExports.RSA = await KeyConvert.getRSA(kp);
          
                  const keystoreMnemonicAsString = await this.ethersWallet.encrypt(password);
          
                  const model: KeystoreDbModel = {
                      _id: id,
                      keypairs: keystores,
                      keystoreSeed: keystoreMnemonicAsString,
                      mnemonic: mnemonic,
                      keypairExports: keyExports,
          
                  }
          
                  await this.db.crypto(password);
                  await this.db.put(model);
          
                  this.id = id;*/

    // Query like
    // Blockchain - query its page
    // with dot separator like :00

    // if (algorithm === 'ED25519') {
    //     const kp = new eddsa('ed25519');
    //     return kp.keyFromSecret(ks.keypairs.ED25519) as eddsa.KeyPair;
    // } else if (algorithm === 'P256') {
    //     const kp = new ec('p256');
    //     return kp.keyFromPrivate(ks.keypairs.P256) as ec.KeyPair;
    // } else if (algorithm === 'ES256K') {
    //     const kp = new ec('secp256k1');
    //     return kp.keyFromPrivate(ks.keypairs.ES256K) as ec.KeyPair;
    // }
  }

  getPrivateKeyExports(AlgorithmTypeString algorithm) {
    // const ks: KeystoreDbModel = await this.db.get(this.id);
    // return ks.keypairExports[algorithm];
  }

  canUse() {
    // let ticket = null;
    // const init = this.accepted;
    // return new Promise((resolve) => {
    //     ticket = setInterval(() => {
    //         if (this.accepted !== init) {
    //             clearInterval(ticket);
    //             resolve(this.accepted);
    //             this.accepted = undefined;
    //             return;
    //         }
    //     }, 1000);
    // });
  }

  ///
  // Signs with selected algorithm
  // @param algorithm Algorithm
  // @param payload Payload as buffer
  // @param options options
  ///
  // Future<Object> sign(AlgorithmTypeString algorithm, Buffer payload) {

  //     this.onRequestPassphraseSubscriber.next({ type: 'request_tx', payload, algorithm });

  //     const canUseIt = await this.canUse();

  //     if (canUseIt) {
  //         const key: ec.KeyPair | eddsa.KeyPair = await this.getPrivateKey(algorithm);
  //         return [null, key.sign(Buffer).toHex()];
  //     }
  //     return [new Error('invalid_passphrase')]
  // }

  ///
  //Generates a mnemonic
  //
  String generateMnemonic() {
    // return ethers.Wallet.createRandom().mnemonic;
  }

  void open(String id) {
    // this.id = id;
    // this.onRequestPassphraseSubscriber.next({ type: 'wallet' });
    // this.onRequestPassphraseWallet.subscribe(async p => {
    //     if (p.type !== 'ui') {
    //         this.accepted = p.accepted;

    //     } else {
    //         try {
    //             this.db.crypto(p.passphrase);
    //             const ks = await this.db.get(id);
    //             this.mnemonic = ks.mnemonic;
    //             this.onRequestPassphraseSubscriber.next({ type: 'done' })
    //         } catch (e) {
    //             this.onRequestPassphraseSubscriber.next({ type: 'error', error: e })
    //         }
    //     }
    // });
  }

  ///
  //Derives a new child Wallet
  ///
  // ethers.HDNode deriveChild(Number sequence, {String derivation = "m/44'/60'/0'/0"}) {
  //     const masterKey = HDNode.fromMnemonic(this.mnemonic);
  //     return masterKey.derivePath(`${derivation}/${sequence}`);
  // }

  String get path {
    return path;
  }

  // String get address {
  //     return this.ethersWallet.getAddress();
  // }
  ///
  // Derives a wallet from a path
  ///
  // ethers.HDNode deriveFromPath(String path) {
  //     const node = HDNode.fromMnemonic(this.mnemonic).derivePath(path);
  //     return node;
  // }

  // getFilecoinDeriveChild(): ethers.HDNode {
  //     return this.deriveFromPath(`m/44'/461'/0/0/1`);
  // }

  /**
         * Gets EdDSA key pair
         */
  // Future<dynamic> getEd25519() async {
  //   // TODO: https://pub.dev/packages/ed25519_hd_key
  //   var seed = bip39.mnemonicToSeed(mnemonic);
  //   var kp = await ed25519.newKeyPairFromSeed(PrivateKey(seed));
  //   return kp;
  // }

  // getP256(): ec.KeyPair {
  //     const p256 = new ec('p256');
  //     const keypair = p256.keyFromPrivate(HDNode.fromMnemonic(this.mnemonic).privateKey);
  //     return keypair;
  // }

  //  ECPair getES256K() {
  //     var seed = bip39.mnemonicToSeed(mnemonic);
  //     var kp =  ECPair.fromPrivateKey(Utf8Encoder().convert(HDWallet.fromSeed(seed).privKey));
  //     return kp;
  //   }

  // getBlsMasterKey(): any {
  //     const masterKey = deriveKeyFromMnemonic(this.mnemonic)
  //     return {
  //         deriveValidatorKeys: (id: number) => deriveEth2ValidatorKeys(masterKey, id)
  //     };
  // }

  // static getRSA256Standalone(len: number = 2048): Promise<JWK.RSAKey> {
  //     return JWK.createKey('RSA', len, {
  //         alg: 'RS256',
  //         use: 'sig'
  //     });
  // }

}
