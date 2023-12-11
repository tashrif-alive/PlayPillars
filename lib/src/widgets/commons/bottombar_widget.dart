import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasking/src/features/core/views/dash/dashboard_view.dart';
import 'package:tasking/src/features/core/views/jobs/post_job_view.dart';

import '../../constants/colors.dart';
import '../../features/core/views/bids/all_bids_screen.dart';
import '../../features/core/views/jobs/all_jobs_screen.dart';
import '../../features/core/views/profile/all_users_screen.dart';

class TTS_BottomNavBar extends StatelessWidget {
  const TTS_BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: 0,
      height: 70.0,
      color: TTS_DarkColor,
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: TTS_LogoColor,
      // animationCurve: Curves.easeInExpo,
      items: const <Widget>[
        Icon(Icons.home, size: 25, color: TTS_WhiteColor),
        Icon(Icons.group_outlined, size: 25, color: TTS_WhiteColor),
        Icon(Icons.add, size: 25, color: TTS_WhiteColor),
        Icon(Icons.library_books, size: 25, color: TTS_WhiteColor),
        Icon(Icons.notifications_active_sharp, size: 25, color: TTS_WhiteColor),
      ],
      onTap: (index) {
        Future.delayed(const Duration(milliseconds: 500), () {
          // Do something
          ToBottomPage(index);
        });
      },
    );
  }

  void ToBottomPage(page) {
    if (page == 0) {
      Get.to(DashboardScreen());
    } else if (page == 1) {
      Get.to(AllUsersScreen());
    } else if (page == 2) {
      Get.to(PostJobScreen());
    } else if (page == 3) {
      Get.to(AllJobsScreen());
    } else if (page == 4) {
      Get.to(AllBidsScreen());
    }
    // Get.to(WelcomeScreen());
  }

  void setState(Null Function() param0) {}
}
