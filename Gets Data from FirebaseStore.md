# لجلب البيانات من ال firestore  ل collection كامل او docs معين بداخل هذا ال collection


import 'package:cloud_firestore/cloud_firestore.dart';
 getData()async{
   
   //هنا حددنا ايش من doc نريد ان نسحب البيانات منه
   //لما نحدد doc فان البيانات الراجعه في النهاية تكون على شكل map
   //ال data تعني البيانات التي بداخل القيمة الراجعه
 ```dart
FirebaseFirestore.instance.collection("users").doc("SK0cMfsOk6AZHXCL7HUK").get().then((value) {
    print("------------------------");
    value.data()?.forEach((key, value) { 
      print("$key = $value");
    });
    print("------------------------");
  });


print("-----------------------------++++++++++++++++++++------------------------------------------");
```

 //هنا رجعنا كل ال doc الموجوده بداخل ال collection users
 //لما نرجع كل ال doc فان البيانات الراجعه في النهاية تكون على شكل List وما بداخلها Map
```dart
    FirebaseFirestore.instance.collection("users").get().then((value) {
      value.docs.forEach((element) { //List 
        print("--------------------------");
        print("password = ${element.data()['password']}");//Map
        element.data().forEach((key, value) {
          print(value);
        });
      });
    });
print("-----------------------------++++++++++7777++++++++++------------------------------------------");

    FirebaseFirestore.instance.collection("note").get().then((value) => {
        print("-----------123---------------"),
      value.docs.forEach((element) {
        element.data().forEach((key, value) {
          print("$key = $value");
        });
      })
    });


}
```

# لتحديد البيانات بشكل كامل نستخدم ال Filtering 
```dart
    FirebaseFirestore.instance.collection("users").where("lang",arrayContainsAny: ["ar","en"]).get().then((value) {
      value.docs.forEach((element) {
        print("-------------------------------------------------------------------------------");
        print(element.data()["userName"]);
        print(element.exists);
      });
    });
```
ال lang هو ال doc الموجود بداخل ال collection users 
