{*****************************************
     Autori: Rihards Krislauks
             Andris Stafeckis
             Aigars Steinbergs
******************************************}
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, math, OpenGL, ExtCtrls, Menus, ToolWin, ActnMan, ActnCtrls,
  ActnMenus, ShellApi;

type

  TForm1 = class(TForm)
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Button3: TButton;
    Button4: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Edit2: TEdit;
    Button16: TButton;
    Button17: TButton;
    Button5: TButton;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Button6: TButton;
    Button7: TButton;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    ScrollBar3: TScrollBar;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Edit6: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Edit7: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    MainMenu1: TMainMenu;
    Options1: TMenuItem;
    Cameracontrols1: TMenuItem;
    Rotationcontrols1: TMenuItem;
    File1: TMenuItem;
    Close1: TMenuItem;
    Randomnesscontrols1: TMenuItem;
    Options2: TMenuItem;
    Enablebackfaceculling1: TMenuItem;
    Help1: TMenuItem;
    Readme1: TMenuItem;
    Invertmouse1: TMenuItem;
    Export1: TMenuItem;
    Edit8: TEdit;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure Cameracontrols1Click(Sender: TObject);
    procedure Rotationcontrols1Click(Sender: TObject);
    procedure Randomnesscontrols1Click(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure FormPaint(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure Enablebackfaceculling1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Readme1Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Invertmouse1Click(Sender: TObject);
    procedure Export1Click(Sender: TObject);
    procedure Edit8Change(Sender: TObject);






  private


  public
    { Public declarations }
  end;

const
  light0_position:TGLArrayf4=( 3000, 10000, 3000, 1);//gaismas koordinatas
  crlf:string=#13#10;

type
  virsotnes = array [0..2] of integer;

var
  Form1: TForm1;
  //mas3dOGL: array [0..2048,0..2048] of TGLArrayf3;
  //mas3d2OGL: array [0..2048,0..2048] of TGLArrayf3;
  mas3dOGL: array [0..4096,0..4096] of TGLArrayf3;
  mas3d2OGL: array [0..4096,0..4096] of TGLArrayf3;
  lightProjectionMatrix, lightViewMatrix, cameraProjectionMatrix, cameraViewMatrix: PGLfloat;
  pamazam,pirmais,zimet:boolean;
  l,k,n2,lx,ly,dx,dy,xa,ya,xb,yb,s,s2,s3, detal:integer;
  angle,angle1,angle2,angle3,angle11,angle22,angle33,paX,paY,paZ:real;
  red,green,blue: GLFloat;
  mat_diffuse: TGLArrayf4;
  mat_ambient: TGLArrayf4;
  clicked:boolean;
  MyTextureTex ,shadowMapTexture: glUint;
  invert: integer;


implementation

{$R *.dfm}


{-----------------------------------------------------------
                      OpenGL
------------------------------------------------------------}

{****define pikselu formatu****}

procedure setupPixelFormat(DC:HDC);
const
   pfd:TPIXELFORMATDESCRIPTOR = (
        nSize:sizeof(TPIXELFORMATDESCRIPTOR);	//pfd izmers
        nVersion:1;			                      //versija
        dwFlags:PFD_SUPPORT_OPENGL or PFD_DRAW_TO_WINDOW or
                PFD_DOUBLEBUFFER;	            //atbalstit dubulto buferi
        iPixelType:PFD_TYPE_RGBA;	            //krasas tips
        cColorBits:24;			                  //krasu dzilums
        cRedBits:0; cRedShift:0;
        cGreenBits:0;  cGreenShift:0;
        cBlueBits:0; cBlueShift:0;
        cAlphaBits:0;  cAlphaShift:0;         //neizmanto alfa buferi
        cAccumBits: 0;
        cAccumRedBits: 0;  		                //neizmanto akumulacijas buferi
        cAccumGreenBits: 0;
        cAccumBlueBits: 0;
        cAccumAlphaBits: 0;
        cDepthBits:32;			                  //dziluma buferis
        cStencilBits:0;		                   	//neizmanto stencil buferi
        cAuxBuffers:0;		                  	//neizmanto auxiliary buferi
        iLayerType:PFD_MAIN_PLANE;  	        //main layer
   bReserved: 0;
   dwLayerMask: 0;                            //neizmanto layer, visible, damage maskas
   dwVisibleMask: 0;
   dwDamageMask: 0;
   );
var pixelFormat:integer;
begin
   pixelFormat := ChoosePixelFormat(DC, @pfd);//izvelas saderigu pikselu formatu
   if (pixelFormat = 0) then
        exit;
   if (SetPixelFormat(DC, pixelFormat, @pfd) <> TRUE) then//iestata pikselu formatu
        exit;
end;


{****inicialize OpenGL****}

procedure GLInit;
const
   ambient:  TGLArrayf4=( 0.4, 0.4, 0.4, 0.4);//izkliedeta gaisma
   difuse:  TGLArrayf4=( 0.8, 0.8, 0.8, 0.8);//atstarota gaisma
   specular: TGLArrayf4=( 1, 1, 1, 1);//atspogulota gaisma
   mat_specular: TGLArrayf4 = ( 117/255, 100/255, 47/255, 1 );//materiala atstarojosas ipasibas


begin
   glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);//tiks izmantota smukaka perspektiva
   glMatrixMode(GL_PROJECTION);//nomaina uz projekciju matricu
   glFrustum(-0.1, 0.1, -0.1, 0.1, 0.3, 4000.0);//define skata logu

   glClearColor(240/255, 240/255, 240/255, 0);//iztira krasu buferi
   //glClearColor(236/255, 233/255, 216/255, 0);//iztira krasu buferi

   glMatrixMode(GL_MODELVIEW);//nomaina uz objektu matricu
   glEnable(GL_DEPTH_TEST);//aktivize dziluma buferi

   glFrontFace(GL_CW);//define poligonu priekspusi
   glEnable(GL_CULL_FACE);//aktivize atpakal versto pol. atmesanu
   glCullFace(GL_BACK);//atmet atpakal verstos pol.

   {----materiali----}
   glMaterialfv(GL_front, GL_SPECULAR, @mat_specular);//pieskir atstarojosas ipasibas
   glMaterialf(GL_FRONT, GL_SHININESS, 30.0);//define spidigumu

   {----gaismas----}
   glEnable(GL_LIGHTING);//aktivize gaismu
   glLightfv(GL_LIGHT0, GL_POSITION, @light0_position);//define poziciju
   glLightfv(GL_LIGHT0, GL_AMBIENT, @ambient);//pieskir izkliedeto komponenti
   glLightfv(GL_LIGHT0, GL_diffuse, @difuse);//pieskir atstaroto/izkliedeto komponenti
   glLightfv(GL_LIGHT0, GL_SPECULAR, @specular);//pieskir atstaroto komponenti
   glEnable(GL_LIGHT0);//aktivize 0. gaismu

   {----nosana----}
   glEnable(GL_NORMALIZE);//automatiska vektoru normalizesana
   glShadeModel(GL_flat);//enojuma modelis

   glGenLists(1);//izveido 1 display list
end;


{****darbibas loga radisanas laika****}

procedure TForm1.FormCreate(Sender: TObject);
var DC:HDC;
    RC:HGLRC;
    i:integer;
begin
   DC:=GetDC(Handle);        //iegust mainigo, kas norada uz loga kontekstu
   SetupPixelFormat(DC);     //uzstada izmantojamajam logam atbilstoso pikselu formatu
   RC:=wglCreateContext(DC); //uzstada logam atbilstosu renderesanas kontekstu
   wglMakeCurrent(DC, RC);   //aktivize OpenGL logu
   GLInit;                   //inicialize OpenGL
   Application.UpdateFormatSettings:=false;
   Application.UpdateMetricSettings:=false;
   DecimalSeparator := '.';
end;


{****darbibas loga iznicinasanas laika****}

procedure TForm1.FormDestroy(Sender: TObject);
begin
  glDeleteLists(1,1);//izdzes display list
end;


{****rekina normalvektorus****}

function getNormal(p1,p2,p3:TGLArrayf3):TGLArrayf3;
var a,b:TGLArrayf3;
begin
   //izveido 2 vektorus
   a[0]:=p2[0]-p1[0]; a[1]:=p2[1]-p1[1]; a[2]:=p2[2]-p1[2];
   b[0]:=p3[0]-p1[0]; b[1]:=p3[1]-p1[1]; b[2]:=p3[2]-p1[2];
   //aprekina perpendikularu vektoru ieprieksejiem
   result[0]:=a[1]*b[2]-a[2]*b[1];
   result[1]:=a[2]*b[0]-a[0]*b[2];
   result[2]:=a[0]*b[1]-a[1]*b[0];
end;


{****izveido display list****}

procedure createList;
var i,j:integer;
    norm1,norm2,a1,a2,a3:TGLArrayf3;

begin
  glNewList(1,GL_COMPILE);//izveido jaunu display list
    glBegin(gl_triangles);//sak zimet trijsturus
    for j:=0 to n2-1 do//iet cauri visiem trijsturiem
      for i:=0 to n2-j-1 do
        begin
        norm1:=getNormal(mas3dOGL[i,j],mas3dOGL[i,j+1],mas3dOGL[i+1,j]);//iegust normalvektoru
        glNormal3fv(@norm1);//padod OGL normalvektoru
        a1:=mas3dOGL[i,j]; a2:=mas3dOGL[i+1,j]; a3:=mas3dOGL[i,j+1];//iegust tristuru virsotnu koord.
        glVertex3fv(@a1); glVertex3fv(@a2); glVertex3fv(@a3);
        if i<n2-j-1 then//parbauda vai nav pedejais trijst. kolonna
          begin
          norm1:=getNormal(mas3dOGL[i+1,j],mas3dOGL[i,j+1],mas3dOGL[i+1,j+1]);
          glNormal3fv(@norm1);
          a1:=mas3dOGL[i+1,j]; a2:=mas3dOGL[i+1,j+1]; a3:=mas3dOGL[i,j+1];
          glVertex3fv(@a1); glVertex3fv(@a2); glVertex3fv(@a3);
          end;
        end;
    glEnd;//beidz zimet trijst.
  glEndList;//beidzas display list
end;


{****zime****}

procedure zimeOGL;
var   //norm1,norm2,a1,a2,a3:TGLArrayf3;
      i,j:integer;
begin
  if zimet=true then//parbauda vai drikst zimet
    begin
      glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);//iztira krasu un dziluma buferi

      mat_diffuse[0]:=red; mat_diffuse[1]:=green; mat_diffuse[2]:=blue; mat_diffuse[3]:=1;//pieskir ieprieks definetas krasas
      mat_ambient[0]:=red; mat_ambient[1]:=green; mat_ambient[2]:=blue; mat_ambient[3]:=1;

      glMaterialfv(GL_FRONT, GL_DIFFUSE, @mat_diffuse);//define materiala atstarotas gaismas ipasibas
      glMaterialfv(GL_FRONT, GL_AMBIENT, @mat_ambient);//izkliedetas gaismas ipasibas

      glLoadIdentity;//ielade vienibas matricu


      {----rotacijas----}
      glRotatef(angle22, 1, 0, 0);//rote "kameru" ap Y asi
      glRotatef(angle11, 0, 1, 0);//ap X asi

      glTranslatef(paX, paY, paZ);//parvieto kalnu

      glRotatef(angle1, 0, 1, 0);//rote kalnu ap savu X asi
      glRotatef(angle2, 1, 0, 0);//Y asi
      glRotatef(angle3, 0, 0, 1);//Z asi


      glLightfv(GL_LIGHT0, GL_POSITION, @light0_position);//define gaismas poziciju

      glCallList(1);//ielade geometriju

      SwapBuffers(wglGetCurrentDc);//attelo
    end;
