import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/texts.dart';
import '../../../../widgets/commons/appbar_widget.dart';
import '../../../../widgets/commons/bottombar_widget.dart';
import '../../../auth/models/users_model.dart';
import '../../controllers/profile_controller.dart';
import '../jobs/all_jobs_screen.dart';
import '../jobs/post_job_view.dart';
import 'widgets/blogtiles_widget.dart';
import 'widgets/category_widget.dart';
import 'widgets/searchbox_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final textTheme = Theme.of(context).textTheme;
    final dashController = Get.put(ProfileController());

    return Scaffold(
      appBar: const TTS_AppBar(),
      bottomNavigationBar: TTS_BottomNavBar(),
      body: SingleChildScrollView(
        child: Container(
          // padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),

              FutureBuilder(
                future: dashController.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      UserModel userData = snapshot.data as UserModel;
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(TTS_App_Welcome, style: textTheme.subtitle1),
                            Text("${userData.fullName}", style: textTheme.headline3),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      // return const Center(child: Text("Something Went Wrong!"));
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return const Center(child: Text("Something Went Wrong!"));
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),

              // Account Stats
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        decoration: const BoxDecoration(
                          color: TTS_LightWhite,
                          border: Border(
                            bottom: BorderSide(width: 4, color: TTS_BlackColor),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.watch_later, size: 50.0, color: Colors.deepOrange),
                            const SizedBox(width: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("02", style: textTheme.headline2),
                                const SizedBox(height: 3.0),
                                Text(TTS_Jobs_Submitted, style: textTheme.subtitle2),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    VerticalDivider(),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        decoration: const BoxDecoration(
                          color: TTS_LightWhite,
                          border: Border(
                            bottom: BorderSide(width: 4, color: TTS_BlackColor),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.work_history, size: 50.0, color: Colors.green),
                            const SizedBox(width: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("13", style: textTheme.headline2),
                                const SizedBox(height: 3.0),
                                Text(TTS_Order_Received, style: textTheme.subtitle2),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              // Account Details
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(child: const Icon(Icons.linear_scale_sharp, color: TTS_LogoColor), backgroundColor: TTS_WhiteColor),
                      title: Text("List Of All Jobs", style: textTheme.subtitle1?.apply(color: Colors.black)),
                      subtitle: Text("Tap To View All Jobs", style: textTheme.bodyText2?.apply(color: Colors.black.withOpacity(0.8))),
                      trailing:
                          CircleAvatar(child: const Icon(Icons.bookmark_added, color: TTS_WhiteColor, size: 40), backgroundColor: Colors.transparent),
                      tileColor: Colors.grey.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 2, color: TTS_LightBlack),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      onTap: () => Get.to(AllJobsScreen()),
                    ),
                    const SizedBox(height: TTS_DefaultSize - 10.0),
                    ListTile(
                      leading: CircleAvatar(child: const Icon(Icons.library_books, color: TTS_LogoColor), backgroundColor: TTS_WhiteColor),
                      title: Text("Post Job", style: textTheme.subtitle1?.apply(color: Colors.black)),
                      subtitle: Text("Create A New Job Post", style: textTheme.bodyText2?.apply(color: Colors.black.withOpacity(0.8))),
                      trailing: CircleAvatar(child: const Icon(Icons.add, color: TTS_WhiteColor, size: 40), backgroundColor: Colors.transparent),
                      tileColor: TTS_PrimaryAccent.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 2, color: TTS_LightBlack),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      onTap: () => Get.to(() => PostJobScreen()),
                    ),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
                child: Divider(
                  height: 1.0,
                ),
              ),

              // Search Box
              DashSearchWidget(textTheme: textTheme),

              const SizedBox(height: 15.0),

              // Services Categories
              DashCategoryWidget(textTheme: textTheme),

              const SizedBox(height: 40.0),

              // Curated Blogs Section
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(TTS_Dash_Blog_Title, style: textTheme.subtitle1?.apply(color: TTS_LogoColor)),
                    Text(TTS_Dash_Blog_Subtitle, style: textTheme.headline4),
                  ],
                ),
              ),

              const SizedBox(height: 10.0),

              // Curated Blogs Tiles
              DashBlogTiles(textTheme: textTheme),

              const SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
