يمكن برضو عمل هذه بال shared Prefrences


```dart
//نعمل متغير هنا من شان حفظ الحالة
bool ?isLogin;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  
  
  //هذا FirebaseAuth.instance.currentUser يرجع null اذا كااان ال user ما سجل الدخول باخر مره كان فاتح على ذا الجوال 
  var user = FirebaseAuth.instance.currentUser;
  if(user!=null) {
    isLogin=true;
  } else {
    isLogin=false;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      
      //هنا يتم التحقق والانتقال الى الشاشه المناسبه
      initialRoute:isLogin==false? AppRoute.login:AppRoute.homePage,
      routes:route
    );

  }
}


```
