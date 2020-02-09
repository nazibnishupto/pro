#include<bits/stdc++.h>

using namespace std;

pair<int,int>numbering[20];
int eatGraph[20][20];
vector<int>edge[20];
int storeVal[20];
int temp[20];
int Difficulty;
int ManCount=7;



int GetVal(int a,int b){
    for(int i=1;i<=13;i++){
        if(numbering[i].first == a and numbering[i].second == b)return i;
    }
    return 0;
}



void PrintBoard(int l[]){
        for(int i=0;i<5;i++){
            if(i==0 || i== 4)
            for(int j=0;j<3;j++){
                if(storeVal[GetVal(i,j)]==1)printf("M  ");
                else if(storeVal[GetVal(i,j)]==2)printf("T  ");
                else printf("_  ");
            }
            else if(i==1 || i==3)
            for(int j=0;j<3;j++){
                if(storeVal[GetVal(i,j)]==1)printf(" M");
                else if(storeVal[GetVal(i,j)]==2)printf(" T");
                else printf(" _");
            }
            else
                for(int j=1;j<2;j++){
                    if(storeVal[GetVal(i,j)]==1)printf("   M");
                    else if(storeVal[GetVal(i,j)]==2)printf("   T");
                    else printf("   _");
                }
            printf("\n");
        }
}




void Numbering(){
    numbering[1]=make_pair(0,0);
    numbering[2]=make_pair(0,1);
    numbering[3]=make_pair(0,2);
    numbering[4]=make_pair(1,0);
    numbering[5]=make_pair(1,1);
    numbering[6]=make_pair(1,2);
    numbering[7]=make_pair(2,1);
    numbering[8]=make_pair(3,0);
    numbering[9]=make_pair(3,1);
    numbering[10]=make_pair(3,2);
    numbering[11]=make_pair(4,0);
    numbering[12]=make_pair(4,1);
    numbering[13]=make_pair(4,2);

    storeVal[5]=2;
    storeVal[7]=1;
    storeVal[8]=1;
    storeVal[9]=1;
    storeVal[10]=1;
    storeVal[11]=1;
    storeVal[12]=1;
    storeVal[13]=1;
    for(int i=1;i<=13;i++){
        temp[i]=storeVal[i];
    }
}



void BuildGraph(){
    edge[1].push_back(2);
    edge[1].push_back(4);

    edge[2].push_back(1);
    edge[2].push_back(3);
    edge[2].push_back(5);

    edge[3].push_back(2);
    edge[3].push_back(6);

    edge[4].push_back(1);
    edge[4].push_back(5);
    edge[4].push_back(7);

    edge[5].push_back(2);
    edge[5].push_back(4);
    edge[5].push_back(7);
    edge[5].push_back(6);

    edge[6].push_back(5);
    edge[6].push_back(7);
    edge[6].push_back(3);

    edge[7].push_back(4);
    edge[7].push_back(5);
    edge[7].push_back(6);
    edge[7].push_back(8);
    edge[7].push_back(9);
    edge[7].push_back(10);

    edge[8].push_back(7);
    edge[8].push_back(9);
    edge[8].push_back(11);

    edge[9].push_back(7);
    edge[9].push_back(8);
    edge[9].push_back(10);
    edge[9].push_back(12);

    edge[10].push_back(9);
    edge[10].push_back(13);
    edge[10].push_back(7);

    edge[11].push_back(8);
    edge[11].push_back(12);

    edge[12].push_back(11);
    edge[12].push_back(9);
    edge[12].push_back(13);

    edge[13].push_back(12);
    edge[13].push_back(10);




    eatGraph[1][4]=7;
    eatGraph[1][2]=3;
    eatGraph[2][5]=7;
    eatGraph[3][2]=1;
    eatGraph[3][6]=7;
    eatGraph[4][7]=10;
    eatGraph[4][5]=6;
    eatGraph[5][7]=9;
    eatGraph[6][5]=4;
    eatGraph[6][7]=8;

    eatGraph[7][4]=1;
    eatGraph[7][5]=2;
    eatGraph[7][6]=3;
    eatGraph[7][8]=11;
    eatGraph[7][9]=12;
    eatGraph[7][10]=13;

    eatGraph[8][7]=6;
    eatGraph[8][9]=10;
    eatGraph[9][7]=5;
    eatGraph[10][7]=4;
    eatGraph[10][9]=8;
    eatGraph[11][8]=7;
    eatGraph[11][12]=13;
    eatGraph[12][9]=7;
    eatGraph[13][12]=11;
    eatGraph[13][10]=7;
}






