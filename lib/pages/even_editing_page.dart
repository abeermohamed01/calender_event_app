import 'package:calender_event_app/provider/event_provider.dart';
import 'package:calender_event_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:calender_event_app/model/event.dart';
import 'package:provider/provider.dart';

class EvenEditingPage extends StatefulWidget {
  final Event? event;
  const EvenEditingPage({
    Key? key,
    this.event,
  }) : super(key: key);
  @override
  State<EvenEditingPage> createState() => _EvenEditingPageState();
}

class _EvenEditingPageState extends State<EvenEditingPage> {
  final _fromKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  @override
  void initState() {
    super.initState();
    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(const Duration(hours: 2));
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        actions: buildEditingAction(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _fromKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildTile(),
                buildDateTimePicker(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildEditingAction() => [
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            onPressed: saveForm,
            icon: const Icon(Icons.done),
            label: const Text('SAVE'))
      ];

  Widget buildTile() => TextFormField(
        style: const TextStyle(fontSize: 24),
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'Add Title',
        ),
        controller: titleController,
        validator: (title) =>
            title != null && title.isEmpty ? 'Title cannot empty' : null,
        onFieldSubmitted: (_) => saveForm(),
      );

  Widget buildDateTimePicker() => Column(
        children: [
          buildForm(),
          buildTo(),
        ],
      );

  Widget buildForm() => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: buildHeader(
            header: 'FROM',
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: buildDropDownField(
                      text: Utils.toDate(fromDate),
                      onClicked: () => pickFromDateTime(pickDate: true),
                    )),
                Expanded(
                    child: buildDropDownField(
                  text: Utils.toTime(fromDate),
                  onClicked: () => pickFromDateTime(pickDate: false),
                )),
              ],
            )),
      );
  Future pickFromDateTime({
    required bool pickDate,
  }) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }

    setState(() => fromDate = date);
  }

  Future pickToDateTime({
    required bool pickDate,
  }) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );
    if (date == null) return;
    setState(() => toDate = date);
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));
      if (timeOfDay == null) return null;

      final date =
          DateTime(initialDate.year, initialDate.hour, initialDate.minute);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  Widget buildTo() => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: buildHeader(
            header: 'To',
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: buildDropDownField(
                      text: Utils.toDate(toDate),
                      onClicked: () => pickToDateTime(pickDate: true),
                    )),
                Expanded(
                    child: buildDropDownField(
                  text: Utils.toTime(toDate),
                  onClicked: () => pickToDateTime(pickDate: false),
                )),
              ],
            )),
      );

  Widget buildDropDownField({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Widget buildHeader({
    required String header,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          child,
        ],
      );

  Future saveForm() async {
    final isValid = _fromKey.currentState!.validate();
    if (isValid) {
      final event = Event(
          title: titleController.text,
          from: fromDate,
          to: toDate,
          description: 'Description' ,
      isAllDay: false,
      );

      final provider = Provider.of<EventProvider>(context , listen: false);
      provider.addEvent(event);
      Navigator.of(context).pop();
    }
  }
}
