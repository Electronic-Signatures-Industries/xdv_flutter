import 'package:sembast/sembast.dart';
import 'package:wallet/src/keystore_item.dart';
import 'package:x509/x509.dart';

class KeyStore {
  Database database;

  var DEFAULT_KEYSTORE_ITEMS = [
    {'sepc256k1': KeystoreItem()},
    {'sepc256r1': KeystoreItem()},
    {'ed25519': KeystoreItem()},
    {'rsa1024': KeystoreItem()},
    {'rsa2048': KeystoreItem()},
  ] as List<Map<String, KeystoreItem>>;

  constructor(Database db) {
    database = db;
  }

  void load() async {
    // pre load default keystore items
    var store = intMapStoreFactory.store();
    for (var item in DEFAULT_KEYSTORE_ITEMS) {
      await store.add(database, item);
    }
  }
}
