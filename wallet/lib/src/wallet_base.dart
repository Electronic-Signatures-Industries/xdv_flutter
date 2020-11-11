import 'dart:collection';
import 'dart:svg';

import 'dart:convert';
import 'package:sembast/sembast.dart'; // keystore - pouchdb
import 'package:jose/jose.dart';                      // jwt
import 'package:wallet_core/wallet_core.dart';            // hdwallet
import 'package:pointycastle/pointycastle.dart';  // crypto
import 'package:cryptography/cryptography.dart';  //crypto
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

class WalletOptions {
    String password;
    String mnemonic;
}


class KeystoreDbModel {
    Number _id;
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
}

abstract class KeyStore {
  set();
  remove();
  find();
  void lock();
  void enable();
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

  String dbPath;

  StoreRef<int, Map<String,Object>> store;

  KeyStore keystore;

    // id: string;
    //Subject onRequestPassphraseSubscriber = new Subject<string>();
    // onRequestPassphraseWallet: Subject = new Subject<string>();
    // onSignExternal: Subject = new Subject<{
    //     isEnabled: boolean;
    //     signature: string | Buffer;
    // }>();
    // ethersWallet: any;
    // accepted: any;
    Wallet() {
      // File path to a file in the current directory
      dbPath = 'xdv_wallet.db';
    }

    load() async {
      var dir = await getApplicationDocumentsDirectory();
      if (dir) {
      // make sure it exists
        await dir.create(recursive: true);
        load();
      }

     
    }
    
