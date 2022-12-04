import 'package:flutter/material.dart';

class ManageProductItem extends StatelessWidget {
  final String id;
  final String image;
  final String title;

  const ManageProductItem(this.id, this.title, this.image);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(image),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: Theme.of(context).errorColor),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
