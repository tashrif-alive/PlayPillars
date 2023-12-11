import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tasking/src/constants/colors.dart';
import 'package:tasking/src/features/core/views/dash/dashboard_view.dart';

import '../../controllers/bid_controller.dart';
import '../../controllers/job_controller.dart';
import '../../models/bid_model.dart';
import '../../models/job_model.dart';
import '../jobs/job_details_screen.dart';


class AllBidsScreen extends StatelessWidget {
  const AllBidsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    final controller = Get.put(BidPostController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TTS_WhiteColor,
        leading: IconButton(
            icon: Icon(LineAwesomeIcons.arrow_left),
            color: TTS_DarkColor,
            onPressed: () {
              Get.to(DashboardScreen());
            }),
        title: Text(
          "List of All Bids",
          style: Theme.of(context).textTheme.headline5,
        ),
        actions: [IconButton(color: TTS_DarkColor, onPressed: () {}, icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))],
      ),
      // bottomNavigationBar: TTS_BottomNavBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: FutureBuilder<List<BidModel>>(
            future: controller.getAllBids(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  final bidData = snapshot.data!;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {
                                final String? _bidId = bidData[index].id;
                                Get.to(JobDetailScreen(jobId: _bidId));
                                // controller.getJobDetails(jobId);
                                print(bidData[index].id);
                              },
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1.0, color: TTS_LightBlack),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              textColor: TTS_DarkColor,
                              iconColor: TTS_LogoColor,
                              tileColor: Colors.black12,
                              leading: CircleAvatar(
                                child: const Icon(Icons.bookmark_added_outlined),
                                backgroundColor: TTS_DarkColor,
                              ),
                              title: Text("${bidData[index].biddername}"),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${bidData[index].bidderdescription}", maxLines: 2),
                                  Row(
                                    children: [
                                      Icon(Icons.pin_drop_outlined, size: 14),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("${bidData[index].location}"),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Column(
                                children: [
                                  Text("৳ ${bidData[index].askingprice}", style: Theme.of(context).textTheme.headline5!.apply(color: TTS_LogoColor)),
                                  SizedBox(
                                    width: 100,
                                    height: 26,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white38,
                                        foregroundColor: TTS_DarkColor,
                                        padding: EdgeInsets.all(0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Text("View Details", style: Theme.of(context).textTheme.bodySmall),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      });
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
