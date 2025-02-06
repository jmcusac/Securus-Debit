import 'package:flutter/foundation.dart';
import '../model/contact_model.dart';

class ContactViewModel extends ChangeNotifier {
  final ContactService _contactService;
  bool _isLoading = false;
  String? _error;

  List<Contact> _contacts = [];

  ContactViewModel(this._contactService);

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Contact> get contacts => _contacts;

  Future<void> loadContacts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _contacts = await _contactService.getContacts();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addContact(Contact contact) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _contactService.addContact(contact);
      _contacts.add(contact);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> removeContact(int index) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _contactService.removeContact(_contacts[index]);
      _contacts.removeAt(index);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
