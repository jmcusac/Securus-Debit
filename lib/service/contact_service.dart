class ContactService {
  List<Contact> _contacts = [];

  Future<List<Contact>> getContacts() async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 500));
    return _contacts;
  }

  Future<void> addContact(Contact contact) async {
    await Future.delayed(Duration(milliseconds: 500));
    _contacts.add(contact);
  }

  Future<void> removeContact(Contact contact) async {
    await Future.delayed(Duration(milliseconds: 500));
    _contacts.remove(contact);
  }
}
