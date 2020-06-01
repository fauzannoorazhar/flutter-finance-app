import 'package:finance_app/models/finance.dart';
import 'package:finance_app/models/todo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
    // Singleton DatabaseHelper
    static DatabaseHelper _databaseHelper;
    // Singleton Database
    static Database _database;

    String financeTable = 'finance_table';
	String colId = 'id';
	String colRp = 'rp';
	String colDeskripsi = 'deskripsi';
	String colTanggal = 'tanggal';
    String colStatus = 'status';

    DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

    factory DatabaseHelper() {
        if (_databaseHelper == null) {
			_databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
		}
		return _databaseHelper;
    }

    Future<Database> get database async {

		if (_database == null) {
			_database = await initializeDatabase();
		}
		return _database;
	}

    Future<Database> initializeDatabase() async {
		// Get the directory path for both Android and iOS to store database.
		Directory directory = await getApplicationDocumentsDirectory();
		String path = directory.path + 'finance.db';

		// Open/create the database at a given path
		var financesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
		return financesDatabase;
	}

    void _createDb(Database db, int newVersion) async {
		await db.execute('CREATE TABLE $financeTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colRp TEXT, '
				'$colDeskripsi TEXT, $colTanggal TEXT, $colStatus INTEGER)');
	}

    // Fetch Operation: Get all todo objects from database
	Future<List<Map<String, dynamic>>> getTodoMapList() async {
		Database db = await this.database;

        // var result = await db.rawQuery('SELECT * FROM $financeTable order by $colRp ASC');
		var result = await db.query(financeTable, orderBy: '$colTanggal ASC');
		return result;
	}

    // Insert Operation: Insert a todo object to database
	Future<int> insertTodo(Finance finance) async {
		Database db = await this.database;
		var result = await db.insert(financeTable, finance.toMap());
        //var result = await db.rawInsert('INSERT INTO $financeTable($colRp, $colDeskrips) VALUES("some name", 1234, 456.789)');
		return result;
	}

	// Update Operation: Update a todo object and save it to database
	// Future<int> updateTodo(Todo todo) async {
	// 	var db = await this.database;
	// 	var result = await db.update(financeTable, todo.toMap(), where: '$colId = ?', whereArgs: [todo.id]);
	// 	return result;
	// }

  	// Future<int> updateTodoCompleted(Todo todo) async {
	// 	var db = await this.database;
	// 	var result = await db.update(financeTable, todo.toMap(), where: '$colId = ?', whereArgs: [todo.id]);
	// 	return result;
	// }

	// Delete Operation: Delete a todo object from database
	Future<int> deleteTodo(int id) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $financeTable WHERE $colId = $id');
		return result;
	}

	// Get number of todo objects in database
	// Future<int> getCount() async {
	// 	Database db = await this.database;
	// 	List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $financeTable');
	// 	int result = Sqflite.firstIntValue(x);
	// 	return result;
	// }

	// Get the 'Map List' [ List<Map> ] and convert it to 'todo List' [ List<Todo> ]
	Future<List<Finance>> getTodoList() async {

		var todoMapList = await getTodoMapList(); // Get 'Map List' from database
		int count = todoMapList.length;         // Count the number of map entries in db table

		List<Finance> todoList = List<Finance>();
		// For loop to create a 'todo List' from a 'Map List'
		for (int i = 0; i < count; i++) {
			todoList.add(Finance.fromMapObject(todoMapList[i]));
		}

		return todoList;
	}

    Future<int> calculate() async {
        Database db = await this.database;
        var sumStatus1 = await db.rawQuery("SELECT SUM($colRp) as Rp FROM $financeTable WHERE $colStatus = 1");
        var sumStatus2 = await db.rawQuery("SELECT SUM($colRp) as Rp FROM $financeTable WHERE $colStatus = 0");

        int intSumStatus1 = sumStatus1[0]['Rp'] ?? 0;
        int intSumStatus2 = sumStatus2[0]['Rp'] ?? 0;
        int calculate = intSumStatus1 - intSumStatus2;
        
        return calculate;
    }

    Future<List<Map<String, dynamic>>> getTanggalTerakhir() async {
        Database db = await this.database;
        var findTanggal = await db.rawQuery("SELECT $colTanggal FROM $financeTable ORDER BY $colTanggal DESC LIMIT 1");

        return findTanggal;
    }
}