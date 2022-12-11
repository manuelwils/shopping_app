import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/ProductProvider.dart';
import '../../Screens/Products/EditProductScreen.dart';
import '../Components/SnackBar.dart';
import '../Components/DeleteDialog.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String image;
  final String title;

  const UserProductItem(this.id, this.title, this.image);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context);
    final BuildContext _ctx = context;
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
                  onPressed: () => Navigator.of(context)
                      .pushNamed(EditProductScreen.routeName, arguments: id),
                  icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
                ),
                IconButton(
                  onPressed: () async {
                    return showDeleteDialog(context).then((value) async {
                      if (value == true) {
                        await productsData.deleteProduct(id).catchError(
                              (exception) => showSnackBar(
                                  _ctx, exception.toString(), '', () {}),
                            );
                      }
                    });
                  },
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
