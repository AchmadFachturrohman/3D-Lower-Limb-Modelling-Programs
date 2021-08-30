unit Interface_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  TeeProcs, VclTee.TeeGDIPlus, OpenGL, Vcl.ExtCtrls, Math;

type
  TInterfaceForm = class(TForm)
    Timer1: TTimer;
    btnRun: TButton;
    btnClose: TButton;
    ICCGroup: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    ScrollBar3: TScrollBar;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    ActiveTestBox: TGroupBox;
    FlexorHip: TButton;
    FlexorKnee: TButton;
    FlexorAnkle: TButton;
    ExtensorHip: TButton;
    ExtensorKnee: TButton;
    ExtensorAnkle: TButton;
    PassiveTestBox: TGroupBox;
    procedure motionEquation;
    procedure renderkakiseated;
    procedure renderkakistanding;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnRunClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
    procedure FlexorHipClick(Sender: TObject);
    procedure ExtensorHipClick(Sender: TObject);
    procedure FlexorKneeClick(Sender: TObject);
    procedure ExtensorKneeClick(Sender: TObject);
    procedure FlexorAnkleClick(Sender: TObject);
    procedure ExtensorAnkleClick(Sender: TObject);
  private
    { Private-Deklarationen }
     myDC : HDC;
     myRC : HGLRC;
     myPalette : HPALETTE;
     procedure SetupPixelFormat;
  public
    { Public-Deklarationen }
  end;

const
  mat_specular : array [0..3] of GLfloat = ( 8.0, 8.0, 1.0, 0.0 );
  mat_shininess : GLfloat = 40.0;
  light_position : array [0..3] of GLfloat = ( 120.6, 14.0, 41.0, 10.7 );

  lf = 1.25;
  masf = 1.5;
  max = 3;
  dt = 0.0001;
  g1 = 9.8;

  //segments masses
  m1 = masf*6.86; //9.74
  m2 = masf*2.76; //3.86
  m3 = masf*0.89; //0.99

  //moments of inertia
  i1 = 0.133;
  i2 = 0.048;
  i3 = 0.004;

  //segments length
  l1 = lf*0.383;  //5*0.383 = 1.915*0.25 ~ 1.25*0.383 = 0.47875
  l2 = lf*0.407;  //5*0.407 = 2.035*0.25 ~ 1.25*0.407 = 0.50875
  l3 = lf*0.149;  //5*0.149 = 0.745*0.25 ~ 1.25*0.149 = 0.18625

  //segments 'center of mass' length
  a1 = lf*0.42*l1; //0.2
  a2 = lf*0.41*l2; //0.15
  a3 = lf*0.4*l3;  //0.08

  //passive damping
  cpd1 = 3.09;
  cpd2 = 10.0;
  cpd3 = 0.943;

  //joint stifness
  k11 = 2.6;
  k21 = 5.8;
  k31 = 8.7;
  k41 = 1.3;

  k12 = 6.1;
  k22 = 5.9;
  k32 = 10.5;
  k42 = 21.8;

  k13 = 2;
  k23 = 5;
  k33 = 2;
  k43 = 5;

  {fmax}
  fmax1 = 1100;
  fmax2 = 1000;
  fmax3 = 7300;
  fmax4 = 1000;
  fmax5 = 1650;
  fmax6 = 2180;

  {vmax}
  vmax1 = 0.4;
  vmax2 = 0.4;
  vmax3 = 0.45;
  vmax4 = 0.45;
  vmax5 = 0.2;
  vmax6 = 0.2;

  {moment arm}
  rf1 = 0.132;
  rf2 = 0.054;
  rf3 = 0.049;
  rf4 = 0.025;
  rf5 = 0.040;
  rf6 = 0.023;

  {length optimum}
  lo1 = 0.35;
  lo2 = 0.46;
  lo3 = 0.29;
  lo4 = 0.48;
  lo5 = 0.56;
  lo6 = 0.3;

  tf = 0.6;       //fall time
  tr = 0.4;       //rise time

  {shape parameter}
  cm = 2.5;       //shape parameter of F-V

  {damp const muscle}
  kdamp1 = 275;
  kdamp2 = 200;
  kdamp3 = 300;
  kdamp4 = 200;
  kdamp5 = 200;
  kdamp6 = 200;

  {const pe}
  kpe1 = 5.85;
  kpe2 = 2.41;
  kpe3 = 1.6;
  kpe4 = 5.4;
  kpe5 = 8.25;
  kpe6 = 1.3;

  cp1 = 3.09;
  cp2 = 10.0;
  cp3 = 0.943;
  k1p1 = 2.6;
  k1p2 = 6.1;
  k1p3 = 2.0;
  k2p1 = 5.8;
  k2p2 = 5.9;
  k2p3 = 5;
  k3p1 = 8.7;
  k3p2 = 10.5;
  k3p3 = 2.0;
  k4p1 = 1.3;
  k4p2 = 21.8;
  k4p3 = 5.0;
  phi11 = -10*pi/180;
  phi12 = 6*pi/180;
  phi13 = -15*pi/180;
  phi21 = 10*pi/180;
  phi22 = 110*pi/180;
  phi23 = 25*pi/180;

type
  row = array [1..max] of real;
  matrix = array [1..max] of row;
  myarray = array [1..1000000] of extended;

var
  InterfaceForm: TInterfaceForm;

  a, b, ab :matrix;
  m, c :matrix;
  ab1 :row;
  angle, vel, accl, g, torque, anglebef, psf  :row;
  t, time,
  teta1,     teta2,     teta3,
  theta1,    theta2,    theta3,
  thetadot1, thetadot2, thetadot3,
  thetadotdot1, thetadotdot2, thetadotdot3    :real;
  term1, term2, term3 :row;

  s1,    s2,    s3,    s4,    s5,    s6,
  mus1,  mus2,  mus3,  mus4,  mus5,  mus6,
  mpd1,  mpd2,  mpd3,  mpd4,  mpd5,  mpd6,
  mpe1,  mpe2,  mpe3,  mpe4,  mpe5,  mpe6,
  tetseb1,tetseb2,tetseb3                     :extended;

  ftot1, ftot2, ftot3, ftot4, ftot5, ftot6,
  act1,  act2,  act3,  act4,  act5,  act6,
  adot1, adot2, adot3, adot4, adot5, adot6,
  u1,    u2,    u3,    u4,    u5,    u6,
  fl1,   fl2,   fl3,   fl4,   fl5,   fl6,
  fv1,   fv2,   fv3,   fv4,   fv5,   fv6,
  lt1,   lt2,   lt3,   lt4,   lt5,   lt6,
  lc1,   lc2,   lc3,   lc4,   lc5,   lc6      :real;

  k1, k2, k3, k4  :myarray;

  xpos, ypos, zpos :real;
  yaw, pitch, roll :integer;
  Sphere, cylinder, disk, partialdisk: GLUquadricObj;
