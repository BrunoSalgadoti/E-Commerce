import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/users.dart';
import 'package:ecommerce/models/users_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminUsersManager extends ChangeNotifier {
  List<Users> userList = [];
  List<Widget> favouriteList = [];
  List<Widget> normalList = [];

  List<String> get names => userList.map((e) => e.userName!).toList();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController searchController = TextEditingController();

  void updateUser(UserManager userManager) {
    if (userManager.adminEnable) {
      listenToUsers();
    }
  }

  Future<void> listenToUsers() async {
    firestore.collection('users').get().then((snapshot) async {
      userList = snapshot.docs.map((d) => Users.fromDocument(d)).toList();
      userList.sort((a, b) =>
          a.userName!.toLowerCase().compareTo(b.userName!.toLowerCase()));
      filterList();
      notifyListeners();
    });
  }

  void _sendEmail(String userEmail, String userName) {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: userEmail,
        query: encodeQueryParameters(<String, String>{
          'subject': 'BRN Info_DEV',
          'body': 'Olá $userName,\n Estamos Entrando em contato para:\n'
        }));
    launchUrl(emailLaunchUri);
  }

  void filterList() {
    List<Users> users = [];
    users.addAll(userList);
    favouriteList = [];
    normalList = [];

    users.forEach((user) {
      if (searchController.text.isNotEmpty) {
        users.retainWhere((user) => user.userName!
            .toLowerCase()
            .contains(searchController.text.toLowerCase()));
      }

      if (user.favourite) {
        favouriteList.add(
          Slidable(
            startActionPane: ActionPane(
              motion: const DrawerMotion(),
              extentRatio: 0.25,
              children: [
                SlidableAction(
                  flex: 2,
                  label: 'Desfavoritar',
                  backgroundColor: Colors.red,
                  icon: Icons.star,
                  onPressed: (context) {},
                ),
              ],
            ),
            endActionPane: ActionPane(
              motion: const DrawerMotion(),
              extentRatio: 0.25,
              children: [
                SlidableAction(
                  label: 'Enviar',
                  backgroundColor: Colors.cyanAccent,
                  icon: Icons.email,
                  onPressed: (context) {
                    _sendEmail(user.email, user.userName!);
                  },
                ),
              ],
            ),
            child: ListTile(
              leading: Stack(
                children: <Widget>[
                  const CircleAvatar(
                    backgroundImage:
                        NetworkImage("https://placeimg.com/200/200/people"),
                  ),
                  Container(
                      height: 40,
                      width: 40,
                      child: const Center(
                        child: Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ))
                ],
              ),
              title: Text(user.userName!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.white
                  )),
              subtitle: Text(
                user.email,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white
                ),
              ),
            ),
          ),
        );
      } else {
        normalList.add(
          Slidable(
            startActionPane: ActionPane(
              motion: const DrawerMotion(),
              extentRatio: 0.25,
              children: [
                SlidableAction(
                  flex: 2,
                  label: 'Favorito',
                  backgroundColor: Colors.green,
                  icon: Icons.star,
                  onPressed: (context) {},
                ),
              ],
            ),
            endActionPane: ActionPane(
              motion: const DrawerMotion(),
              extentRatio: 0.25,
              children: [
                SlidableAction(
                  label: 'Enviar',
                  backgroundColor: Colors.cyanAccent,
                  icon: Icons.email,
                  onPressed: (context) {
                    _sendEmail(user.email, user.userName!);
                  },
                ),
              ],
            ),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundImage:
                    NetworkImage("https://placeimg.com/200/200/people"),
              ),
              title: Text(user.userName!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.white
                  )),
              subtitle: Text(
                user.email,
                style: const TextStyle(
                    fontSize: 16, color:
                Colors.white
                ),
              ),
            ),
          ),
        );
      }
      notifyListeners();
    });
  }
}
