import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecurusDebitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ContactProvider(),
      child: SecurusDebitView(),
    );
  }
}

class SecurusDebitView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Securus Debit'),
        actions: [
          IconButton(
            icon: Icon(Icons.chat_bubble_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.white,
            child: Text(
              'Contacts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          ExpansionTile(
            title: Text('Securus Debit Details:'),
            children: [_buildDetailsSection()],
          ),
          Expanded(
            child: Consumer<ContactProvider>(
              builder: (context, provider, child) {
                if (provider.contacts.isEmpty) {
                  return Center(
                    child: Text(
                      'Click (+) to add a contact to make a deposit\nto their Securus Debit account.',
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: provider.contacts.length,
                  itemBuilder: (context, index) {
                    return ContactListItem(
                      contact: provider.contacts[index],
                      index: index,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContactDialog(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildDetailsSection() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'You can make a deposit to your contact\'s Securus '
            'Debit account if allowed by their facility. They can use '
            'funds to pay for Securus services at their location. '
            'The funds become the property of the contact.',
          ),
          SizedBox(height: 16),
          Text(
            'These funds can be used for tablet subscriptions, '
            'tablet games, music and movies*. They can also pay '
            'for phone calls, Video Connect sessions and messaging.',
          ),
          SizedBox(height: 16),
          Text('Please note that this is NOT a Commissary Account.'),
          SizedBox(height: 8),
          Text('* If available at their facility'),
        ],
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddContactDialog(),
    );
  }
}

class AddContactDialog extends StatefulWidget {
  @override
  _AddContactDialogState createState() => _AddContactDialogState();
}

class _AddContactDialogState extends State<AddContactDialog> {
  final _nameController = TextEditingController();
  final _facilityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Contact'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _facilityController,
            decoration: InputDecoration(labelText: 'Facility'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final provider = context.read<ContactProvider>();
            provider.addContact(
              Contact(
                name: _nameController.text,
                facility: _facilityController.text,
              ),
            );
            Navigator.pop(context);
          },
          child: Text('Add'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _facilityController.dispose();
    super.dispose();
  }
}

class ContactListItem extends StatelessWidget {
  final Contact contact;
  final int index;

  const ContactListItem({
    required this.contact,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact:',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        contact.name,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        contact.facility,
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    if (value == 'remove') {
                      context.read<ContactProvider>().removeContact(index);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text('Make Deposit'),
                      value: 'deposit',
                    ),
                    PopupMenuItem(
                      child: Text('Transaction Summary'),
                      value: 'summary',
                    ),
                    PopupMenuItem(
                      child: Text('Remove Contact'),
                      value: 'remove',
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deposit:',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      contact.depositStatus,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}