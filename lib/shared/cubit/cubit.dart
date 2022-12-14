import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo_app/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo_app/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/shared/constants/constants.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Map> newTasks = [];
  List<Map> completedTasks = [];
  List<Map> favoriteTasks = [];

  int bottomNavigtionIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];
  Database? database;
  List<String> titles = ['Todo Tasks', 'Done Tasks', 'Archived Tasks'];
  bool isBottomSheetShown = false;
  Icon floatingButtonIcon = Icon(Icons.edit);

  void changeIndex(int index) {
    bottomNavigtionIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void updateDatabase(String status, int id) async {
    database!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataBase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteFromDatabase(int id) async {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataBase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
                //id integer
                //title string
                //deadline string
                // start_time string
                //end_time string
                //remind string
                //repeat string
                //status string

                //data string
                //time string
                //status string
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, deadline TEXT, start_time TEXT, end_time TEXT,'
                    ' remind TEXT ,repeat TEXT, status TEXT)')
            .then((value) => print('Table Created'))
            .catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataBase(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  void getDataBase(database) async {
    newTasks = [];
    completedTasks = [];
    favoriteTasks = [];
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      //print(value);
      value.forEach((element) {
        print(element['id']);
        if (element['status'] == 'New') {
          newTasks.add(element);
        } else if (element['status'] == 'completed') {
          completedTasks.add(element);
        } else {
          favoriteTasks.add(element);
        }
      });
      emit(AppGetDatabaseState());
    });
  }

  insertToDatabase(
      {required String title,
      required String deadline,
      required String start_time,
        required String end_time,
        required String remind,
        required String repeat,




      }) async {
    await database!.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks (title, deadline, start_time, end_time, remind, repeat, status) VALUES ("$title","$deadline","$start_time","$end_time", "$remind", "$repeat" , "New")')
          .then((value) {
        getDataBase(database);
        print('$value Inserted Successfully');
        emit(AppInsertDatabaseState());
      }).catchError((error) {
        print('Error When inserting Table ${error.toString()}');
      });
    });
  }

  void changeBottomSheetState(bool isShow, Icon icon) {
    isBottomSheetShown = isShow;
    floatingButtonIcon = icon;
    emit(AppChangeBottomSheetState());
  }
}
