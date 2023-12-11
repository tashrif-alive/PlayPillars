import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/texts.dart';

class DashSearchWidget extends StatelessWidget {
  const DashSearchWidget({
    Key? key,
    required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TTS_Dash_Title, style: textTheme.headline4),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
            decoration: const BoxDecoration(border: Border(left: BorderSide(width: 4, color: TTS_PrimaryAccent))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(TTS_Search, style: textTheme.headline3?.apply(color: Colors.grey.withOpacity(0.5))),
                Icon(Icons.mic),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
