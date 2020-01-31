import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:grouped_list/grouped_list.dart';

import 'package:todo_firestore/blocs/blocs.dart';
import 'package:todo_firestore/models/todo_model.dart';
import 'package:todo_firestore/components/list_component.dart';
import 'package:todo_firestore/components/button_component.dart';
import 'package:todo_firestore/components/input_component.dart';
import 'package:todo_firestore/pages/login_page.dart';

class TodosPage extends StatefulWidget {

  String username;

  TodosPage({ this.username });

  @override
  _TodosPageState createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {

  TodoBloc todoBloc = TodoBloc();
  AuthBloc authBloc = AuthBloc();

  TextEditingController task = new TextEditingController();
  DateTime selectedDate = DateTime.now();

  int totalTasks = 0;
  String colorSelected = '0xFFe3c800';

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    todoBloc.add(FetchAll());
  }

  Widget _buildGroupSeparator(dynamic groupByValue) {
    final now = DateFormat('yyyy-MM-DD').format(DateTime.now());
    final date = DateFormat('yyyy-MM-DD').format(groupByValue);
    if (date == now) {
      groupByValue = 'Today';
    } else {
      groupByValue = DateFormat('EEE, MMM d, ''yy').format(DateTime.parse(date));
    }
    return Container(
      padding: EdgeInsets.only(top: 15.0),
      child: Text('$groupByValue'),
    );
  }

  Widget todoList(lists) {
    if (lists == null || lists.length == 0) {
      return Center(
        child: Text('No Data'),
      );
    }

    return GroupedListView(
      shrinkWrap: true,
      elements: lists,
      groupBy: (element) => element.date,
      groupSeparatorBuilder: _buildGroupSeparator,
      itemBuilder: (context, element) {
        return ListComponent(
          id: element.key,
          todo: element.todo,
          color: element.color,
          time: element.time,
        );
      },
    );
  }

  Widget RadioComponent(color, Function onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: colorSelected == color ? Color(int.parse(colorSelected)) : Colors.transparent,
            borderRadius: BorderRadius.circular(20.0)
        ),
        child: Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color(int.parse(color))
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              height: 130.0,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ],
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Hello, ${widget.username}',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  Text('You have ${totalTasks} tasks',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    authBloc.add(Logout());
                  }
              )
            ],
          )
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: MultiBlocProvider(
            providers: [
              BlocProvider<TodoBloc>(
                create: (context) => todoBloc,
              ),
              BlocProvider<AuthBloc>(
                create: (context) => authBloc,
              )
            ],
            child: MultiBlocListener(
              listeners: [
                BlocListener<TodoBloc, TodoState>(
                  listener: (context, state) {
                    if (state is TodosLoaded) {
                      setState(() {
                        totalTasks = state.todos.length;
                      });
                    }
                    if (state is TodoSuccess) {
                      Navigator.pop(context);
                      setState(() {
                        selectedDate = DateTime.now();
                        colorSelected = '0xFFe3c800';
                        task.text = '';
                      });
                      todoBloc.add(FetchAll());
                    }
                  },
                ),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is LogoutSuccess) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context)=> LoginPage()));
                    }
                  },
                )
              ],
              child: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
                print(state);
                if (state is TodosLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      todoList(state.todos),
                    ],
                  );
                }

                return Center(
                  child: CircularProgressIndicator()
                );
              },
              ),
            )
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scaffoldKey.currentState.showBottomSheet((context) {
            return StatefulBuilder(
              builder: (context, StateSetter setState) {
                return Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(20.0, 20.0),
                              blurRadius: 20.0,
                              spreadRadius: 20.0
                          )
                        ]
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Add new task'),
                          InputComponent(
                            controller: task,
                            hint: 'New Task',
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              FlatButton(
                                onPressed: () async {
                                  DatePicker.showDateTimePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime.now(),
                                      maxTime: DateTime(2025, 1, 1), onChanged: (date) {
                                        print('change $date');
                                      }, onConfirm: (date) {
                                        print('confirm $date');
                                        setState(() {
                                          selectedDate = date;
                                        });
                                      }, currentTime: DateTime.now());
                                },
                                child: Text('Select Date'),
                              ),
                              Text('$selectedDate')
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RadioComponent('0xFFe3c800', () {
                                  setState(() {
                                    colorSelected = '0xFFe3c800';
                                  });
                                }),
                                RadioComponent('0xFF00e317', () {
                                  setState(() {
                                    colorSelected = '0xFF00e317';
                                  });
                                }),
                                RadioComponent('0xFFe3005b', () {
                                  setState(() {
                                    colorSelected = '0xFFe3005b';
                                  });
                                }),
                                RadioComponent('0xFF001ee3', () {
                                  setState(() {
                                    colorSelected = '0xFF001ee3';
                                  });
                                }),
                                RadioComponent('0xFFe38800', () {
                                  setState(() {
                                    colorSelected = '0xFFe38800';
                                  });
                                }),
                              ],
                            ),
                          ),
                          ButtonComponent(
                            title: 'Add Task',
                            onTap: () {
                              Todo todo = Todo(
                                  color: colorSelected,
                                  todo: task.text,
                                  date: selectedDate
                              );
                              todoBloc.add(Add(todo: todo));
                            },
                          ),
                          RaisedButton(
                            child: Container(
                              width: double.infinity,
                              child: Center(
                                child: Text('Cancel'),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    )
                );
              },
            );
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pinkAccent,
      ),
    );
  }
}
