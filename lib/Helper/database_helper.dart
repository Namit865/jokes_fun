import 'package:sqflite/sqflite.dart';

class  DatabaseHelper {
  late Database database;

  initDatabase()async{
    database = await openDatabase(
      'quotes.db',
      version:1,
      onCreate: (db,version)async{
        await db.execute(
            'CREATE TABLE quotes(id)');
      }
    );
  }

}