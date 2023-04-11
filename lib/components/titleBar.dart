import 'package:flutter/material.dart';

import '../core/_config.dart';
import 'mytext.dart';

Widget titleBar(String title){
  return  Center(child: Padding(
    padding: const EdgeInsets.only( bottom: 15),
    child: MyText.baseText(text: title, size: 20, color: colorBlack, fontWeight: FontWeight.bold),
  ));
}