//scene transition
String stats="";

// title state only 
int selected=0;
PImage titleimg;

// game
int levelnum=3;
int[] interval={180,90,1};
PImage trump;
boolean speed=false;

int[] vscard={26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51};
int[] mycard={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25};

int[] myfuda={0,0,0,0};
int[] vsfuda={0,0,0,0};

int mypointer=5;
int vspointer=5;

int[] ba={0,0};

int cardwidth=100;
int cardheight=150;

int shuffle=1000;

long frames=0;

int mynokori=4;    // yamafuda ga zero no toki no aiteinai tefuda no kazu
int vsnokori=4;

boolean kachimake=false;
boolean mykachi=false;

void setup(){
  titleimg=loadImage("title.png");
  frameRate(60);
  size(1080,720);
  stats="title";
  trump=loadImage("trump.png");
}

void keyPressed(){
  if(keyCode==UP){
      if(stats.equals("title")){
        selected=(selected+(-1+levelnum))%levelnum;
      }
  }
  else if(keyCode==DOWN){
      if(stats.equals("title")){
        selected=(selected+(1+levelnum))%levelnum;
      }
  }
  else if(key==' '){
    if(stats.equals("title")){
      init();
      stats="game";
      frames=0;
    }
  }
  else if(keyCode==ENTER){  //Enter 
    if(stats.equals("title")){
      init();
      stats="game";
      frames=0;
    }
    else if(stats.equals("game")){
      stats="title";
    }
  }
  else if(key=='a' || key=='A'){
    if(stats.equals("game")){
      //jibun no card ga okeruka?
      //kachi make no 
      if(!kachimake){
        if(!speed){
          sousa(0);
          kachimake();
        }
        else if(speed){
          speed(0);
          kachimake();
        }
      }
    }
  }
  else if(key=='s' || key=='S'){
    if(stats.equals("game")){
      //jibun no card ga okeruka?
      //kachi make no handan
      if(!kachimake){
        if(!speed){
          sousa(1);
          kachimake();
        }
        else if(speed){
          speed(1);
          kachimake();
        }
      }
    }
  }
  else if(key=='d' || key=='D'){
    if(stats.equals("game")){
      //jibun no card ga okeruka?
      //kachi make no handan
      if(!kachimake){
        if(!speed){
          sousa(2);
          kachimake();
        }
        else if(speed){
          speed(2);
          kachimake();
        }
      }
    }
  }
  else if(key=='f' || key=='F'){
    if(stats.equals("game")){
      //jibun no card ga okeruka?
      //kachi make no handan
      if(!kachimake){
        if(!speed){
          sousa(3);
          kachimake();
        }
        else if(speed){
          speed(3);
          kachimake();
        }
      }
    }
  }
  
  else if(key=='j' || key=='J'){
    if(stats.equals("game")){
      //jibun no card ga okeruka?
      //kachi make no 
      if(!kachimake){
        if(!speed){
          sousa(4);
          kachimake();
        }
        else if(speed){
          speed(0);
          kachimake();
        }
      }
    }
  }
  else if(key=='k' || key=='K'){
    if(stats.equals("game")){
      //jibun no card ga okeruka?
      //kachi make no handan
      if(!kachimake){
        if(!speed){
          sousa(5);
          kachimake();
        }
        else if(speed){
          speed(1);
          kachimake();
        }
      }
    }
  }
  else if(key=='l' || key=='L'){
    if(stats.equals("game")){
      //jibun no card ga okeruka?
      //kachi make no handan
      if(!kachimake){
        if(!speed){
          sousa(6);
          kachimake();
        }
        else if(speed){
          speed(2);
          kachimake();
        }
      }
    }
  }
  else if(key==';' || key=='+'){
    if(stats.equals("game")){
      //jibun no card ga okeruka?
      //kachi make no handan
      if(!kachimake){
        if(!speed){
          sousa(7);
          kachimake();
        }
        else if(speed){
          speed(3);
          kachimake();
        }
      }
    }
  }
}

void draw(){
  vsnokori=4;
  mynokori=4;
  if(stats.equals("title")){
    titlesc();
  }
  else if(stats.equals("game")){
    kachimake();
    if(!istezumari()){  //tezumari
      speed=true;
      //
    }
    else{
      speed=false;
    }
    frames++;
    if(frames%interval[selected]==0){
      //AI PROCESS
      //kachi make no handan
      if(!kachimake){
        AI();
        kachimake();
      }
    }
    gamesec();
  }
}

