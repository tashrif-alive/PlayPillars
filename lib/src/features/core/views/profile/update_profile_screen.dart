import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tasking/src/features/core/views/profile/profile_screens.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_list.dart';
import '../../../../constants/texts.dart';
import '../../../auth/models/users_model.dart';
import '../../controllers/profile_controller.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TTS_WhiteColor,
        leading: IconButton(
          color: TTS_DarkColor,
          onPressed: () => Get.to(ProfileScreen()),
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          TTS_Edit_Profile,
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: [
          IconButton(color: TTS_DarkColor, onPressed: () {}, icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(Material.defaultSplashRadius),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;
                  return Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image(
                                image: AssetImage(TTS_Profile_Img_All),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: TTS_PrimaryColor,
                              ),
                              child: const Icon(
                                LineAwesomeIcons.camera,
                                size: 20.0,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 60.0),
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              initialValue: userData.fullName,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                label: Text(TTS_Full_Name),
                                // hintText: TTS_Full_Name),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              initialValue: userData.email,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined),
                                label: Text(TTS_Email),
                                // hintText: TTS_Email),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              initialValue: userData.phone,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.numbers),
                                label: Text(TTS_Phone),
                                // hintText: TTS_Phone),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              initialValue: userData.password,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.fingerprint),
                                label: Text(TTS_Password),
                                // hintText: TTS_Password),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => Get.to(() => ProfileScreen()),
                                child: const Text("Update Profile", style: TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(backgroundColor: TTS_PrimaryColor, side: BorderSide.none, shape: StadiumBorder()),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
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
        ),
      ),
    );
  }
}
