import 'package:flutter/material.dart';

ThemeData lightmode= ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: const Color.fromARGB(255, 12, 84, 190),
    primary:  Colors.grey.shade900,
  )
);

ThemeData darkmode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.white
  )
);