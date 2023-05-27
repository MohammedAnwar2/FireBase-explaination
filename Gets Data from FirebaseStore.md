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




_____________________________________________________________________
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
_______________________________________________________________
# Realtime changes
```dart
 FirebaseFirestore.instance.collection("users").snapshots().listen((event) {
      event.docs.forEach((element) {
        print("------------------------------------------------------");
        print(element.data());
      });
    });
  ```
  _________________________________________________________________
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
3 - اضافة اشياء معينه فقط الى ال doc نستخدم برضو ال set مع SetOptions(merge: true)
```dart
 FirebaseFirestore.instance.collection("users").doc("1123").set(
    {
      "class":"56",
    },SetOptions(merge: true));
    // بيضيف ال class بدون ما يعمل  rebuild  لل doc كامل
}
```

________________________________________________________
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
- عند استعمال ال update ، راح يتم تحديث القيمه الموجود في ذلك ال id , لكن عند ادخااال id خاطئ راح يرجع خطأ وهذه مشكله والحل في set
- ممكن تستخدم ال update  لإضافة اي عناصر الى ال doc مثل class او age او NoPhone ...بشرط ان ال id موجود والا راح يطلع خطأ , ولتجنب ذا الخطأ فينا نستخدم ال set مع SetOptions(merge: true)  

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



_________________________________________________________________
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
___________________________________________________
# catchError and then : we can used with all the properties of firstore {'add','delete','update'}
_________________________________________________________

#  Nasted Collection
```dart
  FirebaseFirestore.instance
      .collection("users")
      .doc("1123")
      .collection("adress")
      .doc("ATVYt1trYCUIrvkUVjLH")
      .update({"city": "Hadramoute"}).then((value) {
    Get.snackbar("Successfully", "The update doc is successfully");
  }).catchError((e) {
    Get.snackbar("Error", "$e");
  });
```
________________________________________________

# Cloud Firestore Transactions

هو وسيلة للتأكد من عملية كتابة تحدث فقط على اخر البيانات المتوفره على السيرفر ، يعني أولا نقرأ من الفايرستور وبعدها نستعمل نكتب ، كل ذا من أجل التأكد ان الكتابة راح تحدث على آخر البيااانات الموحوده في الفايرستور ، مثال لو عند بوستات بأسمك القديم وأنت تريد تعديل اسمك القديم في كل البوستات ، فعند التعديل مباشرة ممكن يحدث خطأ كبير اللي هو ، لو مثلا حدث خطأ في منتصف الطريق فهنا راح تظهر بعض البوستات بأسمك القديم وبعضها بأسمك الحالي وذي مشكلة ، فالحل اننا أولا نقرأ كل البيانات من شااان التأكد ، وبعدها نعدل فعند التعديل اما انه بيعدل على كل البيانات او انه ما رح يعدل ابدا. فالخطأ بالغالب اما يكون سوء الاتصال بالسيرفر او بطئ انترنت او...او....او....
- create doc
```dart
 DocumentReference documentReference = FirebaseFirestore.instance.collection("users").doc("1123");
  FirebaseFirestore.instance.runTransaction((transaction)async {
    DocumentSnapshot snapshot = await transaction.get(documentReference);
    if(snapshot.exists)
    {
      transaction.set(documentReference, {
        "age":"12",
        "password":"1234"
      },SetOptions(merge: true));
    }else
    {
      throw Exception("User does not exist!");
    }
  });
 ```
 - delete one specific property
 ```dart
 DocumentReference documentReference = FirebaseFirestore.instance.collection("users").doc("1123");
  FirebaseFirestore.instance.runTransaction((transaction)async {
    DocumentSnapshot snapshot = await transaction.get(documentReference);
    if(snapshot.exists)
    {
      transaction.update(documentReference, {
        "age":FieldValue.delete(),
        "password":"1234",
      },);
    }else
    {
      throw Exception("User does not exist!");
    }
  });
  ```
