///*********************************************
/// Created by ukietux on 2019-12-30 with ♥
/// (>’’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’’<)
///*********************************************
/// © 2019 | All Right Reserved
class DbHelper {
  /*Database db;

  Future<Database> get dataBase async {
    if (db != null) return db;
    db = await initDb();
    return db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "lazywa.db");
    var theDb = await openDatabase(path, version: 1, onCreate: onCreate);
    return theDb;
  }

  // Creating a table name Employee with fields
  void onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute('''
    CREATE TABLE numberLog (
        id INTEGER PRIMARY KEY, 
        code TEXT,
        phone TEXT, 
        notes TEXT, 
        message TEXT, 
        createAt Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
        updateAt Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
        )
    ''');
    print("Created tables");
  }*/
}
