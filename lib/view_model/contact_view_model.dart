import 'package:flutter/foundation.dart';
import '../model/contact_model.dart';
import '../service/contact_service.dart';

enum ViewState { initial, loading, loaded, error }

class ContactViewModel extends ChangeNotifier {
  final ContactService _contactService;
  ViewState _state = ViewState.initial;
  String? _error;
  List<Contact> _contacts = [];

  ContactViewModel(this._contactService) {
    // Load contacts when ViewModel is initialized
    loadContacts();
  }

  // Getters
  ViewState get state => _state;
  String? get error => _error;
  List<Contact> get contacts => List.unmodifiable(_contacts);
  bool get isLoading => _state == ViewState.loading;

  void _setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  Future<void> loadContacts() async {
    try {
      _setState(ViewState.loading);
      _error = null;

      final contacts = await _contactService.getContacts();
      _contacts = contacts;
      _setState(ViewState.loaded);
    } catch (e) {
      _error = e.toString();
      _setState(ViewState.error);
    }
  }

  Future<void> addContact(Contact contact) async {
    try {
      _setState(ViewState.loading);

      await _contactService.addContact(contact);
      _contacts.add(contact);
      _setState(ViewState.loaded);
    } catch (e) {
      _error = e.toString();
      _setState(ViewState.error);
      rethrow; // Allow UI to handle the error if needed
    }
  }

  Future<void> removeContact(int index) async {
    if (index < 0 || index >= _contacts.length) {
      _error = 'Invalid contact index';
      _setState(ViewState.error);
      return;
    }

    try {
      _setState(ViewState.loading);

      final contact = _contacts[index];
      await _contactService.removeContact(contact);
      _contacts.removeAt(index);
      _setState(ViewState.loaded);
    } catch (e) {
      _error = e.toString();
      _setState(ViewState.error);
      rethrow;
    }
  }

  // Optional: Method to refresh contacts
  Future<void> refresh() => loadContacts();

  @override
  void dispose() {
    _contacts.clear();
    super.dispose();
  }
}
