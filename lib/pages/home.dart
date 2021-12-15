import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget buildVisit(String type) {
    return Expanded(
      child: Card(
        elevation: 7,
        color: type == 'Clinic' ? Colors.purple[900] : Colors.white,
        margin: const EdgeInsets.all(15),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Icon(
                  type == 'Clinic' ? Icons.add : Icons.home_outlined,
                  size: 30,
                  color: Colors.purple[900],
                ),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(15),
                  primary: type == 'Clinic' ? Colors.white : Colors.grey[100],
                  onPrimary: Colors.grey,
                  elevation: 0,
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Text(
                "$type Visit",
                style: TextStyle(
                  fontSize: 15,
                  color: type == 'Clinic' ? Colors.white : Colors.black,
                ),
              ),
              Text(
                type == 'Clinic'
                    ? "Make an appointment"
                    : "Call the doctor home",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Alain + emote + picture
                  const Text(
                    'Alain ${Emojis.wavingHand}',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 60,
                    child: Image.asset('assets/persos/alain.png'),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Visits
                buildVisit("Clinic"),
                buildVisit("Home"),
              ],
            ),
            // Text
            Row(children: const [
              // Symptoms + emotes list
            ]),
            // Spacer + Text
            //ListView(children: const [
            // Cards
            // ]),
          ],
        ),
      ),
    );
  }
}
