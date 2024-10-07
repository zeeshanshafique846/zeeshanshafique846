import 'package:get/get.dart';
import 'package:qr_code_scanner_app/modals/ScanModel.dart';
import 'package:qr_code_scanner_app/services/database_services.dart';

class HistoryConntroler extends GetxController {
  RxList<HistoryModel> createdList = <HistoryModel>[].obs;
  RxList<HistoryModel> scannedList = <HistoryModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    updateHistory();
  }

  updateHistory() async {
    scannedList.clear();
    createdList.clear();
    isLoading.value = true;
    List dataList = await DatabaseHelper().queryDatabase();
    List<HistoryModel> list = dataList
        .map(
          (e) => HistoryModel.fromMap(e),
        )
        .toList();

    for (var i = 0; i < list.length; i++) {
      print("dataList >>>> qr image path  ${list[i].imageUrl}");
      if (list[i].qrType == 'create') {
        createdList.add(list[i]);
      } else {
        scannedList.add(list[i]);
      }
    }

    update();
    isLoading.value = false;
  }
}