void titlesc(){
  image(titleimg, 0, 0);
  textSize(60);
  text("EASY", 500, 450);
  text("NORMAL", 500, 550);
  text("HARD", 500, 650);
  text("-", 400, 450+100*selected);
  textSize(24);
  text("SPACE to start",460,700);
}

void gamesec(){

  background(128);
  for(int i=0; i<4; i++){
    if(myfuda[i]>=0){
      PImage tmp=trump.get((myfuda[i]%13)*cardwidth, (myfuda[i]/13)*cardheight, cardwidth+1, cardheight+1);
      image(tmp,150+200*i,550);
    }
  }
  for(int i=0; i<4; i++){
    if(vsfuda[i]>=0){
      PImage tmp=trump.get((vsfuda[i]%13)*cardwidth, (vsfuda[i]/13)*cardheight, cardwidth+1, cardheight+1);
      image(tmp,150+200*i,50);
    }
  }
  for(int i=0; i<2; i++){
    PImage tmp=trump.get(ba[i]%13*cardwidth, ba[i]/13*cardheight, cardwidth+1, cardheight+1);
    image(tmp,250+400*i,300);
  }
  textSize(24);
  if(vspointer<26){
    text((26-vspointer+5)+"card(s)",950,50);
  }
  else if(vspointer>=26){
    int rest=0;
    for(int i=0; i<4; i++){
      if(vsfuda[i]!=-1){
        rest++;
      }
    }
    text((rest)+"card(s)",950,50);
  }
  
  if(mypointer<26){
    text(+(26-mypointer+5)+"card(s)",950,550);
  }
  else if(mypointer>=26){
    int rest=0;
    for(int i=0; i<4; i++){
      if(myfuda[i]!=-1){
        rest++;
      }
    }
    text(+(rest)+"card(s)",950,550);
  }
  
  if(speed && !kachimake){
    text("Speed",450,400);
    text("press (A|S|D|F)",400,370);
  }
  
  if(kachimake){
    textSize(48);
    if(mykachi){
      text("YOU WIN",380,380);
    }
    else if(!mykachi){
      text("YOU LOSE",380,380);
    }
  }
  
}

void init(){
  kachimake=false;
  mykachi=false;
  mypointer=5;
  vspointer=5;
  for(int i=0; i<shuffle; i++){
    int from=(int)(Math.random()*26);
    int to=(int) (Math.random()*26);
    int tmp=mycard[to];
    mycard[to]=mycard[from];
    mycard[from]=tmp;
  }
  
  for(int i=0; i<shuffle; i++){
    int from=(int)(Math.random()*26);
    int to=(int) (Math.random()*26);
    int tmp=vscard[to];
    vscard[to]=vscard[from];
    vscard[from]=tmp;
  }
  
  for(int i=0; i<4; i++){
    myfuda[i]=mycard[i+1];
  }
  
  for(int i=0; i<4; i++){
    vsfuda[i]=vscard[i+1];
  }
  
  ba[0]=mycard[0];
  ba[1]=vscard[0];
  
}

void AI(){  //AI is zenkyo, therefore AI can see 4 cards at a one time.
  int okeru=-1;
  int okuba=-1;
  
  for(int i=0; i<4; i++){
    if(vsfuda[i]!=-1){
      for(int j=0; j<2; j++){  //ba
        if(vsfuda[i]%13 != 0 && vsfuda[i]%13 !=12){  //K to A or A to K no handan
          if(Math.abs(ba[j]%13-vsfuda[i]%13)==1){  //okeru
            if(okeru==-1){  // hasn't oku?
              okeru=i;
              okuba=j;
            }
          }
        }
        else if(vsfuda[i]%13==0){
          if(ba[j]%13==12 || ba[j]%13==1){
            if(okeru==-1){
              okeru=i;
              okuba=j;
            }
          }
        }
        else if(vsfuda[i]%13==12){
          if(ba[j]%13==0 || ba[j]%13==11){
            if(okeru==-1){
              okeru=i;
              okuba=j;
            }
          }
        }
      }
    }
  }
  if(okeru!=-1){
    ba[okuba]=vsfuda[okeru];
    if(vspointer<26){
      vsfuda[okeru]=vscard[vspointer];
      vspointer++;
    }
    else if(vspointer>=26){
      vsfuda[okeru]=-1;
    }
  }
}

