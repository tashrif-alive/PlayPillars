import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tasking/src/features/core/controllers/bid_controller.dart';

import '../../../../constants/sizes.dart';
import '../../../../constants/texts.dart';
import '../../../auth/controllers/signup_controller.dart';
import '../../../auth/models/users_model.dart';
import '../../controllers/job_controller.dart';
import '../../models/bid_model.dart';
import '../../models/job_model.dart';

class BiddingJobFormWidget extends StatelessWidget {
  const BiddingJobFormWidget({
    Key? key,
  }) : super(key: key);

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bidController = Get.put(BidPostController());


    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: bidController.biddername,
              validator: (value) {
                // Is Empty Validation
                if (value == null || value.isEmpty) {
                  return 'Bidder Name is Required!';
                }
                // Return Null If Valid
                return null;
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.add_rounded),
                  label: Text("Name"),
                  hintText: "Name"),
            ),
            SizedBox(height: 16.0),
            const SizedBox(height: TTS_DefaultSize - 10),
            TextFormField(
              controller: bidController.location,
              validator: (value) {
                // Is Empty Validation2
                if (value == null || value.isEmpty) {
                  return 'Please Enter Your Area';
                }
                // Return Null If Valid
                return null;
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.pin_drop_outlined),
                  label: Text("Location"),
                  hintText: "Sector #10, Uttara, Dhaka"),
            ),
            const SizedBox(height: TTS_DefaultSize - 10),
            TextFormField(
              controller: bidController.askingprice,
              validator: (value) {
                // Is Empty Validation
                if (value == null || value.isEmpty) {
                  return 'Please Ask Your Price';
                }

                // Return Null If Valid
                return null;
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(LineAwesomeIcons.hand_holding_us_dollar),
                  label: Text("Price"),
                  hintText: "৳450.00"),
            ),
            const SizedBox(height: TTS_DefaultSize - 10),
            TextFormField(
              controller: bidController.bidderdescription,
              validator: (value) {
                // Is Empty Validation
                if (value == null || value.isEmpty) {
                  return 'Bidder Description is Required';
                }
                // Return Null If Valid
                return null;
              },
              maxLines: 4,
              decoration: InputDecoration(
                  // prefixIcon: Icon(Icons.bookmark),
                  label: Text("Bidder Description"),
                  hintText: "Please Provide Expertise"),
            ),

            const SizedBox(height: TTS_DefaultSize - 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final bidData = BidModel(
                      biddername: bidController.biddername.text.trim(),
                      location: bidController.location.text.trim(),
                      askingprice: bidController.askingprice.text.trim(),
                      bidderdescription: bidController.bidderdescription.text.trim(),
                    );
                    BidPostController.instance.createBidPost(bidData);
                  }
                },
                child: Text("Bid on the post".toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
