```dart
import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
class Test extends StatefulWidget {
  Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  var url;
  getImage()async{
    var image =await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image!=null)
    {
      int random = Random().nextInt(1000000000);
      File file = File(image.path);
      var nameImage = basename(image.path);
      nameImage = "$random$nameImage";
      var revrenceImage = FirebaseStorage.instance.ref("Photos").child("Gallery").child(nameImage);
      await revrenceImage.putFile(file);
      url = await revrenceImage.getDownloadURL();
      setState(() {});
      print("---------------------------");
      print(url);
      print("---------------------------");
    }
    else
    {
        return null;
    }
  }
  getNamesOfImagesAndFolders() async {

    var ref = await FirebaseStorage.instance.ref().child("Photos").child("Camara").listAll();
    ref.items.forEach((element) {
      print(element.name);
    });

    ref.prefixes.forEach((element) {
      print(element.name);
    });
    
  }

  @override
  void initState() {
    getNamesOfImagesAndFolders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: Container(
          width: Get.width,
          child: Column(children: [

            MaterialButton(onPressed: ()async{
              await getImage();
            },child: Icon(Icons.add),),
            SizedBox(height: 30,),
            url!=null?Image.network(url):Center(child: Text("No images"))
          ],),
        ));
  }
}
```
