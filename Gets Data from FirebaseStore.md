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
