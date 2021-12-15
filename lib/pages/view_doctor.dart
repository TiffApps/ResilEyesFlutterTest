import 'package:flutter/material.dart';
import 'package:resileyes_flutter_test/models/doctor.dart';

class ViewDoctor extends StatelessWidget {
  final Doctor doctor;
  const ViewDoctor({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            )
          ],
        ),
        body: Column(
          children: [
            Text(doctor.name),
          ],
        ),
      ),
    );
  }
}
