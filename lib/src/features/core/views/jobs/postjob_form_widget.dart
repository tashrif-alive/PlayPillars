import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/sizes.dart';
import '../../controllers/job_controller.dart';
import '../../models/job_model.dart';

class PostJobFormWidget extends StatelessWidget {
  const PostJobFormWidget({
    Key? key,
  }) : super(key: key);

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final jobController = Get.put(JobPostController());

    final currentTimeInMS = DateTime.now().millisecondsSinceEpoch;
    final currentTimeUTC = DateTime.fromMillisecondsSinceEpoch(currentTimeInMS, isUtc: true);

    String? categoryDropdown = 'AC Servicing';

    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: jobController.jobTitle,
              validator: (value) {
                // Is Empty Validation
                if (value == null || value.isEmpty) {
                  return 'Job Title is Required!';
                }
                // Return Null If Valid
                return null;
              },
              decoration: const InputDecoration(prefixIcon: Icon(Icons.add_rounded), label: Text("Job Title"), hintText: "Job Title"),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: categoryDropdown,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.account_tree_outlined),
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              onChanged: (String? newValue) {
                categoryDropdown = newValue;
                print(categoryDropdown);
              },
              items: <String>[
                'AC Servicing',
                'Car Repair',
                'Car Wash',
                'Fridge Repair',
                'Fridge Servicing',
                'Mobile Repair',
                'Computer Repair',
                'Home Painting',
                'Plumbing',
                'Cleaning Service',
                'Other Services...',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: TTS_DefaultSize - 10),
            TextFormField(
              controller: jobController.location,
              validator: (value) {
                // Is Empty Validation2
                if (value == null || value.isEmpty) {
                  return 'Please Enter Your Location';
                }
                // Return Null If Valid
                return null;
              },
              decoration:
                  const InputDecoration(prefixIcon: Icon(Icons.pin_drop_outlined), label: Text("Location"), hintText: "Sector #10, Uttara, Dhaka"),
            ),
            const SizedBox(height: TTS_DefaultSize - 10),
            TextFormField(
              controller: jobController.budget,
              validator: (value) {
                // Is Empty Validation
                if (value == null || value.isEmpty) {
                  return 'Please Enter Your Max Budget!';
                }

                // Return Null If Valid
                return null;
              },
              decoration: const InputDecoration(
                  prefixIcon: Icon(LineAwesomeIcons.hand_holding_us_dollar), label: Text("Max Budget"), hintText: "Maximum Budget: ৳450.00"),
            ),
            const SizedBox(height: TTS_DefaultSize - 10),
            TextFormField(
              controller: jobController.description,
              validator: (value) {
                // Is Empty Validation
                if (value == null || value.isEmpty) {
                  return 'Job Description is Required';
                }
                // Return Null If Valid
                return null;
              },
              maxLines: 4,
              decoration: const InputDecoration(
                  // prefixIcon: Icon(Icons.bookmark),
                  label: Text("Job Description"),
                  hintText: "Please Provide Ample Details For Your Job!"),
            ),
            const SizedBox(height: TTS_DefaultSize - 10),
            TextFormField(
              controller: jobController.additionalInfo,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.help_outline_outlined), label: Text("Additional Info"), hintText: "Additional Info (If any)"),
            ),
            const SizedBox(height: TTS_DefaultSize - 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final JobData = JobModel(
                      jobTitle: jobController.jobTitle.text.trim(),
                      category: categoryDropdown.toString().trim(),
                      location: jobController.location.text.trim(),
                      budget: jobController.budget.text.trim(),
                      description: jobController.description.text.trim(),
                      additionalInfo: jobController.additionalInfo.text.trim(),
                      date: currentTimeUTC,
                    );
                    JobPostController.instance.createJobPost(JobData);
                  }
                },
                child: Text("Post Job".toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
