import 'package:flutter/foundation.dart';
import '../model/contact_model.dart';
import '../service/contact_service.dart';

class ContactProvider extends ChangeNotifier {
  final ContactService _service = ContactService();
  List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  Future<void> addContact(Contact contact) async {
    await _service.addContact(contact);
    _contacts.add(contact);
    notifyListeners();
  }

  Future<void> removeContact(int index) async {
    if (index >= 0 && index < _contacts.length) {
      final contact = _contacts[index];
      await _service.removeContact(contact);
      _contacts.removeAt(index);
      notifyListeners();
    }
  }
}
