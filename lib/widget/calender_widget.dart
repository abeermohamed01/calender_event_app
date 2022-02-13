import 'package:calender_event_app/model/event_data_source.dart';
import 'package:calender_event_app/provider/event_provider.dart';
import 'package:calender_event_app/widget/tasks_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderWidget extends StatelessWidget {
  const CalenderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    return SfCalendar(
      view: CalendarView.month,
      dataSource: EventDataSource(events),
      initialDisplayDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
      onLongPress: (details){
        final provider = Provider.of<EventProvider>(context , listen:  false);
        provider.setDate(details.date!);
        showModalBottomSheet(context: context, builder: (context) => TasksWidget());
      },
    );
  }
}
