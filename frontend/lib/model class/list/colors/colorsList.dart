import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:fluttericon/maki_icons.dart';

import '../../usermodel/ColorsModelListBuilder.dart';

List<ColorModel> colorList = [
  ColorModel(color: Colors.blue, label: 'pizza', iconData: FontAwesome5.pizza_slice),
  ColorModel(color: Colors.orange, label: 'Burger', iconData: Maki.fast_food),
  ColorModel(color: Colors.green, label: 'Beef', iconData: Linecons.food),
  ColorModel(color: Colors.red, label: 'porotta', iconData: null),
  ColorModel(color: Colors.purple, label: 'Purple', iconData: null),
  ColorModel(color: Colors.teal, label: 'Teal', iconData: null),
  // Add more if needed
];
