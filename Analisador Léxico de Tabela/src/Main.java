import java.util.ArrayList;
import java.util.Stack;

public class Main {
    int index;
    int ERRO=-1;
    int estado;
    String lexema;
    Stack pilha = new Stack();

    public static char leChar(String str, int index){
        return str.charAt(index);
    }

    public void reconhecerPalavras(String palavra, AFD afd){
        estado = 0;
        index = 0;
        lexema = "";
        pilha.clear();
        while(!(afd.estadoFinal.contains(estado)) && estado!=ERRO){//para representar estado erro, usaremos o valor negativo -1
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

    public void limparEstadoFinal(AFD afd){
        while(!(afd.estadoFinal.contains(estado)) && !pilha.empty()){
            pilha.pop();
        }
    }

    public static void main(String[] args) {
        AFD AFD1 = new AFD(1);
        AFD1.mostrarTabela();

    }
}