end;


{-----------------------------------------------------------
                     OpenGL beigas
------------------------------------------------------------}

{-----------------------------------------------------------
                     Geometrija
------------------------------------------------------------}

{****inicialize****}

procedure init;
var x1,z1:integer;
begin
  form1.Caption:='Nelku klints';
  randomize;

  {----sakotneja trijstura koordinatas----}
  //punkts 1
  mas3dOGL[0,0,0]:=-400;//X
  mas3dOGL[0,0,1]:=0;//Y
  mas3dOGL[0,0,2]:=-400;//Z
  //punkts 2
  mas3dOGL[0,1,0]:=0;
  mas3dOGL[0,1,1]:=0;
  mas3dOGL[0,1,2]:=400;
  //punkts 3
  mas3dOGL[1,0,0]:=400;
  mas3dOGL[1,0,1]:=0;
  mas3dOGL[1,0,2]:=-400;

  lx:=0;
  ly:=0;

  invert:=1;

  red:=form1.ScrollBar1.position/form1.ScrollBar1.Max;//nolasa materialu krasas
  green:=form1.ScrollBar2.position/form1.ScrollBar2.Max;
  blue:=form1.ScrollBar3.position/form1.ScrollBar3.Max;

  mat_diffuse[0]:=red; mat_diffuse[1]:=green; mat_diffuse[2]:=blue; mat_diffuse[3]:=1;//materialu ipasibas
  mat_ambient[0]:=red; mat_ambient[1]:=green; mat_ambient[2]:=blue; mat_ambient[3]:=1;

  glMaterialfv(GL_FRONT, GL_DIFFUSE, @mat_diffuse);//pieskir ipasibas
  glMaterialfv(GL_FRONT, GL_AMBIENT, @mat_ambient);
