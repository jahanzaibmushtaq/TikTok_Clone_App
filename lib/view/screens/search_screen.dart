import 'package:flutter/material.dart';
import 'package:tiktok_yt/model/user.dart';
import 'package:tiktok_yt/view/screens/profile_screen.dart';
import 'package:get/get.dart';
import 'package:tiktok_yt/controller/searchUser_controller.dart' as MyController;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchQuery = TextEditingController();

  final searchController = Get.put(MyController.SearchController());

  @override
  void initState() {
    super.initState();
    searchController.searchUser('');
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: TextFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              hintText: "Search Username",
            ),
            controller: searchQuery,
            onFieldSubmitted: (value) {
              searchController.searchUser(value);
            },
          ),
        ),
        body: searchController.searchedUsers.isEmpty
            ? const Center(
          child: Text("Search Users!"),
        )
            : ListView.builder(
          itemCount: searchController.searchedUsers.length,
          itemBuilder: (context, index) {
            myUser user = searchController.searchedUsers[index];

            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(uid: user.uid),
                  ),
                );
              },
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.profilePhoto),
              ),
              title: Text(user.name),
            );
          },
        ),
      );
    });
  }
}
