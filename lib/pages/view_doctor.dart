import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';
import 'package:resileyes_flutter_test/models/doctor.dart';
import 'package:resileyes_flutter_test/pages/widgets/average_doctor_note.dart';

class ViewDoctor extends StatelessWidget {
  final Doctor doctor;
  const ViewDoctor({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[900],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarOpacity: 0.5,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.adaptive.more))
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _DoctorHeader(
                doctor: doctor,
              ),
              _DoctorBody(
                doctor: doctor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DoctorHeader extends StatelessWidget {
  const _DoctorHeader({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 35,
            child: Image.asset(
              doctor.imageUrl,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            "Dr. " + doctor.name,
            style: const TextStyle(color: Colors.white, fontSize: 30),
          ),
          Text(
            doctor.occupation,
            style: const TextStyle(color: Colors.grey, fontSize: 20),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.phone_outlined,
                color: Colors.white,
              ),
              SizedBox(width: 20),
              Icon(
                Icons.message_outlined,
                color: Colors.white,
              )
            ],
          )
        ],
      ),
    );
  }
}

class _DoctorBody extends StatelessWidget {
  const _DoctorBody({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "About Doctor",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 5),
            Text(doctor.desc),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  "Reviews ",
                  style: TextStyle(fontSize: 20),
                ),
                AverageDoctorNote(
                  reviews: doctor.reviews,
                  size: 20,
                ),
                Text(
                  " (${doctor.reviews.length})",
                  style: TextStyle(color: Colors.grey[400], fontSize: 20),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "See all",
                    style: TextStyle(color: Colors.purple[900], fontSize: 17),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: doctor.reviews.length,
                itemBuilder: (BuildContext context, int index) => SizedBox(
                  width: 240,
                  child: Card(
                    elevation: 7.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 40,
                                child: Image.asset(
                                    doctor.reviews[index].member.imageUrl),
                              ),
                              Text(doctor.reviews[index].member.name),
                              Text(Emojis.star +
                                  doctor.reviews[index].ranking.toString())
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            doctor.reviews[index].commentary,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Location",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Icon(Icons.location_pin,
                      color: Colors.purple[900], size: 30),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.location.name,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      doctor.location.address,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Consultation price",
                  style: TextStyle(color: Colors.grey, fontSize: 17),
                ),
                Text(
                  "\$ 52",
                  style: TextStyle(fontSize: 25),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple[900]),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(17)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                      ),
                      child: const Text("Book Appointment"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
