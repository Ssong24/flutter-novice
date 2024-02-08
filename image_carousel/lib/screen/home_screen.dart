import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async'; // for Timer
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController();
  List<File> _images = []; // To store the picked image

  @override
  void initState() {
    super.initState();
    Timer.periodic(
      Duration(seconds: 3),
        (timer) {
          if (_images.isNotEmpty) {
            int nextPage = pageController.page!.toInt() + 1;
            if (nextPage == _images.length) {
              nextPage = 0; // Loop back to the first image
            }

            pageController.animateToPage(
              nextPage,
              duration: Duration(milliseconds: 1000),
              curve: Curves.ease,
            );
          }
        });
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick multiple images
    final List<XFile>? images = await _picker.pickMultiImage();
    // Set state to display the picked image
    if (images != null) {
      setState(() {
        _images = images.map((image) => File(image.path)).toList();
      });
    }
  }

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      appBar: AppBar(
        title: Text("Multi Image Picker Example"),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_library),
            onPressed: _pickImage,
          ),
        ],
      ),
      body: _images.isNotEmpty
        ? PageView.builder(
        controller: pageController,
        itemCount: _images.length,
        itemBuilder: (context, index) {
          return Image.file(_images[index], fit: BoxFit.contain);
        },
      )
          : Center(child: Text("No images selected")),
    );
  }
}