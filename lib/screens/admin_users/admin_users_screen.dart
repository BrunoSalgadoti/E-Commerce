import 'package:alphabet_list_scroll_view_fix/alphabet_list_scroll_view.dart';
import 'package:ecommerce/models/admin_users_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
        centerTitle: true,
      ),
      body: Consumer<AdminUsersManager>(
        builder: (_, adminUsersManager, __) {
          return AlphabetListScrollView(
            itemBuilder: (_, index) {
              return Slidable(
                  key: const ValueKey(0),
                  startActionPane:  const ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        flex: 2,
                        onPressed: doNothing,
                        backgroundColor: Color(0xFF6FFE47),
                        foregroundColor: Colors.white,
                        icon: Icons.mode_comment_sharp,
                        label: 'Env.',
                      ),
                      SlidableAction(
                        flex: 2,
                        onPressed: doNothing,
                        backgroundColor: Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.share,
                        label: 'Com.',
                      ),
                      SlidableAction(
                        flex: 2,
                        onPressed: doNothing,
                        backgroundColor: Color(0xFFE704FF),
                        foregroundColor: Colors.white,
                        icon: Icons.save,
                        label: 'Sal.',
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Stack(
                      children: <Widget>[
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://placeimg.com/200/200/people"
                          ),
                        ),
                        Container(
                            height: 40,
                            width: 40,
                            child: Center(
                              child: Icon(
                                Icons.star,
                                color: Colors.yellow[100],
                              ),
                            ))
                      ],
                    ),
                    title: Text(
                        adminUsersManager.users[index].userName!
                    ),
                    subtitle: Text(
                        adminUsersManager.users[index].email
                    ),
                  ));
            },
            indexedHeight: (index) => 80.0,
            strList: adminUsersManager.names,
            showPreview: true,
          );
        },
      ),
    );
  }
}

//TODO: Funções SlidableAction
void doNothing(BuildContext context) {}
