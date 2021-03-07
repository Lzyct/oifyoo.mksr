import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

///*********************************************
/// Created by ukietux on 2019-12-30 with ♥
/// (>’’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’’<)
///*********************************************
/// © 2019 | All Right Reserved
class DbHelper {
  Database? db;

  Future<Database?> get dataBase async {
    if (db != null) return db;
    db = await initDb();
    return db;
  }

  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "oifyoo_mksr.db");
    var theDb = await openDatabase(path, version: 1, onCreate: onCreate);
    return theDb;
  }

  // Creating a table name Employee with fields
  void onCreate(Database db, int version) async {
    //create table product
    await db.execute('''
    CREATE TABLE product (
        id INTEGER PRIMARY KEY, 
        productName TEXT,
        note TEXT, 
        qty INTEGER, 
        sellingPrice INTEGER,
        purchasePrice INTEGER,
        createdAt Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
        updatedAt Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
        )
    ''');
    //create table transaction
    await db.execute('''
    CREATE TABLE transaksi (
        id INTEGER PRIMARY KEY,
        transactionNumber TEXT,
        idProduct INTEGER,
        qty INTEGER,
        price INTEGER,
        discount INTEGER,
        productName TEXT,
        type TEXT,
        status TEXT,
        note TEXT,
        buyer TEXT,
        createdAt Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
        updatedAt Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
        )
    ''');
    //create table transaction
    await db.execute('''
    CREATE TABLE spending (
        id INTEGER PRIMARY KEY,
        name TEXT,
        price INTEGER,
        note TEXT,
        createdAt Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
        updatedAt Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
        )
    ''');
    print("Created tables");
  }
}