end;


{****rekina punktus***}

procedure klintsOGL(n:integer);
var x1,x2,x3,x12,x23,x13,y1,y2,y3,y12,y23,y13,z1,z2,z3,z12,z23,z13:GLfloat;
    i,j,r:integer;
    rd,rd2,rd3,alpha,garums:double;
begin
randomize;
  for i:=0 to round(power(2,n))-1 do//iet cauri visiem trijst klinti
    for j:=0 to round(power(2,n))-i-1 do
      begin
         {----nolassa trijstura punktu koord----}
         x1:=mas3dOGL[i,j,0];
         y1:=mas3dOGL[i,j,1];
         z1:=mas3dOGL[i,j,2];

         x2:=mas3dOGL[i,j+1,0];
         y2:=mas3dOGL[i,j+1,1];
         z2:=mas3dOGL[i,j+1,2];

         x3:=mas3dOGL[i+1,j,0];
         y3:=mas3dOGL[i+1,j,1];
         z3:=mas3dOGL[i+1,j,2];

         rd:=100/s;//nejausibas koeficienti
         rd2:=100/s2;
         rd3:=100/s3;

         garums:=sqrt((x1-x2)*(x1-x2)+(z1-z2)*(z1-z2));
         alpha:=arcsin(abs(z1-z2)/garums);
         x12:=(x1+x2)/2+sin(alpha)*(random(2*round(garums/rd3))-garums/rd3);//jauna viduspunkta X koord.
         z12:=(z1+z2)/2+cos(alpha)*(random(2*round(garums/rd3))-garums/rd3);//Z koord.
         if (j<>0) or (i<>round(power(2,n))-1) or (n=0) then//parbauda vai nav galejais labejais trijst. un vai nav 0. pakape
           begin
             r:=round(abs(y1-y2));//aprekina randoma robezas no augstumu starpibas
             if s=0 then y12:=(y1+y2)/2//parbauda vai randoms nav 0
              else
             y12:=(y1+y2)/2+random(round(r/rd))-r/(2*rd);//aprekina viduspunkta augstumu
           end
           else if (j=0) and (i=round(power(2,n))-1) then//ja ir galejais labejais trijst
             begin
               r:=round(sqrt((x2-x1)*(x2-x1)+(z2-z1)*(z2-z1)));//randoma robezas no malas garuma
               if s=0 then y12:=y1
                else
               y12:=y1+random(round(r/rd2));//aprekina viduspunkta augstumu
             end;

         garums:=sqrt((x2-x3)*(x2-x3)+(z2-z3)*(z2-z3));
         alpha:=arcsin(abs(z2-z3)/garums);
         x23:=(x2+x3)/2+sin(alpha)*(random(2*round(garums/rd3))-garums/rd3);
         z23:=(z2+z3)/2+cos(alpha)*(random(2*round(garums/rd3))-garums/rd3);
         if (i<>0) or (j<>0) or (n=0) then//parbauda vai nav galejais kreisais trijst.
           begin
             r:=round(abs(y2-y3));
             if s=0 then y23:=(y2+y3)/2
              else
             y23:=(y2+y3)/2+random(round(r/rd))-r/(2*rd);
           end
           else if (i=0) and (j=0) then
             begin
               r:=round(sqrt((x3-x2)*(x3-x2)+(z3-z2)*(z3-z2)));
               if s=0 then y23:=y2
                else
               y23:=y2+random(round(r/rd2));
             end;

         garums:=sqrt((x3-x1)*(x3-x1)+(z3-z1)*(z3-z1));
         alpha:=arcsin(abs(z3-z1)/garums);
         x13:=(x3+x1)/2+sin(alpha)*(random(2*round(garums/rd3))-garums/rd3);
         z13:=(z1+z3)/2+cos(alpha)*(random(2*round(garums/rd3))-garums/rd3);
         if (j<>round(power(2,n))-i-1) or (i<>0) or (n=0) then//parbauda vai nav galejais augsejais trijst.
           begin
             r:=round(abs(y3-y1));
             if s=0 then y13:=(y1+y3)/2
              else
             y13:=(y1+y3)/2+random(round(r/rd))-r/(2*rd);
           end
           else if (j=round(power(2,n))-i-1) and (i=0) then
             begin
               r:=round(sqrt((x3-x1)*(x3-x1)+(z3-z1)*(z3-z1)));
               if s=0 then y13:=y1
                else
               y13:=y1+random(round(r/rd2));
             end;




         mas3D2OGL[i*2,j*2,0]:=x1;//saliek vecos un jaunos aprekinatos punktus
         mas3D2OGL[i*2,j*2,1]:=y1;//otra masiva
         mas3D2OGL[i*2,j*2,2]:=z1;

         mas3D2OGL[i*2,j*2+1,0]:=x12;//jaunais punkts starp 1. un 2. punktu
         mas3D2OGL[i*2,j*2+1,1]:=y12;
         mas3D2OGL[i*2,j*2+1,2]:=z12;

         mas3D2OGL[i*2,j*2+2,0]:=x2;
         mas3D2OGL[i*2,j*2+2,1]:=y2;
         mas3D2OGL[i*2,j*2+2,2]:=z2;

         mas3D2OGL[i*2+1,j*2+1,0]:=x23;//starp 2. un 3.
         mas3D2OGL[i*2+1,j*2+1,1]:=y23;
         mas3D2OGL[i*2+1,j*2+1,2]:=z23;

         mas3D2OGL[i*2+2,j*2,0]:=x3;
         mas3D2OGL[i*2+2,j*2,1]:=y3;
         mas3D2OGL[i*2+2,j*2,2]:=z3;

         mas3D2OGL[i*2+1,j*2,0]:=x13;//1. un 3.
         mas3D2OGL[i*2+1,j*2,1]:=y13;
         mas3D2OGL[i*2+1,j*2,2]:=z13;

      end;


   for i:=0 to round(power(2,n+2))-1 do//parliek punktus no 2. masiva pimaja
    for j := 0 to round(power(2,n+2))-i-1 do
      begin
        mas3dOGL[i,j,0]:=mas3d2OGL[i,j,0];
        mas3dOGL[i,j,1]:=mas3d2OGL[i,j,1];
        mas3dOGL[i,j,2]:=mas3d2OGL[i,j,2];
      end;

  if (pamazam=false) and (n<=l) and (n<=9) then//parbauda vai jaizsauc sevi rekursivi
    klintsOGL(n+1);                            // un vai zimejot "pamazam" nav sasniegta max pakape

