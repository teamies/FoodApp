
import 'package:flutter/material.dart';

   class notification {
  static void onDelete(BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Hoàn thành'),
        duration: Duration(seconds: 1),
      ),
    );
  }
//  static void onAdd(BuildContext context){
//     ScaffoldMessenger.of(context).showSnackBar(
//      const SnackBar(
//         content: Text('Thêm thành công'),
//         duration: Duration(seconds: 1),
//       ),
//     );
//   }

}