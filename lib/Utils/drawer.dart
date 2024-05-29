
import 'package:call_app/login_screen/auth_services.dart';
import 'package:call_app/login_screen/sign_in_landing_page.dart';
import 'package:call_app/services/firebase_service.dart';
import 'package:call_app/services/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDrawer extends ConsumerWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final userdetail  = ref.watch(userDetailsProvider);
      return Drawer(
        child: userdetail.when(
                data: (userData) {
                  return ListView(
                    padding: const EdgeInsets.all(0),
                    children: [
                       DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.green[200],
                        ), //BoxDecoration
                        child: UserAccountsDrawerHeader(
                          decoration: BoxDecoration(color: Colors.green),
                          accountName: Text(
                            '${userData?.name}',
                            style: TextStyle(fontSize: 18),
                          ),
                          accountEmail: Text('${userData?.emailId}'),
                          currentAccountPictureSize: Size.square(50),
                          currentAccountPicture: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 165, 255, 137),
                            child: Text(
                              "${userData?.name.substring(0, 1).toUpperCase()}",
                              style: TextStyle(fontSize: 30.0, color: Colors.blue),
                            ), //Text
                          ), //circleAvatar
                        ), //UserAccountDrawerHeader
                      ), //DrawerHeader
        
                      ListTile(
                        leading: const Icon(Icons.book),
                        title:  Text('${userData?.phoneNumber}'),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
        
                      ListTile(
                        leading: const Icon(Icons.logout),
                        title: const Text('LogOut'),
                        onTap: () {
                           AuthService.logout();
                           FirebaseServices.logout();
                           Navigator.pushReplacement(
                         context, MaterialPageRoute(builder: (context) => const SignInLandingPage())); // Close the dialog
                        },
                      ),
                    ],
                  );
                },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error userDetail: $error')),
            ),
      );


  }
}
