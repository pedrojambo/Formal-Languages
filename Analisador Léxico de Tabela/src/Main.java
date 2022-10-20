import java.util.Scanner;
import java.util.ArrayList;
import java.util.Stack;

public class Main {
    static int index;
    static int ERRO=-1;
    static int estado;
    static String lexema;
    static Stack<Integer> pilha = new Stack<>();

    public static char leChar(String str, int index){
        return str.charAt(index);
    }

    public static String truncaUltimo(String str){
        return str.substring(0,str.length()-1);
    }

    public static void reconhecerPalavras(String palavra, AFD afd){
        estado = 1;
        index = 0;
        lexema = "";
        pilha.clear();
        while(index != (palavra.length()) && estado!=ERRO){//para representar estado erro, usaremos o valor negativo -1
            char c = leChar(palavra,index);
            lexema = lexema + c;
            if(afd.estadoFinal.contains(estado)){
                pilha.clear();
            }
            pilha.push(estado);
            estado = afd.trans(estado, c);
            index++;
        }
    }

    public static void limparEstadoFinal(AFD afd){
        while(!(afd.estadoFinal.contains(estado)) && !pilha.empty()){
            estado = pilha.pop();
            lexema = truncaUltimo(lexema);
            index--;
        }
    }

    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        System.out.printf("\nDigite o exemplo desejado (1 ou 2): \n");
        int exemplo = scan.nextLine().charAt(0) - '0';
        AFD afd = new AFD(exemplo);
        afd.mostrarTabela();
        System.out.printf("\nDigite a palavra desejada: \n");
        String palavra = scan.nextLine();
        reconhecerPalavras(palavra, afd);
        limparEstadoFinal(afd);
        if (afd.estadoFinal.contains(estado)){
            System.out.printf("\nPalavra encontrada: \n");
            System.out.printf(lexema);
        }
        return;
    }
}