end;
{-----------------------------------------------------------------
                 Geometrijas beigas
------------------------------------------------------------------}

{------------------------------------------------------------------
                  Papildus lietas
-------------------------------------------------------------------}

procedure exportOBJAtsev;//obj faila trijsturiem nav kopigu punktu (alternat)
var f: text;
    i,j,trijst:integer;
    norm1: TGLArrayf3;
    a1, a2, a3: TGLArrayf3;
    r:real;
    vert, norm, face: string;
begin
  trijst:=0;

  for j:=0 to n2-1 do//iet cauri visiem trijsturiem
      for i:=0 to n2-j-1 do
        begin
          trijst:=trijst+1;//skaita trijsturus

          norm1:=getNormal(mas3dOGL[i,j],mas3dOGL[i,j+1],mas3dOGL[i+1,j]);//iegust normalvektoru
          a1:=mas3dOGL[i,j]; a2:=mas3dOGL[i+1,j]; a3:=mas3dOGL[i,j+1];//iegust tristuru virsotnu koord.

          vert:=vert+'v '+floattostr(a3[0])+' '+floattostr(a3[1])+' '+floattostr(a3[2])+crlf;// .OBJ faila define virsotnes
          vert:=vert+'v '+floattostr(a2[0])+' '+floattostr(a2[1])+' '+floattostr(a2[2])+crlf;
          vert:=vert+'v '+floattostr(a1[0])+' '+floattostr(a1[1])+' '+floattostr(a1[2])+crlf;

          norm:=norm+'vn '+floattostr(norm1[0])+' '+floattostr(norm1[1])+' '+floattostr((norm1[2]))+crlf;// define normalvektorus

          face:=face+'f '+inttostr(trijst*3-2)+'//'+inttostr(trijst)+' '  //define poligonus
            +inttostr(trijst*3-1)+'//'+inttostr(trijst)+' '
            +inttostr(trijst*3)+'//'+inttostr(trijst)+crlf;


          if i<n2-j-1 then//parbauda vai nav pedejais trijst. kolonna
            begin
              trijst:=trijst+1;

              norm1:=getNormal(mas3dOGL[i+1,j],mas3dOGL[i,j+1],mas3dOGL[i+1,j+1]);
              a1:=mas3dOGL[i+1,j]; a2:=mas3dOGL[i+1,j+1]; a3:=mas3dOGL[i,j+1];

              vert:=vert+'v '+floattostr(a3[0])+' '+floattostr(a3[1])+' '+floattostr(a3[2])+crlf;// .OBJ faila define virsotnes
              vert:=vert+'v '+floattostr(a2[0])+' '+floattostr(a2[1])+' '+floattostr(a2[2])+crlf;
              vert:=vert+'v '+floattostr(a1[0])+' '+floattostr(a1[1])+' '+floattostr(a1[2])+crlf;

              norm:=norm+'vn '+floattostr(norm1[0])+' '+floattostr(norm1[1])+' '+floattostr((norm1[2]))+crlf;// define normalvektorus

              face:=face+'f '+inttostr(trijst*3-2)+'//'+inttostr(trijst)+' '
                +inttostr(trijst*3-1)+'//'+inttostr(trijst)+' '
                +inttostr(trijst*3)+'//'+inttostr(trijst)+crlf;
            end;
        end;
  assign(f,'klints2.obj');
  rewrite(f);
  writeln(f,'g klints'+crlf);
  writeln(f, vert);
  writeln(f, norm);
  writeln(f, face);
  close(f);

