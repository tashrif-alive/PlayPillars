import 'package:flutter/material.dart';
import 'package:tasking/src/features/core/views/profile/profile_screens.dart';

import '../../constants/colors.dart';
import '../../constants/image_list.dart';

class TTS_AppBar extends StatelessWidget implements PreferredSizeWidget {
  const TTS_AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Icon(Icons.grid_view_rounded, color: Colors.black),
      // title: Text(TTS_AppName, style: Theme.of(context).textTheme.headline5),
      title: Image(image: AssetImage(TTS_Logo_Square_Text), height: 50),
      centerTitle: true,
      elevation: 3,
      backgroundColor: Colors.white,
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: TTS_WhiteColor,
            border: Border.all(width: 2, color: TTS_PrimaryAccent_Alt),
            // borderRadius: BorderRadius.circular(105),
            shape: BoxShape.circle,
            image: DecorationImage(image: NetworkImage(TTS_All_User_Profile)),
            // image: DecorationImage(image: AssetImage(TTS_All_User_Profile)),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const ProfileScreen();
              }));
            },
            icon: const Text(""),
            // icon: const Icon(Icons.power_settings_new_sharp, color: Colors.black),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55);
}
