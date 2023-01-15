import 'package:me_empresta_ai/utils/custom_widgets.dart';
import 'package:flutter/material.dart';

class ListHomeItemWidget extends StatelessWidget {
  const ListHomeItemWidget({
    Key? key,
    required this.path,
    required this.title,
    required this.subtitle,
    required this.route,
  }) : super(key: key);

  final String path;
  final String title;
  final String subtitle;
  final String route;

  final iconNext = const Icon(Icons.navigate_next);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: buildSvgIcon(path),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: iconNext,
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}
