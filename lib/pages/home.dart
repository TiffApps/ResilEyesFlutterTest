import 'dart:convert';

import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resileyes_flutter_test/models/doctor.dart';
import 'package:resileyes_flutter_test/models/perso.dart';
import 'package:resileyes_flutter_test/pages/view_doctor.dart';
import 'package:resileyes_flutter_test/utils/constants.dart';
import 'package:resileyes_flutter_test/utils/scale_route.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Doctor>> _futureDoctors;
  late Future<Perso> _futurePerso;

  @override
  void initState() {
    super.initState();
    _futureDoctors = _fetchDoctors();
    _futurePerso = _fetchPerso();
  }

  Future<List<Doctor>> _fetchDoctors() async {
    final String response =
        await rootBundle.loadString('assets/json/doctor.json');
    Iterable iterable = json.decode(response);
    return List<Doctor>.from(
      iterable.map(
        (model) => Doctor.fromJson(model),
      ),
    );
  }

  Future<Perso> _fetchPerso() async {
    final String response =
        await rootBundle.loadString('assets/json/perso.json');
    // Since normally it would have only one user, I used [0] as it doesn't make sense to have a List here anyway
    return Perso.fromJson(json.decode(response)[0]);
  }

  String _calculateRanking(List<Reviews> reviews) {
    return double.parse((reviews.map((m) => m.ranking).reduce((a, b) => a + b) /
                reviews.length)
            .toStringAsFixed(1))
        .toString();
  }

  Widget buildVisit(String type) {
    return Expanded(
      child: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
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
                  primary: type == 'Clinic' ? Colors.white : Colors.grey[200],
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FutureBuilder(
                  future: _futurePerso,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Perso perso = snapshot.data as Perso;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Alain + emote + picture
                          Text(
                            '${perso.name} ${Emojis.wavingHand}',
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 60,
                            child: Image.asset(perso.image),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child:
                            Text("${Emojis.crossMark} Error: no data found!"),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
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
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "What are your symptoms?",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              // Symptom + emote cards list
              SizedBox(
                height: 70.0,
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: symptoms.length,
                  itemBuilder: (BuildContext context, int index) => Card(
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    margin: const EdgeInsets.all(12),
                    color: Colors.grey[200],
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                          child: Text(
                            symptoms[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Spacer + Text
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Popular doctors",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: FutureBuilder(
                  future: _futureDoctors,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Doctor> doctors = snapshot.data as List<Doctor>;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: doctors.length,
                        itemBuilder: (BuildContext context, int index) => Card(
                          elevation: 5.0,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                ScaleRoute(
                                  page: ViewDoctor(doctor: doctors[index]),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: Image.asset(doctors[index].imageUrl),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Dr. " + doctors[index].name,
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Text(
                                  doctors[index].occupation,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  Emojis.star +
                                      _calculateRanking(doctors[index].reviews),
                                  style: const TextStyle(fontSize: 17),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child:
                            Text("${Emojis.crossMark} Error: no data found!"),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
