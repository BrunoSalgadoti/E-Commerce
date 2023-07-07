import 'package:brn_ecommerce/common/button/custom_text_button.dart';
import 'package:brn_ecommerce/common/show_alert_dialog.dart';
import 'package:brn_ecommerce/models/admin_orders_manager.dart';
import 'package:brn_ecommerce/models/page_manager.dart';
import 'package:brn_ecommerce/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminUsersSearch extends ChangeNotifier {
  AdminUsersSearch() {
    _loadAllUsers();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool userFilteredSendEmail = false;
  String _search = '';

  List<Users> allUsers = [];
  List<Widget> favouriteList = [];
  List<Widget> normalList = [];

  List<String> get names => allUsers
      .where((user) => !user.favourite!)
      .map((user) => user.userName!.toUpperCase())
      .toList();

  List<String> get emails => allUsers.map((e) => e.email).toList();

  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Users> get filteredUsers {
    final List<Users> filteredUsers = [];

    _loadAllUsers();

    if (search.isEmpty) {
      userFilteredSendEmail = false;
      filteredUsers.addAll(allUsers);
      allUsers = filteredUsers;
    } else {
      userFilteredSendEmail = true;
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

  void _sendEmail(String? userEmail, String? userName) {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: userEmail ??
            emails.toString().replaceAll('[', '').replaceAll(']', ''),
        query: encodeQueryParameters(<String, String>{
          'subject': 'BRN Info_DEV',
          'body': userName == null
              ? 'Olá estimado Cliente,\n Estamos Entrando em contato para:\n'
              : 'Olá $userName,\n Estamos Entrando em contato para:\n',
        }));
    launchUrl(emailLaunchUri);
  }

  Future<void> _favoringUser(String? id) async {
    await firestore.collection('users').doc(id).update({
      'favourite': true,
    });
  }

  Future<void> _disfavoringUser(String? id) async {
    await firestore.collection('users').doc(id).update({
      'favourite': false,
    });
  }

  void filterList() {
    final List<Users> users = [];
    users.addAll(filteredUsers);
    favouriteList = [];
    normalList = [];

    for (var user in users) {
      if (user.favourite == true) {
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
                  onPressed: (context) {
                    _disfavoringUser(user.id);
                  },
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
            child: Consumer2<AdminOrdersManager, PageManager>(
              builder: (_, adminOrdersManager, pageManager, __) {
                return ListTile(
                  leading: const Stack(
                    children: <Widget>[
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
                          fontWeight: FontWeight.w800, color: Colors.white)),
                  subtitle: Text(
                    user.email,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onTap: () {
                    adminOrdersManager.setUserFilter(user);
                    pageManager.setPage(6);
                  },
                );
              },
            ),
          ),
        );
      } else {
        normalList.add(Slidable(
            startActionPane: ActionPane(
              motion: const DrawerMotion(),
              extentRatio: 0.25,
              children: [
                SlidableAction(
                  flex: 2,
                  label: 'Favorito',
                  backgroundColor: Colors.green,
                  icon: Icons.star,
                  onPressed: (context) {
                    _favoringUser(user.id);
                  },
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
                      userFilteredSendEmail == true
                          ? _sendEmail(user.email, user.userName)
                          : showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return ShowAlertDialog(
                                  titleText: 'Enviar E-mail',
                                  titleSize: 18,
                                  titleColor: Colors.black,
                                  bodyText: 'Escolha para quem deseja enviar\n '
                                      'o E-mail!',
                                  bodyWeight: FontWeight.normal,
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomTextButton(
                                          text: 'Este Contato',
                                          icon: null,
                                          onPressed: () {
                                            _sendEmail(
                                                user.email, user.userName);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        CustomTextButton(
                                          text: 'Todos contatos!',
                                          icon: null,
                                          onPressed: () {
                                            _sendEmail(null, null);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        CustomTextButton(
                                          text: 'Cancelar',
                                          icon: null,
                                          color: Colors.red,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              });
                    }),
              ],
            ),
            child: Consumer2<AdminOrdersManager, PageManager>(
                builder: (_, adminOrdersManager, pageManager, __) {
              return ListTile(
                leading: const CircleAvatar(
                  backgroundImage:
                      NetworkImage("https://placeimg.com/200/200/people"),
                ),
                title: Text(user.userName!,
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, color: Colors.white)),
                subtitle: Text(
                  user.email,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                onTap: () {
                  adminOrdersManager.setUserFilter(user);
                  pageManager.setPage(6);
                },
              );
            })));
      }
    }
  }
}
