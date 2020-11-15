import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus

int gfx_mode=0;

int [] progress = {0,0,0,0};
int [] progress_state = {1,1,1,1};
long[] progress_timer = {0,0,0,0};
int progress_speed = 200;


int[][] pads = {
{0,1,2,3,4,5,6,7},
{16,17,18,19,20,21,22,23},
{32,33,34,35,36,37,38,19},
{48,49,50,51,52,53,54,55},
{64,65,66,67,68,69,70,71},
{80,81,82,83,84,85,86,87},
{96,97,98,99,100,101,102,103},
{112,113,114,115,116,117,118,119}
};


void setup() {
  size(400, 400);
  background(0);
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, "Launchpad [hw:1,0,0]", "Launchpad [hw:1,0,0]"); // Create a new MidiBus using the device names to select the Midi input and output devices respectively.
}

void draw() {
  
   
 switch (gfx_mode) {
    case 0:
      draw_squares();
      break;
    case 1:
      draw_circles();
      break;
    case 2:
      draw_lines();
      break;
    case 3:
      break;
    case 4:
      break;    
 }
 
 update_progress();
 
}

void update_progress(){
  for (int i=0; i<=3;i++){
    if (progress_state[i]<=0){
      continue;
    }
    if (millis () - progress_timer[i]>progress_speed){
      led_off(i+4,progress[i]);
      progress[i]++;
      if (progress[i]>=8){
        progress[i]=0;
      }
      led_on(i+4,progress[i],50+20*i);  
      progress_timer[i]=millis();
    }   
  }
}
void noteOn(int channel, int pitch, int velocity) {
  if ( pitch <8){
    change_mode(pitch);
    gfx_mode=pitch;
  }
  if ( pitch >=64){
    println("change pitch");
    int p = pitch -64;
    p = int(p / 16);
    int r = pitch- (64+p*16);
    
    if (r>7){
      return;
    }
    line_off(p+4);
    led_on(p+4,r,50+20*p);
    progress[p]=r;
    
    
  }
  
}

void change_mode(int mode){
  led_off(0,gfx_mode);
  gfx_mode=mode; 
  led_on(0,mode,200);
}

void led_on(int x, int y, int c){
  myBus.sendNoteOn(0, pads[x][y],c);
}
void led_off(int x, int y){
  myBus.sendNoteOff(0, pads[x][y],0);
}
void line_off(int c){
  for(int i=0;i<=7;i++){
    led_off(c,i);
  }
}


void noteOff(int channel, int pitch, int velocity) {
 //myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff
}
