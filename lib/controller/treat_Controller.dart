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

  List<TreatModel> treatList = <TreatModel>[];
  fetchTreats() async {
    isLoading=true.obs;
    String currentToken = appStorage.read('userToken');

   
    try {
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
         treatList = responseData
            .map((treatData) => TreatModel(
                  id: treatData['id'],
                  treats: treatData['treats'],
                  price: treatData['price'],
                 
                ))
            .toList();
            
        

        print("treatLength: ${treatList.length}");
        isLoading=false.obs;

        
        
      } else {
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
