import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/default_form_field.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/constants/constants.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/layout/home.dart';

var scaffoldKey = GlobalKey<ScaffoldState>();
var titleController = TextEditingController();
var deadlineController = TextEditingController();
var start_timeController = TextEditingController();
var end_timeController = TextEditingController();
var remindController = TextEditingController();
var repeatController = TextEditingController();


var formKey = GlobalKey<FormState>();


class task extends StatelessWidget {
  const task({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()..createDatabase(),
        child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
    builder: (context, state) {
      AppCubit cubit = AppCubit.get(context);
      return Scaffold(
          appBar: AppBar(
              title: Text('Board', style: TextStyle(color: Colors.grey),)),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    color: Colors.red,
                  ),
                  height: 50,
                  child: Center(
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 25,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  Home())
                              );
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color:
                                  Colors.amber.shade700,
                                  fontSize: 16,
                                  fontWeight:
                                  FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                            width: 105,
                          ),
                          Text(
                            'Add Task',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      )),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    color: kThemeColorLight,
                  ),
                  child: Form(
                    key: formKey,

                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(
                          parent:
                          AlwaysScrollableScrollPhysics()),
                      child: Column(
                        //mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          DefaultFormField(
                            controller: titleController,
                            label: 'New Task',
                            type: TextInputType.text,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Title must not be empty';
                              }
                              return null;
                            },
                            prefix: Icons.title,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DefaultFormField(
                              onTap: () {
                                print('Tapped');
                                showDatePicker(
                                    context: context,
                                    initialDate:
                                    DateTime
                                        .now(),
                                    firstDate:
                                    DateTime
                                        .now(),
                                    lastDate: DateTime
                                        .parse(
                                        '2022-07-28'))
                                    .then((value) =>
                                deadlineController
                                    .text = DateFormat
                                    .yMMMd()
                                    .format(
                                    value!));
                              },
                              controller: deadlineController,
                              label: 'Task Deadline',
                              type:
                              TextInputType.datetime,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Date must not be empty';
                                }

                                return null;
                              },
                              prefix:
                              Icons.calendar_today),
                          SizedBox(
                            height: 10,
                          ),
                          DefaultFormField(
                              onTap: () {
                                showTimePicker(
                                    context: context,
                                    initialTime:
                                    TimeOfDay
                                        .now())
                                    .then((value) =>
                                start_timeController
                                    .text =
                                    value!.format(
                                        context));
                              },
                              controller: start_timeController,
                              label: 'Start Time',
                              type:
                              TextInputType.datetime,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Start Time must not be empty';
                                }
                                return null;
                              },
                              prefix: Icons
                                  .watch_later_outlined),
                          SizedBox(
                            height: 10,
                          ),
                          DefaultFormField(
                              onTap: () {
                                showTimePicker(
                                    context: context,
                                    initialTime:
                                    TimeOfDay
                                        .now())
                                    .then((value) =>
                                end_timeController
                                    .text =
                                    value!.format(
                                        context));
                              },
                              controller: end_timeController,
                              label: 'End Time',
                              type:
                              TextInputType.datetime,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'End Time must not be empty';
                                }
                                return null;
                              },
                              prefix: Icons
                                  .watch_later_outlined),
                          SizedBox(
                            height: 10,
                          ),
                          DefaultFormField(
                            controller: remindController,
                            label: 'Remind',
                            type: TextInputType.text,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Remind must not be empty';
                              }
                              return null;
                            },
                            prefix: Icons.title,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DefaultFormField(
                            controller: repeatController,
                            label: 'Repeat',
                            type: TextInputType.text,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Repeat must not be empty';
                              }
                              return null;
                            },
                            prefix: Icons.title,
                          ),

                          SizedBox(
                            height: 320,
                          ),
                        ],
                      ),
                    ),
      ),

                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: kThemeColorLight,
              child: cubit.floatingButtonIcon,
              onPressed: () {

                  if (formKey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  Home())
                    );
                    cubit
                        .insertToDatabase(
                      title: titleController.text,
                      deadline: deadlineController.text,
                      start_time: start_timeController.text,
                      end_time: end_timeController.text,
                      remind: remindController.text,
                      repeat: repeatController.text,
                    )

                        .then((value) {
                      Navigator.pop(context);
                      titleController.clear();
                      deadlineController.clear();
                      start_timeController.clear();
                      end_timeController.clear();
                      remindController.clear();
                      repeatController.clear();

                    });


                  }
                }

          )
      );
    }),
    );
  }
}
