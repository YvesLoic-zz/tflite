import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final String text;
  final Function()? onPressed;

  const RoundButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.65,
      width: MediaQuery.of(context).size.width * 0.90,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Color(0xffffffff),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 0, 4),
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xff1B7E81),
                fontSize: 22,
                fontWeight: FontWeight.w500,
                fontFamily: 'FjallaOne',
              ),
            ),
          ),
          const Divider(
            indent: 12,
            endIndent: 12,
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xffa58d6b),
                fontFamily: 'FjallaOne',
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton.icon(
                  label: const Text(
                    'Try Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'FjallaOne',
                    ),
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_right,
                    size: 25,
                    color: Colors.white,
                  ),
                  onPressed: onPressed,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