implementation

{$R *.DFM}

uses Main_u;

procedure glBindTexture(target: GLenum; texture: GLuint); stdcall; external opengl32;

procedure TInterfaceForm.SetupPixelFormat;
var    hHeap: THandle;
  nColors, i: Integer;
  lpPalette : PLogPalette;
  byRedMask, byGreenMask, byBlueMask: Byte;
  nPixelFormat: Integer;
  pfd: TPixelFormatDescriptor;
begin
  FillChar(pfd, SizeOf(pfd), 0);
  with pfd do
  begin
    nSize     := sizeof(pfd);               // Länge der pfd-Struktur
    nVersion  := 1;                         // Version
    dwFlags   := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;          // Flags
    iPixelType:= PFD_TYPE_RGBA;             // RGBA Pixel Type
    cColorBits:= 32;                        // 24-bit color
    cDepthBits:= 32;                        // 32-bit depth buffer
    iLayerType:= PFD_MAIN_PLANE;            // Layer Type
  end;
  nPixelFormat:= ChoosePixelFormat(myDC, @pfd);
  SetPixelFormat(myDC, nPixelFormat, @pfd);
                                            // Farbpalettenoptimierung wenn erforderlich
  DescribePixelFormat(myDC, nPixelFormat,sizeof(TPixelFormatDescriptor),pfd);
  if ((pfd.dwFlags and PFD_NEED_PALETTE) <> 0) then
  begin
    nColors  := 1 shl pfd.cColorBits;
    hHeap    := GetProcessHeap;
    lpPalette:= HeapAlloc
       (hHeap,0,sizeof(TLogPalette)+(nColors*sizeof(TPaletteEntry)));
    lpPalette^.palVersion := $300;
    lpPalette^.palNumEntries := nColors;
    byRedMask  := (1 shl pfd.cRedBits) - 1;
    byGreenMask:= (1 shl pfd.cGreenBits) - 1;
    byBlueMask := (1 shl pfd.cBlueBits) - 1;
    for i := 0 to nColors - 1 do
    begin
      lpPalette^.palPalEntry[i].peRed  := (((i shr pfd.cRedShift)  and byRedMask)  *255)DIV byRedMask;
      lpPalette^.palPalEntry[i].peGreen:= (((i shr pfd.cGreenShift)and byGreenMask)*255)DIV byGreenMask;
      lpPalette^.palPalEntry[i].peBlue := (((i shr pfd.cBlueShift) and byBlueMask) *255)DIV byBlueMask;
      lpPalette^.palPalEntry[i].peFlags:= 0;
    end;
    myPalette:= CreatePalette(lpPalette^);
    HeapFree(hHeap, 0, lpPalette);
    if (myPalette <> 0) then
    begin
      SelectPalette(myDC, myPalette, False);
      RealizePalette(myDC);
    end;
  end;
end;

procedure TInterfaceForm.renderkakiseated;
begin
  glClearColor(0.0, 0.0, 0.0, 1.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT); //Farb und Tiefenpuffer löschen
  glLoadIdentity;

  gltranslate(xpos,ypos,zpos);

  glrotate(yaw,1,0,0); //roll angle sudut memutar, sumbu x
  glrotate(pitch,0,1,0); //yaw heading angle, poros sumbu y, kiri kanan
  glrotate(roll,0,0,1); //pitch angle sudut dongak  pooros sb z
  glenable(gl_lighting);

  //Hip
  glpushmatrix();
  gluSphere(sphere, 0.095, 32, 32);
  glpopmatrix();

  //Thigh
  glpushmatrix();
  glrotate(90,0,1,0);
  gluCylinder(cylinder, 0.08, 0.05, l1, 32, 32);
  glpopmatrix();

  //Knee
  glpushmatrix();
  gltranslate(l1,0,0);
  gluSphere(sphere, 0.065, 32, 32);
  glpopmatrix();

  //Shank
  glpushmatrix();
  glrotate(90,0,1,0);
  gltranslate(0,0,l1);
  glrotate(180,0,0,1);
  glrotate(teta2,0,1,0);
  gluCylinder(cylinder, 0.05, 0.02, l2, 32, 32);
  glpopmatrix();

  //Ankle
  glpushmatrix();
  glrotate(90,0,1,0);
  gltranslate(0,0,l1);
  glrotate(180,0,0,1);
  glrotate(teta2,0,1,0);
  gltranslate(0,0,l2);
  gluSphere(sphere, 0.055, 32, 32);
  glpopmatrix();

  //Foot
  glpushmatrix();
  glrotate(90,0,1,0);
  gltranslate(0,0,l1);
  glrotate(180,0,0,1);
  glrotate(teta2,0,1,0);
  glrotate(270,0,1,0);
  glrotate(180,0,0,1);
  gltranslate(-l2,0,0);
  glrotate(-teta3,0,1,0);
  gluCylinder(cylinder, 0.04, 0.01, l3, 32, 32);
  glpopmatrix();

  glpushmatrix();
  glrotate(90,0,1,0);
  gltranslate(0,0,l1);
  glrotate(180,0,0,1);
  glrotate(teta2,0,1,0);
  glrotate(270,0,1,0);
  glrotate(180,0,0,1);
  gltranslate(-l2,0,0);
  glrotate(-teta3,0,1,0);
  gltranslate(0,0,l3);
  gluSphere(sphere, 0.015, 32, 32);
  glpopmatrix();

  swapBuffers(InterfaceForm.myDC);
end;

procedure TInterfaceForm.renderkakistanding;
begin
  glClearColor(0.0, 0.0, 0.0, 1.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT); //Farb und Tiefenpuffer löschen
  glLoadIdentity;

  gltranslate(xpos,ypos,zpos);

  glrotate(yaw,1,0,0); //roll angle sudut memutar, sumbu x
  glrotate(pitch,0,1,0); //yaw heading angle, poros sumbu y, kiri kanan
  glrotate(roll,0,0,1); //pitch angle sudut dongak  pooros sb z
  glenable(gl_lighting);

  //Hip
  glpushmatrix();
  gluSphere(sphere, 0.1, 32, 32);
  glpopmatrix();

  //Thigh
  glpushmatrix();
  glrotate(teta1,0,1,0);
  gluCylinder(cylinder, 0.09, 0.06, l1, 32, 32);
  glpopmatrix();

  //Knee
  glpushmatrix();
  glrotate(-90,0,1,0);
  glrotate(teta1,0,1,0);
  gltranslate(l1,0,0);
  gluSphere(sphere, 0.075, 32, 32);
  glpopmatrix();

  //Shank
  glpushmatrix();
  glrotate(teta1,0,1,0);
  gltranslate(0,0,l1);
  glrotate(180,0,0,1);
  glrotate(teta2,0,1,0);
  gluCylinder(cylinder, 0.06, 0.03, l2, 32, 32);
  glpopmatrix();

  //Ankle
  glpushmatrix();
  glrotate(teta1,0,1,0);
  gltranslate(0,0,l1);
  glrotate(180,0,0,1);
  glrotate(teta2,0,1,0);
  gltranslate(0,0,l2);
  gluSphere(sphere, 0.045, 32, 32);
  glpopmatrix();

  //Foot
  glpushmatrix();
  glrotate(teta1,0,1,0);
  gltranslate(0,0,l1);
  glrotate(180,0,0,1);
  glrotate(teta2,0,1,0);
  glrotate(270,0,1,0);
  glrotate(180,0,0,1);
  gltranslate(-l2,0,0);
  glrotate(-teta3,0,1,0);
  gluCylinder(cylinder, 0.03, 0.01, l3, 32, 32);
  glpopmatrix();

  glpushmatrix();
  glrotate(teta1,0,1,0);
  gltranslate(0,0,l1);
  glrotate(180,0,0,1);
  glrotate(teta2,0,1,0);
  glrotate(270,0,1,0);
  glrotate(180,0,0,1);
  gltranslate(-l2,0,0);
  glrotate(-teta3,0,1,0);
  gltranslate(0,0,l3);
  gluSphere(sphere, 0.01, 32, 32);
  glpopmatrix();

  swapBuffers(InterfaceForm.myDC);
