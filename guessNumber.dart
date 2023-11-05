import 'dart:math';
import 'dart:io';

class Guesser{
  int? number;
  int vidas = 10;
  final max = 1000;
  bool victory = false;

  Guesser(){
    var rand = Random();
    this.number = rand.nextInt(max);
  }

  String guess(int valor){
    this.vidas -= 1;
    if (valor <= this.number!){
      return "Valor menor que o buscado!";
    } else{
      return "Valor MAIOR que o buscado!";
    }
  }

  String guessNumber(int valor){
    if (valor == this.number){
      this.victory = true;
      return "Correto!";
    } else{
      this.victory = false;
      return "Incorreto!";
    }
  }

  String guessDivisible(int value){
    this.vidas -= 1;
    if (this.number! % value == 0){
      return "É divisível!";
    } else{
      return "Não é Divisível";
    }
  }

  String guessPrime(int value){
    this.vidas -= 1;
    for (int i = 2; i < value; i++){
      if (value % i == 0) return "Não é primo";
    }
    return "É primo";
  }

  void play(){
    this.presentation();
    while(vidas != 1){
      print("---------------------------------");
      print("Vidas: " + this.vidas.toString());
      print("Faça sua jogada! De 0 à $max");

      String palpite = stdin.readLineSync()!;
      this.guessControl(palpite);

      if (vidas == 1){
        print("É sua última chance, agora você terá que tentar acertar o número!");
        this.lastTurn();
      }
    }
    this.endgame();
  }

  void guessControl(String palpite){
    if (this.isNumber(palpite[0])){
      print(guess(int.parse(palpite)));
    }
    if (palpite[0] == '/'){
      String number = this.getNumber(palpite);
      print(guessDivisible(int.parse(number)));
    }
    if (palpite[0] == '*'){
      print(guessPrime(this.number!));  
    }
  }

  String getNumber(String palpite){
    String result = '';
    for (int i = 1; i < palpite.length; i++){
        result = result + palpite[i];
    }
    return result;
  }

  void lastTurn(){
    print("Hora de chutar o valor: ");
    String resposta = stdin.readLineSync()!;
    print(guessNumber(int.parse(resposta)));
  }

  void endgame(){
    if (this.victory){
      print("Parabéns, você ganhou!!");
    } else{
      print("Infelizmente você não conseguiu descobrir o número :(");
      print("O valor buscado era $number");
    }
  }

  void presentation(){
    print("========================================");
    print("             GUESS NUMBER               ");
    print("========================================");
    print("");
    print("Bem-vindo ao jogo de advinhar o número!");
    print("Será gerado um valor entra 0 e $max, seu objetio é descobrir qual valor foi gerado");
    print("Para isso, você poder:");
    print("     1. Chutar um número (será dito se ele é menor ou maior que o valor buscado)");
    print("     2. Testar se o valor buscado é DIVISÍVEL por algum número. Para isso, insira o valor com uma '/' na frente, como '/2' ");
    print("     3. Teste se o valor é PRIMO digitando um asterisco, como \*");
    print("\n\n");
    }

  bool isNumber(String char){
    if ((char.codeUnitAt(0) > 47) && (char.codeUnitAt(0) < 58)) return true;
    return false;
  }
}

void main(){
  var game = Guesser();
  game.play();
}