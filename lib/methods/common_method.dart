import 'package:flutter/material.dart';

class CommonMethods {
  Widget header(int headerFlexValue, String headerTitle) {
    // final screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
      flex: headerFlexValue,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Colors.pink.shade500),
        padding: EdgeInsets.all(10), // 5% of the screen width

        child: Text(
          headerTitle,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget data(int dataFlexValue, Widget widget) {
    // final screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
      flex: dataFlexValue,
      child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          padding: EdgeInsets.all(10), // 5% of the screen width

          child: widget),
    );
  }
}
