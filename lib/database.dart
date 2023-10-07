import 'dart:io';

import 'package:calculations/modles/products.dart';
import 'package:calculations/modles/reciept.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteDbProvider {
  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "ProductDB.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE Product ("
            "id INTEGER PRIMARY KEY,"
            "title,"
            "price REAL,"
            "weight REAL,"
            "specialLetter TEXT,"
            "newWeight REAL,"
            "note TEXT"
            ")");

        await db.execute(
        "CREATE TABLE Recs ("
        "id INTEGET PRIMARY KEY,"
        "title TEXT,"
        "totalWeight REAL,"
        "totalprice REAL,"
        "note TEXT,"
        "text TEXT,"
        "wwwe TEXT"
        ")");
      },
    );
  }

  Future<List<Product>> getAllProducts({String text}) async {
    final db = await database;

    List<Map> results =
        await db.query("Product", columns: Product.columns, orderBy: "id ASC");

    List<Product> products = [];

    results.forEach((result) {
      Product product = Product.fromMap(result);
      products.add(product);
    });

    List<Product> searchProduct = [];

    
    List<Map> resultSearch = await db.rawQuery("SELECT * FROM Product WHERE title LIKE '%${text}%' OR  note LIKE '%${text}%' OR specialLetter LIKE '%${text}%' ");
    resultSearch.forEach((result) {
      Product product = Product.fromMap(result);
      searchProduct.add(product);
    });


      if(text == null) {
        return products;
      } else {
        return searchProduct;
      }
  }




Future<List<Recipt>> getAllRes() async {
    final db = await database;
    List<Map> results =
        await db.query("Recs", columns: Recipt.columns, orderBy: "id ASC");

    List<Recipt> receipts = [];
    results.forEach((result) {
      Recipt reciept = Recipt.fromMap(result);
      receipts.add(reciept);
    });
    return receipts;
  }


  Future<Product> getProductbyid(int id) async {
    final db = await database;
    var result = await db.query("Product", where: "id = ", whereArgs: [id]);
    return result.isNotEmpty ? Product.fromMap(result.first) : null;
  }

    insert(Product product) async {
      final db = await database;
      var maxIdResult = await db.rawQuery(" SELECT MAX (id)+1 as last_inserted_id FROM Product" );
      var id = maxIdResult.first["last_inserted_id"];

        var result = await db.rawInsert("INSERT Into Product ('id', 'title', 'price', 'weight' , 'specialLetter', 'newWeight','note')" 
        "values( ?, ?, ?, ?, ? ,?,?)",
        [id, product.title, product.price, product.weight, product.specialLetter, product.newWeight, product.note]
        );
        return result;
    }


      insertRes(Recipt recipt) async {
      final db = await database;
      var maxIdResult = await db.rawQuery(" SELECT MAX (id)+1 as last_inserted_id FROM Recs" );
      var id = maxIdResult.first["last_inserted_id"];
      

        var result = await db.rawInsert("INSERT Into Recs ('id', 'title', 'totalWeight', 'totalprice', 'note', 'text' , 'wwwe')" 
        "values( ?, ?, ?, ?, ? , ?, ?)",
        [id, recipt.title, recipt.totalWeight, recipt.totalprice , recipt.note, recipt.text , recipt.wwwe]
        );
        return result;
    }

delete(int id) async { 
   final db = await database; 
   db.delete("Product", where: "id = ?", whereArgs: [id]); 
}

update(Product product) async { 
   final db = await database; 
   var result = await db.update("Product", product.toMap(), 
   where: "id = ?", whereArgs: [product.id]); return result; 
} 

updateRecipt(Recipt recipt) async { 
   final db = await database; 
   var result = await db.update("Recs", recipt.toMap(), 
   where: "title = ?", whereArgs: [recipt.title]); return result; 
} 


 search (String text) async {
   final db = await database; 
  var res = await db.rawQuery( "SELECT * FROM Product WHERE title LIKE '%${text}%' OR  note LIKE '$text'");
  print (res);
}



deleteRes(Recipt recipt) async { 
   final db = await database; 
   db.delete("Recs", where: "title = ?", whereArgs: [recipt.title]); 
}




}