end;

procedure TInterfaceForm.FormDestroy(Sender: TObject);
begin
  wglmakecurrent(0,0);
  wgldeletecontext(mydc);
  releasedc(handle,mydc);
end;

procedure TInterfaceForm.FormResize(Sender: TObject);
begin
  glViewport(0, 0, Width, Height);    // Setzt den Viewport für das OpenGL Fenster
  glMatrixMode(GL_PROJECTION);        // Matrix Mode auf Projection setzen
  glLoadIdentity();                   // Reset View
  gluPerspective(45.0, Width/Height, 1, 100.0);  // Perspektive den neuen Maßen anpassen.
  glMatrixMode(GL_MODELVIEW);         // Zurück zur Modelview Matrix
  glLoadIdentity();
end;

procedure TInterfaceForm.FormCreate(Sender: TObject);
begin
  yaw   := strtoint(SpinEdit1.Text);
  pitch := strtoint(SpinEdit2.Text);
  roll  := strtoint(SpinEdit3.Text);
  InterfaceForm.myDC:= GetDC(Handle);
  SetupPixelFormat;
  myRC:= wglCreateContext(myDC);
  wglMakeCurrent(myDC, myRC);
  glEnable(GL_DEPTH_TEST);
  glLoadIdentity;

  glClearColor(0.0, 0.0, 0.0, 1.0); // Black Background
  glShadeModel(GL_SMOOTH); // Enables Smooth Color Shading
  glClearDepth(1.0); // Depth Buffer Setup
  glEnable(GL_DEPTH_TEST); // Enable Depth Buffer
  glDepthFunc(GL_LESS); // The Type Of Depth Test To Do

  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);

  glEnable(GL_TEXTURE_2D);

  Sphere := gluNewQuadric();
  cylinder:= gluNewQuadric();
  disk:=glunewquadric();
  partialdisk:=glunewquadric();
  gluQuadricNormals(Sphere, GLU_SMOOTH); // Create Smooth Normals
  gluQuadricNormals(cylinder, GLU_SMOOTH); // Create Smooth Normals
  gluQuadricNormals(disk, GLU_SMOOTH); // Create Smooth Normals

  glMaterialfv(GL_FRONT, GL_SPECULAR, @mat_specular);
  glMaterialfv(GL_BACK, GL_SPECULAR, @mat_specular);
  glMaterialfv(GL_FRONT, GL_SHININESS, @mat_shininess);
  glMaterialfv(GL_BACK, GL_SHININESS, @mat_shininess);
  glLightfv(GL_LIGHT0, GL_POSITION, @light_position);
  glLightfv(GL_LIGHT3, GL_SPECULAR, @mat_specular);
  glLightfv(GL_LIGHT1, GL_POSITION, @light_position);
  glLightfv(GL_LIGHT2, GL_POSITION, @light_position);

  glEnable(GL_LIGHTING);
  glEnable(GL_LIGHT0);
  glEnable(GL_LIGHT1);
  glEnable(GL_LIGHT2);
  glEnable(GL_LIGHT3);
  glDepthFunc(GL_LEQUAL);

  zpos:=-4;
end;

procedure TInterfaceForm.btnCloseClick(Sender: TObject);
begin
  if btnRun.Caption = 'Run' then begin
    MainForm.btnReset.Enabled := true;
    MainForm.btnShowInterface.Visible := false;
    Close;
  end;
end;

procedure TInterfaceForm.btnRunClick(Sender: TObject);
begin
  if btnRun.Caption = 'Run' then
  begin
    btnRun.Caption := 'Stop';
    MainForm.btnReset.Enabled := false;

    theta1 := Scrollbar1.Position*pi/180;
    theta2 := Scrollbar2.Position*pi/180;
    theta3 := Scrollbar3.Position*pi/180;

    thetadot1 := 0;
    thetadot2 := 0;
    thetadot3 := 0;

    thetadotdot1 := 0;
    thetadotdot2 := 0;
    thetadotdot3 := 0;

    anglebef[1]:=0;
    anglebef[2]:=0;
    anglebef[3]:=0;

    angle[1]:= theta1;
    angle[2]:= theta2;
    angle[3]:= theta3;

    vel[1]   := thetadot1;
    vel[2]   := thetadot2;
    vel[3]   := thetadot3;

    accl[1]  := thetadotdot1;
    accl[2]  := thetadotdot2;
    accl[3]  := thetadotdot3;

    timer1.Enabled:=true;
  end else
  if btnRun.Caption = 'Stop' then
  begin
    btnRun.Caption := 'Run';
    timer1.Enabled := false;
  end;
end;

procedure TInterfaceForm.ExtensorAnkleClick(Sender: TObject);
begin
  s1:= 0;
  s2:= 0;
  s3:= 0;
  s4:= 0;
  s5:= 0;
  s6:= 1;

  if ExtensorAnkle.Caption='Ankle Extensor' then
  begin
    ExtensorAnkle.Caption:='STOP';
    MainForm.btnReset.Enabled := false;
    MainForm.btnShowInterface.Visible := true;
    if (FlexorAnkle.Caption='Ankle Flexor') AND (ExtensorKnee.Caption='Knee Extensor') AND (FlexorKnee.Caption='Knee Flexor') AND (FlexorHip.Caption='Hip Flexor') AND (ExtensorHip.Caption='Hip Extensor') then
    begin
     theta1:= scrollbar1.Position*pi/180;
     theta2:= scrollbar2.Position*pi/180;
     theta3:= scrollbar3.Position*pi/180;

     thetadot1:= 0;
     thetadot2:= 0;
     thetadot3:= 0;

     thetadotdot1:= 0;
     thetadotdot2:= 0;
     thetadotdot3:= 0;

     anglebef[1]:=0;
     anglebef[2]:=0;
     anglebef[3]:=0;

     angle[1]:= theta1;
     angle[2]:= theta2;
     angle[3]:= theta3;

     vel[1]:= thetadot1;
     vel[2]:= thetadot2;
     vel[3]:= thetadot3;

     accl[1]:= thetadotdot1;
     accl[2]:= thetadotdot2;
     accl[3]:= thetadotdot3;
    end;

    FlexorAnkle.Caption:='Ankle Flexor';

    timer1.Enabled:=true;
  end else
  if ExtensorAnkle.Caption='STOP' then
  begin
    ExtensorAnkle.Caption:='Ankle Extensor';
    timer1.Enabled:=false;
  end;
