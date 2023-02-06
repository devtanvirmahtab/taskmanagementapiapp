
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key, required this.title, required this.description, required this.status, required this.editTap, required this.favTap,
  }) : super(key: key);

  final String title,description,status;
  final VoidCallback editTap,favTap;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 7),
      decoration: BoxDecoration(
          color:Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title ?? "",style: Theme.of(context).textTheme.headline1),
                IconButton(onPressed: favTap, icon:const Icon(Icons.favorite_outline_outlined),color: Theme.of(context).primaryColor),
              ],
            ),
            Text(description ?? "",style: Theme.of(context).textTheme.subtitle1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(status ?? ""),
                ),
                IconButton(onPressed: editTap, icon: const Icon(Icons.edit_outlined,color: appPrimaryColor))
              ],
            )
          ],
        ),
      ),
    );
  }
}