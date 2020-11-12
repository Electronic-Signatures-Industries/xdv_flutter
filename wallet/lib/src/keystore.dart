import 'package:sembast/sembast.dart';
import 'package:wallet/src/keystore_item.dart';
import 'package:x509/x509.dart';

class KeyStore {
  Database database;

  var DEFAULT_KEYSTORE_ITEMS = [
    {'sepc256k1': {} as dynamic},
    {'sepc256r1': {} as dynamic},
    {'ed25519': {} as dynamic},
    {'rsa1024': {} as dynamic},
    {'rsa2048': {} as dynamic},
  ] as List<Map<String, KeystoreItem>>;

  set constructor(Database db) {
    database = db;
  }

  void load() async {
    // pre load default keystore items
    var store = intMapStoreFactory.store();
    for (var item in DEFAULT_KEYSTORE_ITEMS) {
      await store.add(database, item);
    }
  }

  setKeyPair(String key, KeystoreItem kp) {
    var store = intMapStoreFactory.store();
    var key_item = store.record(key);

    key_item.update(database, kp);
  }

  // TODO
  // finder
  // getter
  // setter
  // remove

  // NODE MODULES WITH DART FEATURES
  // JWK -> PEM y viceversa
}
