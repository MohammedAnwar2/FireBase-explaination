```dart
bool ?isLogin;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
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
      initialRoute:isLogin==false? AppRoute.login:AppRoute.homePage,
      routes:route
    );

  }
}


```
