هذه هي الطريقة لعمل login مع تمرير كل هذه ال parameter فاغلب الكود هو جااااهز

```dart
class LoginWidget
{

  login({final validate, final myEmail, final myPassword, required BuildContext context}) async {
    //ال BuildContext من شان تمرير ال context  لجل ال AwesomeDialog لانها ما تشتغل بدونه
    if (validate.currentState!.validate()) {
      try {

        UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: myEmail,
            password: myPassword
        );
        return credential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: 'error',
              desc: 'No user found for this email',
    )..show();
/*          Get.defaultDialog(
              title: "error",
              content: const Text("No user found for that email"),
              backgroundColor: Colors.amberAccent,
              confirmTextColor: Colors.white,
              titleStyle: const TextStyle(color: Colors.deepOrange));*/
        } else if (e.code == 'wrong-password') {

          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.rightSlide,
            title: 'error',
            desc: 'Wrong password provided for this user',
          )..show();

/*          Get.defaultDialog(
              title: "error",
              content: const Text("Wrong password provided for that user"),
              backgroundColor: Colors.amberAccent,
              confirmTextColor: Colors.white,
              titleStyle: const TextStyle(color: Colors.deepOrange));*/
        }
      }    } else {}
  }
  
  
  //من ناحية هذه الدال , تستخدم للتحقق من حساب الuser هل هو ملكه او لا 
  emailVerified()async{
    User? user = FirebaseAuth.instance.currentUser;
    await user?.sendEmailVerification();

  }

}
```
