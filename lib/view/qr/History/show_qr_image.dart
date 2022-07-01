import 'package:flutter/material.dart';

class ShowQrImage extends StatefulWidget {
  const ShowQrImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  State<ShowQrImage> createState() => _ShowQrImageState();
}

class _ShowQrImageState extends State<ShowQrImage> {
  bool isScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                'Show QR Image',
                style: TextStyle(
                  fontSize: (isScreenWidth(context)) ? 20 : 28,
                ),
              ),
            ),
            body: Center(
              child: Card(
                child: SizedBox(
                  height: (isScreenWidth(context)) ? 300 : 400,
                  width: (isScreenWidth(context)) ? 300 : 400,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset(
                      widget.image,
                    ),
                  ),
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                'Show QR Image',
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
            ),
            body: Center(
              child: Card(
                child: SizedBox(
                  height: 400,
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset(
                      widget.image,
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
