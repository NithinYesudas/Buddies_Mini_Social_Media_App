import 'package:flutter/material.dart';
class StoryDisplayScreen extends StatelessWidget {
  const StoryDisplayScreen({required this.imageUrl,required this.name,Key? key}) : super(key: key);
final String imageUrl,name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name),),
      body: SizedBox(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,
      child: Image.network(imageUrl,fit: BoxFit.cover,),),
    );
  }
}
