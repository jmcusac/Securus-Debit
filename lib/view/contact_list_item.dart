import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:securus_debit/constants/securus_branding.dart';
import 'package:securus_debit/model/contact_model.dart';
import 'package:securus_debit/view_model/contact_view_model.dart';

class ContactListItem extends StatelessWidget {
  final Contact contact;
  final int index;

  const ContactListItem({
    Key? key,
    required this.contact,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Contact Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact:',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 32),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.name.toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        contact.facility,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 28),
            // Deposit Row
            Row(
              children: [
                Text(
                  'Deposit:',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 32),
                Text(
                  contact.depositStatus,
                  style: TextStyle(
                    color: SecurusColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            SizedBox(height: 28),
            // Action Row
            Row(
              children: [
                Text(
                  'Action:',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 32),
                PopupMenuButton(
                  padding: EdgeInsets.zero,
                  icon:
                      Icon(Icons.more_vert, color: Colors.grey[600], size: 20),
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
                      enabled: false,
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
          ],
        ),
      ),
    );
  }
}
