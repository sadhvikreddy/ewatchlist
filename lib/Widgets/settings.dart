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
                body: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              'EWatchlist',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30),
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
                            //forgot password screen
                          },
                          child: const Text(
                            'Forgot Password',
                          ),
                        ),
                        Container(
                            height: 50,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              child: const Text('Login'),
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
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                settings.updateUserState(UserState.signUp);
                              },
                            ),
                          ],
                        ),
                        Text(settings.statusMessages),
                      ],
                    ))));
      } else if (settings.userState == UserState.signUp) {
        return MaterialApp(
            home: Scaffold(
                body: Center(
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          color: Colors.grey,
                          child: Column(children: [
                            const Text('Signup'),
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
                                height: 50,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ElevatedButton(
                                  child: const Text('Sign up'),
                                  onPressed: () {
                                    settings.triggerSignup(
                                        settings.nameController.text,
                                        settings.emailController.text,
                                        settings.passController.text);
                                  },
                                )),
                            Text(settings.statusMessages),
                          ]),
                        )))));
      } else if (settings.userState == UserState.signedIn) {
        return MaterialApp(
            home: Scaffold(
                body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text("${settings.userName} is signed in"),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () => {}, child: const Text("Go to watchlist")),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () => {}, child: const Text("Change Username")),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () => {}, child: const Text("Change Password")),
            ),
            Center(
                child: ElevatedButton(
                    onPressed: settings.triggerSignout,
                    child: const Text("Sign Out")))
          ],
        )));
      } else {
        return const CircularProgressIndicator();
      }
    });
  }
}