void sousa(int num){
  if(myfuda[num%4]!=-1){
    int okuba=-1;
      if(myfuda[num%4]%13!=0 && myfuda[num%4]%13!=12){
        if(Math.abs(ba[num/4]%13-myfuda[num%4]%13)==1){  //okeru
          if(okuba==-1){  // hasn't oku?
            okuba=num/4;
          }
        }
      }
      else if(myfuda[num%4]%13==0){
        if(ba[num/4]%13==12 || ba[num/4]%13==1){
          if(okuba==-1){
            okuba=num/4;
          }
        }
      }
      else if(myfuda[num%4]%13==12){
        if(ba[num/4]%13==0 || ba[num/4]%13==11){
          if(okuba==-1){
            okuba=num/4;
          }
        }
      }
    if(okuba!=-1){
      ba[okuba]=myfuda[num%4];
      if(mypointer<26){
        myfuda[num%4]=mycard[mypointer];
        mypointer++;
      }
      else if(mypointer>=26){
        myfuda[num%4]=-1;
      }
    }
  }
}

boolean istezumari(){
  boolean tezumari=false;
  
  for(int i=0; i<4; i++){
    if(vsfuda[i]!=-1){
      for(int j=0; j<2; j++){  //ba
        if(vsfuda[i]%13 != 0 && vsfuda[i]%13 !=12){  //K to A or A to K no handan
          if(Math.abs(ba[j]%13-vsfuda[i]%13)==1){  //okeru
            tezumari=true;
          }
        }
        else if(vsfuda[i]%13==0){
          if(ba[j]%13==12 || ba[j]%13==1){
            tezumari=true;
          }
        }
        else if(vsfuda[i]%13==12){
          if(ba[j]%13==0 || ba[j]%13==11){
            tezumari=true;
          }
        }
      }
    }
    
    if(myfuda[i]!=-1){
      for(int j=0; j<2; j++){  //ba
        if(myfuda[i]%13 != 0 && myfuda[i]%13 !=12){  //K to A or A to K no handan
          if(Math.abs(ba[j]%13-myfuda[i]%13)==1){  //okeru
            tezumari=true;
          }
        }
        else if(myfuda[i]%13==0){
          if(ba[j]%13==12 || ba[j]%13==1){
            tezumari=true;
          }
        }
        else if(myfuda[i]%13==12){
          if(ba[j]%13==0 || ba[j]%13==11){
            tezumari=true;
          }
        }
      }
    }
  }
  return tezumari;
}

void speed(int num){
  boolean fudanull=myfuda[num]==-1;
  
  if(!kachimake){ // kachimake has't detected
    if(!fudanull){
      if(mypointer<26){
        ba[0]=mycard[mypointer];
        mypointer++;
      }
      else{
        ba[0]=myfuda[num];
        myfuda[num]=-1;
      }
      
      if(vspointer<26){
        ba[1]=vscard[vspointer];
        vspointer++;
      }
      else{
        //ima aru tefuda kara random ni erabu
        int cards=0;
        for(int i=0; i<4; i++){
          if(vsfuda[i]>=0){
            cards++;
          }
        }
        int[] selecard=new int[cards];
        int tmp=0;
        for(int i=0; i<4; i++){
          if(vsfuda[i]>=0){
            selecard[tmp]=i;
            tmp++;
          }
        }
        int rand=(int)(Math.random()*tmp);
        ba[1]=vsfuda[selecard[rand]];
        vsfuda[selecard[rand]]=-1;
      }
      speed=false;
    }
  }
  kachimake();
}

void kachimake(){
  //kachi make no handan
  if(mypointer>=26 || vspointer>=26){
    mynokori=4;
    vsnokori=4;
    for(int i=0; i<4; i++){
      if(myfuda[i]==-1){
        mynokori--;
      }
    }
    
    for(int i=0; i<4; i++){
      if(vsfuda[i]==-1){
        vsnokori--;
      }
    }
    if(vsnokori==0 || mynokori==0){
      kachimake=true;
      if(vsnokori==0){
        mykachi=false;
      }
      else{
        mykachi=true;
      }
    }
  }
}