end;

procedure TInterfaceForm.ExtensorHipClick(Sender: TObject);
begin
  s1:= 0;
  s2:= 1;
  s3:= 0;
  s4:= 0;
  s5:= 0;
  s6:= 0;

  if ExtensorHip.Caption='Hip Extensor' then
  begin
    ExtensorHip.Caption:='STOP';
    MainForm.btnReset.Enabled := false;
    MainForm.btnShowInterface.Visible := true;
    if (FlexorHip.Caption='Hip Flexor') AND (ExtensorKnee.Caption='Knee Extensor') AND (ExtensorKnee.Caption='Knee Flexor')AND (FlexorAnkle.Caption='Ankle Flexor') AND (ExtensorAnkle.Caption='Ankle Extensor') then
    begin
     theta1:= scrollbar1.Position*pi/180;
     theta2:= scrollbar2.Position*pi/180;
     theta3:= scrollbar3.Position*pi/180;

     thetadot1:= 0;
     thetadot2:= 0;
     thetadot3:= 0;

     thetadotdot1:= 0;
     thetadotdot2:= 0;
     thetadotdot3:= 0;

     anglebef[1]:=0;
     anglebef[2]:=0;
     anglebef[3]:=0;

     angle[1]:= theta1;
     angle[2]:= theta2;
     angle[3]:= theta3;

     vel[1]:= thetadot1;
     vel[2]:= thetadot2;
     vel[3]:= thetadot3;

     accl[1]:= thetadotdot1;
     accl[2]:= thetadotdot2;
     accl[3]:= thetadotdot3;
    end;

    FlexorHip.Caption:='Hip Flexor';

    timer1.Enabled:=true;
  end else
  if ExtensorHip.Caption='STOP' then
  begin
    ExtensorHip.Caption:='Hip Extensor';
    timer1.Enabled:=false;
  end;
end;

procedure TInterfaceForm.ExtensorKneeClick(Sender: TObject);
begin
  s1:= 0;
  s2:= 0;
  s3:= 0;
  s4:= 1;
  s5:= 0;
  s6:= 0;

  if ExtensorKnee.Caption='Knee Extensor' then
  begin
    ExtensorKnee.Caption:='STOP';
    MainForm.btnReset.Enabled := false;
    MainForm.btnShowInterface.Visible := true;
    if (FlexorKnee.Caption='Knee Flexor') AND (FlexorAnkle.Caption='Ankle Flexor') AND (ExtensorAnkle.Caption='Ankle Extensor') AND (FlexorHip.Caption='Hip Flexor') AND (ExtensorHip.Caption='Hip Extensor') then
    begin
     theta1:= scrollbar1.Position*pi/180;
     theta2:= scrollbar2.Position*pi/180;
     theta3:= scrollbar3.Position*pi/180;

     thetadot1:= 0;
     thetadot2:= 0;
     thetadot3:= 0;

     thetadotdot1:= 0;
     thetadotdot2:= 0;
     thetadotdot3:= 0;

     anglebef[1]:=0;
     anglebef[2]:=0;
     anglebef[3]:=0;

     angle[1]:= theta1;
     angle[2]:= theta2;
     angle[3]:= theta3;

     vel[1]:= thetadot1;
     vel[2]:= thetadot2;
     vel[3]:= thetadot3;

     accl[1]:= thetadotdot1;
     accl[2]:= thetadotdot2;
     accl[3]:= thetadotdot3;
    end;

    FlexorKnee.Caption:='Knee Flexor';

    timer1.Enabled:=true;
  end else
  if ExtensorKnee.Caption='STOP' then
  begin
    ExtensorKnee.Caption:='Knee Extensor';
    timer1.Enabled:=false;
  end;
end;

procedure TInterfaceForm.FlexorAnkleClick(Sender: TObject);
begin
  s1:= 0;
  s2:= 0;
  s3:= 0;
  s4:= 0;
  s5:= 1;
  s6:= 0;

  if FlexorAnkle.Caption='Ankle Flexor' then
  begin
    FlexorAnkle.Caption:='STOP';
    MainForm.btnReset.Enabled := false;
    MainForm.btnShowInterface.Visible := true;
    if ((ExtensorAnkle.Caption='Ankle Extensor') AND (ExtensorKnee.Caption='Knee Extensor') AND (FlexorKnee.Caption='Knee Flexor') AND (FlexorHip.Caption='Hip Flexor') AND (ExtensorHip.Caption='Hip Extensor')) then
    begin
     theta1:= scrollbar1.Position*pi/180;
     theta2:= scrollbar2.Position*pi/180;
     theta3:= scrollbar3.Position*pi/180;

     thetadot1:= 0;
     thetadot2:= 0;
     thetadot3:= 0;

     thetadotdot1:= 0;
     thetadotdot2:= 0;
     thetadotdot3:= 0;

     anglebef[1]:=0;
     anglebef[2]:=0;
     anglebef[3]:=0;

     angle[1]:= theta1;
     angle[2]:= theta2;
     angle[3]:= theta3;

     vel[1]:= thetadot1;
     vel[2]:= thetadot2;
     vel[3]:= thetadot3;

     accl[1]:= thetadotdot1;
     accl[2]:= thetadotdot2;
     accl[3]:= thetadotdot3;
    end;

    ExtensorAnkle.Caption:='Ankle Extensor';

    timer1.Enabled:=true;
  end else
  if FlexorAnkle.Caption='STOP' then
  begin
    FlexorAnkle.Caption:='Ankle Flexor';
    timer1.Enabled:=false;
  end;
end;

