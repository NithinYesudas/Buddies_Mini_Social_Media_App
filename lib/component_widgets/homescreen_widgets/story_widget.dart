import 'dart:io';

import 'package:buddies/screens/story_display_screen.dart';
import 'package:buddies/services/story_services.dart';
import 'package:buddies/utils/custom_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../provider/story_provider.dart';

class StoryWidget extends StatefulWidget {
  const StoryWidget({Key? key}) : super(key: key);

  @override
  State<StoryWidget> createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<StoryProvider>(context,listen: false).fetchStories();
    Provider.of<StoryProvider>(context,listen: false).getMyyStory();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return SizedBox(
        height: mediaQuery.height * .14,
        child: Consumer<StoryProvider>(
          builder: (context, storyProvider, child) {
            return ListView.builder(
                padding: const EdgeInsets.all(5),
                scrollDirection: Axis.horizontal,
                itemCount: storyProvider.getStories.length + 1,
                itemBuilder: (ctx, index) {
                  if (index == 0) {
                    return storyProvider.myStory == null
                        ? SizedBox(
                            height: 80,
                            width: 80,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        XFile? image = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery);
                                        if (image != null) {
                                          StoryServices.uploadStory(
                                              File(image.path));
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              CustomColors.lightAccent,
                                          shape: CircleBorder()),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      )),
                                ),
                                const Text("Add story")
                              ],
                            ),
                          )
                        : Container(
                      height: 90,
                          width: 90,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (ctx) => StoryDisplayScreen(
                                            imageUrl: storyProvider.myStory!.imageUrl,
                                            name: "You")));
                                  },
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: CustomColors.lightAccent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: CircleAvatar(
                                        radius: 37,
                                        backgroundColor: Colors.white,

                                        backgroundImage:
                                            NetworkImage(storyProvider.myStory!.imageUrl),
                                      ),
                                    ),
                                  ),
                                ),
                               Text("You"),

                            ],
                          ),
                        );
                  }
                  final story = storyProvider.getStories[index - 1];
                  return FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection("users")
                          .doc(story.userId)
                          .get(),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        }
                        final userData = snapshot.data!.data();
                        return Container(
                          height: 90,
                          width: 90,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => StoryDisplayScreen(
                                          imageUrl: story.imageUrl,
                                          name: userData["name"])));
                                },
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: CustomColors.lightAccent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 37,
                                      backgroundImage:
                                          NetworkImage(userData!["imageUrl"]),

                                    ),
                                  ),
                                ),
                              ),
                              Text(userData["name"])
                            ],
                          ),
                        );
                      });
                });
          },
        ));
  }
}
