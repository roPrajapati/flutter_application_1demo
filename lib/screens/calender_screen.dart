import 'package:flutter/material.dart';
import 'package:flutter_application_1demo/controller/calender_controller.dart';
import 'package:flutter_application_1demo/utils/extensions.dart';
import 'package:get/get.dart';


class CalenderScreen extends StatelessWidget {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Calender"),
        leading: const Icon(Icons.menu),
        actions: [const Icon(Icons.notifications)],
      ),
      body: GetBuilder<CalenderController>(
        init: CalenderController(),
        builder: (CalenderController controller) {
         
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CalenderHeader(
                  selectedMonth: controller.selectedMonth,
                  selectedDate: controller.selectedDate,
                  onChange: (value) => controller.selectMonth(value),
                ),
               
                Expanded(
                  child: CalenderBody(
                      selectedDate: controller.selectedDate,
                      selectedMonth: controller.selectedMonth,
                      selectDate: (DateTime value) =>
                          controller.selectMonthDay(value)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CalenderRowItem extends StatelessWidget {
   const CalenderRowItem({
    required this.hasRightBorder,
    required this.isActiveMonth,
    required this.isSelected,
    required this.date,
    required this.onTap,
  });

  final bool hasRightBorder;
  final bool isActiveMonth;
  final VoidCallback onTap;
  final bool isSelected;

  final DateTime date;
  @override
  Widget build(BuildContext context) {
    final int number = date.day;
    
    

    final isToday = date.isToday;
    final bool isPassed = date.isBefore(DateTime.now());

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
        width: 50,
        decoration: isActiveMonth
            ? isToday
                ? BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10))
                : BoxDecoration(
                    color: isSelected ? Colors.green : Colors.transparent,
                    border: Border.all(
                        color: isSelected ? Colors.green : Colors.grey),
                    borderRadius: BorderRadius.circular(10))
            : null,
        child: Text(
          number.toString(),
          style: TextStyle(
              fontSize: 14,
              color: isPassed
                  ? isActiveMonth
                      ? Colors.grey
                      : Colors.transparent
                  : isActiveMonth
                      ? Colors.black
                      : Colors.grey[300]),
        ),
      ),
    );
  }
}

class CalenderBody extends StatelessWidget {
  const CalenderBody({
    required this.selectedMonth,
    required this.selectedDate,
    required this.selectDate,
  });

  final DateTime selectedMonth;
  final DateTime? selectedDate;

  final ValueChanged<DateTime> selectDate;

  @override
  Widget build(BuildContext context) {
    CalendarMonthData data = CalendarMonthData(
      year: selectedMonth.year,
      month: selectedMonth.month,
    );

    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('MON'),
            Text('TUE'),
            Text('WED'),
            Text('THU'),
            Text('FRI'),
            Text('SAT'),
            Text('SUN'),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var week in data.weeks)
              Row(
                children: week.map((d) {
                  return Expanded(
                    child: CalenderRowItem(
                      hasRightBorder: false,
                      date: d.date,
                      isActiveMonth: d.isActiveMonth,
                      onTap: () => selectDate(d.date),
                      isSelected: selectedDate != null &&
                          selectedDate!.isSameDate(d.date),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: const Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5, top: 15, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            "Assign by: Nilesh Devani",
                            style: TextStyle(overflow: TextOverflow.ellipsis),
                            maxLines: 1,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            "2022-09-19 2:50 PM",
                            style: TextStyle(overflow: TextOverflow.ellipsis),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Flexible(
                    child: Text(
                      "SMPS audit check",
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Flexible(
                    child: Text(
                      "Task type : Once",
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Flexible(
                    child: Text(
                      "Assign to : Dhaval Kosambiya",
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Flexible(
                    child: Text(
                      "Manage by : Mayur bhanderi, nilesh Devani",
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(height: 10,),
                   Flexible(
                    child: Text(
                      "End Date : 2022-09-19 2:50 PM",
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CalenderHeader extends StatelessWidget {
  const CalenderHeader({
    required this.selectedMonth,
    required this.selectedDate,
    required this.onChange,
  });

  final DateTime selectedMonth;
  final DateTime? selectedDate;

  final ValueChanged<DateTime> onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
              'Selected date: ${selectedDate == null ? 'non' : "${selectedDate!.day}.${selectedDate!.month}.${selectedDate!.year}"}'),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  onChange(selectedMonth.addMonth(-1));
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              Expanded(
                child: Text(
                  ' ${selectedMonth.month.toMonthName()} - ${selectedMonth.year}',
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                onPressed: () {
                  onChange(selectedMonth.addMonth(1));
                },
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