int Evolution_func(int turn,int board[20],int Mancount,int Level){
    if( Level >= Difficulty or Mancount < 4 ) return Mancount;
    int temp[20];
    for(int k=1;k<=13;k++){
        temp[k]=board[k];
    }
    if(turn == 1){
        pair< int , pair<int,int> >saveCount[200];
        int cnt=0;
        for(int i=1;i<=13;i++){
            if(temp[i]==1){
                for(int j=0;j<edge[i].size();j++){
                    int u=edge[i][j];
                    if(temp[u] == 0){
                        temp[i] = 0;
                        temp[u] = 1;
                        saveCount[cnt++]=make_pair(Evolution_func(0,temp,Mancount,Level+1),make_pair(i,u));
                         for(int k=1;k<=13;k++){
                            temp[k]=board[k];
                        }
                    }
                }
            }
        }

        sort(saveCount,saveCount+cnt);
        reverse(saveCount,saveCount+cnt);
        board[saveCount[0].second.first]=0;
        board[saveCount[0].second.second]=1;
        return Evolution_func(0,board,Mancount,Level+1);
    }
    else{
         pair< int , pair<int,int> >saveCount[200];
         int cnt=0;

         pair< int , pair<int,int> >saveEat[200];
         int Ecnt=0;

         for(int i=1;i<=13;i++){
            if(temp[i]==2){
                for(int j=0;j<edge[i].size();j++){
                    int u=edge[i][j];
                    if(temp[u]==0){
                        temp[i]=0;
                        temp[u]=2;
                        saveCount[cnt++]=make_pair(Evolution_func(1,temp,Mancount,Level),make_pair(i,u));
                        for(int k=1;k<=13;k++){
                            temp[k]=board[k];
                        }
                    }
                    else if(temp[u]==1){
                        if( temp[eatGraph[i][u]]==0 and eatGraph[i][u] !=0 ){
                            temp[i]=0;
                            temp[u]=0;
                            temp[eatGraph[i][u]]=2;
                            saveEat[Ecnt++] = make_pair( Evolution_func(1,temp,Mancount-1,Level) , make_pair(i,u));
                            for(int k=1;k<=13;k++){
                                temp[k]=board[k];
                            }
                        }
                    }
                }
            }
         }
        sort(saveCount,saveCount+cnt);
        sort(saveEat,saveEat+Ecnt);
        if(Ecnt==0){
            board[saveCount[0].second.first]=0;
            board[saveCount[0].second.second]=2;
            return Evolution_func(1,board,Mancount,Level+1);
        }
        else if(saveCount[0].first < saveEat[0].first){
            board[saveCount[0].second.first]=0;
            board[saveCount[0].second.second]=2;
            return Evolution_func(1,board,Mancount,Level+1);
        }
        else{
            board[saveEat[0].second.first]=0;
            board[saveEat[0].second.second]=0;
            board[eatGraph[saveEat[0].second.first][saveEat[0].second.second]]=2;
            return Evolution_func(1,board,Mancount-1,Level+1);
        }
    }
}






int HumanMove(int a,int b){
    if(storeVal[b]!=0)return 0;
    if(storeVal[a]!=1)return 0;
    for(int i=0;i<edge[a].size();i++){
        if(edge[a][i] == b){
            return 1;
        }
    }
    return 0;
}




int checkHumanMove(){
     for(int i=1;i<=13;i++){
        if(storeVal[i]==1){
            for(int j=0;j<edge[i].size();j++){
                if(storeVal[edge[i][j]]==0)return 1;
            }
        }
    }
    return 0;
}








int main(){
    Numbering();
    BuildGraph();
    printf("Initial Table :");
    cout<<endl;
    PrintBoard(storeVal);
    //printf("Enter Difficulty: ");
    //cin>>Difficulty;
    Difficulty=3;
    bool GameOver=false,Human=false,Tiger=false;
    int cnt=0;
    while(!GameOver){
        if(cnt%2){
            if(!checkHumanMove()){
                Human=true;
                break;
            }
            bool ValidMove=false;
            while(!ValidMove){
                printf("Enter your Move : ");
                int a,b;
                cin>>a>>b;
                cout<<endl;
                int check=HumanMove(a,b);
                if(check==1){
                    ValidMove=true;
                    storeVal[a]=0;
                    storeVal[b]=1;
                }
                else{
                    printf("Invalid Move\n");
                }
            }
        }
        else{
             pair< int , pair<int,int> >saveCount[200];
             int cnt=0;

             pair< int , pair<int,int> >saveEat[200];
             int Ecnt=0;

             for(int i=1;i<=13;i++){
                if(temp[i]==2){
                    for(int j=0;j<edge[i].size();j++){
                        int u=edge[i][j];
                        if(temp[u]==0){
                            temp[i]=0;
                            temp[u]=2;
                            saveCount[cnt++] = make_pair(Evolution_func(1,temp,ManCount,0),make_pair(i,u));
                            for(int k=1;k<=13;k++){
                                temp[k]=storeVal[k];
                            }
                        }
                        else if(temp[u]==1){
                            if( temp[eatGraph[i][u]]==0 and eatGraph[i][u] !=0){
                                temp[i]=0;
                                temp[u]=0;
                                temp[eatGraph[i][u]]=2;
                                saveEat[Ecnt++] = make_pair( Evolution_func(1,temp,ManCount-1,0) , make_pair(i,u));
                                for(int k=1;k<=13;k++){
                                    temp[k]=storeVal[k];
                                }
                            }
                        }
                    }
                }
             }
            sort(saveCount,saveCount+cnt);
            sort(saveEat,saveEat+Ecnt);
            if(Ecnt==0 and cnt==0 ){

                Tiger=true;
                break;
            }

            if(Ecnt==0){
                storeVal[saveCount[0].second.first]=0;
                storeVal[saveCount[0].second.second]=2;

            }
            else if(saveCount[0].first < saveEat[0].first){
                storeVal[saveCount[0].second.first]=0;
                storeVal[saveCount[0].second.second]=2;

            }
            else{
                storeVal[saveEat[0].second.first]=0;
                storeVal[saveEat[0].second.second]=0;
                storeVal[eatGraph[saveEat[0].second.first][saveEat[0].second.second]]=2;

            }
        }
        if(ManCount<4){
            GameOver=true;
            break;
        }
        for(int k=1;k<=13;k++){
            temp[k]=storeVal[k];
        }
        if(cnt%2){
            printf("User move :");
            cout<<endl;
            PrintBoard(storeVal);
            cout<<endl<<endl;
        }
        else{
            printf("AI move :");
            cout<<endl;
            PrintBoard(storeVal);
            cout<<endl<<endl;
        }

        for(int i=1;i<=13;i++){

        }
        cnt++;
    }

    if(!Tiger or Human){
        printf("You lost\n");
    }
    else {
        printf("You Won\n");
    }

}
