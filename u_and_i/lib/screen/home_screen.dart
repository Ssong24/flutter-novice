import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  DateTime firstDay = DateTime(2018,12,8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea( // 1. 시스템 UI 피해서 UI 그리기
        top: true,
        bottom: false,
        child: Column(
          // 2. 위아래 끝에 위젯 배치
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // 반대축 최대 크기로 늘리기
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DDay(
              onHeartPressed: onHeartPressed,
              firstDay: firstDay,
            ),
            _CoupleImage(),
          ],
        ),
      ),
    );
  }
  void onHeartPressed() {
    var now = DateTime.now();

    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: Container(
                color: Colors.white,
                height: 300,
                child: CupertinoDatePicker(
                  mode:CupertinoDatePickerMode.date,
                  // initialDateTime: DateTime(now.year, now.month, now.day),
                  // maximumDate: now,
                  onDateTimeChanged: (DateTime date) {
                    setState(() {
                      firstDay = date;
                    });
                  },
                ),
              ),
            ),
          );
        },
      barrierDismissible: true,
    );
  }
}


class _DDay extends StatelessWidget {
  final GestureTapCallback onHeartPressed;
  final DateTime firstDay;
  _DDay({
    required this.onHeartPressed,
    required this.firstDay,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final now = DateTime.now();

    return Column(
      children: [
        const SizedBox(height: 16.0),
        Text(
          'U&I',
          style: textTheme.displayLarge,
        ),
        const SizedBox(height:16.0),
        Text(
          '우리 처음 만난 날',
          style: textTheme.bodyLarge,
        ),
        Text(
          '${firstDay.year}.${firstDay.month}.${firstDay.day}',
        style: textTheme.bodyMedium,
        ),
        const SizedBox(height:16.0),
        IconButton(
            iconSize:60.0,
            onPressed: onHeartPressed,
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
        ),
        const SizedBox(height:16.0),
        Text(
          'D+${DateTime(now.year, now.month, now.day).difference(firstDay).inDays + 1}',
          style: textTheme.displayMedium,
        ),
      ],
    );
  }
}

class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Center( // 1. 이미지 중앙 정렬
        child: Image.asset(
          'asset/img/middle_image.png',
          // 2. 화면 반만큼만 높이 구현
          height: MediaQuery.of(context).size.height /2,
        ),
      );
  }
}