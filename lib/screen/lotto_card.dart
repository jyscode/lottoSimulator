import 'package:flutter/material.dart';
import 'package:listview_example/const/static_method.dart';
import 'package:listview_example/model/lotto_model.dart';

class LottoCard extends StatelessWidget {
  final LottoModel model;
  final String result;
  final bool? isWin;

  LottoCard({
    required this.isWin,
    required this.model,
    required this.result,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ratio = MediaQuery.of(context).size.width / 428.0;
    return Container(
      decoration: isWin! == true ? BoxDecoration(
        border: Border.all(
          color: Colors.orange,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ) : null,
      child: Row(children: [
        StaticMethod.listToCircle(model, ratio),
        SizedBox(
          width: 5.0,
        ),
        Text(result),
      ]),
    );
  }
}
