import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_app/admin/services/auth.dart';
import 'package:food_app/admin/services/shared_pref.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? profile, name, email;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  // Future getImage() async {
  //   var image = await _picker.pickImage(source: ImageSource.gallery);
  //
  //   selectedImage = File(image!.path);
  //   setState(() {
  //     uploadItem();
  //   });
  // }
  Future getImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image!.path);
        uploadItem();
      });
    }
  }


  // uploadItem() async {
  //   if (selectedImage != null) {
  //     String addId = randomAlphaNumeric(10);
  //
  //     Reference firebaseStorageRef =
  //     FirebaseStorage.instance.ref().child("blogImages").child(addId);
  //     final UploadTask task = firebaseStorageRef.putFile(
  //         selectedImage! as File);
  //
  //     var downloadUrl = await (await task).ref.getDownloadURL();
  //     await SharedPreferencesHelper().saveUserProfile(downloadUrl);
  //
  //     setState(() {
  //
  //     });
  //   }
  // }
  Future<void> uploadItem() async {
    if (selectedImage != null) {
      //  String addId = randomAlphaNumeric(10);

      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImages");
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      try {
        TaskSnapshot snapshot = await task;
        var downloadUrl = await snapshot.ref.getDownloadURL();
        await SharedPreferencesHelperss().saveUserProfile(downloadUrl);
      } catch (e) {
        print("Error uploading image: $e");
      }
    }
  }
  getthesharedpref() async {
    profile = await SharedPreferencesHelperss().getUserProfile() ?? ""; // Provide a default value if null
    name = await SharedPreferencesHelperss().getUserName() ?? "";
    email = await SharedPreferencesHelperss().getUserEmail() ?? "";
    setState(() {});
  }


  onthisload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    onthisload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 45, left: 20, right: 20),
                          height: MediaQuery.of(context).size.height / 4.3,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.elliptical(
                                    MediaQuery.of(context).size.width, 105)),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 6.5),
                            child: Material(
                              elevation: 10.0,
                              borderRadius: BorderRadius.circular(60),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: selectedImage == null
                                    ? GestureDetector(
                                        onTap: () {
                                          getImage();
                                        },
                                        child: profile == null
                                            ? Image.asset(
                                                "assets/images/img.png",
                                                height: 120,
                                                width: 120,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                profile!,
                                                height: 120,
                                                width: 120,
                                                fit: BoxFit.cover,
                                              ),
                                      )
                                    : Image.file(
                                        selectedImage!,
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 70),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Ankush Choudhary",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 2.0,
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Ankush Choudhary",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 2.0,
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "ankush2002choudhary@gmail.com",

                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
        
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 2.0,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Row(
                            children: [
                              Icon(
                                Icons.description,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Terms and Condition",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
        
                    SizedBox(
                      height: 30.0,
                    ),
                    GestureDetector(
                      onTap: () {
                         AuthMethods().deleteuser();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          elevation: 2.0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 10.0,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Delete Account",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    GestureDetector(
                      onTap: () {
                         AuthMethods().SignOut();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          elevation: 2.0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 10.0,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Logout",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