end;

function atrastVirs(num, detal: integer; up: boolean): virsotnes;//atrod virsotnes trijsturim
var  virs1, virs2, virs3, atnemt, rinda, num2: integer;
begin

   num2:=num;//pagaidu mainigais aprekiniem
   rinda:=0;//norada kura rinda ir trijst
   atnemt:=round(power(2,detal))+1;// skaitis kada ir novirze starp punktiem viena kolona, bet dazadas rindas

    while (num2-(atnemt-1)>0) do//rekina novirzi
      begin
        rinda:=rinda+1;
        atnemt:=atnemt-1;
        num2:=num2-atnemt;
      end;
    if up then//skiro uz augsu un apaksu pagrieztos trijst
      begin
        virs1:=num+rinda;
        virs2:=virs1+1;
        virs3:=virs1+atnemt;
      end
    else
      begin
        virs1:=num+rinda+1;
        virs2:=virs1+atnemt;
        virs3:=virs2-1;
      end;
    atrastVirs[0]:=virs1;//atgriez virs numurus
    atrastVirs[1]:=virs2;
    atrastVirs[2]:=virs3;
end;

procedure exportOBJ;//eksporte kalnu (trijst ar kopigam malam)
var f: text;
    i,j,trijst,trijstAlt:integer;
    norm1: TGLArrayf3;
    a1, a2, a3: TGLArrayf3;
    r:real;
    vert, norm, face: string;
    virs: virsotnes;
begin
  trijst:=0;
  trijstAlt:=0;
  //writeln(f,'');

  for j:=0 to n2-1 do//iet cauri visiem trijsturiem
      for i:=0 to n2-j-1 do
        begin
          trijst:=trijst+1;//skaita trijsturus
          trijstAlt:=trijstAlt+1;
          norm1:=getNormal(mas3dOGL[i,j],mas3dOGL[i,j+1],mas3dOGL[i+1,j]);//iegust normalvektoru
          a1:=mas3dOGL[i,j]; a2:=mas3dOGL[i+1,j]; a3:=mas3dOGL[i,j+1];//iegust tristuru virsotnu koord.

          vert:=vert+'v '+floattostr(a1[0])+' '+floattostr(a1[1])+' '+floattostr(a1[2])+crlf;
          if i=n2-j-1 then vert:=vert+'v '+floattostr(a2[0])+' '+floattostr(a2[1])+' '+floattostr(a2[2])+crlf;

          norm:=norm+'vn '+floattostr(norm1[0])+' '+floattostr(norm1[1])+' '+floattostr((norm1[2]))+crlf;// define normalvektorus

          virs:= atrastVirs(trijstAlt, detal, true);
          face:=face+'f '+inttostr(virs[2])+'//'+inttostr(trijst)+' '  //define poligonus
            +inttostr(virs[1])+'//'+inttostr(trijst)+' '
            +inttostr(virs[0])+'//'+inttostr(trijst)+crlf;
          if i<n2-j-1 then//parbauda vai nav pedejais trijst. kolonna
            begin
              trijst:=trijst+1;

              norm1:=getNormal(mas3dOGL[i+1,j],mas3dOGL[i,j+1],mas3dOGL[i+1,j+1]);
              a1:=mas3dOGL[i+1,j]; a2:=mas3dOGL[i+1,j+1]; a3:=mas3dOGL[i,j+1];

              //vert:=vert+'v '+floattostr(a1[0])+' '+floattostr(a1[1])+' '+floattostr(a1[2])+crlf;

              norm:=norm+'vn '+floattostr(norm1[0])+' '+floattostr(norm1[1])+' '+floattostr((norm1[2]))+crlf;// define normalvektorus

              virs:= atrastVirs(trijstAlt, detal, false);
              face:=face+'f '+inttostr(virs[2])+'//'+inttostr(trijst)+' '  //define poligonus
                +inttostr(virs[1])+'//'+inttostr(trijst)+' '
                +inttostr(virs[0])+'//'+inttostr(trijst)+crlf;
            end;
        end;
  vert:=vert+'v '+floattostr(a3[0])+' '+floattostr(a3[1])+' '+floattostr(a3[2])+crlf;
{  for j:=0 to n2-1 do//iet cauri visiem trijsturiem
      for i:=0 to n2-j-1 do
        begin
          face:=face+'f '+inttostr(trijst*3-2)+'//'+inttostr(trijst)+' '  //define poligonus
            +inttostr(trijst*3-1)+'//'+inttostr(trijst)+' '
            +inttostr(trijst*3)+'//'+inttostr(trijst)+crlf;
        end;
 }
  assign(f,'klints.obj');
  rewrite(f);
  writeln(f,'g klints'+crlf);
  writeln(f, vert);
  writeln(f, norm);
  writeln(f, face);
  close(f);

end;


{------------------------------------------------------------------
                  Papildus lietas beigas
-------------------------------------------------------------------}

{----------------------------------------------------------------
                       Pogas
----------------------------------------------------------------}

{****nodzes****}

procedure TForm1.Button2Click(Sender: TObject);

begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);//iztira krasu, dziluma buferi
  InvalidateRect(self.Handle ,nil,true);//notira canvas
  glClearColor(240/255, 240/255, 240/255, 0);//piepilda krasu buferi ar ekrana krasu

  init;//inicialize sakotnejo trijst
  k:=0;//pogas pamazam skaititajs tiek atgriezts uz 0
  n2:=0;//nomaina detalizacijas pakapi uz 0

  pamazam:=false;//nekamreiz izsaucot klintsOGL() ta stradas rekursivi
  pirmais:=true;//nakamreiz uzspiezot `pamazam` zimes sakotnejo trijst
  zimet:=false;//aizliedz zimet (ierobezo eventu OnPaint)
