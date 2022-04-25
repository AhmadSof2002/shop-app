
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtgrk/shared/cubit/states.dart';
import 'package:mtgrk/shared/network/local/cache_helper.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  // List<Widget> screens = [
  //   NewTasksScreen(),
  //   DoneTasksScreen(),
  //   ArchivedTasksScreen()
  // ];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void updateData({@required String? status, @required int? id}) async {
    database.rawUpdate('UPDATE tasks SET status = ?  WHERE id = ?',
        ['$status', id]).then((value) {
      getDatabase(database);
      emit(AppUpdateDataBaseState());
      // getDatabase(database);
      // emit(AppGetDataBaseState());
    });
  }

  void deleteData({@required int? id}) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDatabase(database);
      emit(AppDeleteDataBaseState());
      // getDatabase(database);
      // emit(AppGetDataBaseState());
    });
  }

  void createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (Database db, int version) {
      // When creating the db, create the table
      print('database created');

      db
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT,status TEXT)')
          .then((value) => print("Table created"))
          .catchError((error) {
        print('${error.toString()}');
      });
    }, onOpen: (database) {
      getDatabase(database);

      print('database opened');
    }).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }

  Future insertToDatabase(
      {required String title,
      required String time,
      required String date}) async {
    return await database.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")')
          .then((value) {
        print('$value has been instered successfully');
        emit(AppInsertDataBaseState());
        getDatabase(database);
      }).catchError((error) {
        print('Error when insterting new record ${error.toString()}');
      });
    });
  }

  void getDatabase(Database database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppGetDataBaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });

      emit(AppGetDataBaseState());
    });
    ;
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  void changeBottomSheetState(
      {@required bool? isShown, @required IconData? Icon}) {
    isBottomSheetShown = isShown!;
    fabIcon = Icon!;
    emit(AppChangeBottomSheetState());
  }
bool isDark=false;
  void changeMode({bool? fromShared}) {
      if(isDark != null ){
        fromShared=isDark;
      }
    isDark = !isDark;
    CacheHelper.putBoolean(key: 'isDark', value: isDark)
        .then((value) => emit(AppChangeModeState()));
  }
}