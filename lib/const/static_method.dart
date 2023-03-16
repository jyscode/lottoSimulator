import 'package:flutter/material.dart';
import 'package:listview_example/const/text_style.dart';

import '../model/lotto_model.dart';

class StaticMethod{
  static Widget listToCircle(LottoModel model, double ratio) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ...model.lottoList
          .map((e) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: numToCircle(e, ratio),
      ))
          .toList(),
      Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: numToCircle(model.bonusNum, ratio),
      )
    ]);
  }

  static CircleAvatar numToCircle(int num, double ratio) {
    if (num < 10) {
      return CircleAvatar(
        backgroundColor: Colors.yellow[500],
        radius: 20 * ratio,
        child: Text(
          num.toString(),
          style: LOTTO_TEXTSTYLE,
        ),
      );
    }
    if (num < 20) {
      return CircleAvatar(
        backgroundColor: Colors.blue[500],
        radius: 20 * ratio,
        child: Text(
          num.toString(),
          style: LOTTO_TEXTSTYLE,
        ),
      );
    }
    if (num < 30) {
      return CircleAvatar(
        backgroundColor: Colors.red[400],
        radius: 20 * ratio,
        child: Text(
          num.toString(),
          style: LOTTO_TEXTSTYLE,
        ),
      );
    }
    if (num < 40) {
      return CircleAvatar(
        backgroundColor: Colors.grey[500],
        radius: 20 * ratio,
        child: Text(
          num.toString(),
          style: LOTTO_TEXTSTYLE,
        ),
      );
    } else {
      return CircleAvatar(
        backgroundColor: Colors.green[400],
        radius: 20 * ratio,
        child: Text(
          num.toString(),
          style: LOTTO_TEXTSTYLE,
        ),
      );
    }
  }
}