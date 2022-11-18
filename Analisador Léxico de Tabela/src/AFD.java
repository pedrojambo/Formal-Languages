import javax.crypto.NullCipher;
import javax.lang.model.type.ErrorType;
import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

public class AFD {
    public ArrayList<Integer> estadoFinal;
    public char[][] tabela;
    int tamAlfabeto;

    public AFD(int afd){        //inicializa uma das duas tabelas selecionadas para teste
        if(afd == 1){           //AFD teste número 1
            estadoFinal = new ArrayList<>();
            estadoFinal.add(3);
            tabela = new char[4][3];
            tamAlfabeto=2;
            tabela[0][1] = (char)('0');
            tabela[0][2] = (char)(1 + '0');
            tabela[1][0] = (char)(1 + '0');
            tabela[1][1] = (char)(2 + '0');
            tabela[1][2] = (char)(1 + '0');
            tabela[2][0] = (char)(2 + '0');
            tabela[2][1] = (char)(3 + '0');
            tabela[2][2] = (char)(1 + '0');
            tabela[3][0] = (char)(3 + '0');
            tabela[3][1] = (char)(3 + '0');
            tabela[3][2] = (char)(1 + '0');
        }
        else if(afd == 2){
            estadoFinal = new ArrayList<>();
            estadoFinal.add(1);
            tabela = new char[4][3];
            tamAlfabeto=2;
            tabela[0][1] = (char)('0');
            tabela[0][2] = (char)(1 + '0');
            tabela[1][0] = (char)(1 + '0');
            tabela[1][1] = (char)(1 + '0');
            tabela[1][2] = (char)(2 + '0');
            tabela[2][0] = (char)(2 + '0');
            tabela[2][1] = (char)(3 + '0');
            tabela[2][2] = (char)(1 + '0');
            tabela[3][0] = (char)(3 + '0');
            tabela[3][1] = (char)(2 + '0');
            tabela[3][2] = (char)(3 + '0');
        }
    }

    public void mostrarTabela(){
        System.out.print("\nAFD escolhido: \n\n");
        for(int i=0; i<4; i++){
            for(int j=0; j<3; j++){
                System.out.print(tabela[i][j] + "\t");
            }
            System.out.println();
        }
    }

    public int trans(int estado, char c){
        for(int j=1;j<=tamAlfabeto;j++){
            if (tabela[0][j]==c){
                char temp = tabela[estado][j];
                System.out.println("Estado de "+estado+" para "+temp);
                return Character.getNumericValue(temp);
            }
        }
        System.out.println("caractere nao encontrado");
        return -1;
    }

}