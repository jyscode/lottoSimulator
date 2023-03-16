import 'package:flutter/material.dart';
import 'package:listview_example/common/layout/default_layout.dart';
import 'package:listview_example/model/lotto_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String lottoNum = "";
    String bonusNum = "";
    return DefaultLayout(
        child: GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text('로또 번호 6개 입력: '),
                Expanded(
                  child: TextField(
                    onChanged: (String? val) {
                      lottoNum = val ?? "";
                    },
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.grey[300],
                        hintText: ',로 구분하여 입력하세요.'),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text('보너스 번호 입력: '),
                Expanded(
                  child: TextField(
                    onChanged: (String? val) {
                      bonusNum = val ?? "";
                    },
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[300],
                    ),
                  ),
                )
              ],
            ),
            ElevatedButton(
              onPressed: () {
                try {
                  List<int> list = [];
                  for (var value in lottoNum.split(',')) {
                    list.add(int.parse(value));
                  }
                  if(list.length != 6){
                    print(list.length);
                    print('잘못된 결과 입니다.');
                  }
                  else{
                    Navigator.of(context).pop(LottoModel(lottoList: list, bonusNum: int.parse(bonusNum)));
                  }
                } catch(e){
                  print(e);
                  print('잘못된 입력 입니다.');
                }

              },
              child: Text('저장'),
            )
          ],
        ),
      ),
    ));
  }
}