    ///
    // Gets a key from storage
    // @param id 
    // @param algorithm 
    ///
    getPublicKey(String id) {
        const content = await this.db.get(id);
        return await JWK.asKey(JSON.parse(content.key), 'jwk');
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

    create(String password, String mnemonic) {
      var id = 'addrandom';
      // const id = Buffer.from(ethers.utils.randomBytes(100)).toString('base64');

       // Load From Existing mnemonic
        if (mnemonic.isNotEmpty) {
          this.mnemonic = bip39.generateMnemonic(
            strength: 128
          );
        }
             // const ks: KeystoreDb5\Model = await this.db.get(this.id);


        var keystore =  Keystore();
        keystore.load();



        // Filecoin
        let keyFil = this.getFilecoinDeriveChild();
        keystores.Filecoin = keyFil;

        // ED25519
        let kp = this.getEd25519();
        keystores.ED25519 = kp.getSecret('hex');
        keyExports.ED25519 = await KeyConvert.getEd25519(kp);
        keyExports.ED25519.ldJsonPublic = await KeyConvert.createLinkedDataJsonFormat(
            LDCryptoTypes.Ed25519,
            kp,
            false);


        // ES256K
        kp = this.getES256K();
        keystores.ES256K = kp.getPrivate('hex');
        keyExports.ES256K = await KeyConvert.getES256K(kp);
        keyExports.ES256K.ldJsonPublic = await KeyConvert.createLinkedDataJsonFormat(
            LDCryptoTypes.JWK,
            // @ts-ignore
            { publicJwk: JSON.parse(keyExports.ES256K.ldSuite.publicKeyJwk) },
            false
        );

        // P256
        kp = this.getP256();
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

        this.id = id;

        return this;
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
    Future<Object> sign(AlgorithmTypeString algorithm, Buffer payload) {

        // this.onRequestPassphraseSubscriber.next({ type: 'request_tx', payload, algorithm });

        // const canUseIt = await this.canUse();


        // if (canUseIt) {
        //     const key: ec.KeyPair | eddsa.KeyPair = await this.getPrivateKey(algorithm);
        //     return [null, key.sign(Buffer).toHex()];
        // }
        // return [new Error('invalid_passphrase')]
    }

    ///
    // Signs a JWT for single recipient
    // @param algorithm Algorithm
    // @param payload Payload as buffer
    // @param options options
    ///
    Future<Object> signJWT(AlgorithmTypeString algorithm, Object payload, Object options){

        // this.onRequestPassphraseSubscriber.next({ type: 'request_tx', payload, algorithm });

        // const canUseIt = await this.canUse();


        // if (canUseIt) {
        //     const { pem } = await this.getPrivateKeyExports(algorithm);
        //     return [null, await JWTService.sign(pem, payload, options)];
        // }
        // return [new Error('invalid_passphrase')]

    }

    Future<Object> signJWTFromPublic(Object publicKey, Object payload, Object options){

        // this.onRequestPassphraseSubscriber.next({ type: 'request_tx', payload });

        // const canUseIt = await this.canUse();


        // if (canUseIt) {
        //     return [null, JWTService.sign(publicKey, payload, options)];
        // }

        // return [new Error('invalid_passphrase')]
    }

    ///
    // Encrypts JWE
    // @param algorithm Algorithm 
    // @param payload Payload as buffer
    // @param overrideWithKey Uses this key instead of current wallet key
    // 
    ///
    Future<Object> encryptJWE(AlgorithmTypeString algorithm, Object payload,Object  overrideWithKey) {

        // this.onRequestPassphraseSubscriber.next({ type: 'request_tx', payload, algorithm });

        // const canUseIt = await this.canUse();


        // if (canUseIt) {
        //     let jwk;
        //     if (overrideWithKey === null) {
        //         const keys = await this.getPrivateKeyExports(algorithm);
        //         jwk = keys.jwk;
        //     }
        //     return [null, await JOSEService.encrypt([jwk], payload)];
        // }
        // return [new Error('invalid_passphrase')]

    }

    Future<Object> decryptJWE(AlgorithmTypeString algorithm, Object payload) {

        // this.onRequestPassphraseSubscriber.next({ type: 'request_tx', payload, algorithm });

        // const canUseIt = await this.canUse();


        // if (canUseIt) {
        //     const { jwk } = await this.getPrivateKeyExports(algorithm);

        //     return [null, await JWE.createDecrypt(
        //         await JWK.asKey(jwk, 'jwk')
        //     ).decrypt(payload)];
        // }
        // return [new Error('invalid_passphrase')]
    }
    ///
    // Encrypts JWE with multiple keys
    // @param algorithm 
    // @param payload 
    ///
    Future<Object> encryptMultipleJWE(List<Object> keys,  AlgorithmTypeString algorithm, Object payload){

        this.onRequestPassphraseSubscriber.next({ type: 'request_tx', payload, algorithm });

        const canUseIt = await this.canUse();


        if (canUseIt) {
            const { jwk } = await this.getPrivateKeyExports(algorithm);
            return [null, await JOSEService.encrypt([jwk, ...keys], payload)];
        }
        return [new Error('invalid_passphrase')]
    }
    ///
    //Generates a mnemonic
    //
    String generateMnemonic() {
        return ethers.Wallet.createRandom().mnemonic;
    }

    void open(String id) {
        this.id = id;
        this.onRequestPassphraseSubscriber.next({ type: 'wallet' });
        this.onRequestPassphraseWallet.subscribe(async p => {
            if (p.type !== 'ui') {
                this.accepted = p.accepted;

            } else {
                try {
                    this.db.crypto(p.passphrase);
                    const ks = await this.db.get(id);
                    this.mnemonic = ks.mnemonic;
                    this.onRequestPassphraseSubscriber.next({ type: 'done' })
                } catch (e) {
                    this.onRequestPassphraseSubscriber.next({ type: 'error', error: e })
                }
            }
        });
    }


    ///
    //Derives a new child Wallet
    ///
    ethers.HDNode deriveChild(Number sequence, {String derivation = "m/44'/60'/0'/0"}) {
        const masterKey = HDNode.fromMnemonic(this.mnemonic);
        return masterKey.derivePath(`${derivation}/${sequence}`);
    }

    String get path {
        return path;
    }

    String get address {
        return this.ethersWallet.getAddress();
    }
    ///
    // Derives a wallet from a path
    ///
    ethers.HDNode deriveFromPath(String path) {
        const node = HDNode.fromMnemonic(this.mnemonic).derivePath(path);
        return node;
    }

    ethers.HDNode getFilecoinDeriveChild() {
        return this.deriveFromPath(`m/44'/461'/0/0/1`);
    }

    ///
    // Gets EdDSA key pair
    ///
    eddsa.KeyPair getEd25519() {
        const ed25519 = new eddsa('ed25519');
        // createEd25519()
        // const hdkey = HDKey.fromExtendedKey(HDNode.fromMnemonic(this.mnemonic).extendedKey);
        const { key } = getMasterKeyFromSeed(ethers.utils.HDNode.mnemonicToSeed(this.mnemonic));
        const keypair = ed25519.keyFromSecret(key);
        return keypair;
    }


    ec.KeyPair getP256() {
        const p256 = new ec('p256');
        const keypair = p256.keyFromPrivate(HDNode.fromMnemonic(this.mnemonic).privateKey);
        return keypair;
    }

    ec.KeyPair getES256K() {
        const ES256k = new ec('secp256k1');
        const keypair = ES256k.keyFromPrivate(HDNode.fromMnemonic(this.mnemonic).privateKey);
        return keypair;
    }

    Object getBlsMasterKey() {
        const masterKey = deriveKeyFromMnemonic(this.mnemonic)
        return {
            deriveValidatorKeys: (id: number) => deriveEth2ValidatorKeys(masterKey, id)
        };
    }


    Future<jwk.RSAKey> getRSA256Standalone({int len = 2048}) {
        return JWK.createKey('RSA', len, {
            alg: 'RS256',
            use: 'sig'
        });
(); 
        
        }
             // const ks: KeystoreDb5\Model = await this.db.get(this.id);


        class Keystore {;
        keystore.load'())
}xzzzzz



