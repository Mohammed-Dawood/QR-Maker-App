import 'package:flutter/material.dart';

class LinkToTextField extends StatelessWidget {
  const LinkToTextField({
    Key? key,
    required this.goToLink,
    required this.assetName,
  }) : super(key: key);

  final String assetName;
  final Future? Function() goToLink;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: goToLink,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CircleAvatar(
            backgroundImage: AssetImage(assetName),
          ),
        ),
      ),
    );
  }
}
