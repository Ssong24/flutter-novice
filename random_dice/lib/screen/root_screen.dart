import 'package:flutter/material.dart';
import 'package:random_dice/screen/home_screen.dart';
import 'package:random_dice/screen/settings_screen.dart';
import 'dart:math';
import 'package:shake/shake.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin{
  TabController? controller; // 사용할 TabController 선언
  double threshold = 2.7; // 민감도의 기본값 설정
  int number = 1; // 주사위 숫자
  ShakeDetector? shakeDetector;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 2, vsync: this); // 컨트롤러 초기화
    controller!.addListener(tabListener); // 컨트롤러 속성이 변경될 때마다 실행할 함수 등록

    shakeDetector = ShakeDetector.autoStart( // 흔들기 감지 즉시 시작
      shakeSlopTimeMS: 100, // 감지 주기
      shakeThresholdGravity: threshold, // 감지 민감도
      onPhoneShake: onPhoneShake, // 감지 후 실행할 함수
    );
  }

  void onPhoneShake() {  // 감지 후 실행할 함수
    final rand = new Random();

    setState(() {
      number = rand.nextInt(5) + 1;
    });
  }

  tabListener() { // 리스너로 사용할 함수
    setState(() {}); // 콜백함수 tabListener에 setState()를 실행해 controller 속성이 변경될 때마다 build()를 재실행
  }

  @override
  dispose() { // addListener로 listener를 등록하면 위젯이 삭제될 때 항상 등록된 listener도 같이 삭제되야 하는데 그걸 해주는 함수.
    controller!.removeListener(tabListener);  // 리스너에 등록한 함수 등록 취소
    shakeDetector!.stopListening(); // 흔들기 감지 중지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView( // 1. 탭 화면 보여줄 위젯
        controller: controller, // 컨트롤러 등록하기
        children: renderChildren(),
      ),
      // 2. 아래 탭 내비게이션을 구현하는 매개변수
      bottomNavigationBar: renderBottomNavigation(),
    );
  }
  List<Widget> renderChildren() {
    return [
      HomeScreen(number: number), // different from book
      SettingsScreen(
        threshold: threshold,
        onThresholdChange: onThresholdChange,
      ),
    ];
  }

  // 슬라이더 값 변경 시 실행함수
  void onThresholdChange(double val) {
    setState(() {
      threshold = val;
    });
  }

  BottomNavigationBar renderBottomNavigation() {
    return BottomNavigationBar(
      // 현재 화면에 렌더링되는 탭의 인덱스
      currentIndex: controller!.index,
      onTap: (int index) {
        setState(() {
          controller!.animateTo(index);
        });
      },
      items: [
      BottomNavigationBarItem( // 하단 탭바의 각 버튼 구현
          icon: Icon(
            Icons.edgesensor_high_outlined,
          ),
      label: '주사위',
      ),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
          ),
      label: '설정',
      ),
    ],
    );
  }
}