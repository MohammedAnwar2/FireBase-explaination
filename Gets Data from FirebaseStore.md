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

# لفلترة البيانات بشكل كامل نستخدم ال Filtering 
# لكن هنا يوجد فلتر واحد فقط
```dart
    FirebaseFirestore.instance.collection("users").where("lang",arrayContainsAny: ["ar","en"]).get().then((value) {
      value.docs.forEach((element) {
        print("-------------------------------------------------------------------------------");
        print(element.data()["userName"]);
        print(element.exists);
      });
    });
```
ال lang هو ال doc الموجود بداخل الcollection users 


# لعمل عدة فلاتر نستخدم الاتي و ذلك بتكرار ال while
```dart
FirebaseFirestore.instance.collection("users").where("lang",arrayContainsAny: ["ar"]).where("age",isGreaterThanOrEqualTo: "20").where("userName",isEqualTo: "Salem").get().then((value) {
      value.docs.forEach((element) {
        print("-------------------------------------------------------------------------------");
        print(element.data());
        print(element.exists);
      });
    });
   ```
   # ملاحظه
   - ممكن ما يشتغل سواء , بيظهر لنا رابط في ال Run  انسخة الى اي BROWSER مثل القوقل كروم  وبعدها انتظر لييين تتحول كلمة Building الى Enabled
   - بعدها اضغط على الاحمر(ctrl+F2) من شان يتقفل البرنامج ومن ثم اعمل flutter clean ويعدها اعد تشغيل البرنامج بالاخضر(shift+F12) 





# Cloud Firestore Order By , Limit , StartAt , EndAt , StartAfter , endBefore
- StartAt = Greater or Equal to 
- StartAfter = Greater than
- EndAt = Less or Equal to 
- endBefore = Less than 
```dart
 FirebaseFirestore.instance.collection("users").orderBy("age",descending: false).startAfter(["19"]).limit(1).get().then((value) {
        for (var element in value.docs) {
          print("------------------------------------------------------------------------------------------------------");
          print(element.data());
        }
```
- ال limit خلها اخر شيء 
- عند استخدام StartAt , EndAt , StartAfter , endBefore خل الdescending ء, orderBy("age",descending: false) تساوي  false او لا تكتب ال orderBy ابدا , كل ذا من شان يضل الترتيب من الاصغر الى الاكبر , لانه في حالة كان true  بيكون الترتيب من الاكبر الى الاصغر ولذا ما رح نقدر نطبق الخواص الاربع ذولا بشكل كااامل

# Realtime changes
```dart
 FirebaseFirestore.instance.collection("users").snapshots().listen((event) {
      event.docs.forEach((element) {
        print("------------------------------------------------------");
        print(element.data());
      });
    });
  ```
  
# Add data to fireStore

1- مع id عشوائي 
```dart
     FirebaseFirestore.instance.collection("users").add({
       "age":"35",
       "email":"nnnnn@gmail.com",
       "lang":["ar","fr","en"],
       "password":"abc772555127",
       "userName":"Ahmed Saleh"
     });
```
2 - مع تخصيص id 
```dart
 FirebaseFirestore.instance.collection("users").doc("123").set({
   "age":"55",
   "email":"vvvv@gmail.com",
   "lang":["ar","fr","en"],
   "password":"abc772555127",
   "userName":"basel fhme"
 });
```

# Update Date in fireStore

أولا عند ال update لازم نحدد ال id 


1 - using update 
 
```dart
FirebaseFirestore.instance.collection("users").doc("123"). update (
    {
      "age":"56",
    });
}
```
عند استعمال ال update ، راح يتم تحديث القيمه الموجود في ذلك ال id , لكن عند ادخااال id خاطئ راح يرجع خطأ وهذه مشكله والحل في set



2 - using set
```dart
 FirebaseFirestore.instance.collection("users").doc("1123").set(
    {
      "age":"56",
    },SetOptions(merge: true));
}
```

ال set اختصاصها انشأ doc جديد ، حتى عند استعمالها بالوضع العادي ، راح يتم انشأ واحد جديد واذا كان موجود ال id راح يعمل له rebuild من جديد ، يعني لو جئنا بنعدل ال age فقط راح يتم مسح كل شيء ويبني لك doc جديد فيها age فقط

فالحل نستخدم,SetOptions(merge: true) الموجوده بداخل ال set فوظيفتها تخلي الset مثل ال update يعني لو تريد نعدل على حاجه معينه راح يتم التعديل على هذه الحاجه فقط ولن يتم المساس باي قيمه أخرى ، 

الاختلاف بين ال update وال set
إذا كان ال id خاطى 
فان ال update ترجع خطأ وال set تنشأ doc جديد




# Delete Data 

1 - delete documents

```dart
FirebaseFirestore.instance
      .collection("users")
      .doc("1123")
      .delete().then((value) {
    Get.snackbar("Successfully", "The delete doc is successfully");
  }).catchError((e) {
    Get.snackbar("Error", "$e");
  });
  ```



2 - delete a specific properties from within a document itself 
You can use  the 'delete' method with the 'FieldValue' class


  ```dart
  FirebaseFirestore.instance
      .collection("users")
      .doc("1123")
      .update({"age":FieldValue.delete()}).then((value) {
    Get.snackbar("Successfully", "The delete doc is successfully");
  }).catchError((e) {
    Get.snackbar("Error", "$e");
  });
```

# catchError and then : we can used with all the properties of firstore {'add','delete','update'}
