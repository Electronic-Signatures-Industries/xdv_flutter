class FileCoinWallet /*extends Wallet*/ {
  /*
     * Verifies a filecoin signed transaction
     * @param signature a filecoin signature
     * @param cborContent a filecoint raw transaction
     */
  // async verifyFilecoinSignature(signature: string, cborContent: string): Promise<boolean> {
  //     return filecoinSigner.verifySignature(
  //         signature,
  //         cborContent
  //     ) as boolean;
  // }

  /**
     * Signs a filecoin transaction
     * @param transaction a filecoin transaction
     * @param signer Sets the filecoin or lotus signer
     */
  //  signFilecoinTransaction(transaction: any, signer: FilecoinSignTypes): Promise<[Error, any?]> {

  //     this.onRequestPassphraseSubscriber.next({ type: 'request_tx', transaction, algorithm: signer.toString() });

  //     const canUseIt = await this.canUse();
  //     const tx = filecoinSigner.transactionSerialize(transaction);
  //     if (canUseIt) {
  //         let signature;
  //         const pvk = await this.getFilecoinDeriveChild();
  //         if (signer === 'filecoin') {
  //             signature = filecoinSigner.transactionSign(
  //                 tx,
  //                 pvk
  //             );
  //         } else {
  //             signature = filecoinSigner.transactionSignLotus(
  //                 tx,
  //                 pvk
  //             );
  //         }
  //         return [null, signature];
  //     }
  //     return [new Error('invalid_passphrase')]
  // }

}
