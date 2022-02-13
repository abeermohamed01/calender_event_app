import 'package:calender_event_app/widget/calender_widget.dart';
import 'package:flutter/material.dart';

import 'even_editing_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calender Event'),
        centerTitle: true,
      ),
      body: const CalenderWidget(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add , color: Colors.white,),
        backgroundColor: Colors.red,
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const EvenEditingPage()));
        },
      ),
    );
  }
}