end;


{****zime kalnu ar noteikto det. pakapi****}

procedure TForm1.Button3Click(Sender: TObject);
var tikz,tikz2:cardinal;
begin
  s:=strtoint(edit6.text);//nolasa kalnainuma random koeficientu
  s2:=strtoint(edit7.text);//nolasa vispareja augstuma random koeficientu
  s3:=strtoint(edit8.Text);//nolasa horizontalas nobides koeficientu;
  l:=strtoint(edit1.Text)-2;//nolasa detalizacijas pakapi (-2 ir ,jo projekcija zime par 2 pakapem velaku trijsturi, neka norada `detalizacijas pakepe`)
  detal:=strtoint(edit1.text);//noskaidro trijsturu skaitu
  n2:=round(power(2,strtoint(edit1.Text)));//nolasa kalna malas garumu punktos

  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);//iztira krasu un dziluma buferi
  init;//inicialize sakotnejo trijst

  zimet:=true;//atlauj zimet
  pamazam:=false;//liek klintsOGL izsaukt sevi rekursivi
  pirmais:=true;//nakamreiz uzspiezot `pamazam` zimes sakotnejo trijst
  k:=0;//pamazam skaititajs=0
  //setlength(mas3dOGL,[0..8192,0..8192]);
  //setlength(mas3d2OGL,[0..8192,0..8192]);
  tikz:=GetTickCount;//nolasa laiku no sistemas startupa
  klintsOGL(0);//aprekina punktus
  caption:='rekina ' + IntToStr(GetTickCount-tikz) + ' msecs';//virsraksts:= laiks no startupa - laiks no startupa pirms klints izsauksanas

  tikz2:=GetTickCount;
  createList;//izveido dizplay list
  zimeOGL;//uzzime kalnu
  caption:=caption+', zime '+inttostr(gettickcount-tikz2)+' msecs';//rekina cik ilgi zime
end;


{****zime pamazam****}

procedure TForm1.Button4Click(Sender: TObject);
begin
  zimet:=true;//atlauj zimet
  s:=strtoint(edit6.text);//nolasa random koeficientus
  s2:=strtoint(edit7.text);
  s3:=strtoint(edit8.text);

  if k<11 then //skatas vai netiks parsniegts masiva lielums
  begin
    pamazam:=true;//kalns neizsauks sevi rekursivi
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);//iztira krasu, dziluma buferi

    if pirmais=true then//parbauda vai jazime sakotnejais trijst
      begin//zine sakotnejo trijst
        init;
        pirmais:=false;
        n2:=1;
        createList;
        zimeOGL;
      end
    else
      begin//zime kalnu
        n2:=n2*2;
        klintsOGL(k);
        createList;
        zimeOGL;
        k:=k+1;
      end;

  end;
end;

{****atgriez "kameru" sakotneja punkta****}
procedure TForm1.Button5Click(Sender: TObject);
begin
  {----parvietojums----}
  paz:=-1500;
  pax:=0;
  pay:=0;

  {----lenki----}
  angle1:=0;
  angle2:=0;
  angle3:=0;
  angle11:=0;
  angle22:=0;

  zimeogl;
end;

{****parvietojas uz prieksu****}
procedure TForm1.Button6Click(Sender: TObject);
begin
  pax:=pax-sin(angle11*pi/180)*strtofloat(edit2.text)*5*cos(angle22*pi/180);
  paz:=paz+cos(angle11*pi/180)*strtofloat(edit2.text)*5*cos(angle22*pi/180);
  pay:=pay+sin(angle22*pi/180)*strtofloat(edit2.text)*5;

  zimeOGL;
end;

{****parvietojas uz aizmuguri****}
procedure TForm1.Button7Click(Sender: TObject);
begin
  pax:=pax+sin(angle11*pi/180)*strtofloat(edit2.text)*5*cos(angle22*pi/180);
  paz:=paz-cos(angle11*pi/180)*strtofloat(edit2.text)*5*cos(angle22*pi/180);
  pay:=pay-sin(angle22*pi/180)*strtofloat(edit2.text)*5;

  zimeOGL;
end;

{****griez kameru uz augsu****}
procedure TForm1.Button8Click(Sender: TObject);
begin
  angle22:=angle22-strtofloat(edit2.text)/5;
  zimeOGL;
  if angle22<-360 then angle22:=angle22+360;
end;

{****griez kameru uz leju****}
procedure TForm1.Button9Click(Sender: TObject);
begin
  angle22:=angle22+strtofloat(edit2.text)/5;
  zimeOGL;
  if angle22>360 then angle22:=angle22-360;
end;

{****paslepj/parada kameras kontrolus****}
procedure TForm1.Cameracontrols1Click(Sender: TObject);
begin
  if button8.Visible=false then
    begin
      button8.Visible:=true;
      button9.Visible:=true;
      button10.Visible:=true;
      button11.Visible:=true;
    end
  else
    begin
      button8.Visible:=false;
      button9.Visible:=false;
      button10.Visible:=false;
      button11.Visible:=false;
    end;
end;

{****aizver logu****}
procedure TForm1.Close1Click(Sender: TObject);
begin
  form1.Close;
end;

{****kontrole detalizacijas pakapes ievadi****}
procedure TForm1.Edit1Change(Sender: TObject);
begin
  if (edit1.text<>'') then
    begin
      if edit1.text<'0' then edit1.text:='7';
      if edit1.text>'9' then edit1.text:='7';
      if strtoint(edit1.text)>11 then edit1.text:='11';
    end;
end;

{****kontrole parvietosanas atruma ievadi****}
procedure TForm1.Edit2Change(Sender: TObject);
var s:string;
begin
  if edit2.text='' then edit2.text:='1';
  if (edit2.Text[length(edit2.Text)]<'0') or (edit2.Text[length(edit2.Text)]>'9') then
    begin
      s:=edit2.text;
      SetLength(s,length(s)-1);
      edit2.text:=s;
      button3.SetFocus;
    end;
