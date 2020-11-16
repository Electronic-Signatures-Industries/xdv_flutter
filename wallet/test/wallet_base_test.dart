// Import the test package and Counter class
import 'package:test/test.dart';
import 'package:wallet/src/wallet_base.dart' as wallet_base;

import 'package:test/test.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_sqflite/sembast_sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:wallet_core/wallet_core.dart';

import '../lib/src/algorithm_factory.dart';

void main() {
  test('keystore create', () async {
    final wallet = wallet_base.Wallet();

    var response = await wallet.create('',
        'hurry common fish horn region opinion clinic arrow trap amused keen despair');

    expect(response, 1);
  });
  test('db create', () async {
    var DEFAULT_KEYSTORE_ITEMS = [
      {'algo': 'ed25519'},
      {'algo': 'es256k'},
      {'algo': 'sepc256r1'},
      {'algo': 'rsa1024'},
      {'algo': 'rsa2048'},
    ];

    // The sqflite base factory

    var factory = getDatabaseFactorySqflite(databaseFactoryFfi);

    final dbFolder = '/home/luis/Documents/projects/xdv_flutter/wallet/';
    var db = await factory.openDatabase(join(dbFolder, 'example.db'));
    // Use the main store for storing key values as String
    var store = StoreRef<String, dynamic>.main();

    // Writing the data
    for (var item in DEFAULT_KEYSTORE_ITEMS) {
      await store.record(item['algo']).put(db, {});
    }

    var algo = 'ed25519';
    // Reading the data
    var key1 = await store.record(algo).get(db);
    print('key1 (empty): $key1');

    var mnemonic =
        'hurry common fish horn region opinion clinic arrow trap amused keen despair';
    var kp = await AlgorithmFactory.create(algo, mnemonic);

    await store.record(algo).update(db, kp);
    // Reading the data
    key1 = await store.record(algo).get(db);
    print('key1 (fill): $key1');
  });
  test('simple sqflite example', () async {
    // The sqflite base factory

    var factory = getDatabaseFactorySqflite(databaseFactoryFfi);

    final dbFolder = '/home/luis/Documents/projects/xdv_flutter/wallet/';
    var db = await factory.openDatabase(join(dbFolder, 'example.db'));
    // Use the main store for storing key values as String
    var store = StoreRef<String, String>.main();

    // Writing the data
    await store.record('username').put(db, 'my_username');

    // Reading the data
    var url = await store.record('url').get(db);
    var username = await store.record('username').get(db);

    print('url: $url');
    print('username: $username');
  });
}
