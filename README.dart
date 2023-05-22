                try {
                  userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: "moanbm123@gmail.com",
                      password: "abc772555127"
                  );
                  print(userCredential?.user?.emailVerified);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                  }

                }
                if(userCredential?.user?.emailVerified==false)
                {
                  User? user = FirebaseAuth.instance.currentUser;
                  await user?.sendEmailVerification();
                }






                try {
                  userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: "moanbm123@gmail.com",
                    password:  "abc772555127"
                  );
                  if(userCredential?.user?.emailVerified==false)
                  {
                    User? user = FirebaseAuth.instance.currentUser;
                    await user?.sendEmailVerification();
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }

