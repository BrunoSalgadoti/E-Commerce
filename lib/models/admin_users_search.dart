import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminUsersSearch extends ChangeNotifier {
  AdminUsersSearch() {
    _loadAllUsers();
  }

  List<Widget> favouriteList = [];
  List<Widget> normalList = [];

  List<String> get names => allUsers.map((e) => e.userName!).toList();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Users> allUsers = [];
  String _search = '';

  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Users> get filteredUsers {
    final List<Users> filteredUsers = [];

    _loadAllUsers();

    if (search.isEmpty) {
      filteredUsers.addAll(allUsers);
      allUsers = filteredUsers;
    } else {
      filteredUsers.addAll(allUsers.where((u) => u.userName!
          .toString()
          .toLowerCase()
          .contains(search.toString().toLowerCase())));
     allUsers = filteredUsers;
    }
    return filteredUsers;
  }

  Future<void> _loadAllUsers() async {
    final QuerySnapshot snapUsers = await firestore.collection('users').get();

    allUsers = snapUsers.docs.map((d) => Users.fromDocument(d)).toList();
    allUsers.sort((a, b) =>
        a.userName!.toLowerCase().compareTo(b.userName!.toLowerCase()));
    filterList();
    notifyListeners();
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
    final List<Users> users = [];
    users.addAll(filteredUsers);
    favouriteList = [];
    normalList = [];

    for (var user in users) {
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
                children: const <Widget>[
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage("https://placeimg.com/200/200/people"),
                  ),
                  SizedBox(
                      height: 40,
                      width: 40,
                      child: Center(
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
                style: const TextStyle(fontSize: 16,
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
                style: const TextStyle(fontSize: 16,
                    color: Colors.white
                ),
              ),
            ),
          ),
        );
      }
      notifyListeners();
    }
    notifyListeners();
  }
}
