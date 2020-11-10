import 'dart:collection';
import 'dart:svg';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jose/jose.dart';
import 'package:web3dart/web3dart.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:cryptography/cryptography.dart';

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
  set() {return 0;}
  remove()  {return 0;}
  find()  {return 0;} 
  void lock();
  void enable();
}


mixin AndroidKeyStore implements KeyStore, HDWallet {
}

mixin SigningKeypairTypes implements List {
}


class WalletKeyStore implements KeyStore{
  @override
  enable() {
    // TODO: implement enable
    throw UnimplementedError();
  }

  @override
  find() {
    // TODO: implement find
    throw UnimplementedError();
  }

  @override
  lock() {
    // TODO: implement lock
    throw UnimplementedError();
  }

  @override
  remove() {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  set() {
    // TODO: implement set
    throw UnimplementedError();
  }

}

type FilecoinSignTypes = 'filecoin' | 'lotus';
class Wallet {
    // id: string;
    // onRequestPassphraseSubscriber: Subject = new Subject<string>();
    // onRequestPassphraseWallet: Subject = new Subject<string>();
    // onSignExternal: Subject = new Subject<{
    //     isEnabled: boolean;
    //     signature: string | Buffer;
    // }>();
    // private db = new PouchDB('xdv:web:wallet');
    // ethersWallet: any;
    // mnemonic: any;
    // accepted: any;
    constructor() {
        // PouchDB.plugin(require('crypto-pouch'));
    }


    
    /**
     * Gets a key from storage
     * @param id 
     * @param algorithm 
     */
    getPublicKey(id: string) {
        const content = await this.db.get(id);
        return await JWK.asKey(JSON.parse(content.key), 'jwk');
    }


    /**
     * Sets a key in storage
     * @param id 
     * @param algorithm 
     * @param value 
     */
    setPublicKey(id: string, algorithm: AlgorithmTypeString, value: object) {
        // if ([AlgorithmType.P256_JWK_PUBLIC, AlgorithmType.RSA_JWK_PUBLIC, AlgorithmType.ED25519_JWK_PUBLIC,
        // AlgorithmType.ES256K_JWK_PUBLIC].includes(AlgorithmType[algorithm])) {
        //     await this.db.put({
        //         _id: id,
        //         key: value
        //     });
        // }
    }

    getImportKey(id: string) {
        // const content = await this.db.get(id);
        // return content;
    }

    /**
     * Sets a key in storage
     * @param id 
     * @param algorithm 
     * @param value 
     */
    setImportKey(id: string, value: object) {

        // await this.db.put({
        //     _id: id,
        //     key: value
        // });
    }

    create(password: string, mnemonic?: string) {
        // const id = Buffer.from(ethers.utils.randomBytes(100)).toString('base64');

        // if (mnemonic) {
        //     this.ethersWallet = ethers.Wallet.fromMnemonic(mnemonic);
        // } else {
        //     this.ethersWallet = ethers.Wallet.createRandom();
        //     mnemonic = this.ethersWallet.mnemonic;
        // }

        // this.mnemonic = mnemonic


        // let keystores: KeyStoreModel = new KeyStore()
        // let keyExports: KeyStoreModel = new KeyStore();

        // // Filecoin
        // let keyFil = this.getFilecoinDeriveChild();
        // keystores.Filecoin = keyFil;

        // // ED25519
        // let kp = this.getEd25519();
        // keystores.ED25519 = kp.getSecret('hex');
        // keyExports.ED25519 = await KeyConvert.getEd25519(kp);
        // keyExports.ED25519.ldJsonPublic = await KeyConvert.createLinkedDataJsonFormat(
        //     LDCryptoTypes.Ed25519,
        //     kp,
        //     false);


        // // ES256K
        // kp = this.getES256K();
        // keystores.ES256K = kp.getPrivate('hex');
        // keyExports.ES256K = await KeyConvert.getES256K(kp);
        // keyExports.ES256K.ldJsonPublic = await KeyConvert.createLinkedDataJsonFormat(
        //     LDCryptoTypes.JWK,
        //     // @ts-ignore
        //     { publicJwk: JSON.parse(keyExports.ES256K.ldSuite.publicKeyJwk) },
        //     false
        // );

        // // P256
        // kp = this.getP256();
        // keystores.P256 = kp.getPrivate('hex');
        // keyExports.P256 = await KeyConvert.getP256(kp);
        // keyExports.P256.ldJsonPublic = await KeyConvert.createLinkedDataJsonFormat(
        //     LDCryptoTypes.JWK,
        //     // @ts-ignore
        //     { publicJwk: JSON.parse(keyExports.P256.ldSuite.publicKeyJwk) },
        //     false
        // );
        // // RSA
        // kp = await Wallet.getRSA256Standalone();
        // keystores.RSA = kp.toJSON(true);
        // keyExports.RSA = await KeyConvert.getRSA(kp);

        // const keystoreMnemonicAsString = await this.ethersWallet.encrypt(password);

        // const model: KeystoreDbModel = {
        //     _id: id,
        //     keypairs: keystores,
        //     keystoreSeed: keystoreMnemonicAsString,
        //     mnemonic: mnemonic,
        //     keypairExports: keyExports,

        // }

        // await this.db.crypto(password);
        // await this.db.put(model);

        // this.id = id;

        // return this;
    }

