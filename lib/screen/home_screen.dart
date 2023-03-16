import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listview_example/model/lotto_model.dart';
import 'package:listview_example/const/static_method.dart';
import 'package:listview_example/model/result_model.dart';
import 'package:listview_example/screen/lotto_card.dart';

import 'settings_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<LottoCard> cardList = [];
  List<LottoCard> winList = [];
  List<LottoCard> winOver3 = [];
  late LottoModel winLotto;
  int win1 = 0;
  int win2 = 0;
  int win3 = 0;
  int win4 = 0;
  int win5 = 0;
  bool isChecked = false;
  int makeCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    Set<int> lottoList = Set();

    while (lottoList.length != 6) {
      final num = Random().nextInt(45) + 1;
      lottoList.add(num);
    }
    final pList = lottoList.toList();
    pList.sort();
    int bNum;

    while (true) {
      bNum = Random().nextInt(45) + 1;
      if (!pList.contains(bNum)) {
        break;
      }
    }
    winLotto = LottoModel(lottoList: pList, bonusNum: bNum);
  }

  @override
  Widget build(BuildContext context) {
    final ratio = MediaQuery.of(context).size.width / 428.0;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '로또 시뮬레이터',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20 * ratio,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final result = await Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => SettingsScreen()));

                    if (result != null) {
                      winLotto = result;
                      setState(() {
                        resetLotto();
                      });
                    }
                  },
                  icon: Icon(
                    Icons.settings,
                  ),
                  color: Colors.red[400],
                ),
              ],
            ),
            Row(
              children: [
                Text('당첨된 로또만 표시'),
                Checkbox(
                    value: isChecked,
                    onChanged: (bool? val) {
                      setState(() {
                        isChecked = val!;
                      });
                    }),
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.0 * ratio),
                itemCount: isChecked ? winList.length : cardList.length,
                itemBuilder: (BuildContext context, int index) {
                  return isChecked ? winList[index] : cardList[index];
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30.0 * ratio),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '시뮬레이션 횟수 ${cardList.length}',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 20.0 * ratio,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 30.0 * ratio),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '쓴 돈 ${cardList.length * 5000}',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            ),

            Text('1등 당첨횟수: ${win1}'),
            Text('2등 당첨횟수: ${win2}'),
            Text('3등 당첨횟수: ${win3}'),
            Text('4등 당첨횟수: ${win4}'),
            Text('5등 당첨횟수: ${win5}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10.0 * ratio),
                  child: SizedBox(
                    width: 100 * ratio,
                    height: 50 * ratio,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      style: TextStyle(fontSize: 10.0, height: 2.0, color: Colors.black),
                      onChanged: (String? val) {
                        if (val != null) {
                          makeCount = int.parse(val);
                        }
                      },
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.grey[300],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: makeLotto,
                  child: Text('랜덤 로또 생성'),
                ),
                SizedBox(
                  width: 10.0 * ratio,
                ),
                ElevatedButton(onPressed: resetLotto, child: Text('초기화')),
              ],
            ),
            SizedBox(
              height: 30 * ratio,
            ),
            StaticMethod.listToCircle(winLotto, ratio),
          ],
        ),
      ),
    );
  }

  ResultModel confirmLotto(LottoModel myLotto, LottoModel winLotto) {
    int count = 0;

    for (var element in myLotto.lottoList) {
      if (winLotto.lottoList.contains(element)) count++;
    }

    if (count == 5) {
      if (winLotto.bonusNum == myLotto.bonusNum) {
        win2++;
        final model = LottoCard(model: myLotto, result: '2등', isWin: true);
        winList.add(model);
        winOver3.add(model);
        return ResultModel(result: '2등', isWin: true);
      } else {
        final model = LottoCard(model: myLotto, result: '3등', isWin: true);
        winList.add(model);
        winOver3.add(model);
        win3++;
        return ResultModel(result: '3등', isWin: true);
      }
    }

    switch (count) {
      case 3:
        win5++;
        winList.add(LottoCard(
          model: myLotto,
          result: '5등',
          isWin: true,
        ));
        return ResultModel(result: '5등', isWin: true);
      case 4:
        win4++;
        winList.add(LottoCard(
          model: myLotto,
          result: '4등',
          isWin: true,
        ));
        return ResultModel(result: '4등', isWin: true);
      case 6:
        win1++;
        winList.add(LottoCard(
          model: myLotto,
          result: '1등',
          isWin: true,
        ));
        return ResultModel(result: '1등', isWin: true);
      default:
        return ResultModel(result: ' 꽝', isWin: false);
    }
  }

  void makeLotto() {
    if(makeCount == 0){
      makeCount =1;
    }
    for(var i =0; i< makeCount; i++) {
      Set<int> lottoList = Set();

      while (lottoList.length != 6) {
        final num = Random().nextInt(45) + 1;
        lottoList.add(num);
      }
      final pList = lottoList.toList();
      int bNum;

      while (true) {
        bNum = Random().nextInt(45) + 1;
        if (!pList.contains(bNum)) {
          break;
        }
      }
      pList.sort();

      final model = LottoModel(lottoList: pList, bonusNum: bNum);

      final result = confirmLotto(model, winLotto);

      final card =
      LottoCard(model: model, result: result.result, isWin: result.isWin);
      cardList.add(card);

    }
    setState(() {

    });
  }

  void resetLotto() {
    setState(() {
      cardList = [];
      win1 = 0;
      win2 = 0;
      win3 = 0;
      win4 = 0;
      win5 = 0;
    });
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

      ],
    );
  }
}
