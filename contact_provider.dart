import 'package:flutter/foundation.dart';

class ContactProvider extends ChangeNotifier {
  List<Contact> _contacts = [];
  List<Contact> get contacts => _contacts;

  void addContact(Contact contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  void removeContact(int index) {
    _contacts.removeAt(index);
    notifyListeners();
  }
}