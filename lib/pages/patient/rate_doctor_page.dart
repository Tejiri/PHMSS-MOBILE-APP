import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:phmss_patient_app/Providers/patient_providers/patient_doctor_provider.dart';
import 'package:phmss_patient_app/Providers/patient_providers/rating_provider.dart';
import 'package:phmss_patient_app/api/api.dart';
import 'package:phmss_patient_app/models/patient_doctor.dart';
import 'package:phmss_patient_app/models/rating.dart';
import 'package:provider/provider.dart';

class RateDoctorPage extends StatefulWidget {
  const RateDoctorPage({super.key});

  @override
  State<RateDoctorPage> createState() => _RateDoctorPageState();
}

class _RateDoctorPageState extends State<RateDoctorPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController ratingComment = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Rating? rating = Provider.of<RatingProvider>(context, listen: true).rating;
    PatientDoctor? doctor =
        Provider.of<PatientDoctorProvider>(context, listen: false)
            .patientDoctor;
    double selectedRating = 3.0;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text("Rate Doctor"),),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              rating == null
                  ? Container(
                      margin: EdgeInsets.only(top: 10),
                      width: double.infinity,
                      child: Text(
                        "No rating to display",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Previous Rating (Long press to delete)",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),

                        // Divider(height: 5,color: Colors.black,thickness: 1,),
                        GestureDetector(
                          onLongPress: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Confirm Deletion'),
                                  content: Text(
                                      'Are you sure you want to delete this review?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        setState(() {
                                          isLoading = true;
                                        });
                                        await Api()
                                            .deleteRating(
                                                context:
                                                    scaffoldKey.currentContext!)
                                            .then((value) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                        });
                                      },
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            // decoration: BoxDecoration(border: Border.all()),
                            padding: EdgeInsets.only(left: 8, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Doctor - ${doctor?.firstName} ${doctor?.lastName}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                RatingBar.builder(
                                  itemSize: 20,
                                  initialRating:
                                      double.parse(rating!.rating.toString()),
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  ignoreGestures: true,
                                  // itemPadding:
                                  //     EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    size: 1,
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (currentRating) {
                                    // Provider.of<userRatingProvider>(context,
                                    //         listen: false)
                                    //     .updateUserRatingProvider(currentRating);
                                  },
                                ),
                                Text("${rating?.description}")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
          isLoading == true
              ? Container(
                  decoration:
                      BoxDecoration(color: Colors.grey[400]?.withOpacity(0.6)),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Loading",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )
              : Container(),
        ],
      ),
      floatingActionButton: rating != null
          ? Container()
          : FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: Text("Leave Review"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              "Your review is valued to us to validate the service provided by doctors"),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: RatingBar.builder(
                              itemSize: 40,
                              initialRating: selectedRating,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                switch (index) {
                                  case 0:
                                    return Icon(
                                      Icons.sentiment_very_dissatisfied,
                                      color: Colors.red,
                                    );
                                  case 1:
                                    return Icon(
                                      Icons.sentiment_dissatisfied,
                                      color: Colors.redAccent,
                                    );
                                  case 2:
                                    return Icon(
                                      Icons.sentiment_neutral,
                                      color: Colors.amber,
                                    );
                                  case 3:
                                    return Icon(
                                      Icons.sentiment_satisfied,
                                      color: Colors.lightGreen,
                                    );
                                  case 4:
                                    return Icon(
                                      Icons.sentiment_very_satisfied,
                                      color: Colors.green,
                                    );
                                }
                                return Container();
                              },
                              onRatingUpdate: (rating) {
                                print(rating);
                                setState(() {
                                  selectedRating = rating;
                                });
                              },
                            ),
                            // RatingBar.builder(
                            //   itemSize: 40,
                            //   initialRating: 3,
                            //   minRating: 0,
                            //   direction: Axis.horizontal,
                            //   allowHalfRating: true,
                            //   itemCount: 5,
                            //   // itemPadding:
                            //   //     EdgeInsets.symmetric(horizontal: 4.0),
                            //   itemBuilder: (context, _) => Icon(
                            //     size: 1,
                            //     Icons.star,
                            //     color: Colors.amber,
                            //   ),
                            //   onRatingUpdate: (currentRating) {
                            //     // Provider.of<userRatingProvider>(context,
                            //     //         listen: false)
                            //     //     .updateUserRatingProvider(currentRating);
                            //   },
                            // ),
                          ),
                          Container(
                              // color: Colors.amberAccent,
                              child: TextField(
                            controller: ratingComment,
                            decoration: InputDecoration(
                                label: Text("Comment"),
                                hintText: "Enter comment"),
                          ))
                        ],
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  color: Colors.grey[200],
                                  height: 30,
                                  child: Center(
                                      child: Text(
                                    "Cancel",
                                  )),
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 5, right: 5)),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  Navigator.pop(context);
                                  setState(() {
                                    isLoading = true;
                                  });

                                  await Api()
                                      .rateDoctor(
                                          context: scaffoldKey.currentContext!,
                                          rating: selectedRating,
                                          description: ratingComment.text)
                                      .then((value) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  });
                                },
                                child: Container(
                                  color: Colors.blue,
                                  height: 30,
                                  child: Center(
                                      child: Text(
                                    "Send",
                                  )),
                                ),
                              ),
                            )
                          ],
                        )
                      ]),
                );
              },
              child: Icon(Icons.rate_review)),
    );
  }
}
