// import 'package:calender_event_app/model/event.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class EventViewingPage extends StatelessWidget {
//   final Event event;
//   const EventViewingPage({Key? key , required this.event}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: const CloseButton(),
//         actions: buildViewingActions(context , event),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(32),
//         children: [
//           buildDateTime(event),
//           const SizedBox(height: 32,),
//           Text(event.title , style: TextStyle(fontSize: 24 , fontWeight: FontWeight.bold),),
//           const SizedBox(height: 24,),
//           Text(event.description , style: TextStyle(color: Colors.white , fontSize: 18),),
//
//         ],
//       ),
//     );
//   }
//   Widget buildDateTime(Event event){
//     return Column(
//       children: [
//         buildDate(event.isAllDay ? 'All_day' : 'From' , event.from),
//         if(!event.isAllDay) buildDate('To' , event.to),
//       ],
//     );
//   }
//   Widget buildDate(){}
// }
