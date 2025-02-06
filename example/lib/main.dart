import 'package:torn_ticket/torn_ticket.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Torn Ticket Example',
      home: TicketExampleScreen(),
    );
  }
}

class TicketExampleScreen extends StatelessWidget {
  const TicketExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: const Text(
          'TORN TICKET EXAMPLES',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header('Grid Example'),
              const SizedBox(height: 10),
              _buildGridExample(),
              const SizedBox(height: 20),
              _header('List Example'),
              const SizedBox(height: 10),
              _buildListExample(),
              _header('Single Ticket Example'),
              const SizedBox(height: 10),
              _buildSingleTicketExample(),
              const TornTicket(
                child: Center(
                  child: Text('Ticket #1'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text _header(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildGridExample() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: 4,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return TornTicket(
          elevation: 5,
          shadowColor: Colors.black,
          shadowOffset: const Offset(0, 0.8),
          margin: EdgeInsets.zero,
          child: Center(child: Text('Coupon #${index + 1}')),
        );
      },
    );
  }

  Widget _buildListExample() {
    return ListView.builder(
      itemCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TornTicket(
            borderRadius: 15.0,
            cutoutRadius: 10.0,
            cutoutHeight: 15.0,
            cutoutPosition: 0.4,
            bottomEndSpacing: 5.0,
            bottomArcSpacing: 10.0,
            elevation: 5.0,
            shadowColor: Colors.black,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(child: Text('Ticket #${index + 1}')),
          ),
        );
      },
    );
  }

  Widget _buildSingleTicketExample() {
    return const Center(
      child: TornTicket(
        borderRadius: 15.0,
        cutoutRadius: 10.0,
        cutoutHeight: 15.0,
        cutoutPosition: 0.4,
        bottomEndSpacing: 5.0,
        bottomArcSpacing: 10.0,
        elevation: 5.0,
        hasShadow: true,
        shadowColor: Colors.black,
        margin: EdgeInsets.symmetric(horizontal: 10),
        shadowOffset: Offset(5, 2),
        child: Center(
          child: Text('Ticket #1'),
        ),
      ),
    );
  }
}
