import 'package:sembast/sembast.dart';
import 'package:wallet/src/keystore_item.dart';
import 'package:x509/x509.dart';

class KeyStore {
  Database database;

  var DEFAULT_KEYSTORE_ITEMS = [
    {name: '', algorithm: '', value: KeystoreItem()}
  ];

  constructor(Database db) {
    database = db;
  }

  void load() async {
    // pre load default keystore items
    var store = intMapStoreFactory.store();
    for (var item in DEFAULT_KEYSTORE_ITEMS) {
      var key = await store.add(database, item);
    }
  }
}
