import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_player/component/custom_video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key ? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video; // 동영상 저장할 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: video == null ? renderEmpty() : renderVideo(),
    );
  }

  Widget renderEmpty() {
    return Container(
      width: MediaQuery.of(context).size.width, // 넓이 최대로 늘려주기
      decoration: getBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            onTap: onNewVideoPressed, // 로고 탭하면 실행하는 함수
          ),
          SizedBox(height:30.0),
          _AppName(),
        ],
      ),
    );
  }

  void onNewVideoPressed() async { // 이미지 선택하는 기능 구현 함수
    final video = await ImagePicker().pickVideo(
        source: ImageSource.gallery, // gallery 혹은 camera
    );

    if (video != null) {
      setState(() {
        this.video = video;
      });
    }
  }

  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF2A3A7C),
          Color(0xFF000118),
        ]
      )
    );
  }

  Widget renderVideo() {
    return Center(
      child: CustomVideoPlayer(
        video: video!, // 선택된 동영상 입력해주기
        onNewVideoPressed: onNewVideoPressed,
      ), // 동영상 재생기 위젯
    );
  }
}

class _Logo extends StatelessWidget {
  final GestureTapCallback onTap; // 탭했을 때 실행할 함수

  const _Logo({
    required this.onTap,
    Key? key,
}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // 상위 위젯으로부터 탭 콜백받기
      child: Image.asset(
        'asset/img/logo.png',
      ),
    );

  }
}

class _AppName extends StatelessWidget {
  const _AppName({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'VIDEO',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          style: textStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}