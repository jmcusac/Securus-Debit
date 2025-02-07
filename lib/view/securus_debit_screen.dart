import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/contact_model.dart';
import '../view_model/contact_view_model.dart';
import '../service/contact_service.dart';

class SecurusDebitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContactViewModel>(
      create: (_) => ContactViewModel(ContactService()),
      child: SecurusDebitView(),
    );
  }
}

class SecurusDebitView extends StatefulWidget {
  @override
  _SecurusDebitViewState createState() => _SecurusDebitViewState();
}

class _SecurusDebitViewState extends State<SecurusDebitView> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Color(0xFF4267B2),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Securus Debit'),
        actions: [
          IconButton(
            icon: Icon(Icons.chat_bubble_outline),
            onPressed: null, // Disabled as per requirements
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            color: Colors.white,
            child: Center(
              child: Text(
                'Contacts',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(16),
            elevation: 1,
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'Securus Debit Details:',
                    style: TextStyle(color: Colors.black87),
                  ),
                  trailing: Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.blue,
                  ),
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                ),
                if (isExpanded) _buildDetailsSection(),
              ],
            ),
          ),
          Expanded(
            child: Consumer<ContactViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.error != null) {
                  return Center(child: Text(viewModel.error!));
                }

                // Always check for empty contacts list, even during loading
                if (viewModel.contacts.isEmpty &&
                    viewModel.state != ViewState.loading) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Click (+) to add a contact to make a deposit\nto their Securus Debit account.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                }

                return Stack(
                  children: [
                    // Contact list
                    ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: viewModel.contacts.length,
                      itemBuilder: (context, index) {
                        return ContactListItem(
                          contact: viewModel.contacts[index],
                          index: index,
                        );
                      },
                    ),
                    // Loading indicator overlaid when loading
                    if (viewModel.state == ViewState.loading)
                      Container(
                        color: Colors.white.withOpacity(0.7),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContactDialog(context),
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Color(0xFF4267B2),
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
            style: TextStyle(color: Colors.grey[700]),
          ),
          SizedBox(height: 16),
          Text(
            'These funds can be used for tablet subscriptions, '
            'tablet games, music and movies*. They can also pay '
            'for phone calls, Video Connect sessions and messaging.',
            style: TextStyle(color: Colors.grey[700]),
          ),
          SizedBox(height: 16),
          Text(
            'Please note that this is NOT a Commissary Account.',
            style: TextStyle(color: Colors.grey[700]),
          ),
          SizedBox(height: 8),
          Text(
            '* If available at their facility',
            style: TextStyle(color: Colors.grey[700], fontSize: 12),
          ),
          SizedBox(height: 16),
          Consumer<ContactViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: () => _showAddContactDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4267B2),
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text('Add Contact'),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: null, // Disabled functionality
                    style: ElevatedButton.styleFrom(
                      backgroundColor: viewModel.contacts.isEmpty
                          ? Colors.grey
                          : Color(0xFF4267B2),
                      minimumSize: Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text('Transaction Summary'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => ChangeNotifierProvider.value(
        value: context.read<ContactViewModel>(),
        child: AddContactDialog(),
      ),
    );
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
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact:',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        contact.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        contact.facility,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  icon: Icon(Icons.more_vert, color: Colors.grey[600]),
                  onSelected: (value) async {
                    if (value == 'remove') {
                      try {
                        await context
                            .read<ContactViewModel>()
                            .removeContact(index);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Failed to remove contact: ${e.toString()}')),
                        );
                      }
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'deposit',
                      child: Text('Make Deposit'),
                    ),
                    PopupMenuItem(
                      enabled: false, // Disabled as per requirements
                      value: 'summary',
                      child: Text(
                        'Transaction Summary',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'remove',
                      child: Text('Remove Contact'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deposit:',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      contact.depositStatus,
                      style: TextStyle(
                        color: Color(0xFF4267B2),
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
          onPressed: () async {
            if (_nameController.text.isEmpty ||
                _facilityController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please fill in all fields')),
              );
              return;
            }

            try {
              final viewModel = context.read<ContactViewModel>();
              final contact = Contact(
                name: _nameController.text,
                facility: _facilityController.text,
              );

              Navigator.pop(context); // Close dialog before adding contact
              await viewModel.addContact(contact);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Failed to add contact: ${e.toString()}')),
              );
            }
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
