import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tasking/src/constants/colors.dart';
import 'package:tasking/src/features/core/views/jobs/all_jobs_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../controllers/job_controller.dart';
import '../../models/job_model.dart';
import '../bids/bidding_on_job_view.dart';
import 'job_details_widget.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({Key? key, this.jobId}) : super(key: key);

  final String? jobId;

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final controller = Get.put(JobPostController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TTS_WhiteColor,
        leading: IconButton(
          color: TTS_DarkColor,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const AllJobsScreen();
            }));
          },
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          "Job Details",
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: [IconButton(color: TTS_DarkColor, onPressed: () {}, icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              FutureBuilder(
                future: controller.getJobDetails(jobId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      JobModel jobDetails = snapshot.data as JobModel;
                      final jobCreatedAtDiff = DateTime.now().millisecondsSinceEpoch - jobDetails.date.millisecondsSinceEpoch;
                      final jobDate = DateFormat.yMMMMd().format(jobDetails.date);
                      final jobCreatedAt = jobDetails.date;
                      final timeAgo = timeago.format(DateTime.now().subtract(Duration(milliseconds: jobCreatedAtDiff)));
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "${jobDetails.jobTitle}",
                              style: Theme.of(context).textTheme.headline4,
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ListTile(
                            onTap: () {},
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: TTS_BlackColor,
                              ),
                              child: const Icon(
                                LineAwesomeIcons.user_circle,
                                color: TTS_WhiteColor,
                                size: 30,
                              ),
                            ),
                            title: Text("Job Placed By:", style: Theme.of(context).textTheme.bodyText2?.apply(color: TTS_LightBlack)),
                            subtitle: Text("Admin", style: Theme.of(context).textTheme.bodyText1?.apply(color: TTS_DarkColor)),
                          ),
                          // Text("${userData.fullName}", style: Theme.of(context).textTheme.headline4),
                          // Text("${userData.email}", style: Theme.of(context).textTheme.bodyText1),
                          const Divider(),
                          // const SizedBox(height: 10),
                          //menu
                          JobDetailsWidget(
                            title: "Posted Date:",
                            subtitle: "${jobDate} (${timeAgo})",
                            icon: LineAwesomeIcons.clock,
                            onPress: () {
                              print(jobDate);
                              print(timeAgo);
                              print(jobCreatedAt);
                              print(jobCreatedAtDiff);
                            },
                          ),
                          JobDetailsWidget(title: "Location ", subtitle: "${jobDetails.location}", icon: LineAwesomeIcons.map_pin, onPress: () {}),
                          JobDetailsWidget(
                              title: "Maximum Budget",
                              subtitle: "৳ ${jobDetails.budget}",
                              icon: LineAwesomeIcons.hand_holding_us_dollar,
                              onPress: () {}),
                          JobDetailsWidget(
                              title: "Required Skill",
                              subtitle: jobDetails.category.isEmpty ? "Not Specified" : "${jobDetails.category}",
                              icon: LineAwesomeIcons.toolbox,
                              onPress: () {}),
                          const Divider(),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text("Job Descriptions", style: Theme.of(context).textTheme.headline5),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text("${jobDetails.description}", textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText1),
                          ),

                          const SizedBox(height: 20),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text("Additional Info", style: Theme.of(context).textTheme.headline5),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text("${jobDetails.additionalInfo}", textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText1),
                          ),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(side: BorderSide.none, shape: StadiumBorder()),
                              onPressed: () => Get.to(BiddingOnJobScreen()),
                              child: Text("Bid For This Job".toUpperCase()),
                            ),
                          ),
                          const SizedBox(height: 50),
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
            ],
          ),
        ),
      ),
    );
  }
}
