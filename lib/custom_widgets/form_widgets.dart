import 'package:flutter/material.dart';

customTextField({required controller,required bool obscureText,required Icon icon,required String hintText}) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(border: Border.all(width: 2)),
    child: TextField(
      obscureText: obscureText ,
      controller: controller,
      decoration: InputDecoration(
        
          hintText: hintText,
          border: InputBorder.none,
          icon: icon ),
    ),
  );
}

customButton({required onTap,required buttonText}) {
  return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue[200],
        ),
        height: 50,
        child: Center(
            child: Center(
                child: Text(
          "$buttonText",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ))),
      ));

  // ElevatedButton(
  //     style: ElevatedButton.styleFrom(),
  //     onPressed: () {}, child: Text("Login")),
}
