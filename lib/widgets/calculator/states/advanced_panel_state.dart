import 'package:get/get.dart';

final AdvancedPanelState advancedPanelState = Get.put<AdvancedPanelState>(AdvancedPanelState());

class AdvancedPanelState extends GetxController{
  Rx<bool> isShiftMode = false.obs;

  setShiftMode(bool mode) => isShiftMode.value = mode;

}