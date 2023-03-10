import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:me_empresta_ai/screens/homeScreen.dart';

Widget dividerList() => const Divider(
      height: 2,
      color: Colors.pink,
    );

Widget buildSvgIcon(String path) =>
    SvgPicture.asset(path, width: 48, height: 48);

const addIcon = Icon(Icons.add);
const salvarText = Text("Salvar");
const loanText = Text("Emprestar");
const unavailableText = Text("Indisponivel");
