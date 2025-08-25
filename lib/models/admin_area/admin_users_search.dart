import 'dart:async';

import 'package:brn_ecommerce/common/drawer/components/page_manager.dart';
import 'package:brn_ecommerce/common/images/root_assets.dart';
import 'package:brn_ecommerce/common/miscellaneous/communications_utils.dart';
import 'package:brn_ecommerce/helpers/themes/get_another_colors.dart';
import 'package:brn_ecommerce/models/admin_area/admin_orders_manager.dart';
import 'package:brn_ecommerce/models/users/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminUsersSearch extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final List<String> email = [];
  List<Widget> favouriteList = [];
  List<Widget> normalList = [];
  List<Users> allUsers = [];
  String _search = '';

  List<String> get allEmails => allUsers.map((e) => e.email).toList();

  /// Updates all users and populates the lists (respecting search, if any)
  void setUsers(List<Users> users) {
    allUsers = users;
    final current = _search.trim().isEmpty
        ? users
        : users
            .where((u) => (u.userName ?? '').toLowerCase().contains(_search.toLowerCase()))
            .toList();
    filterList(current);
  }

  String get search => _search;
  set search(String value) {
    _search = value;
    // re-filters using the already loaded list
    setUsers(allUsers);
    notifyListeners();
  }

  /// Create lists (favorites and normal) and prepare the email list
  void filterList(List<Users> users) {
    favouriteList = [];
    normalList = [];
    email.clear();

    for (var user in users) {
      email.add(user.email);

      final tile = _buildUserTile(user);
      if (user.favourite == true) {
        favouriteList.add(tile);
      } else {
        normalList.add(tile);
      }
    }
    notifyListeners();
  }

  /// Dynamically build user widget with Slidable and star overlay
  Widget _buildUserTile(Users user) {
    final isFav = user.favourite == true;

    return Slidable(
      key: ValueKey(user.id),
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.30,
        children: [
          SlidableAction(
            label: isFav ? 'Desfavoritar' : 'Favorito',
            backgroundColor: isFav ? Colors.red : Colors.green,
            icon: Icons.star,
            onPressed: (_) async {
              if (isFav) {
                await _disfavoringUser(user.id);
              } else {
                await _favoringUser(user.id);
              }
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
              onPressed: (context) => _showEmailDialog(context, user)),
          SlidableAction(
            label: kIsWeb ? 'WhatsApp' : 'Ligar',
            backgroundColor: Colors.greenAccent,
            icon: kIsWeb ? FontAwesomeIcons.whatsapp : Icons.phone,
            onPressed: (context) {
              try {
                CommunicationsUtils(parameterClass1Of2: user)
                    .openPhone(context, user.phoneNumber ?? '');
              } catch (user) {
                CommunicationsUtils(parameterClass1Of2: user)
                    .alertForCall(context, 'Erro ao tentar abrir o telefone!');
              }
            },
          ),
        ],
      ),
      child: Consumer2<AdminOrdersManager, PageManager>(
        builder: (_, adminOrdersManager, pageManager, __) {
          return ListTile(
            leading: SizedBox(
              height: 40,
              width: 40,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: (user.userPhotoURL == null || user.userPhotoURL!.isEmpty)
                        ? const CircleAvatar(
                            backgroundImage: AssetImage(RootAssets.iconUserNoImage),
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(user.userPhotoURL!),
                          ),
                  ),
                  if (isFav)
                    const Positioned(
                      right: -4,
                      top: -4,
                      child: Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 25,
                      ),
                    ),
                ],
              ),
            ),
            title: Text(
              user.userName ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: isFav ? Colors.yellow : getTextColor(),
              ),
            ),
            subtitle: Text(
              "${user.email}\nTel.: ${user.phoneNumber ?? ""}",
              style: TextStyle(
                fontSize: 16,
                color: isFav ? Colors.yellow : getTextColor(),
              ),
            ),
            onTap: () {
              adminOrdersManager.setUserFilter(user);
              pageManager.setPage(7);
            },
          );
        },
      ),
    );
  }

  /// Dialog to confirm sending mass email
  void _showEmailDialog(BuildContext context, Users user) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Atenção'),
        content: const Text('Deseja enviar o email para todos os contatos?'),
        actions: [
          TextButton(
            onPressed: () {
              CommunicationsUtils(parameterClass1Of2: user).sendEmail(null, null, allEmails);
              Navigator.of(dialogContext).pop(); // <- uses the context of the dialogue
            },
            child: const Text('Sim'),
          ),
          TextButton(
            onPressed: () {
              CommunicationsUtils(parameterClass1Of2: user)
                  .sendEmail(user.email, user.userName, email);
              Navigator.of(dialogContext).pop(); // <- uses the context of the dialogue
            },
            child: const Text('Não'),
          ),
        ],
      ),
    );
  }

  /// Favorite User — Persists in Firestore and updates locally
  Future<void> _favoringUser(String? userId) async {
    if (userId == null) return;
    try {
      await firestore.collection('users').doc(userId).update({'favourite': true});
    } catch (e) {
      if (kDebugMode) debugPrint('Erro ao favoritar: $e');
    }
    final idx = allUsers.indexWhere((u) => u.id == userId);
    if (idx != -1) {
      allUsers[idx].favourite = true;
      // re-aplica o filtro atual
      setUsers(allUsers);
    }
  }

  /// Unfavorite user — persists in Firestore and updates locally
  Future<void> _disfavoringUser(String? userId) async {
    if (userId == null) return;
    try {
      await firestore.collection('users').doc(userId).update({'favourite': false});
    } catch (e) {
      if (kDebugMode) debugPrint('Erro ao desfavoritar: $e');
    }
    final idx = allUsers.indexWhere((u) => u.id == userId);
    if (idx != -1) {
      allUsers[idx].favourite = false;
      // reapplies the current filter
      setUsers(allUsers);
    }
  }
}
