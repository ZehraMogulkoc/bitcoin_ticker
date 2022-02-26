import 'package:flutter/material.dart';
import 'coin_data.dart';

String selectedCurrency = 'USD';
Map<String, String> coinValue = {};
bool isWaiting = false;
class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {


  void getData( ) async {
    isWaiting = true;
    CoinData coinData = await new CoinData();

    try {
      var data = await coinData.getCoinData(selectedCurrency);
      isWaiting = false;
      setState(()   {
        coinValue = data ;
      });



    } catch (e) {
      print(e);
    }
  }

  DropdownButton<String> getDropdownItems() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
        value: selectedCurrency, items: dropdownItems, onChanged: (value){
          setState(() {
            selectedCurrency=value;
            getData();
          });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    getDropdownItems();
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/blokchain.jpg"),
          fit: BoxFit.cover,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: CardWidget(),
            ),
            Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.black38,
              child:getDropdownItems()
            ),
          ],
        ),
      ),
    );
  }
}

Widget CardWidget(){
  List<CryptoCard> cryptoCards = [];
  for(String  each in cryptoList){
   cryptoCards.add(CryptoCard(
     cryptoCurrency: each,
     selectedCurrency: selectedCurrency,
     value:  isWaiting ?'?':coinValue[each],
   ));
  }
  return  Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
    children: cryptoCards,
    );
}

class CryptoCard extends StatelessWidget {
  //2: You'll need to able to pass the selectedCurrency, value and cryptoCurrency to the constructor of this CryptoCard Widget.
  const CryptoCard({
    this.value,
    this.selectedCurrency,
    this.cryptoCurrency,
  });

  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.amber,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}