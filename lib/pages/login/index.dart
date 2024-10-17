import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pinmarker/components/bars/bottom_bar.dart';
import 'package:pinmarker/components/bars/left_bar.dart';
import 'package:pinmarker/helpers/variables/style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => StateLoginPageState();
}

class StateLoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  CameraController? cameraCtrl;
  Future<void>? initControlFuture;

  FlashMode flashMode = FlashMode.off;

  Future<void> _loadPreferences() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      cameraCtrl = CameraController(cameras.first, ResolutionPreset.medium);

      initControlFuture = cameraCtrl!.initialize();
      setState(() {});
    } else {
      Get.snackbar("Error", "No cameras found on device");
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  void dispose() {
    cameraCtrl?.dispose();
    super.dispose();
  }

  Future<XFile?> captureImage() async {
    try {
      await cameraCtrl?.setFlashMode(flashMode);
      final imageFile = await cameraCtrl?.takePicture();
      return imageFile;
    } catch (e) {
      Get.snackbar("Error", "Failed to capture image");
      return null; // Return null in case of error
    }
  }

  void navigateToShowImage(XFile imageFile) {
    // Add navigation logic here, for example:
    // Get.to(() => ShowImage(path: imageFile.path));
  }

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double fullHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        title: const Text('QR Sign In', style: TextStyle(color: whiteColor)),
        actions: <Widget>[
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.circleInfo,
              color: whiteColor,
            ),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ArtSweetAlert.show(
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                      type: ArtSweetAlertType.info,
                      title: "Information!",
                      text:
                          "You can scan PinMarker QR Sign In from PinMarker Web in the Profile Menu or through the PinMarker Telegram Bot"));
            },
          ),
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Back to PinMarker',
            onPressed: () {
              Get.to(const BottomBar());
            },
            color: whiteColor,
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: initControlFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (cameraCtrl != null && cameraCtrl!.value.isInitialized) {
              return Center(
                child: SizedBox(
                  width: fullWidth,
                  height: fullHeight,
                  child: CameraPreview(cameraCtrl!),
                ),
              );
            } else {
              return const Center(child: Text('Camera not initialized'));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      drawer: const LeftBar(),
      floatingActionButton: SizedBox(
        height: 140,
        child: Column(
          children: [
            FloatingActionButton(
              heroTag: 1,
              backgroundColor: primaryColor,
              onPressed: () async {
                final imageFile = await captureImage();
                if (imageFile != null) {
                  navigateToShowImage(imageFile);
                }
              },
              child: const Icon(
                Icons.camera_alt,
                color: whiteColor,
              ),
            ),
            const SizedBox(height: 20),
            FloatingActionButton(
              heroTag: 2,
              backgroundColor: primaryColor,
              onPressed: () {
                setState(() {
                  if (flashMode == FlashMode.off) {
                    Get.snackbar("Alert", "Flash is switched on",
                        backgroundColor: whiteColor,
                        borderColor: primaryColor,
                        borderWidth: 1.0);
                    flashMode = FlashMode.torch;
                  } else {
                    Get.snackbar("Alert", "Flash is switched off",
                        backgroundColor: whiteColor,
                        borderColor: primaryColor,
                        borderWidth: 1.0);
                    flashMode = FlashMode.off;
                  }
                });
              },
              child: Icon(
                flashMode == FlashMode.off ? Icons.flash_off : Icons.flash_on,
                color: whiteColor,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
