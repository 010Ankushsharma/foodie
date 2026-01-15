

import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/admin/services/database.dart';
import 'package:image_picker/image_picker.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final List<String>items=['icecream','pizza','salad', 'burger'];
  String? value;
  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController detailController = new TextEditingController();
  final ImagePicker picker = ImagePicker();
  File? selectedImage;

  Future getImage()async{
    var image = await picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {

    });
  }
  uploadItem() async {
    if (selectedImage != null &&
        nameController.text != "" &&
        priceController.text != "" &&
        detailController.text != "") {
      String addId = generateRandomString(10);

      Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child("blogImages").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl = await (await task).ref.getDownloadURL();

      Map<String, dynamic> addItem = {
        "Image": downloadUrl,
        "Name": nameController.text,
        "Price": priceController.text,
        "Detail": detailController.text
      };
      await DatabaseMethods().addFoodItem(addItem, value!).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Food Item has been added Successfully",
              style: TextStyle(fontSize: 18.0),
            )));
      });
    }
  }
  String generateRandomString(int length) {
    var random = Random.secure();
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color(0xFF373866),
          ),
        ),
        centerTitle: true,
        title: Text('Add Item',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upload your food image",
                style: TextStyle(fontWeight: FontWeight.w100, fontSize: 20),
              ),
              SizedBox(
                height: 29,
              ),
              selectedImage == null ?
              GestureDetector(
                onTap: (){
                  getImage();
                },
                child: Center(
                  child: Material(
                    elevation: 4,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                      Icons.camera_alt_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              )
                  : Center(
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        selectedImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Item Name",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Item Name",
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 20)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Item Price",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Item Price",
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 20)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Item Detail",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  maxLines: 6,
                  controller: detailController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Item Detail",
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 20)),
                ),
              ),
              SizedBox(height: 20,),
              Text(
                "Select Category",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color:Color(0xFFececf8),borderRadius: BorderRadius.circular(10)),
                  child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  items: items.map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item, style: TextStyle(color: Colors.black,fontSize: 18,),),
                  )).toList(),
                  onChanged: (value) => setState(() {
                    this.value=value;
                  }),
                  dropdownColor: Colors.white,
                  hint: Text("select Category"),
                  iconSize: 36,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.black,),
                  value: value,
                ),
              )),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  uploadItem();

                },
                child: Center(
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                       child: Center(child: Text("Add",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
