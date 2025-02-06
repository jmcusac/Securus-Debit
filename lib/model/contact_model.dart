class Contact {
  final String name;
  final String facility;
  final String depositStatus;
  
  Contact({
    required this.name, 
    required this.facility,
    this.depositStatus = 'MAKE DEPOSIT'
  });
}