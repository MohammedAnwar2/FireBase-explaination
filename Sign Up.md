طريقة عملsign up
خلال ذا المشروع عملنا على التحقق من ال emdil ي لانه لاحظت ما يتحقق منه بالشكل المطلوب لذا استخدمت هذه ال package للتحقق من الemail اللي هي email_validator 
```dart
validator: (value) {
  final bool isValid = EmailValidator.validate(value!);
  if (!isValid) {
    return "Email does not valid";
  } else {
    return null;
  }
}
```


```dart
class SignUpWidget
{

  signUp({final validate, final myEmail, final myPassword}) async {
    if (validate.currentState!.validate()) {
      try {
        UserCredential credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: myEmail,
          password: myPassword,
        );
        return credential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.defaultDialog(
              title: "error",
              content: const Text("The password provided is too weak"),
              backgroundColor: Colors.amberAccent,
              confirmTextColor: Colors.white,
              titleStyle: const TextStyle(color: Colors.deepOrange));
          //print('.');
        } else if (e.code == 'email-already-in-use') {
          Get.defaultDialog(
              title: "error",
              content: Text("The account already exists for that email"),
              backgroundColor: Colors.amberAccent,
              confirmTextColor: Colors.white,
              titleStyle: TextStyle(color: Colors.deepOrange));
        }
      } catch (e) {
        Get.defaultDialog(
            title: "error",
            content: Text("$e"),
            backgroundColor: Colors.amberAccent,
            confirmTextColor: Colors.white,
            titleStyle: TextStyle(color: Colors.deepOrange));
      }
    } else {}
  }
  emailVerified()async{
    User? user = FirebaseAuth.instance.currentUser;
    await user?.sendEmailVerification();

  }

}
```
| الاسم        | الرقم     | التاريخ       | الوصف            |
|--------------|-----------|---------------|------------------|
| أحمد         | 12345     | 2024-11-16    | فاتورة مستحقة   |
| سارة         | 67890     | 2024-11-15    | طلب جديد         |
| محمد         | 54321     | 2024-11-14    | مراجعة الحسابات |
| نور          | 98765     | 2024-11-13    | اجتماع عمل       |
