


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AppUtils {
  

    static Future<bool> checkConnectivity() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    return connectivityResult.contains(ConnectivityResult.none);
  }


 static void customSnackBarError({required String error, int duration = 5}) {
    String message = '';
   
    message = error;
    Get.rawSnackbar(
      progressIndicatorBackgroundColor: Colors.transparent,
      progressIndicatorValueColor:
          const AlwaysStoppedAnimation<Color>(Colors.transparent),
      messageText: Text(message,
          style: const TextStyle(color: Colors.white)),
      dismissDirection: DismissDirection.horizontal,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      borderRadius: 4,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      duration: Duration(seconds: duration),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeInOut,
      showProgressIndicator: true,
      leftBarIndicatorColor: Colors.transparent,
      animationDuration: const Duration(seconds: 1),
      borderColor: Colors.transparent,
      reverseAnimationCurve: Curves.easeOut,
      borderWidth: 2,
    );
  }

  static customSnackBarSuccess({required String success, int duration = 5}) {
    String message = '';
   
       message = success;

    Get.rawSnackbar(
      progressIndicatorBackgroundColor: Colors.green,
      progressIndicatorValueColor:
          const AlwaysStoppedAnimation<Color>(Colors.transparent),
      messageText: Text(message,
          style: const TextStyle(color: Colors.white)),
      dismissDirection: DismissDirection.horizontal,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      borderRadius: 4,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      duration: Duration(seconds: duration),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeInOut,
      showProgressIndicator: true,
      leftBarIndicatorColor: Colors.transparent,
      animationDuration: const Duration(seconds: 2),
      borderColor: Colors.transparent,
      reverseAnimationCurve: Curves.easeOut,
      borderWidth: 2,
    );
  }


static showDeleteConfirmationDialog(BuildContext context, VoidCallback onDelete) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              onDelete(); 
              Navigator.of(context).pop(); 
            },
            child: Text('Yes'),
          ),
        ],
      );
    },
  );
}



static showUpdateDialog(
    BuildContext context,
    TextEditingController nameController,
    TextEditingController bankController,
    TextEditingController accountNumberController,
    VoidCallback onUpdate) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Update Information'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
         
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: bankController,
              decoration: InputDecoration(labelText: 'Bank'),
            ),
            TextField(
              controller: accountNumberController,
              decoration: InputDecoration(labelText: 'Account Number'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
         
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
            },
            child: Text('Cancel'),
          ),
         
          TextButton(
            onPressed: () {
              onUpdate(); 
              Navigator.of(context).pop(); 
            },
            child: Text('Update'),
          ),
        ],
      );
    },
  );
}

  
}



// class CustomSnackBar {
//   static error({required String error, int duration = 5}) {
//     String message = '';
   
//     message = error;
//     Get.rawSnackbar(
//       progressIndicatorBackgroundColor: Colors.transparent,
//       progressIndicatorValueColor:
//           const AlwaysStoppedAnimation<Color>(Colors.transparent),
//       messageText: Text(message,
//           style: const TextStyle(color: Colors.white)),
//       dismissDirection: DismissDirection.horizontal,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.red,
//       borderRadius: 4,
//       margin: const EdgeInsets.all(8),
//       padding: const EdgeInsets.all(8),
//       duration: Duration(seconds: duration),
//       isDismissible: true,
//       forwardAnimationCurve: Curves.easeIn,
//       showProgressIndicator: true,
//       leftBarIndicatorColor: Colors.transparent,
//       animationDuration: const Duration(seconds: 1),
//       borderColor: Colors.transparent,
//       reverseAnimationCurve: Curves.easeOut,
//       borderWidth: 2,
//     );
//   }

//   static success({required String success, int duration = 5}) {
//     String message = '';
   
//        message = success;

//     Get.rawSnackbar(
//       progressIndicatorBackgroundColor: Colors.green,
//       progressIndicatorValueColor:
//           const AlwaysStoppedAnimation<Color>(Colors.transparent),
//       messageText: Text(message,
//           style: const TextStyle(color: Colors.white)),
//       dismissDirection: DismissDirection.horizontal,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.green,
//       borderRadius: 4,
//       margin: const EdgeInsets.all(8),
//       padding: const EdgeInsets.all(8),
//       duration: Duration(seconds: duration),
//       isDismissible: true,
//       forwardAnimationCurve: Curves.easeInOutCubicEmphasized,
//       showProgressIndicator: true,
//       leftBarIndicatorColor: Colors.transparent,
//       animationDuration: const Duration(seconds: 2),
//       borderColor: Colors.transparent,
//       reverseAnimationCurve: Curves.easeOut,
//       borderWidth: 2,
//     );
//   }
// }
