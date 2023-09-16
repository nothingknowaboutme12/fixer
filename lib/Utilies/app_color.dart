import 'package:fixer/Utilies/dimention.dart';
import 'package:flutter/material.dart';

class MaterialColr {
  static const Color primaryColor = Color(0xFF838EBA);
  static const Color secondaryColor = Color(0xFF2B3D66);
}

const String appName = "Fixer";
const String appLogo = 'assets/logo.png';
const nameLogo = Text(
  appName,
  textScaleFactor: 1.3,
  style: TextStyle(
    color: Colors.white,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    letterSpacing: 10,
    fontSize: 30,
  ),
);

final logoWithName = Column(
  children: [
    Image.asset(
      appLogo,
      height: 60,
      width: 60,
    ),
    const SizedBox(
      height: Dimensions.paddingSizeSmall,
    ),
    const Text(
      appName,
      textScaleFactor: 1.1,
      style: TextStyle(
        color: Colors.white,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
        letterSpacing: 10,
        fontSize: 24,
      ),
    ),
  ],
);
