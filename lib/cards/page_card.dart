import 'package:flutter/material.dart';
import 'package:goa/data/page_data.dart';

class PageCard extends StatelessWidget {
  final PageData page;
  const PageCard({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 80),
          _buildText(context),
          const SizedBox(height: 50),
          _buildPicture(context),
          const SizedBox(height: 40),
          _buildSubtitile(context),
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Text(
      page.title,
      style: Theme.of(context).textTheme.headline6,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitile(BuildContext context) {
    return Text(
      page.subtitle,
      style: Theme.of(context).textTheme.subtitle2,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPicture(
    BuildContext context, {
    double size = 190,
    double iconSize = 120,
  }) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, page.screen);
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(60.0)),
          color: page.cardColor,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Icon(
              page.icon,
              size: iconSize,
              color: page.logoColor,
            ),
          ],
        ),
      ),
    );
  }
}
