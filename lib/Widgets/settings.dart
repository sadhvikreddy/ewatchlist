import 'package:ewatchlist/Providers/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsModel>(builder: (context, settings, child) {
      if (settings.userState == UserState.signedOut) {
        return MaterialApp(
            home: Scaffold(
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.pushNamed(context, '/search');
                  },
                  backgroundColor: const Color.fromRGBO(54, 68, 79, 0.8),
                  label: const Text('Search'),
                  icon: const Icon(Icons.search),
                ),
                body: Center(
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListView(
                          children: <Widget>[
                            Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  height: 100,
                                  width: 100,
                                )),
                            Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                child: const Text(
                                  'Sign in',
                                  style: TextStyle(fontSize: 20),
                                )),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: TextField(
                                controller: settings.emailController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: TextField(
                                obscureText: true,
                                controller: settings.passController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Password',
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext ctx) {
                                      return AlertDialog(
                                        title: const Text("Forgot password?"),
                                        content: TextField(
                                          onChanged: ((value) {
                                            settings.chEmail = value;
                                          }),
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red)
                                                // Color.fromRGBO(54, 68, 79, 1)),
                                                ),
                                            labelText: 'Email',
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('Cancel')),
                                          TextButton(
                                              onPressed: () {
                                                settings.forgotPass();
                                              },
                                              child: const Text(
                                                  'Request Email link')),
                                        ],
                                      );
                                    });
                              },
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                    color: Color.fromRGBO(54, 68, 79, 0.8)),
                              ),
                            ),
                            Container(
                                color: const Color.fromRGBO(54, 68, 79, 0),
                                height: 50,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStatePropertyAll<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    )),
                                    foregroundColor:
                                        const MaterialStatePropertyAll<Color>(
                                            Colors.white),
                                    backgroundColor:
                                        const MaterialStatePropertyAll<Color>(
                                            Color.fromRGBO(54, 69, 79, 1)),
                                  ),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    settings.triggerSignin(
                                        settings.passController.text,
                                        settings.emailController.text);
                                  },
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text('Does not have account?'),
                                TextButton(
                                  child: const Text(
                                    'Sign up',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromRGBO(54, 68, 79, 0.8)),
                                  ),
                                  onPressed: () {
                                    settings.updateUserState(UserState.signUp);
                                  },
                                ),
                              ],
                            ),
                            Text(settings.statusMessages),
                          ],
                        )))));
      } else if (settings.userState == UserState.signUp) {
        return MaterialApp(
            home: Scaffold(
                body: Center(
                    child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 100,
                  width: 100,
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Welcome!',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: settings.nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: settings.emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: settings.passController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
                color: const Color.fromRGBO(54, 68, 79, 0),
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
                    foregroundColor:
                        const MaterialStatePropertyAll<Color>(Colors.white),
                    backgroundColor: const MaterialStatePropertyAll<Color>(
                        Color.fromRGBO(54, 69, 79, 1)),
                  ),
                  child: const Text('Sign up'),
                  onPressed: () {
                    settings.triggerSignup(
                        settings.nameController.text,
                        settings.emailController.text,
                        settings.passController.text);
                  },
                )),
            Container(
                color: const Color.fromRGBO(54, 68, 79, 0),
                width: 100,
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                    onPressed: () =>
                        settings.updateUserState(UserState.signedOut),
                    style: ButtonStyle(
                        backgroundColor:
                            const MaterialStatePropertyAll<Color>(Colors.white),
                        foregroundColor: const MaterialStatePropertyAll<Color>(
                            Color.fromRGBO(54, 69, 79, 1)),
                        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [BackButtonIcon(), Text("Back")],
                    ))),
            Text(settings.statusMessages),
          ]),
        ))));
      } else if (settings.userState == UserState.signedIn) {
        return MaterialApp(
            home: Scaffold(
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.pushNamed(context, '/search');
                  },
                  backgroundColor: const Color.fromRGBO(54, 68, 79, 0.8),
                  label: const Text('Search'),
                  icon: const Icon(Icons.search),
                ),
                body: Align(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListView(children: <Widget>[
                          Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                'assets/images/logo.png',
                                height: 200,
                                width: 200,
                              )),
                          Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Hello ${settings.userName}',
                                style: const TextStyle(fontSize: 20),
                              )),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              height: 100,
                              padding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStatePropertyAll<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  )),
                                  foregroundColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Color.fromRGBO(54, 69, 79, 1)),
                                ),
                                child: const Text('Go to Watchlist',
                                    style: TextStyle(fontSize: 20)),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/watchlist');
                                },
                              )),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              height: 100,
                              padding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStatePropertyAll<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  )),
                                  foregroundColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Color.fromRGBO(54, 69, 79, 1)),
                                ),
                                child: const Text('Change Username',
                                    style: TextStyle(fontSize: 20)),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext ctx) {
                                        return AlertDialog(
                                          title: const Text("Change username"),
                                          content: TextField(
                                            onChanged: ((value) {
                                              settings.chUserName = value;
                                            }),
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.red)
                                                  // Color.fromRGBO(54, 68, 79, 1)),
                                                  ),
                                              labelText: 'Name',
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: const Text('Cancel')),
                                            TextButton(
                                                onPressed: () {
                                                  settings.changeUsername();
                                                  Navigator.pop(
                                                      context, 'Cancel');
                                                },
                                                child: const Text(
                                                    'Change username')),
                                          ],
                                        );
                                      });
                                },
                              )),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              height: 100,
                              padding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStatePropertyAll<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  )),
                                  foregroundColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Color.fromRGBO(54, 69, 79, 1)),
                                ),
                                child: const Text(
                                  'Sign Out',
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  settings.triggerSignout();
                                },
                              )),
                        ])))));
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
