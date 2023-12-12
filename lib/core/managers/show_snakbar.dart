
import 'package:flutter/material.dart';

void ShowSnakbar(BuildContext context,String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}