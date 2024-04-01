import 'dart:async';

import 'package:brn_ecommerce/common/buttons/custom_text_button.dart';
import 'package:brn_ecommerce/common/miscellaneous/communications_utils.dart';
import 'package:brn_ecommerce/models/admin_area/admin_orders_manager.dart';
import 'package:brn_ecommerce/models/screens/page_manager.dart';
import 'package:brn_ecommerce/models/users/users.dart';
import 'package:brn_ecommerce/services/development_monitoring/firebase_performance.dart';
import 'package:brn_ecommerce/services/development_monitoring/monitoring_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class AdminUsersSearch extends ChangeNotifier {
  AdminUsersSearch() {
    if (allUsers.isEmpty) {
      _loadAllUsers();
    }
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  StreamSubscription<dynamic>? _subscription;

  bool userFilteredSendEmail = false;
  String _search = '';

  List<Users> allUsers = [];
  List<Widget> favouriteList = [];
  List<Widget> normalList = [];

  List<String> get names {
    if (search.isEmpty) {
      return allUsers
          .where((user) => !user.favourite!)
          .map((user) => user.userName!.toUpperCase())
          .toList();
    } else {
      final filteredUsers = getFilteredUsers();

      return filteredUsers
          .where((user) => !user.favourite!)
          .map((user) => user.userName!.toUpperCase())
          .toList();
    }
  }

  List<String> get emails => allUsers.map((e) => e.email).toList();

  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  void _loadAllUsers() {
    if (!kReleaseMode) {
      MonitoringLogger().logInfo('_loadAllUsers');
    }

    PerformanceMonitoring().startTrace('listen-users', shouldStart: true);

    // Start by fetching data from cache
    firestore.collection("users").get(const GetOptions(source: Source.cache)).then((snapshot) {
      if (snapshot.metadata.isFromCache) {
        allUsers = snapshot.docs.map((d) => Users.fromDocument(d)).toList();
        allUsers.sort((a, b) => a.userName!.toLowerCase().compareTo(b.userName!.toLowerCase()));
        filterList(allUsers);
        notifyListeners();
      }
    });

    // Listen to the stream for real-time updates and update the UI when necessary
    _subscription = firestore.collection("users").snapshots().listen((snapshot) {
      allUsers = snapshot.docs.map((d) => Users.fromDocument(d)).toList();
      allUsers.sort((a, b) => a.userName!.toLowerCase().compareTo(b.userName!.toLowerCase()));
      filterList(allUsers);
      notifyListeners();
    });

    PerformanceMonitoring().stopTrace('listen-users');
  }

  List<Users> getFilteredUsers() {
    if (!kReleaseMode) {
      MonitoringLogger().logInfo('getFilteredUsers');
    }

    List<Users> filteredUsers = [];

    if (search.isEmpty) {
      userFilteredSendEmail = false;
      filteredUsers.addAll(allUsers);
    } else {
      userFilteredSendEmail = true;
      filteredUsers.addAll(allUsers.where(
          (u) => u.userName!.toString().toLowerCase().contains(search.toString().toLowerCase())));
    }

    filterList(filteredUsers);
    return filteredUsers;
  }

  Future<void> _favoringUser(String? id) async {
    await firestore.collection("users").doc(id).update({
      "favourite": true,
    });
  }

  Future<void> _disfavoringUser(String? id) async {
    await firestore.collection("users").doc(id).update({
      "favourite": false,
    });
  }

  void filterList(List<Users> allOrFiltered) {
    final List<Users> users = [];
    users.addAll(allOrFiltered);
    favouriteList = [];
    normalList = [];

    for (var user in users) {
      if (user.favourite == true) {
        favouriteList.add(
          Slidable(
            startActionPane: ActionPane(
              motion: const DrawerMotion(),
              extentRatio: 0.30,
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
              extentRatio: 0.50,
              children: [
                SlidableAction(
                  label: 'Enviar',
                  backgroundColor: Colors.cyanAccent,
                  icon: Icons.email,
                  onPressed: (context) {
                    CommunicationsUtils(parameterClass1Of2: user)
                        .sendEmail(user.email, user.userName, emails);
                  },
                ),
                SlidableAction(
                  label: 'Ligar',
                  backgroundColor: Colors.greenAccent,
                  icon: Icons.phone,
                  onPressed: (context) {
                    CommunicationsUtils(parameterClass1Of2: user)
                        .openPhone(context, user.phoneNumber ?? '');
                    CommunicationsUtils(parameterClass1Of2: user)
                        .alertForCall(context, 'Número telefônico indisponível!');
                  },
                ),
              ],
            ),
            child: Consumer2<AdminOrdersManager, PageManager>(
              builder: (_, adminOrdersManager, pageManager, __) {
                return ListTile(
                  leading: Stack(
                    children: <Widget>[
                      user.userPhotoURL == "" || user.userPhotoURL == null
                          ? const CircleAvatar(
                              backgroundImage: AssetImage('assets/images/userWithoutImage.png'))
                          : CircleAvatar(
                              backgroundImage: NetworkImage(user.userPhotoURL!),
                            ),
                      const SizedBox(
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
                      style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.black)),
                  subtitle: Text(
                    "${user.email}\nTel.: ${user.phoneNumber ?? ""}",
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  onTap: () {
                    adminOrdersManager.setUserFilter(user);
                    pageManager.setPage(7);
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
              extentRatio: 0.30,
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
              extentRatio: 0.50,
              children: [
                SlidableAction(
                    label: 'Enviar',
                    backgroundColor: Colors.cyanAccent,
                    icon: Icons.email,
                    autoClose: true,
                    onPressed: (context) => userFilteredSendEmail == true
                        ? CommunicationsUtils(parameterClass1Of2: user)
                            .sendEmail(user.email, user.userName, emails)
                        : showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Enviar E-mail:'),
                                titleTextStyle: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                                content: const Text('Escolha para quem deseja enviar o E-mail!'),
                                alignment: Alignment.topCenter,
                                contentTextStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                                actions: [
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    children: [
                                      CustomTextButton(
                                        text: 'Contato Selecionado',
                                        fontSize: 13,
                                        icon: null,
                                        onPressed: () {
                                          CommunicationsUtils(parameterClass1Of2: user)
                                              .sendEmail(user.email, user.userName, emails);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      CustomTextButton(
                                        text: 'Todos os contatos!',
                                        fontSize: 13,
                                        icon: null,
                                        onPressed: () {
                                          CommunicationsUtils(parameterClass1Of2: user)
                                              .sendEmail(null, null, emails);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      CustomTextButton(
                                          text: 'Cancelar Envio',
                                          fontSize: 13,
                                          icon: null,
                                          fontColor: Colors.red,
                                          onPressed: () => Navigator.of(context).pop()),
                                    ],
                                  ),
                                ],
                              );
                            })),
                SlidableAction(
                    label: 'Ligar',
                    backgroundColor: Colors.greenAccent,
                    icon: Icons.phone,
                    onPressed: (context) {
                      CommunicationsUtils(parameterClass1Of2: user)
                          .openPhone(context, user.phoneNumber ?? '');
                      CommunicationsUtils(parameterClass1Of2: user)
                          .alertForCall(context, 'Erro ao tentar abrir o telefone!');
                    }),
              ],
            ),
            child: Consumer2<AdminOrdersManager, PageManager>(
                builder: (_, adminOrdersManager, pageManager, __) {
              return ListTile(
                leading: user.userPhotoURL == "" || user.userPhotoURL == null
                    ? const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/userWithoutImage.png'))
                    : CircleAvatar(backgroundImage: NetworkImage(user.userPhotoURL!)),
                title: Text(user.userName!,
                    style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.white)),
                subtitle: Text(
                  "${user.email}\nTel.: ${user.phoneNumber ?? ""}",
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

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