procedure TInterfaceForm.FlexorHipClick(Sender: TObject);
begin
  s1:= 1;
  s2:= 0;
  s3:= 0;
  s4:= 0;
  s5:= 0;
  s6:= 0;

  if FlexorHip.Caption='Hip Flexor' then
  begin
    FlexorHip.Caption:='STOP';
    MainForm.btnReset.Enabled := false;
    MainForm.btnShowInterface.Visible := true;
    if (ExtensorHip.Caption='Hip Extensor') AND (ExtensorKnee.Caption='Knee Extensor') AND (FlexorKnee.Caption='Knee Flexor')AND (FlexorAnkle.Caption='Ankle Flexor') AND (ExtensorAnkle.Caption='Ankle Extensor') then
    begin
      theta1:= scrollbar1.Position*pi/180;
      theta2:= scrollbar2.Position*pi/180;
      theta3:= scrollbar3.Position*pi/180;

      thetadot1:= 0;
      thetadot2:= 0;
      thetadot3:= 0;

      thetadotdot1:= 0;
      thetadotdot2:= 0;
      thetadotdot3:= 0;

      anglebef[1]:=0;
      anglebef[2]:=0;
      anglebef[3]:=0;

      angle[1]:= theta1;
      angle[2]:= theta2;
      angle[3]:= theta3;

      vel[1]:= thetadot1;
      vel[2]:= thetadot2;
      vel[3]:= thetadot3;

      accl[1]:= thetadotdot1;
      accl[2]:= thetadotdot2;
      accl[3]:= thetadotdot3;
    end;

    ExtensorHip.Caption:='Hip Extensor';
    timer1.Enabled:=true;
  end else
  if FlexorHip.Caption='STOP' then
  begin
    FlexorHip.Caption:='Hip Flexor';
    timer1.Enabled:=false;
  end;
end;

procedure TInterfaceForm.FlexorKneeClick(Sender: TObject);
begin
  s1:= 0;
  s2:= 0;
  s3:= 1;
  s4:= 0;
  s5:= 0;
  s6:= 0;

  if FlexorKnee.Caption='Knee Flexor' then
  begin
    FlexorKnee.Caption:='STOP';
    MainForm.btnReset.Enabled := false;
    MainForm.btnShowInterface.Visible := true;
    if (ExtensorKnee.Caption='Knee Extensor') AND (FlexorAnkle.Caption='Ankle Flexor') AND (ExtensorAnkle.Caption='Ankle Extensor') AND (FlexorHip.Caption='Hip Flexor') AND (ExtensorHip.Caption='Hip Extensor') then
    begin
     theta1:= scrollbar1.Position*pi/180;
     theta2:= scrollbar2.Position*pi/180;
     theta3:= scrollbar3.Position*pi/180;

     thetadot1:= 0;
     thetadot2:= 0;
     thetadot3:= 0;

     thetadotdot1:= 0;
     thetadotdot2:= 0;
     thetadotdot3:= 0;

     anglebef[1]:=0;
     anglebef[2]:=0;
     anglebef[3]:=0;

     angle[1]:= theta1;
     angle[2]:= theta2;
     angle[3]:= theta3;

     vel[1]:= thetadot1;
     vel[2]:= thetadot2;
     vel[3]:= thetadot3;

     accl[1]:= thetadotdot1;
     accl[2]:= thetadotdot2;
     accl[3]:= thetadotdot3;
    end;

    ExtensorKnee.Caption:='Knee Extensor';

    timer1.Enabled:=true;
  end else
  if FlexorKnee.Caption='STOP' then
  begin
    FlexorKnee.Caption:='Knee Flexor';
    timer1.Enabled:=false;
  end;
end;

procedure matrixMultiplication(a,b :matrix; n :integer);
var
  i,j,k :integer;
  temp :real;
begin
  for i:= 1 to max do
  begin
    for j:= 1 to n do
    begin
    temp:=0;
      for k:= 1 to max do
      begin
        temp:=temp+a[i,k]*b[k,j];
      end;
    ab[i,j]:=temp;
    end;
  end;
end;

procedure matrixMultiplication1(a :matrix; b :row; n :integer);
var
  i,j :integer;
  temp :real;
begin
  for i:= 1 to max do
  begin
    temp:=0;
    for j:= 1 to max do
    begin
      temp:=temp+a[i,j]*b[j];
    end;
    ab1[i]:=temp;
  end;
end;

procedure matrixInversion(a :matrix; n :integer);
var
  i,j,k :integer;
  factor :real;
  temp :row;
begin
  for i:=1 to n do
    for j:=1 to n do
      if i=j then
        b[i,j]:=1 else
        b[i,j]:=0;

  for i:=1 to n do
  begin
    for j:=i+1 to n do
      if abs (a[i,i])<abs (a[j,i]) then
      begin
        temp:=a[i];
        a[i]:=a[j];
        a[j]:=temp;
        temp:=b[i];
        b[i]:=b[j];
        b[j]:=temp
      end;
      if a[i,i]=0 then Exit;
      factor:=a[i,i];
      for j:=n downto 1 do
      begin
        b[i,j]:=b[i,j]/factor;
        a[i,j]:=a[i,j]/factor
      end;
      for j:=i+1 to n do
      Begin
        factor:=-a[j,i];
        for k:=1 to n do
        Begin
          a[j,k]:=b[j,k]+a[i,k]*factor;
          a[j,k]:=b[j,k]+b[i,k]*factor
        end
      end
  end;

  for i:=n downto 2 do
  begin
    for j:=i-1 downto 1 do
    begin
      factor:=-a[j,i];
      for k:=1 to n do
      begin
        a[j,k]:=a[j,k]+a[i,k]*factor;
        b[j,k]:=b[j,k]+b[i,k]*factor
      end
    end
  end;
end;

procedure TInterfaceForm.motionEquation;
begin
  m[1,1]:=i1+m1*sqr(a1)+i2+m2*(sqr(l1)+sqr(a2)+2*l1*a2*cos(theta2))+i3+m3*(sqr(l1)+sqr(l2)+sqr(a3)+2*l1*l2*cos(theta2)+2*l2*a3*cos(theta3)+2*l1*a3*cos(theta3-theta2));
  m[1,2]:=-i2-m2*(sqr(a2)+l1*a2*cos(theta2))-i3-m3*(sqr(l2)-sqr(a3)-l1*l2*cos(theta2)-2*l2*a3*cos(theta3)-l1*a3*cos(theta3-theta2));
  m[1,3]:=i3+m3*(sqr(a3)-l2*a3*cos(theta3)+l1*a3*cos(theta3-theta2));

  m[2,1]:=-i2-m2*(sqr(a2)+l1*a2*cos(theta2))-i3-m3*(sqr(l2)+sqr(a3)+l1*l2*cos(theta2)+2*l2*a3*cos(theta3)+l1*a3*cos(theta3-theta2));
  m[2,2]:=i2+m2*sqr(a2)+i3+m3*(sqr(l2)+sqr(a3)+2*l2*a3*cos(theta3));
  m[2,3]:=-i3-m3*(sqr(a3)+l2*a3*cos(theta3));

  m[3,1]:=i3+m3*(sqr(a3)+l2*a3*cos(theta3)+l1*a3*cos(theta3-theta2));
  m[3,2]:=-i3-m3*(sqr(a3)+l2*a3*cos(theta3));
  m[3,3]:=i3+m3*sqr(a3);

  c[1,1]:=0;
  c[1,2]:=0;
  c[1,3]:=0;

  c[2,1]:=-m2*l1*a2*thetadot1*sin(theta2)-m3*l1*l2*thetadot1*sin(theta2)+m3*l1*a3*thetadot1*sin(theta3-theta2);
  c[2,2]:=m2*l1*a2*thetadot1*sin(theta2)+m3*l1*a3*thetadot1*sin(theta3-theta2)+m3*l1*l2*thetadot1*sin(theta2);
  c[2,3]:=m3*l1*a3*thetadot1*sin(theta3-theta2);

  c[3,1]:=m2*l2*a3*(2*thetadot2-thetadot1)*sin(theta3)-m3*l1*a3*thetadot1*sin(theta3-theta2);
  c[3,2]:=-m2*l2*a3*thetadot2*sin(theta3)+m3*l1*a3*thetadot1*sin(theta3-theta2);
  c[3,3]:=m2*l2*a3*(thetadot2-thetadot1)*sin(theta3)-m3*l1*a3*thetadot1*sin(theta3-theta2);

  g[1]:=m1*g1*a1*sin(theta1)+m2*g1*(l1*sin(theta1)-a2*sin(theta2-theta1))+m3*g1*(l1*sin(theta1)-l2*sin(theta2-theta1)+a3*sin(theta1-theta2+theta3));
  g[2]:=m2*g1*a2*sin(theta2-theta1)+m3*g1*(l2*sin(theta2-theta1)-a3*sin(theta1-theta2+theta3));
  g[3]:=m3*g1*a3*sin(theta1-theta2+theta3);
