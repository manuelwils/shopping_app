import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/dummy_products.dart';

import '../models/Product.dart';
import '../providers/ProductProvider.dart';
import '../widgets/components/SnackBar.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = '/edit-product';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  Product newProduct = Product(
      id: DateTime.now().toString(), title: '', amount: 0, image: '', desc: '');

  final _form = GlobalKey<FormState>();

  final _titleFocus = FocusNode();
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  final TextEditingController _imageController = TextEditingController();

  @override
  void dispose() {
    _titleFocus.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();

    _imageController.dispose();

    super.dispose();
  }

  bool isValid = false;

  void _submitForm() {
    isValid = _form.currentState!.validate();

    if (!isValid) return;
    _form.currentState!.save();

    dummyProducts.add(newProduct);

    _form.currentState!.reset();
    _imageController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                  textInputAction: TextInputAction.next,
                  focusNode: _titleFocus,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_priceFocus);
                  },
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Title must be at least 5 characters long';
                    }
                    return null;
                  },
                  onSaved: (value) => newProduct = Product(
                    id: newProduct.id,
                    title: value,
                    amount: newProduct.amount,
                    image: newProduct.image,
                    desc: newProduct.desc,
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Price'),
                  ),
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocus,
                  validator: (value) {
                    if (!RegExp(r'[0-9]+').hasMatch(value!)) {
                      return 'Price must be greater than 0';
                    }
                    return null;
                  },
                  onSaved: (value) => newProduct = Product(
                    id: newProduct.id,
                    title: newProduct.title,
                    amount: double.parse(value!),
                    image: newProduct.image,
                    desc: newProduct.desc,
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Description'),
                  ),
                  maxLength: 200,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 10) {
                      return 'description must be at least 10 characters long';
                    }
                    return null;
                  },
                  onSaved: (value) => newProduct = Product(
                    id: newProduct.id,
                    title: newProduct.title,
                    amount: newProduct.amount,
                    image: newProduct.image,
                    desc: value,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        image: DecorationImage(
                          image: NetworkImage(_imageController.text),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text('Image URL'),
                          ),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imageController,
                          onChanged: (value) => setState(() {}),
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'(.+)\.(.+)\/(.+)').hasMatch(value)) {
                              return 'Image source must be a valid URL';
                            }
                            return null;
                          },
                          onSaved: (value) => newProduct = Product(
                            id: newProduct.id,
                            title: newProduct.title,
                            amount: newProduct.amount,
                            image: value,
                            desc: newProduct.desc,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _submitForm();
                      isValid
                          ? showSnackBar(
                              context,
                              'Added To Products!',
                              'UNDO',
                              () {
                                Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .deleteProduct(newProduct.id!);
                              },
                            )
                          : '';
                    },
                    child: const Text('Submit'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}