import 'package:sembast/sembast.dart';
import 'package:wallet/src/keystore_item.dart';
import 'package:wallet/src/wallet_base.dart';
import 'package:x509/x509.dart';
import 'package:sembast/utils/value_utils.dart';
import 'package:sembast_sqflite/sembast_sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class KeyStore {
  var DEFAULT_KEYSTORE_ITEMS = [
    {'algo': 'ed25519'},
    {'algo': 'es256k'},
    {'algo': 'p384'},
    {'algo': 'p256'},
    {'algo': 'sepc256r1'},
    {'algo': 'rsa1024'},
    {'algo': 'rsa2048'},
  ];

  // Use the main store for storing key values as String
  var store = StoreRef<String, dynamic>.main();

  KeyStore();

  void enable() {}

  void lock() {}

  void load(Database database) async {
    // Writing the data
    for (var item in DEFAULT_KEYSTORE_ITEMS) {
      await store.record(item['algo']).put(database, {});
    }
  }

  Future<dynamic> fetchKeyPair(Database database, String key) async {
    // Reading the data
    return await store.record(key).get(database);
  }

  void setKeyPair(Database database, String key, dynamic kp) async {
    await store.record(key).update(database, kp);
  }

  void removeKeyPair(Database database, String key) async {
    await store.record(key).delete(database);
  }

  // TODO
  // getter
  // setter
  // remove

  // NODE MODULES WITH DART FEATURES
  // JWK -> PEM y viceversa
}
