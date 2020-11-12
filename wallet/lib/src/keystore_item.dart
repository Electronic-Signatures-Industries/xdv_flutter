class KeystoreItem {
  String privateKey;
  String publicKey;
  dynamic ldJSON;
  String pem;
  String jwk;

  KeystoreItem(String _publicKey, String _privateKey) {
    publicKey = _publicKey;
    privateKey = _privateKey;
    ldJSON = '';
    pem = '';
    jwk = '';
  }
}