end;

{****kontrole kalniguma random limena ievadi****}
procedure TForm1.Edit6Change(Sender: TObject);
var s:string;
begin
  if edit6.text='' then edit6.text:='1';
  if (edit6.Text[length(edit6.Text)]<'0') or (edit6.Text[length(edit6.Text)]>'9') then
    begin
      s:=edit6.text;
      SetLength(s,length(s)-1);
      edit6.text:=s;
      button3.SetFocus;
    end;
end;

{****kontrole vispareja augstuma random limena ievadi****}
procedure TForm1.Edit7Change(Sender: TObject);
var s:string;
begin
  if edit7.text='' then edit7.text:='1';
  if (edit7.Text[length(edit7.Text)]<'0') or (edit7.Text[length(edit7.Text)]>'9') then
    begin
      s:=edit7.text;
      SetLength(s,length(s)-1);
      edit7.text:=s;
      button3.SetFocus;
    end;
end;

procedure TForm1.Edit8Change(Sender: TObject);
var s:string;
begin
if edit8.text='' then edit8.text:='1';
  if (edit8.Text[length(edit8.Text)]<'0') or (edit8.Text[length(edit8.Text)]>'9') then
    begin
      s:=edit8.text;
      SetLength(s,length(s)-1);
      edit8.text:=s;
      button3.SetFocus;
    end;
end;

{****aktivize back face culling****}
procedure TForm1.Enablebackfaceculling1Click(Sender: TObject);
begin
  if glIsEnabled(GL_CULL_FACE)= true then
    glDisable(GL_CULL_FACE)
  else glEnable(GL_CULL_FACE);
  zimeOGL;
end;

procedure TForm1.Export1Click(Sender: TObject);
begin
  exportOBJ;
end;

{****inicialize programmu****}
procedure TForm1.FormActivate(Sender: TObject);
begin
  init;
  pirmais:=true;
  k:=0;
  n2:=0;

  paz:=-1500;
  pay:=0;
  pax:=0;
end;

{****griez kameru pa labi****}
procedure TForm1.Button10Click(Sender: TObject);
begin
  angle11:=angle11+strtofloat(edit2.text)/5;
  zimeOGL;
  if angle11>360 then angle11:=angle11-360;
end;

{****griez kameru pa kreisi****}
procedure TForm1.Button11Click(Sender: TObject);
begin
  angle11:=angle11-strtofloat(edit2.text)/5;
  zimeOGL;
  if angle11<-360 then angle11:=angle11+360;
end;

{****rote ap Y asi****}
procedure TForm1.Button12Click(Sender: TObject);
begin
angle1:=angle1+strtofloat(edit2.text);
zimeOGL;
if angle1>360 then angle1:=angle1-360;
end;

{****rote ap Y asi****}
procedure TForm1.Button13Click(Sender: TObject);
begin
angle1:=angle1-strtofloat(edit2.text);
zimeOGL;
if angle1<-360 then angle1:=angle1+360;
end;

{****rote ap X asi****}
procedure TForm1.Button14Click(Sender: TObject);
begin
  angle2:=angle2-strtofloat(edit2.text);
  zimeOGL;
  if angle2<-360 then angle2:=angle2+360;
end;

{****rote ap X asi****}
procedure TForm1.Button15Click(Sender: TObject);
begin
  angle2:=angle2+strtofloat(edit2.text);
  zimeOGL;
  if angle2>360 then angle2:=angle2-360;
end;

{****rote ap Z asi****}
procedure TForm1.Button16Click(Sender: TObject);
begin
  angle3:=angle3-strtofloat(edit2.text);
  zimeOGL;
  if angle3>360 then angle3:=angle3-360;
end;

{****rote ap Z asi****}
procedure TForm1.Button17Click(Sender: TObject);
begin
  angle3:=angle3+strtofloat(edit2.text);
  zimeOGL;
  if angle3>360 then angle3:=angle3-360;
end;

{****nolasa koord. kad nospiesta pele****}
procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  xa:=x;
  ya:=y;
  clicked:=true;
end;

{****kustina kameru pelei kustoties****}
procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var t:integer;
begin
  if clicked then//parbauda vai peles poga ir nospiesta
    begin
      xb:=x;
      yb:=y;

      {----rote kalnu----}
      if (ssCtrl in Shift) then//parbauda vai nospiests Ctrl
        begin
          angle1:=((angle1+((xb-xa)/400)));

          if (abs(angle1)<=45)or(abs(angle1)>=315) then
            angle2:=((angle2-((ya-yb)/400)));

          if (abs(angle1)>45)and(abs(angle1)<135) then
            if angle1>0 then
              angle3:=((angle3+((yb-ya)/400)))
            else  angle3:=((angle3-((yb-ya)/400))) ;

          if (abs(angle1)>=135)and(abs(angle1)<=225) then
            angle2:=((angle2+((ya-yb)/400))) ;

          if (abs(angle1)>225)and(abs(angle1)<315) then
            if angle1>0 then
              angle3:=((angle3-((yb-ya)/400)))
            else  angle3:=((angle3+((yb-ya)/400))) ;

          if angle1>360 then angle1:=angle1-360;
          if angle1<-360 then angle1:=angle1+360;
          if angle2>360 then angle2:=angle2-360;
          if angle2<-360 then angle2:=angle2+360;
          if angle3>360 then angle3:=angle3-360;
          if angle3<-360 then angle3:=angle3+360;

          edit3.text:=inttostr(round(angle1));
          edit4.text:=inttostr(round(angle2));
          edit5.text:=inttostr(round(angle3));

          zimeOGL;
        end

      {----griez kameru----}
      else
        begin
          angle11:=((angle11+((xb-xa)/500)*invert));//aprekina kameras pagrieziena
          angle22:=((angle22+((yb-ya)/500)*invert));//lenkus no peles kustibas

          if angle11>360 then angle11:=angle11-360;
          if angle11<-360 then angle11:=angle11+360;
          if angle22>360 then angle22:=angle22-360;
          if angle22<-360 then angle22:=angle22+360;

          zimeOGL;
        end;
    end;

