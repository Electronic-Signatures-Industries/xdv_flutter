import 'package:wallet/src/algorithm_type_string.dart';

class jose {
  ///
  // Signs a JWT for single recipient
  // @param algorithm Algorithm
  // @param payload Payload as buffer
  // @param options options
  ///
  Future<Object> signJWT(
      AlgorithmTypeString algorithm, Object payload, Object options) {
    // this.onRequestPassphraseSubscriber.next({ type: 'request_tx', payload, algorithm });

    // const canUseIt = await this.canUse();

    // if (canUseIt) {
    //     const { pem } = await this.getPrivateKeyExports(algorithm);
    //     return [null, await JWTService.sign(pem, payload, options)];
    // }
    // return [new Error('invalid_passphrase')]
  }

  Future<Object> signJWTFromPublic(
      Object publicKey, Object payload, Object options) {
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
  Future<Object> encryptJWE(
      AlgorithmTypeString algorithm, Object payload, Object overrideWithKey) {
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
  Future<Object> encryptMultipleJWE(
      List<Object> keys, AlgorithmTypeString algorithm, Object payload) {
    // this.onRequestPassphraseSubscriber.next({ type: 'request_tx', payload, algorithm });

    // const canUseIt = await this.canUse();

    // if (canUseIt) {
    //     const { jwk } = await this.getPrivateKeyExports(algorithm);
    //     return [null, await JOSEService.encrypt([jwk, ...keys], payload)];
    // }
    // return [new Error('invalid_passphrase')]
  }
}
