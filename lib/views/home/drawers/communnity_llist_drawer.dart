import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit_clone/views/community/controller/community_controller.dart';
import 'package:routemaster/routemaster.dart';

class CommunnityLlistDrawer extends ConsumerWidget {
  const CommunnityLlistDrawer({super.key});
  void navigateToCreateCommunity(BuildContext context) {
    Navigator.pop(context);
    Routemaster.of(context).push('/create-community');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
          child: Column(
        children: [
          ListTile(
            title: const Text('Create Community'),
            leading: const Icon(Icons.add),
            onTap: () {
              navigateToCreateCommunity(context);
            },
          ),
          ref.watch(userCommunitiesProvider).when(
              data: (communities) {
                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: communities.length,
                      itemBuilder: (context, int index) {
                        return ListTile(
                          title: Text(communities[index].name),
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(communities[index].avatar),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Routemaster.of(context)
                                .push('/community/${communities[index].id}');
                          },
                        );
                      }),
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (error, _) => Text('Error: ${error.toString()}'))
        ],
      )),
    );
  }
}
