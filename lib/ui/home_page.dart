import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todoso/controllers/task_controller.dart';
import 'package:todoso/models/task.dart';
import 'package:todoso/services/notification_services.dart';
import 'package:todoso/services/theme_service.dart';
import 'package:todoso/ui/add_task_page.dart';
import 'package:todoso/ui/constants/constants.dart';
import 'package:todoso/ui/theme.dart';
import 'package:todoso/ui/widgets/button.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:todoso/ui/widgets/task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

var notifyHelper;
final _taskController = Get.put(TaskController());
var _selectedDate;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    _selectedDate = DateTime.now();
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _addTaskBar(),
          _addDateBar(),
          SizedBox(height: 10),
          _showTask(),
        ],
      ),
    );
  }

  _showTask() {
    return Expanded(child: Obx(() {
      return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (_, index) {
            print(_taskController.taskList.length);
            return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                    child: FadeInAnimation(
                        child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          print("Tapped");
                          _showBottomSheet(
                              context, _taskController.taskList[index]);
                        },
                        child: (TaskTile(_taskController.taskList[index]))),
                  ],
                ))));
          });
    }));
  }

  Container _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        onDateChange: (selectedDate) {
          _selectedDate = selectedDate;
        },
      ),
    );
  }

  Container _addTaskBar() {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat.yMMMd().format(DateTime.now()),
                style: subHeadingStyle),
            Text("Today", style: headingStyle),
          ],
        ),
        MyButton(
            label: " + Add Task",
            onTap: () async {
              await Get.to(AddTaskPage());
              _taskController.getTasks();
            }),
      ]),
    );
  }

  void _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 4),
      height: task.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.34,
      color: Get.isDarkMode ? darkGreyClr : Colors.white,
    ));
  }
}

_appBar(BuildContext context) {
  return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
              title: "Theme Changed",
              body: Get.isDarkMode
                  ? "Activated Light Theme"
                  : "Activated DarkTheme");
          notifyHelper.scheduledNotification();
        },
        child: Icon(
            Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
            size: 20,
            color: Get.isDarkMode ? Colors.white : Colors.black),
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/profile.png"),
        ),
        const SizedBox(width: 10),
      ]);
}