- delete all the doc
```dart
  DocumentReference documentReference = FirebaseFirestore.instance.collection("users").doc("1123");
  FirebaseFirestore.instance.runTransaction((transaction)async {
    DocumentSnapshot snapshot = await transaction.get(documentReference);
    if(snapshot.exists)
    {
      transaction.delete(documentReference);
    }else
    {
      throw Exception("User does not exist!");
    }
  });
  ```
  - upate
  ```dart
   DocumentReference documentReference = FirebaseFirestore.instance.collection("users").doc("1123");
  FirebaseFirestore.instance.runTransaction((transaction)async {
    DocumentSnapshot snapshot = await transaction.get(documentReference);
    if(snapshot.exists)
    {
      transaction.update(documentReference,{
        "email":"nnnnn@gmail.com",
        "lang":["ar","fr","en"],
        "password":"abc772555127",
      });
    }else
    {
      throw Exception("User does not exist!");
    }
  });
  ```
  
  
# Batch Write
- تمكننا من تنفيذ اكثر من عملية كتابة بوقت واحد ( set , update , delete ). 
 
 *ملاحظة مهمه
- عمليات الكتابة (write)هن { set , update , delete }
- عمليات القراء (read)هن { get }
- في ال Batch Write  اما كل العمليات تنجح او كل العمليات تفشل مثلها مثل ال Transaction.
- لازم نعمل batch.commit() من اجل تحديث البيانات مثلها مثل ال setState وال update وال emit وانتبه لموضعها زين. شف الأمثله و راح تعرف وين بالضبط  
1 - تعديل كل ال docs
```dart
WriteBatch batch = FirebaseFirestore.instance.batch();
FirebaseFirestore.instance.collection("users").get().then((value) {
  value.docs.forEach((documents) {
    batch.update(documents.reference, {
      "email":"123"});
    batch.set(documents.reference, {
      "userName":"123"},SetOptions(merge: true));
    batch.update(documents.reference, {
      "age":FieldValue.delete(),
      "password":"123"
    });
  });
  
  batch.commit();
});

```
2 - تعديل  docs محدد
```dart
DocumentReference doc1 = FirebaseFirestore.instance.collection("users").doc("1123");
DocumentReference doc2 = FirebaseFirestore.instance.collection("users").doc("1a4cfmPF6xuoGLCior8v");
WriteBatch batch = FirebaseFirestore.instance.batch();
   batch.update(doc1, {
     "email":"zzzzzzz"});
   batch.update(doc2, {
     "lang":FieldValue.delete()
   });
   batch.commit();
```

# عرض البيانات على ال ui

* ui.isEmpty||ui==null?const Center(child: CircularProgressIndicator()): ListView.builder()
- توجد طريقتين

* الطريقة الاولى(استخدام List)

1 - [To Get One Document]
```dart
 List ui=[] ;
  getData()async{
    FirebaseFirestore.instance.collection("users").doc("1123").get().then((value) {
     setState(() {
      ui.add(value.data());
     });

     });
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
```

2 - [To Get All The Documents]
```dart
List ui=[] ;

  getData()async{
    FirebaseFirestore.instance.collection("users").get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          ui.add(element.data());
        });

      });
    });
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
```

* الطريقة الثانية (لا نتحتاج الى ال setState)(FutureBuilder)

1 - [To Get All The Documents]
```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  Test({Key? key}) : super(key: key);

  CollectionReference users = FirebaseFirestore.instance.collection("users");
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: users.get(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text("${snapshot.data.docs[index].data()["userName"]}"),
                      subtitle: Text("${snapshot.data.docs[index].data()["email"]}"),
                      trailing: Text("${snapshot.data.docs[index].data()["password"]}"),
                    ),
                  );
                },
              );
        }
        if (snapshot.hasError) {
          return Text("error");
        }
        return Center(child:CircularProgressIndicator() );
      },
    ));
  }
}
```
2 - [To Get One Document]
```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  Test({Key? key}) : super(key: key);

  DocumentReference users = FirebaseFirestore.instance.collection("users").doc("1123");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: users.get(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
              return Card(
                child: ListTile(
                  title: Text("${snapshot.data.data()["userName"]}"),
                  subtitle: Text("${snapshot.data.data()["email"]}"),
                  trailing: Text("${snapshot.data.data()["password"]}"),
                ),
              );
        }
        if (snapshot.hasError) {
          return Text("error");
        }
        return Center(child:CircularProgressIndicator() );
      },
    ));
  }
}

```
