import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';
import 'package:resileyes_flutter_test/models/doctor.dart';

class AverageDoctorNote extends StatelessWidget {
  final List<Reviews> reviews;
  final double? size;
  const AverageDoctorNote({Key? key, required this.reviews, this.size})
      : super(key: key);

  String _calculateRanking(List<Reviews> reviews) {
    return double.parse((reviews.map((m) => m.ranking).reduce((a, b) => a + b) /
                reviews.length)
            .toStringAsFixed(1))
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      Emojis.star + _calculateRanking(reviews),
      style: TextStyle(fontSize: size ?? 17),
    );
  }
}
