import 'dart:convert';

import 'package:get/get.dart';
import 'package:squeak/App_URL/apiurl.dart';
import 'package:squeak/Local%20Storage/global_variable.dart';

import 'package:http/http.dart' as http;
import 'package:squeak/components/colors.dart';
import 'package:squeak/components/snakbar.dart';

import '../models/treatmodel.dart';

class treatController extends GetxController {
  var isLoading = false.obs;

  List<TreatModel> treatList = <TreatModel>[].obs;
  fetchTreats() async {
    isLoading.value = true;
    String currentToken = appStorage.read('userToken');

    try {
      treatList.clear();
      final response = await http.get(
        Uri.parse(AppUrl.treatUrl),
        headers: {
          'Authorization': "Bearer  $currentToken ",
          'Accept': "application/json"
        },
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['data'];
        for (var videoData in responseData) {
           print(videoData["id"]);
          treatList.add(TreatModel(

           
              id: videoData["id"],
              treats: videoData["treats"],
              price: videoData["price"]));
        }

        print("treatLength: ${treatList.length}");
        isLoading.value = false;
      } else {
        isLoading = false.obs;
        final Map<String, dynamic> responseData = json.decode(response.body);
        showInSnackBar(responseData["message"], color: AppColors.errorcolor);
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
      print('discover error');
    }
  }

  




}
