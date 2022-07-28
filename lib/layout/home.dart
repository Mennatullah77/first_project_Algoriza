import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/default_form_field.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/constants/constants.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/layout/task.dart';

var scaffoldKey = GlobalKey<ScaffoldState>();
var titleController = TextEditingController();
var deadlineController = TextEditingController();
var start_timeController = TextEditingController();
var end_timeController = TextEditingController();
var remindController = TextEditingController();
var repeatController = TextEditingController();


var formKey = GlobalKey<FormState>();

class Home extends StatelessWidget {
  static const List<Tab> tabs = <Tab>[
    Tab(text: 'All' ),
    Tab(text: 'Completed'),
    Tab(text: 'Uncompleted'),
    Tab(text: 'Favorite'),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
//cubit.titles[cubit.bottomNavigtionIndex],
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.black,
              key: scaffoldKey,
              appBar: AppBar(
                backgroundColor: Colors.black,
                actions: <Widget>[
                  IconButton(onPressed: () {},
                    visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.search),
                    iconSize: 18,
                    color: Colors.grey,
                  )
                  ,
                  IconButton(onPressed: () {},
                    visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                    padding: EdgeInsets.only(left:10 , right: 15),
                    icon: Icon(Icons.notifications),
                    iconSize: 18,
                    color: Colors.grey,
                  ),

                  IconButton(onPressed: () {},
                    visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                    padding: EdgeInsets.only(right: 25),
                    icon: Icon(Icons.menu),
                    iconSize: 18,
                    color: Colors.grey,
                  )
                ],
                    title: Text('Todo' , style: TextStyle(color: Colors.grey)
                ),),
              //   bottom: const TabBar(
              //     tabs: tabs,
              //   ),
              // ),
              body:
              cubit.screens[cubit.bottomNavigtionIndex],

              floatingActionButton: FloatingActionButton(
                onPressed: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  task()));
            }
              )
              );

              // Stack(
              //     children :[
              //       // TabBarView(
              //       //   children: tabs.map((Tab tab) {
              //       //     return
              //       //       Center(
              //       //         child: Text(
              //       //           '${tab.text!} Tab',
              //       //           style: Theme.of(context).textTheme.headline5,
              //       //         ),
              //       //       );
              //       //
              //       //
              //       //   }).toList(),
              //       // ),
              //       Align(
              //           alignment: Alignment.bottomCenter,
              //           child: Container(
              //
              //             margin: const EdgeInsets.all(20),
              //             height: 45,
              //             width: double.infinity,
              //             child: ElevatedButton(
              //               onPressed: () {
              //                 Navigator.push(
              //                     context,
              //                     MaterialPageRoute(builder: (context) =>  task())
              //                 );
              //               },
              //               style:
              //               ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(40.0),
              //
              //               ),
              //                   primary: Colors.green
              //               ),
              //               child: const Text('Add a task'),
              //             ),
              //             // floatingActionButton:
              //             // SizedBox(
              //             //   height: 20.0,
              //             //   width: double.infinity,
              //             //   child: FittedBox(
              //             //     child: FloatingActionButton.extended(
              //             //       label: const Text('Add a task'),
              //             //       onPressed: () {},
              //             //     ),
              //             //   ),
              //             // ),
              //
              //           )
              //       ),
              //     ]
              // )


          }),
    );
  }
}
