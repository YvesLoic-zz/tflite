import 'dart:async';
import 'package:goa/cards/found_object_card.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

const String ssd = "SSD MobileNet";
const String yolo = "Tiny YOLOv2";

late List<CameraDescription> cameras;
typedef Callback = void Function(List<dynamic> list, int h, int w);

class CameraScreen extends StatefulWidget {
  static const String name = 'camera_screen';

  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  List? _recognitions;
  int? _imageHeight;
  int? _imageWidth;
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();
    loadModel().then((val) {
      setState(() {});
    });

    controller = CameraController(cameras[0], ResolutionPreset.ultraHigh);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
      newFrame();
    });
  }

  // Takes a new frame
  void newFrame() {
    print('inside init');
    controller!.startImageStream((CameraImage img) {
      if (!isDetecting) {
        isDetecting = true;
        print('loading ssd');
        ssdMobileNet(img);
        print('SSD completete');
      }
      if (mounted) {
        setState(() {
          _imageHeight = img.width;
          _imageWidth = img.height;
        });
      }
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  // loads the model with the required assets
  Future loadModel() async {
    Tflite.close();
    try {
      String? res = await Tflite.loadModel(
        model: "assets/ssd_mobilenet.tflite",
        labels: "assets/ssd_mobilenet.txt",
      );

      print(res);
    } catch (e) {
      print('Failed to load model: $e');
    }
  }

// function to call the model: SSD
  Future ssdMobileNet(CameraImage img) async {
    int startTime = DateTime.now().millisecondsSinceEpoch;
    print('inside SSD');
    var recognitions = await Tflite.detectObjectOnFrame(
        bytesList: img.planes.map((plane) {
          return plane.bytes;
        }).toList(), // required
        model: "SSDMobileNet",
        imageHeight: img.height,
        imageWidth: img.width,
        imageMean: 127.5, // defaults to 127.5
        imageStd: 127.5, // defaults to 127.5
        rotation: 90, // defaults to 90, Android only
        threshold: 0.1, // defaults to 0.1
        asynch: true // defaults to true
        );
    if (mounted) {
      setState(() {
        _recognitions = recognitions;
        isDetecting = false;
      });
    }
    int endTime = DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GOA Detection d objet',
          style: TextStyle(
            fontFamily: 'FjallaOne',
          ),
        ),
        backgroundColor: const Color(0xff1B7E81),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          !controller!.value.isInitialized
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'No available camera :(',
                          style: TextStyle(
                            color: Color(0xffaf8d6b),
                            fontSize: 36,
                            fontFamily: 'FjallaOne',
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Icon(
                          Icons.broken_image,
                          size: size.width / 4,
                        )
                      ],
                    ),
                  ),
                )
              : AspectRatio(
                  aspectRatio: controller!.value.aspectRatio,
                  child: CameraPreview(controller!),
                ),
          const SizedBox(
            height: 5.0,
          ),
          _recognitions == null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'No objetcs found :(',
                        style: TextStyle(
                          color: Color(0xffaf8d6b),
                          fontSize: 25,
                          fontFamily: 'FjallaOne',
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Icon(
                        Icons.broken_image,
                        size: size.width / 7,
                      )
                    ],
                  ),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ListView.builder(
                      itemCount: _recognitions!.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 16),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return FoundObject(
                            name: "${_recognitions![index]["detectedClass"]}",
                            percent:
                                "${(_recognitions![index]["confidenceInClass"] * 100).toStringAsFixed(0)}%");
                      },
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
