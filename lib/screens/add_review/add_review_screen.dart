import 'package:flutter/material.dart';
import 'package:restaurant_app/data/http/api_service.dart';
import 'package:restaurant_app/data/models/restaurant_detail.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key, required this.restaurant});

  final RestaurantDetail restaurant;

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  final _reviewInputController = TextEditingController();
  final _nameInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'From ${widget.restaurant.name}: We hopefully fulfill your expectation with our foods, beverages and our service.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Name'),
                      controller: _nameInputController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter your name';
                        }

                        if (value.length <= 3) {
                          return 'minimum 3 characters';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Review'),
                      controller: _reviewInputController,
                      minLines: 5,
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter some text';
                        }

                        if (value.length <= 3) {
                          return 'minimum 3 characters';
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      width: .infinity,
                      child: FilledButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final payload = {
                              "id": widget.restaurant.id,
                              "name": _nameInputController.text,
                              "review": _reviewInputController.text,
                            };
                            final response = await ApiService().addReview(
                              payload,
                            );

                            if (!response.error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('success')),
                              );
                            }
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