end;

procedure TInterfaceForm.Timer1Timer(Sender: TObject);
var
  j :integer;
begin
  t := 0;
  lt1 := lo1;
  lt2 := lo2;
  lt3 := lo3;
  lt4 := lo4;
  lt5 := lo5;
  lt6 := lo6;

  MainForm.HipAngleSeries.AddY(teta1);
  MainForm.KneeAngleSeries.AddY(teta2);
  MainForm.AnkleAngleSeries.AddY(teta3);

  MainForm.Series1.AddY(act1);
  MainForm.Series2.AddY(act2);
  MainForm.Series3.AddY(act3);
  MainForm.Series4.AddY(act4);
  MainForm.Series5.AddY(act5);
  MainForm.Series6.AddY(act6);

  MainForm.IloMuscleForceSeries.AddY(ftot1);
  MainForm.GluMuscleForceSeries.AddY(ftot2);
  MainForm.BSFHMuscleForceSeries.AddY(ftot3);
  MainForm.VasMuscleForceSeries.AddY(ftot4);
  MainForm.SoleusMuscleForceSeries.Add(ftot5);
  MainForm.TibialisMuscleForceSeries.AddY(ftot6);

  MainForm.IloMuscleLenghtSeries.AddY(lc1);
  MainFOrm.GluMuscleLenghtSeries.AddY(lc2);
  MainForm.BSFHMuscleLenghtSeries.AddY(lc3);
  MainForm.VasMuscleLenghtSeries.AddY(lc4);
  MainForm.SoleusMuscleLenghtSeries.AddY(lc5);
  MainForm.TibialisMuscleLenghtSeries.AddY(lc6);

  MainForm.IloMuscle_fl_Series.AddY(fl1);
  MainForm.GluMuscle_fl_Series.AddY(fl2);
  MainForm.BSFHMuscle_fl_Series.AddY(fl3);
  MainForm.VasMuscle_fl_Series.AddY(fl4);
  MainForm.SoleusMuscle_fl_Series.AddY(fl5);
  MainForm.TibialisMuscle_fl_Series.AddY(fl6);

  MainForm.IloMuscle_fv_Series.AddY(fv1);
  MainForm.GluMuscle_fv_Series.AddY(fv2);
  MainForm.BSFHMuscle_fv_Series.AddY(fv3);
  MainForm.VasMuscle_fv_Series.AddY(fv4);
  MainForm.SoleusMuscle_fv_Series.AddY(fv5);
  MainForm.TibialisMuscle_fv_Series.AddY(fv6);

  MainForm.HipTorqueSeries.AddY(torque[1]);
  MainForm.KneeTorqueSeries.AddY(torque[2]);
  MainForm.AnkleTorqueSeries.AddY(torque[3]);
  while t<0.01 do
  begin
    if MainForm.TestModeGroup.ItemIndex = 0 then
    begin
      u1    := 0.5*tanh(5*(s1-0.5)) + 0.5;
      adot1 := ((1/tr)*(u1-act1)) + ((1/tf)*(u1-(act1-(u1-act1))*u1));
      act1  := act1 + adot1*rf1;

      u2    :=0.5*tanh(5*(s2-0.5)) + 0.5;
      adot2 :=((1/tr)*(u2-act2)) + ((1/tf)*(u2-(act2-(u2-act2))*u2));
      act2  :=act2 + adot2*rf2;

      u3    := 0.5*tanh(5*(s3-0.5)) + 0.5;
      adot3 := ((1/tr)*(u3-act3)) + ((1/tf)*(u3-(act3-(u3-act3))*u3));
      act3  := act3 + adot3*rf3;

      u4    :=0.5*tanh(5*(s4-0.5)) + 0.5;
      adot4 :=((1/tr)*(u4-act4)) + ((1/tf)*(u4-(act4-(u4-act4))*u4));
      act4  :=act4 + adot4*rf4;

      u5    := 0.5*tanh(5*(s5-0.5)) + 0.5;
      adot5 := ((1/tr)*(u5-act5)) + ((1/tf)*(u5-(act5-(u5-act5))*u5));
      act5  := act5+adot5*rf5;

      u6    := 0.5*tanh(5*(s6-0.5)) + 0.5;
      adot6 := ((1/tr)*(u6-act6)) + ((1/tf)*(u6-(act6-(u6-act6))*u6));
      act6  := act6 + adot6*rf6;

      lt1:=lt1+(rf1*(anglebef[1]-angle[1]));
      lc1:=lt1;
      if lt1<0 then lt1:=0;

      lt2:=lt2+(rf2*(angle[1]-anglebef[1]));
      lc2:=lt2;
      if lt2<0 then lt2:=0;

      lt3:=lt3+(rf3*(anglebef[2]-angle[2]));
      lc3:=lt3;
      if lt3<0 then lt3:=0;

      lt4:=lt4+(rf4*(angle[2]-anglebef[2]));
      lc4:=lt4;
      if lt4<0 then lt4:=0;

      lt5:=lt5+(rf5*(anglebef[3]-angle[3]));
      lc5:=lt5;
      if lt5<0 then lt5:=0;

      lt6:=lt6+(rf6*(angle[3]-anglebef[3]));
      lc6:=lt6;
      if lt6<0 then lt6:=0;

      {force length}
      fl1:=1-(sqr((lt1-lo1)/(0.5*lo1)));
      fl2:=1-(sqr((lt2-lo2)/(0.5*lo2)));

      fl3:=1-(sqr((lt3-lo3)/(0.5*lo3)));
      if fl3<0 then fl3:=0;

      fl4:=1-(sqr((lt4-lo4)/(0.5*lo4))) ;
      if fl4<0 then fl4:=0;

      fl5:=1-(sqr((lt5-lo5)/(0.5*lo5))) ;
      if fl5<0 then fl5:=0;

      fl6:=1-(sqr((lt6-lo6)/(0.5*lo6))) ;
      if fl6<0 then fl6:=0;

      {force velocity}
      if lt1<=lo1 then fv1:=(vmax1-(rf1*vel[1]))/(vmax1+(rf1*cm*vel[1]))
      else if lt1>lo1 then fv1:=1.3 - (0.3*(vmax1+(cm*vmax1))/(1+((cm*cm)*vel[1]*rf1)));
      if fv1<0 then fv1:=0;

      if lt2<=lo2 then fv2:=(vmax2-(rf2*vel[1]))/(vmax2+(rf2*cm*vel[1]))
      else if lt2>lo2 then fv2:=1.3 - (0.3*(vmax2+(cm*vmax2))/(1+((cm*cm)*vel[1]*rf2)));
      if fv2<0 then fv2:=0;

      if lt3<=lo3 then fv3:=(vmax3-(rf3*vel[2]))/(vmax3+(rf3*cm*vel[2]))
      else if lt3>lo3 then fv3:=1.3 - (0.3*(vmax3+(cm*vmax3))/(1+((cm*cm)*vel[2]*rf3)));
      if fv3<0 then fv3:=0;

      if lt4<=lo4 then fv4:=(vmax4-(rf4*vel[2]))/(vmax4+(rf4*cm*vel[2]))
      else if lt4>lo4 then fv4:=1.3 - (0.3*(vmax4+(cm*vmax4))/(1+((cm*cm)*vel[2]*rf4)));
      if fv4<0 then fv4:=0;

      if lt5<=lo5 then fv5:=(vmax5-(rf5*vel[3]))/(vmax5+(rf5*cm*vel[3]))
      else if lt5>lo5 then fv5:=1.3 - (0.3*(vmax5+(cm*vmax5))/(1+((cm*cm)*vel[3]*rf5)));
      if fv5<0 then fv5:=0;

      if lt6<=lo6 then fv6:=(vmax6-(rf6*vel[3]))/(vmax6+(rf6*cm*vel[3]))
      else if lt6>lo6 then fv6:=1.3 - (0.3*(vmax6+(cm*vmax6))/(1+((cm*cm)*vel[3]*rf6)));
      if fv6<0 then fv6:=0;

      ftot1:= act1*fl1*fv1*fmax1;
      ftot2:= act2*fl2*fv2*fmax2;
      ftot3:= act3*fl3*fv3*fmax3;
      ftot4:= act4*fl4*fv4*fmax4;
      ftot5:= act5*fl5*fv5*fmax5;
      ftot6:= act6*fl6*fv6*fmax6;

      if ftot1>fmax1 then ftot1:=fmax1;
      if ftot2>fmax2 then ftot2:=fmax2;
      if ftot1<0 then ftot1:=0;
      if ftot1<0 then ftot2:=0;

      if angle[1]>=90*pi/180 then ftot1:=0;  //muscle tidak bisa mendorong
      if angle[1]>=90*pi/180 then ftot2:=0;
      if angle[1]<=-30*pi/180 then ftot1:=0;  //muscle tidak bisa mendorong
      if angle[1]<=-30*pi/180 then ftot2:=0;

      if ftot3>fmax3 then ftot3:=fmax3;
      if ftot4>fmax4 then ftot4:=fmax4;
      if ftot3<0 then ftot3:=0;
      if ftot4<0 then ftot4:=0;

      if ftot5>fmax1 then ftot5:=fmax5;
      if ftot6>fmax2 then ftot6:=fmax6;
      if ftot5<0 then ftot5:=0;
      if ftot6<0 then ftot6:=0;

      if angle[2]<=-10*pi/180 then ftot5:=0;  //muscle tidak bisa mendorong
      if angle[2]<=-10*pi/180 then ftot6:=0;

      mpd1 :=kdamp1*rf1*vel[1];
      mpe1 := kpe1*exp(15*(lt1-lo1)-1);

      mpd2 := kdamp2*rf2*vel[1];
      mpe2 := kpe2*exp(15*(lt2-lo2)-1);

      mpd3 := kdamp3*rf3*vel[2];
      mpe3 := kpe3*exp(15*(lt3-lo3)-1);

      mpd4 := kdamp4*rf4*vel[2];
      mpe4 := kpe4*exp(15*(lt4-lo4)-1);

      mpd5 := kdamp5*rf5*vel[3];
      mpe5 := kpe5*exp(15*(lt5-lo5)-1);

      mpd6 := kdamp6*rf6*vel[3];
      mpe6 := kpe6*exp(15*(lt6-lo6)-1);

      mus1 := (ftot1-mpd1+mpe1)*rf1;
      mus2 := (ftot2-mpd2+mpe2)*rf2;
      mus3 := (ftot3-mpd3+mpe3)*rf3;
      mus4 := (ftot4-mpd4+mpe4)*rf4;
      mus5 := (ftot5-mpd5+mpe5)*rf5;
      mus6 := (ftot6-mpd6+mpe6)*rf6;

      psf[1] := -cp1*thetadot1 + k1p1*exp(-k2p1*(theta1-phi11)) - k3p1*exp(-k4p1*(phi21-theta1));
      psf[2] := -cp2*thetadot2 + k1p2*exp(-k2p2*(theta2-phi12)) - k3p2*exp(-k4p2*(phi22-theta2));
      psf[3] := -cp3*thetadot3 + k1p3*exp(-k2p3*(theta3-phi13)) - k3p3*exp(-k4p3*(phi23-theta3));

      torque[1] := mus1 - mus2 + psf[1];
      torque[2] := mus3 - mus4 + psf[2];
      torque[3] := mus5 - mus6 + psf[3];
    end else
    if MainForm.TestModeGroup.ItemIndex = 1 then
    begin
      torque[1] := -cp1*thetadot1 + k1p1*exp(-k2p1*(theta1-phi11)) - k3p1*exp(-k4p1*(phi21-theta1));
      torque[2] := -cp2*thetadot2 + k1p2*exp(-k2p2*(theta2-phi12)) - k3p2*exp(-k4p2*(phi22-theta2));
      torque[3] := -cp3*thetadot3 + k1p3*exp(-k2p3*(theta3-phi13)) - k3p3*exp(-k4p3*(phi23-theta3));
    end;

    //k1
    motionEquation;
    matrixInversion(m,3);
    matrixMultiplication1(b,torque,3);
    term1:=ab1;

    matrixInversion(m,3);
    matrixMultiplication(b,c,3);
    matrixMultiplication1(ab,vel,3);
    term2:=ab1;

    matrixInversion(m,3);
    matrixMultiplication1(b,g,3);
    term3:=ab1;

    for j:= 1 to max do
    begin
      accl[j] := term1[j] + term2[j] - term3[j];
    end;

    for j:= 1 to max do
    begin
      k1[j] := 0.5*dt*accl[j];
    end;

    //k2
    theta1 := theta1 + 0.5*dt*(thetadot1+0.5*k1[1]);
    theta2 := theta2 + 0.5*dt*(thetadot2+0.5*k1[2]);
    theta3 := theta3 + 0.5*dt*(thetadot3+0.5*k1[3]);

    thetadot1 := thetadot1 + k1[1];
    thetadot2 := thetadot2 + k1[2];
    thetadot3 := thetadot3 + k1[3];

    motionEquation;
    matrixInversion(m,3);
    matrixMultiplication1(b,torque,3);
    term1:=ab1;

    matrixInversion(m,3);
    matrixMultiplication(b,c,3);
    matrixMultiplication1(ab,vel,3);
    term2:=ab1;

    matrixInversion(m,3);
    matrixMultiplication1(b,g,3);
    term3:=ab1;

    for j:= 1 to max do
    begin
      accl[j] := term1[j] + term2[j] - term3[j];
    end;

    for j:= 1 to max do
    begin
      k2[j] := 0.5*dt*accl[j];
    end;

    //k3
    theta1 := theta1+0.5*dt*(thetadot1+0.5*k1[1]);
    theta2 := theta2+0.5*dt*(thetadot2+0.5*k1[2]);
    theta3 := theta3+0.5*dt*(thetadot3+0.5*k1[3]);

    thetadot1 := thetadot1+k2[1];
    thetadot2 := thetadot2+k2[2];
    thetadot3 := thetadot3+k2[3];

    motionEquation;
    matrixInversion(m,3);
    matrixMultiplication1(b,torque,3);
    term1:=ab1;

    matrixInversion(m,3);
    matrixMultiplication(b,c,3);
    matrixMultiplication1(ab,vel,3);
    term2:=ab1;

    matrixInversion(m,3);
    matrixMultiplication1(b,g,3);
    term3:=ab1;

    for j:= 1 to max do
    begin
      accl[j]:= term1[j] + term2[j]- term3[j];
    end;

    for j:= 1 to max do
    begin
      k3[j] := 0.5*dt*accl[j];
    end;

    //k4
    theta1 := theta1+dt*(thetadot1+k3[1]);
    theta2 := theta2+dt*(thetadot2+k3[2]);
    theta3 := theta3+dt*(thetadot3+k3[3]);

    thetadot1 := thetadot1+2*k3[1];
    thetadot2 := thetadot2+2*k3[2];
    thetadot3 := thetadot3+2*k3[3];

    motionEquation;
    matrixInversion(m,3);
    matrixMultiplication1(b,torque,3);
    term1:=ab1;

    matrixInversion(m,3);
    matrixMultiplication(b,c,3);
    matrixMultiplication1(ab,vel,3);
    term2:=ab1;

    matrixInversion(m,3);
    matrixMultiplication1(b,g,3);
    term3:=ab1;

    for j:= 1 to max do
    begin
      accl[j] := term1[j] + term2[j] - term3[j];
    end;

    for j:= 1 to max do
    begin
      k4[j] := 0.5*dt*accl[j];
    end;

    for j:= 1 to max do
    begin
      angle[j] := angle[j] + dt*(vel[j]+1/3*(k1[j]+k2[j]+k3[j]));
    end;

    for j:= 1 to max do
    begin
      vel[j] := vel[j] + 1/3*(k1[j]+2*k2[j]+2*k3[j]+k4[j]);
    end;

    anglebef[1] := angle[1];
    anglebef[2] := angle[2];
    anglebef[3] := angle[3];

    if MainForm.ConditionGroup.ItemIndex = 0 then
    begin
      theta1 := 90*pi/180;
    end else
    if MainForm.ConditionGroup.itemindex = 1 then
    begin
      theta1 := angle[1];
    end;
    theta2 := angle[2];
    theta3 := angle[3];

    if MainForm.ConditionGroup.ItemIndex = 0 then
    begin
      thetadot1 := 0;
    end else
    if MainForm.ConditionGroup.ItemIndex = 1 then
    begin
      thetadot1:= vel[1];
    end;
    thetadot2 := vel[2];
    thetadot3 := vel[3];

    if MainForm.ConditionGroup.ItemIndex = 0 then
    begin
      thetadotdot1 := 0;
    end else
    if MainForm.ConditionGroup.ItemIndex = 1 then
    begin
      thetadotdot1 := accl[1];
    end;
    thetadotdot2 := accl[2];
    thetadotdot3 := accl[3];
    t:= t+dt;
  end;

  teta1 := theta1*180/pi;
  teta2 := (theta2)*180/pi;
  teta3 := theta3*180/pi;

  if MainForm.ConditionGroup.ItemIndex = 0 then
  begin
   renderkakiseated;
  end else
  if MainForm.ConditionGroup.ItemIndex = 1 then
  begin
   renderkakistanding;
  end;
