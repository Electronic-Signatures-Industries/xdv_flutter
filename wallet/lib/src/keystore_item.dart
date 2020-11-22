class KeyPairContainer {
  dynamic privateKey;
  dynamic publicKey;
  dynamic ldJSON;
  String pem;
  Map<String, dynamic> jwk;

  KeyPairContainer(dynamic _publicKey, dynamic _privateKey) {
    publicKey = _publicKey;
    privateKey = _privateKey;
    ldJSON = '';
    pem = '';
  }
}
