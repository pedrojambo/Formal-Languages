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
            tamAlfabeto=3;
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
        }

    public void mostrarTabela(){
        System.out.print("AFD escolhido: \n\n");
        for(int i=0; i<4; i++){
            for(int j=0; j<3; j++){
                System.out.print(tabela[i][j] + "\t");
            }
            System.out.println();
        }
        System.out.println();
        System.out.println();
    }

    public int trans(int estado, char c){
        for(int j=1;j<tamAlfabeto;j++){
            if (tabela[0][j]==c){
                return tabela[estado+1][j];
            }
        }
        return -1;
    }

}