import 'package:app_duelo/models/yugioh_card.dart';
import 'package:flutter/material.dart';

class CardDetailsPage extends StatelessWidget {
  final YugiohCard card;

  const CardDetailsPage({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(card.name),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  card.imageUrl,
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16,),
        
              Text(
                card.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8,),
              _buildEdisonStatus(card),
        
              const SizedBox(height: 16,),
              Text(
                "Tipo: ${card.race ?? '-'}", 
                style: TextStyle(
                      fontSize: 18,
                      // fontWeight: FontWeight.bold
                    ),
              ),
              const SizedBox(height: 8,),
              Text(
                'ATK: ${card.atk?.toString() ?? '-'}/${card.def?.toString() ?? '-'}', 
                style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
              ),
              const SizedBox(height: 16,),
        
              Text(card.desc,
                style: Theme.of(context).textTheme.bodyMedium
              ),
        
              const SizedBox(height: 8,),
        
              _buildLimitInfo(card),


              const SizedBox(height: 12,),
        
              Center(
                
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  }, 
                  style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 82, 198, 98),
                  foregroundColor: Colors.white,

                  minimumSize: const Size(220, 55),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),

                  elevation: 6,
                ),

                  child: Text(
                    "Voltar",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  )
                )
              )
        
            ],
          ),
        ),
      ),
    );
    
  }
  Widget _buildEdisonStatus(YugiohCard card){
    if (!card.isEdison) {
      return const Text(
        '❌ Não é Edison',
        style: TextStyle(color: Colors.red),
      );
    }
    return const Text(
      '✅ Edison',
      style: TextStyle(color: Colors.green),
    );
  }

  Widget _buildLimitInfo(YugiohCard card){
    final limit = card.tcgLimit;

    String text;
    switch (limit) {
      case 0:
        text = '(0)';
        break;
      case 1:
        text = "(1)";
        break;
      case 2:
        text ="(2)";
        break;
      default:
        text = "(3)";

    }
    return Text(
      "Limite por deck: $text",
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}