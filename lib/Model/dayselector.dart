import 'package:flutter/material.dart';

class DaySelect extends StatefulWidget {
  DaySelect({Key key}) : super(key: key);

  @override
  _DaySelectState createState() => _DaySelectState();
}

class Day {
  int id;
  String name;
  Day(this.id, this.name);

  static List<Day> getDays() {
    return <Day>[
      Day(1, 'Sunday'),
      Day(2, 'Monday'),
      Day(3, 'Tuesday'),
      Day(4, 'Wednesday'),
      Day(5, 'Thursday'),
      Day(6, 'Friday'),
      Day(7, 'Saturday'),
    ];
  }
}

class _DaySelectState extends State<DaySelect> {
  List<Day> _days = Day.getDays();
  List<DropdownMenuItem<Day>> _dropdownMenuItems;
  Day _selectedDay;

  @override
  void initState() {
    _dropdownMenuItems = buildDropDownMenuItems(_days);
    _selectedDay = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Day>> buildDropDownMenuItems(List days) {
    List<DropdownMenuItem<Day>> items = List();
    for (Day day in days) {
      items.add(DropdownMenuItem(
        value: day,
        child: Text(day.name),
      ));
    }
    return items;
  }

  onChangedDropdownItem(Day selectedDay) {
    setState(() {
      _selectedDay = selectedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(),
          color: Color(0xFF398AE5)),
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            value: _selectedDay,
            items: _dropdownMenuItems,
            onChanged: onChangedDropdownItem,
            icon: Icon(Icons.keyboard_arrow_down),
            iconSize: 25,
          ),
        ),
      ),
    );
  }
}
