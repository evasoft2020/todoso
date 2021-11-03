import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:intl/intl.dart';
import 'package:todoso/controllers/task_controller.dart';
import 'package:todoso/models/task.dart';
import 'package:todoso/ui/constants/constants.dart';
import 'package:todoso/ui/theme.dart';
import 'package:todoso/ui/widgets/button.dart';
import 'package:todoso/ui/widgets/my_input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20, 25, 30];
  String _selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Add Task", style: headingStyle),
            MyInputField(
                title: "Title",
                hint: "Enter your title",
                controller: _titleController),
            MyInputField(
                title: "Note",
                hint: "Enter your note",
                controller: _noteController),
            MyInputField(
              title: "Date",
              hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(
                icon: Icon(Icons.calendar_today_outlined, color: Colors.grey),
                onPressed: () {
                  print("Hi");
                  _getDateFromUser();
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: MyInputField(
                        title: "Start Date",
                        hint: _startTime,
                        widget: IconButton(
                          onPressed: () {
                            _getTimeFromUser(isStartDate: true);
                          },
                          icon: Icon(Icons.access_time_filled_rounded,
                              color: Colors.grey),
                        ))),
                SizedBox(width: 10),
                Expanded(
                    child: MyInputField(
                        title: "End Date",
                        hint: _endTime,
                        widget: IconButton(
                          onPressed: () {
                            _getTimeFromUser(isStartDate: false);
                          },
                          icon: Icon(Icons.access_time_filled_rounded,
                              color: Colors.grey),
                        )))
              ],
            ),
            MyInputField(
              title: "Remind",
              hint: "$_selectedRemind minutes early",
              widget: DropdownButton(
                onChanged: (String? value) {
                  setState(() {
                    _selectedRemind = int.parse(value!);
                  });
                },
                underline: Container(height: 0),
                items: remindList.map<DropdownMenuItem<String>>((int value) {
                  return DropdownMenuItem<String>(
                      value: value.toString(), child: Text(value.toString()));
                }).toList(),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
              ),
            ),
            MyInputField(
              title: "Repeat",
              hint: "$_selectedRepeat",
              widget: DropdownButton(
                onChanged: (String? value) {
                  setState(() {
                    _selectedRepeat = value!;
                  });
                },
                underline: Container(height: 0),
                items:
                    repeatList.map<DropdownMenuItem<String>>((String? value) {
                  return DropdownMenuItem<String>(
                      value: value,
                      child:
                          Text(value!, style: TextStyle(color: Colors.grey)));
                }).toList(),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 18),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _colorPalette(),
                  MyButton(
                    label: "Create Task",
                    onTap: () => _validateDate(),
                  )
                ]),
          ]),
        ),
      ),
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDB();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar("Required", " All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.warning_amber_rounded));
    }
  }

  _addTaskToDB() async {
    int _value = await _taskController.addTask(
        task: Task(
      title: _titleController.text,
      note: _noteController.text,
      date: DateFormat.yMd().format(_selectedDate),
      startTime: _startTime,
      endTime: _endTime,
      remind: _selectedRemind,
      repeat: _selectedRepeat,
      color: _selectedColor,
      isCompleted: 0,
    ));
    print("My id is : $_value");
  }

  Column _colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Color", style: titleStyle),
        SizedBox(height: 8),
        Wrap(
          children: List<Widget>.generate(3, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? primaryClr
                        : index == 1
                            ? pinkClr
                            : yellowClr,
                    child: _selectedColor == index
                        ? Icon(Icons.done, color: Colors.white, size: 18)
                        : Container()),
              ),
            );
          }),
        )
      ],
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios,
              color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/profile.png"),
          ),
          SizedBox(width: 10)
        ]);
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2022),
    );
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("Null or Wrong Something!");
    }
  }

  _getTimeFromUser({required bool isStartDate}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time canceled");
    } else if (isStartDate == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartDate == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])));
  }
}