end;

procedure TInterfaceForm.ScrollBar1Change(Sender: TObject);
begin
  teta1 := Scrollbar1.Position;
  Edit1.Text := inttostr(Scrollbar1.Position);
  if MainForm.ConditionGroup.ItemIndex = 0 then
  begin
    renderkakiseated;
  end;
  if MainForm.ConditionGroup.ItemIndex = 1 then
  begin
    renderkakistanding;
  end;
end;

procedure TInterfaceForm.ScrollBar2Change(Sender: TObject);
begin
  teta2 := Scrollbar2.Position;
  Edit2.Text := inttostr(Scrollbar2.Position);
  if MainForm.ConditionGroup.ItemIndex = 0 then
  begin
    renderkakiseated;
  end;
  if MainForm.ConditionGroup.ItemIndex = 1 then
  begin
    renderkakistanding;
  end;
end;

procedure TInterfaceForm.ScrollBar3Change(Sender: TObject);
begin
  teta3 := Scrollbar3.Position;
  Edit3.Text := inttostr(Scrollbar3.Position);
  if MainForm.ConditionGroup.ItemIndex = 0 then
  begin
    renderkakiseated;
  end;
  if MainForm.ConditionGroup.ItemIndex = 1 then
  begin
    renderkakistanding;
  end;
end;

procedure TInterfaceForm.SpinEdit1Change(Sender: TObject);
begin
  yaw := SpinEdit1.Value;
end;

procedure TInterfaceForm.SpinEdit2Change(Sender: TObject);
begin
  pitch := SpinEdit2.Value;
end;

procedure TInterfaceForm.SpinEdit3Change(Sender: TObject);
begin
  roll := SpinEdit3.Value;
end;

end.
