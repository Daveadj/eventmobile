
class TicketOption {
  final String name;
  final double price;

  TicketOption(this.name, this.price);
}

List<TicketOption> ticketOptions = [
  TicketOption("General Admission", 20.0),
  TicketOption("VIP", 50.0),
  TicketOption("Student", 15.0),
  // Add more options as needed
];