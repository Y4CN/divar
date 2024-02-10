import 'dart:io';

abstract class AddItemEvent {}

class AddItemRequestAddEvent extends AddItemEvent {
  int categoryId;
  String title;
  String price;
  String description;
  String status;
  List<File> images;

  AddItemRequestAddEvent({
    required this.categoryId,
    required this.title,
    required this.price,
    required this.description,
    required this.status,
    required this.images,
  });
}


class AddItemGetCategoryEvent extends AddItemEvent {}
