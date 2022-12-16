import 'package:get/get.dart';

class MonitorController extends GetxController {
  //TODO: Implement MonitorController

  final theme = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void theme_change() {
    if (theme.value == true) {
      theme.value = false;
    } else {
      theme.value = true;
    }
  }
}