end;

{****atzime, ja atlaista pele****}
procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var t:integer;
begin
  clicked:=false;
end;

{****atjauno attelu****}
procedure TForm1.FormPaint(Sender: TObject);
begin
  if zimet=true then zimeogl;
end;

{****inverte kameru****}
procedure TForm1.Invertmouse1Click(Sender: TObject);
begin
  if invert=1 then
    invert:=-1
  else invert:=1;
end;

{****parada/paslepj random kontrolus****}
procedure TForm1.Randomnesscontrols1Click(Sender: TObject);
begin
  if edit6.Visible=true then
    begin
      edit6.Visible:=false;
      edit7.Visible:=false;
      label2.Visible:=false;
      label3.Visible:=false;
      label4.Visible:=false;
      label5.Visible:=false;
    end
  else
    begin
      edit6.Visible:=true;
      edit7.Visible:=true;
      label2.Visible:=true;
      label3.Visible:=true;
      label4.Visible:=true;
      label5.Visible:=true;
    end;
end;

{****parada readme.txt****}
procedure TForm1.Readme1Click(Sender: TObject);
begin
    ShellExecute(Handle,'open', 'notepad.exe','Readme.txt', nil, SW_SHOWNORMAL);
end;

{****parada/paslepj rotacijas kontrolus****}
procedure TForm1.Rotationcontrols1Click(Sender: TObject);
begin
  if button12.Visible=false then
    begin
      button12.Visible:=true;
      button13.Visible:=true;
      button14.Visible:=true;
      button15.Visible:=true;
      button16.Visible:=true;
      button17.Visible:=true;
    end
  else
    begin
      button12.Visible:=false;
      button13.Visible:=false;
      button14.Visible:=false;
      button15.Visible:=false;
      button16.Visible:=false;
      button17.Visible:=false;
  end;
end;

{****nolasa materialu krasu no scrool bar****}
procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  red:=ScrollBar1.position/ScrollBar1.Max;
  zimeOGL;
end;

{****nolasa materialu krasu no scrool bar****}
procedure TForm1.ScrollBar2Change(Sender: TObject);
begin
  green:=ScrollBar2.position/ScrollBar1.Max;
  zimeOGL;
end;

{****nolasa materialu krasu no scrool bar****}
procedure TForm1.ScrollBar3Change(Sender: TObject);
begin
  blue:=ScrollBar3.position/ScrollBar1.Max;
  zimeOGL;
end;

{****kontrole loga izmera mainu****}
procedure TForm1.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
var DC:HDC;
    RC:HGLRC;
    i:integer;
begin
  if newheight>newwidth then//aprekina skata loga izmerus no garakas malas
    glViewport(-round((newHeight-newwidth)/2), 0, newHeight, newHeight)
  else glViewport(0, -round((newWidth-newheight)/2), newWidth, newWidth);

  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  glFrustum(-0.1, 0.1, -0.1, 0.1, 0.3, 4000.0);//no jauna nodefine skata telpu

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();

  zimeOGL;
end;

{****reage uz klaviaturas ievadi****}
procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var v:real;
begin
  v:=strtofloat(edit2.text);
  case key of
  87://W
    begin
      pax:=pax-sin(angle11*pi/180)*strtofloat(edit2.text)*v*cos(angle22*pi/180);
      paz:=paz+cos(angle11*pi/180)*strtofloat(edit2.text)*v*cos(angle22*pi/180);
      pay:=pay+sin(angle22*pi/180)*strtofloat(edit2.text)*v;
    end;
  83://S
    begin
      pax:=pax+sin(angle11*pi/180)*strtofloat(edit2.text)*v*cos(angle22*pi/180);
      paz:=paz-cos(angle11*pi/180)*strtofloat(edit2.text)*v*cos(angle22*pi/180);
      pay:=pay-sin(angle22*pi/180)*strtofloat(edit2.text)*v;
    end;
  68://D
    begin
      pax:=pax-sin(angle11*pi/180+pi/2)*strtofloat(edit2.text)*v*cos(angle22*pi/180);
      paz:=paz+cos(angle11*pi/180+pi/2)*strtofloat(edit2.text)*v*cos(angle22*pi/180);
      pay:=pay+sin(angle22*pi/180)*strtofloat(edit2.text)*v;
    end;
  65://A
    begin
      pax:=pax-sin(angle11*pi/180-pi/2)*strtofloat(edit2.text)*v*cos(angle22*pi/180);
      paz:=paz+cos(angle11*pi/180-pi/2)*strtofloat(edit2.text)*v*cos(angle22*pi/180);
      pay:=pay+sin(angle22*pi/180)*strtofloat(edit2.text)*v;
    end;
  69://E
    begin
      pax:=pax-sin(angle11*pi/180)*strtofloat(edit2.text)*v*cos(angle22*pi/180-pi/2);
      paz:=paz+cos(angle11*pi/180)*strtofloat(edit2.text)*v*cos(angle22*pi/180-pi/2);
      pay:=pay+sin(angle22*pi/180-pi/2)*strtofloat(edit2.text)*v;
    end;
  81://Q
    begin
      pax:=pax-sin(angle11*pi/180)*strtofloat(edit2.text)*v*cos(angle22*pi/180+pi/2);
      paz:=paz+cos(angle11*pi/180)*strtofloat(edit2.text)*v*cos(angle22*pi/180+pi/2);
      pay:=pay+sin(angle22*pi/180+pi/2)*strtofloat(edit2.text)*v;
    end;
  end;
  zimeOGL;
end;
{--------------------------------------------------
               Pogas beigas
---------------------------------------------------}
end.
