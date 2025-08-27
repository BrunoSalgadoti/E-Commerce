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
  final List<Users> _favouriteUsers = [];
  final List<Users> _normalUsers = [];
  List<Users> allUsers = [];

  String _search = '';

  List<String> get allEmails => allUsers.map((e) => e.email).toList();

  /// Exhibition of MODELS
  List<Users> get favouriteUsers => List.unmodifiable(_favouriteUsers);
  List<Users> get normalUsers => List.unmodifiable(_normalUsers);

  /// Widgets Exhibition
  List<Widget> get favouriteList => _favouriteUsers.map((u) => _buildUserTile(u)).toList();
  List<Widget> get normalList => _normalUsers.map((u) => _buildUserTile(u)).toList();

  String get search => _search;
  set search(String value) {
    _search = value;
    setUsers(allUsers); // reaplica filtro
    notifyListeners();
  }

  /// AUpdates all users and populates the lists
  void setUsers(List<Users> users) {
    allUsers = users;
    final current = _search.trim().isEmpty
        ? users
        : users
            .where((u) => (u.userName ?? '').toLowerCase().contains(_search.toLowerCase()))
            .toList();
    filterList(current);
  }

  /// Create favorite and normal lists
  void filterList(List<Users> users) {
    _favouriteUsers
      ..clear()
      ..addAll(users.where((u) => u.favourite == true));
    _normalUsers
      ..clear()
      ..addAll(users.where((u) => u.favourite != true));

    email
      ..clear()
      ..addAll(users.map((e) => e.email));

    notifyListeners();
  }

  /// Build dinâmico do Tile
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
                color: isFav ? getEspecialColor() : getTextColor(),
              ),
            ),
            subtitle: Text(
              "${user.email}\nTel.: ${user.phoneNumber ?? ""}",
              style: TextStyle(
                fontSize: 16,
                color: isFav ? getEspecialColor() : getTextColor(),
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

  /// Email sending dialog
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
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Sim'),
          ),
          TextButton(
            onPressed: () {
              CommunicationsUtils(parameterClass1Of2: user)
                  .sendEmail(user.email, user.userName, email);
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Não'),
          ),
        ],
      ),
    );
  }

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
      setUsers(allUsers);
    }
  }

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
      setUsers(allUsers);
    }
  }
}