    getPrivateKey(algorithm: AlgorithmTypeString): Promise<ec.KeyPair | eddsa.KeyPair> {


        // const ks: KeystoreDbModel = await this.db.get(this.id);

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

    getPrivateKeyExports(algorithm: AlgorithmTypeString) {
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


    /**
     * Signs with selected algorithm
     * @param algorithm Algorithm
     * @param payload Payload as buffer
     * @param options options
     */
    sign(algorithm: AlgorithmTypeString, payload: Buffer): Promise<[Error, any?]> {

        // this.onRequestPassphraseSubscriber.next({ type: 'request_tx', payload, algorithm });

        // const canUseIt = await this.canUse();


        // if (canUseIt) {
        //     const key: ec.KeyPair | eddsa.KeyPair = await this.getPrivateKey(algorithm);
        //     return [null, key.sign(Buffer).toHex()];
        // }
        // return [new Error('invalid_passphrase')]
    }

    /**
     * Signs a JWT for single recipient
     * @param algorithm Algorithm
     * @param payload Payload as buffer
     * @param options options
     */
    signJWT(algorithm: AlgorithmTypeString, payload: any, options: any): Promise<[Error, any?]> {

        // this.onRequestPassphraseSubscriber.next({ type: 'request_tx', payload, algorithm });

        // const canUseIt = await this.canUse();


        // if (canUseIt) {
        //     const { pem } = await this.getPrivateKeyExports(algorithm);
        //     return [null, await JWTService.sign(pem, payload, options)];
        // }
        // return [new Error('invalid_passphrase')]

    }

    signJWTFromPublic(publicKey: any, payload: any, options: any): Promise<[Error, any?]> {

        // this.onRequestPassphraseSubscriber.next({ type: 'request_tx', payload });

        // const canUseIt = await this.canUse();


        // if (canUseIt) {
        //     return [null, JWTService.sign(publicKey, payload, options)];
        // }

        // return [new Error('invalid_passphrase')]
    }

    /**
     * Encrypts JWE
     * @param algorithm Algorithm 
     * @param payload Payload as buffer
     * @param overrideWithKey Uses this key instead of current wallet key
     * 
     */
    encryptJWE(algorithm: AlgorithmTypeString, payload: any, overrideWithKey: any): Promise<[Error, any?]> {

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

    decryptJWE(algorithm: AlgorithmTypeString, payload: any): Promise<[Error, any?]> {

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
    /**
     * Encrypts JWE with multiple keys
     * @param algorithm 
     * @param payload 
     */
    encryptMultipleJWE(keys: any[], algorithm: AlgorithmTypeString, payload: any): Promise<[Error, any?]> {

        this.onRequestPassphraseSubscriber.next({ type: 'request_tx', payload, algorithm });

        const canUseIt = await this.canUse();


        if (canUseIt) {
            const { jwk } = await this.getPrivateKeyExports(algorithm);
            return [null, await JOSEService.encrypt([jwk, ...keys], payload)];
        }
        return [new Error('invalid_passphrase')]
    }
    /**
    * Generates a mnemonic
    */
    generateMnemonic() {
        return ethers.Wallet.createRandom().mnemonic;
    }

    open(id: string) {
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


    /**
     * Derives a new child Wallet
     */
    deriveChild(sequence: number, derivation = "m/44'/60'/0'/0"): ethers.HDNode {
        const masterKey = HDNode.fromMnemonic(this.mnemonic);
        return masterKey.derivePath(`${derivation}/${sequence}`);
    }

    get path() {
        return this.ethersWallet.path;
    }

    get address() {
        return this.ethersWallet.getAddress();
    }
    /**
     * Derives a wallet from a path
     */
    deriveFromPath(path: string): ethers.HDNode {
        const node = HDNode.fromMnemonic(this.mnemonic).derivePath(path);
        return node;
    }

    getFilecoinDeriveChild(): ethers.HDNode {
        return this.deriveFromPath(`m/44'/461'/0/0/1`);
    }

    /**
     * Gets EdDSA key pair
     */
    getEd25519(): eddsa.KeyPair {
        const ed25519 = new eddsa('ed25519');
       // createEd25519()
        // const hdkey = HDKey.fromExtendedKey(HDNode.fromMnemonic(this.mnemonic).extendedKey);
        const { key } = getMasterKeyFromSeed(ethers.utils.HDNode.mnemonicToSeed(this.mnemonic));
        const keypair = ed25519.keyFromSecret(key);
        return keypair;
    }


    getP256(): ec.KeyPair {
        const p256 = new ec('p256');
        const keypair = p256.keyFromPrivate(HDNode.fromMnemonic(this.mnemonic).privateKey);
        return keypair;
    }

    getES256K(): ec.KeyPair {
        const ES256k = new ec('secp256k1');
        const keypair = ES256k.keyFromPrivate(HDNode.fromMnemonic(this.mnemonic).privateKey);
        return keypair;
    }

    getBlsMasterKey(): any {
        const masterKey = deriveKeyFromMnemonic(this.mnemonic)
        return {
            deriveValidatorKeys: (id: number) => deriveEth2ValidatorKeys(masterKey, id)
        };
    }


    static getRSA256Standalone(len: number = 2048): Promise<JWK.RSAKey> {
        return JWK.createKey('RSA', len, {
            alg: 'RS256',
            use: 'sig'
        });
    }


}
