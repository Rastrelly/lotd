unit UEDmapedit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,UED_main,
  Vcl.Buttons, Vcl.Menus, ShellAPI, ComObj;

type
  TForm2 = class(TForm)
    Timer1: TTimer;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    New1: TMenuItem;
    Save1: TMenuItem;
    Open1: TMenuItem;
    Map1: TMenuItem;
    Build1: TMenuItem;
    Panel2: TPanel;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    GroupBox5: TGroupBox;
    Label7: TLabel;
    Edit15: TEdit;
    Button6: TButton;
    Panel4: TPanel;
    GroupBox4: TGroupBox;
    ScrMemo: TMemo;
    GroupBox7: TGroupBox;
    CheckBox4: TCheckBox;
    Edit3: TEdit;
    ComboBox3: TComboBox;
    Label18: TLabel;
    Edit4: TEdit;
    Label19: TLabel;
    Edit6: TEdit;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Label16: TLabel;
    Button2: TButton;
    Button1: TButton;
    Button3: TButton;
    Button8: TButton;
    GroupBox8: TGroupBox;
    ComboBox1: TComboBox;
    Button7: TButton;
    ComboBox2: TComboBox;
    Label11: TLabel;
    Edit22: TEdit;
    Edit21: TEdit;
    Edit20: TEdit;
    Label10: TLabel;
    Edit19: TEdit;
    CheckBox9: TCheckBox;
    Button10: TButton;
    Edit18: TEdit;
    Edit17: TEdit;
    Edit16: TEdit;
    CheckBox8: TCheckBox;
    Label9: TLabel;
    Button12: TButton;
    Button13: TButton;
    Button22: TButton;
    Button23: TButton;
    Button24: TButton;
    Editors1: TMenuItem;
    Variableeditor1: TMenuItem;
    exteditor1: TMenuItem;
    Itemeditor1: TMenuItem;
    Cardeditor1: TMenuItem;
    Charactereditor1: TMenuItem;
    Label12: TLabel;
    ComboBox4: TComboBox;
    CheckBox10: TCheckBox;
    Edit34: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Edit35: TEdit;
    Edit36: TEdit;
    Edit37: TEdit;
    Edit38: TEdit;
    Edit39: TEdit;
    Edit40: TEdit;
    Button29: TButton;
    Button30: TButton;
    Button31: TButton;
    BufferedCellData1: TMenuItem;
    PerkEditor1: TMenuItem;
    Button32: TButton;
    Random1: TMenuItem;
    Panel5: TPanel;
    Image1: TImage;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    Panel6: TPanel;
    GroupBox3: TGroupBox;
    Label8: TLabel;
    Label21: TLabel;
    ComboBox8: TComboBox;
    Edit28: TEdit;
    Edit29: TEdit;
    Edit30: TEdit;
    Button25: TButton;
    Button26: TButton;
    Edit31: TEdit;
    Edit32: TEdit;
    Edit33: TEdit;
    Button27: TButton;
    Button34: TButton;
    Button35: TButton;
    Splitter1: TSplitter;
    Label15: TLabel;
    Edit23: TEdit;
    Button28: TButton;
    Button19: TButton;
    Button20: TButton;
    Label20: TLabel;
    Edit26: TEdit;
    Edit27: TEdit;
    Label17: TLabel;
    Edit25: TEdit;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Button4: TButton;
    Button5: TButton;
    Button11: TButton;
    GroupBox10: TGroupBox;
    Label2: TLabel;
    Label14: TLabel;
    Label1: TLabel;
    Edit7: TEdit;
    Button14: TButton;
    Edit2: TEdit;
    Edit1: TEdit;
    Button18: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox5: TCheckBox;
    Edit5: TEdit;
    GroupBox9: TGroupBox;
    Label3: TLabel;
    Label13: TLabel;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    Button9: TButton;
    Button21: TButton;
    Edit8: TComboBox;
    Button33: TButton;
    ComboBox5: TComboBox;
    ComboBox6: TComboBox;
    ComboBox7: TComboBox;
    Panel7: TPanel;
    GroupBox6: TGroupBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    CheckBox11: TCheckBox;
    GroupBox11: TGroupBox;
    Label25: TLabel;
    Button36: TButton;
    MonsterListEditor1: TMenuItem;
    N1: TMenuItem;
    Debugmenu1: TMenuItem;
    Help1: TMenuItem;
    Scriptingreference1: TMenuItem;
    Button37: TButton;
    Button38: TButton;
    Freemesheditor1: TMenuItem;
    Exportdatabase1: TMenuItem;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Label26: TLabel;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    LightSourceEditor1: TMenuItem;
    Label27: TLabel;
    Edit41: TEdit;
    AutoGetDoorAngles1: TMenuItem;
    SpeedButton13: TSpeedButton;
    oggleEditView1: TMenuItem;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    Exportcarddatabase1: TMenuItem;
    EcportMapImage1: TMenuItem;
    SaveDialog2: TSaveDialog;
    Button39: TButton;
    Label28: TLabel;
    Edit42: TEdit;
    Label29: TLabel;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    Edit43: TEdit;
    Edit44: TEdit;
    Button40: TButton;
    Edit24: TComboBox;
    CheckBox19: TCheckBox;
    Label30: TLabel;
    Edit45: TEdit;
    ComboBox9: TComboBox;
    procedure LoadGS(fn:string);
    procedure SaveGS(fn:string);
    procedure LoadJSeq(fn:string);
    procedure SaveJSeq(fn:string);
    procedure PasteToArea;
    procedure WriteCellOverride(x,y:integer;orr,letter:string);
    function extractitemoverridename(lng:string;id:integer):string;
    procedure formspritelist(var cb:TComboBox);
    procedure autosetdoors;
    procedure setcelldoorface(i,j:integer);
    procedure displayfspritedata(fs:integer);
    procedure edb(db:integer);
    procedure SaveMap(fn:string;saveb:boolean);
    function LoadCard(fn,loc:string):card;
    procedure SaveCard(cts:card;fn:string);
    procedure SavePlayer(fn:string);
    procedure LoadPlayer(fn:string);
    function LoadChar(fn:string):character;
    procedure SavePerk(pid:integer;fn:string);
    function LoadPerk(pid:integer;fn:string):perk;
    procedure SaveChar(cts:character;fn:string);
    procedure SaveLoot(lts:loot;fn:string);
    function LoadLoot(fn:string):loot;
    procedure WriteCellMeshData(x,y:integer);
    procedure ReadCellOverrides(i,j:integer);
    procedure LoadMap(fn:string);
    procedure RenderMap;
    procedure Timer1Timer(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button6Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure ComboBox5Change(Sender: TObject);
    procedure ComboBox6Change(Sender: TObject);
    procedure ComboBox7Change(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Edit24Change(Sender: TObject);
    procedure Edit25Change(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure ComboBox8Change(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure Edit26Change(Sender: TObject);
    procedure Edit27Change(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Build1Click(Sender: TObject);
    procedure Edit28Change(Sender: TObject);
    procedure Edit29Change(Sender: TObject);
    procedure Edit30Change(Sender: TObject);
    procedure Button26Click(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    procedure Variableeditor1Click(Sender: TObject);
    procedure exteditor1Click(Sender: TObject);
    procedure Itemeditor1Click(Sender: TObject);
    procedure Cardeditor1Click(Sender: TObject);
    procedure Charactereditor1Click(Sender: TObject);
    procedure Button27Click(Sender: TObject);
    procedure Edit31Change(Sender: TObject);
    procedure Edit32Change(Sender: TObject);
    procedure Edit33Change(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure Button28Click(Sender: TObject);
    procedure Button29Click(Sender: TObject);
    procedure Button31Click(Sender: TObject);
    procedure Button30Click(Sender: TObject);
    procedure BufferedCellData1Click(Sender: TObject);
    procedure PerkEditor1Click(Sender: TObject);
    procedure getcpeids;
    procedure Button32Click(Sender: TObject);
    procedure Button33Click(Sender: TObject);
    procedure savelight(ca,la,qa,r,g,b:real;reas:integer);
    procedure LoadSavedLight;
    procedure Button34Click(Sender: TObject);
    procedure Button35Click(Sender: TObject);
    procedure Random1Click(Sender: TObject);
    procedure GroupBox5DblClick(Sender: TObject);
    procedure GroupBox10DblClick(Sender: TObject);
    procedure GroupBox7DblClick(Sender: TObject);
    procedure GroupBox9DblClick(Sender: TObject);
    procedure GroupBox8DblClick(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MonsterListEditor1Click(Sender: TObject);
    procedure LoadMonsterList;
    procedure SaveMonsterList;
    procedure Button36Click(Sender: TObject);
    procedure Debugmenu1Click(Sender: TObject);
    procedure Scriptingreference1Click(Sender: TObject);
    procedure Button37Click(Sender: TObject);
    procedure Button38Click(Sender: TObject);
    procedure Freemesheditor1Click(Sender: TObject);
    procedure Exportdatabase1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure LightSourceEditor1Click(Sender: TObject);
    procedure Edit41Change(Sender: TObject);
    procedure AutoGetDoorAngles1Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure oggleEditView1Click(Sender: TObject);
    procedure CheckBox12Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Exportcarddatabase1Click(Sender: TObject);
    procedure EcportMapImage1Click(Sender: TObject);
    procedure Button39Click(Sender: TObject);
    procedure Edit42Change(Sender: TObject);
    procedure CheckBox14Click(Sender: TObject);
    procedure CheckBox15Click(Sender: TObject);
    procedure CheckBox16Click(Sender: TObject);
    procedure CheckBox17Click(Sender: TObject);
    procedure Button40Click(Sender: TObject);
    procedure CheckBox19Click(Sender: TObject);
    procedure Edit45Change(Sender: TObject);
    procedure ComboBox9Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  mbmp:TBitmap;
  wcx,wcy:integer;
  wcx2,wcy2:integer;
  fsw:integer; //current freesprite no
  cx,cy:integer;
  cpcell:lcell;
  orx,ory:integer;

implementation

{$R *.dfm}

uses UEDcardedit, UEDcharedit, Utalismanedit, UEDItemedit, UEDtextedit,
  UEDPerkEdit, UEDMonsterlist, UEDDebug, UFreeMeshEd, UEDLSourc;

procedure addflt(v:real);
begin
  form1.Memo1.Lines.Add(floattostr(v));
end;

procedure addint(v:integer);
begin
  form1.Memo1.Lines.Add(inttostr(v));
end;

procedure addbool(v:boolean);
begin
  form1.Memo1.Lines.Add(booltostr(v));
end;

procedure addstr(v:string);
begin
  form1.Memo1.Lines.Add(v);
end;

function readflt(pn:integer):real;
begin
  result:=strtofloat(form1.Memo1.Lines[pn]);
end;

function readint(pn:integer):integer;
begin
  result:=strtoint(form1.Memo1.Lines[pn]);
end;

function readfloat(pn:integer):real;
var strg,strg2:string;
    i:integer;
begin
  strg:=form1.Memo1.Lines[pn];
  strg2:='';
  for i:=1 to length(strg) do if not ( strg[i] in ['0'..'9', FormatSettings.DecimalSeparator]) then
  begin
    strg2:=strg2+FormatSettings.DecimalSeparator;
  end
  else
  begin
    strg2:=strg2+strg[i];
  end;
  result:=strtofloat(strg2);
end;


function readbool(pn:integer):boolean;
begin
  try
    result:=strtobool(form1.Memo1.Lines[pn]);
  except
    result:=false;
  end;
end;

function readstr(pn:integer):string;
begin
  result:=form1.Memo1.Lines[pn];
end;

procedure TForm2.getcpeids;
var i:integer;
begin
  Form1.Memo1.Lines.Clear;
  Form1.Memo1.Lines.LoadFromFile(gameexe+'\text\'+lang+'\cpe.txt');
  for i:=0 to 100 do
  begin
    cpeids[i]:=readstr(i);
  end;
end;


procedure TForm2.GroupBox10DblClick(Sender: TObject);
begin
   with groupbox10 do
   if height=20 then height:=122 else height:=20;
end;

procedure TForm2.GroupBox5DblClick(Sender: TObject);
begin
 with groupbox5 do
 if height=20 then height:=235 else height:=20;
end;

procedure TForm2.GroupBox7DblClick(Sender: TObject);
begin
   with groupbox7 do
   if height=20 then height:=131 else height:=20;
end;

procedure TForm2.GroupBox8DblClick(Sender: TObject);
begin
   with groupbox8 do
   if height=20 then height:=170 else height:=20;
end;

procedure TForm2.GroupBox9DblClick(Sender: TObject);
begin
   with groupbox9 do
   if height=20 then height:=108 else height:=20;
end;

procedure TForm2.SaveMap(fn:string;saveb:boolean);
var i,j,mv:integer;
    gfm:freemesh;
begin
  mv:=12; //<-indicates map format version; change if add new features to map
  //format with load/save those features needing to have IF MV>... THEN
  lip:=true;
  sip:=true;
  Form1.ProcessLoadScreen;
  clsr:=random(loadscrs);
  Form1.Memo1.Lines.Clear;
  addint(mv);
  addstr(mapid);
  addint(dw);
  addint(dh);
  addint(envir);
  addint(spx);
  addint(spy);
  addint(epx);
  addint(epy);
  addint(stdx);
  addint(stdy);
  for i:=0 to dw do
  for j:=0 to dh do
  begin
    with cells[i,j] do
    begin
      addint(x);
      addint(y);
      addbool(wall);
      addbool(passable);
      addbool(chest);
      addbool(door);
      addbool(trap);
      addint(chestno);
      addint(doorno);
      addint(traptype);
      addint(power);
      addint(textid);
      addstr(spritename);
      addbool(floor);
      addbool(ceil);
      addint(doorface);
      addbool(outdoors);
      addint(plz);
      addint(blockx1);
      addint(blockx2);
      addint(blocky1);
      addint(blocky2);
      addbool(grass);
      addint(dens);
      addstr(gtp);
    end;
    Application.ProcessMessages;
  end;
  for i:=0 to 200 do
  begin
    with gfreesprite[i] do
    begin
      addint(x);
      addint(y);
      addint(z);
      addint(w);
      addint(h);
      addflt(dirx);
      addflt(diry);
      addbool(enabled);
      addbool(fixed);
      addstr(name);
      Application.ProcessMessages;
    end;
  end;
  for i:=0 to 200 do
  begin
    if saveb=true then gfm:=gfreemeshb[i] else gfm:=gfreemesh[i]; //if ingame save FREEMESH
    //if in editor save FREEMESHB (base untouched by visualisation object)
    with gfm do
    begin
      addint(x);
      addint(y);
      addint(z);
      addint(ta);
      addint(ra);
      addint(pa);
      addbool(enabled);
      addstr(name);
      addint(sx);
      addint(sy);
      addint(sz);
      addstr(texture);
      addbool(fire);
      addint(fdx);
      addint(fdy);
      addint(fdz);
      //behavs
      addint(bhv);
      addint(x1);
      addint(x2);
      addint(y1);
      addint(y2);
      addint(z1);
      addint(z2);
      addflt(spd);
      addbool(loop);
      addflt(rx);
      addflt(ry);
      addflt(rz);
      addflt(rta);
      addflt(rra);
      addflt(rpa);
      addstr(trscript);
      Application.ProcessMessages;
    end;
  end;
  for i:=0 to 19 do
  begin
    with visls[i] do
    begin
      addint(round(amb_r*255));
      addint(round(amb_g*255));
      addint(round(amb_b*255));
      addint(round(diff_r*255));
      addint(round(diff_g*255));
      addint(round(diff_b*255));
      addint(round(Spec_r*255));
      addint(round(Spec_g*255));
      addint(round(Spec_b*255));
      addint(round(ca*10000));
      addint(round(la*10000));
      addint(round(qa*10000));
      addint(round(x));
      addint(round(y));
      addint(round(z));
      addbool(enabled);
      addint(sdx);
      addint(sdy);
      addint(sdz);
      addint(stl);
      addint(spotcutoff);
      addflt(spotexponent);
    end;
  end;
  Form1.Memo1.Lines.SaveToFile(fn);
  {Form1.playerlight.ConstAttenuation:=strtoint(Form1.Memo1.Lines[0])/100;
  Form1.playerlight.LinearAttenuation:=strtoint(Form1.Memo1.Lines[1])/100;
  Form1.playerlight.QuadraticAttenuation:=strtoint(Form1.Memo1.Lines[2])/100;
  Form1.playerlight.Diffuse.Red:=strtoint(Form1.Memo1.Lines[3])/255;
  Form1.playerlight.Diffuse.Green:=strtoint(Form1.Memo1.Lines[4])/255;
  Form1.playerlight.Diffuse.Blue:=strtoint(Form1.Memo1.Lines[5])/255;}
  {with form1.playerlight do
  begin
    savelight(ConstAttenuation,LinearAttenuation,QuadraticAttenuation,
              Diffuse.Red,Diffuse.Green,Diffuse.Blue,2);
  end;}
  lip:=false;
  if Form2.Visible=true then ShowMessage('save complete');
end;


procedure TForm2.Random1Click(Sender: TObject);
begin
  Form1.RandomMap;
  form2.autosetdoors;
  Form1.BuildLevel;
end;

procedure TForm2.ReadCellOverrides(i,j:integer);
begin

  //reads overrides for parts of the cell - textures and meshes
   if mapid<>'' then
   begin

    if fileexists(gameexe+'\levels\'+mapid+'\'+inttostr(i)+'_'+inttostr(j)+'_w.txt')=true then
    begin
      Form1.Memo1.Lines.Loadfromfile(gameexe+'\levels\'+mapid+'\'+inttostr(i)+'_'+inttostr(j)+'_w.txt');
      cells[i,j].wco:=Form1.Memo1.Lines[0];
    end
    else
      cells[i,j].wco:='';
    if fileexists(gameexe+'\levels\'+mapid+'\'+inttostr(i)+'_'+inttostr(j)+'_f.txt')=true then
    begin
      Form1.Memo1.Lines.Loadfromfile(gameexe+'\levels\'+mapid+'\'+inttostr(i)+'_'+inttostr(j)+'_f.txt');
      cells[i,j].fco:=Form1.Memo1.Lines[0];
    end
    else
      cells[i,j].fco:='';
    if fileexists(gameexe+'\levels\'+mapid+'\'+inttostr(i)+'_'+inttostr(j)+'_c.txt')=true then
    begin
      Form1.Memo1.Lines.Loadfromfile(gameexe+'\levels\'+mapid+'\'+inttostr(i)+'_'+inttostr(j)+'_c.txt');
      cells[i,j].cco:=Form1.Memo1.Lines[0];
    end
    else
      cells[i,j].cco:='';
    if fileexists(gameexe+'\levels\'+mapid+'\'+inttostr(i)+'_'+inttostr(j)+'_mo.txt')=true then
    begin
      Form1.Memo1.Lines.Loadfromfile(gameexe+'\levels\'+mapid+'\'+inttostr(i)+'_'+inttostr(j)+'_mo.txt');
      cells[i,j].wmo:=Form1.Memo1.Lines[0];//+Form1.Memo1.Lines[1];
      try
        cells[i,j].ta:=strtoint(Form1.Memo1.Lines[2]);
        cells[i,j].ra:=strtoint(Form1.Memo1.Lines[3]);
        cells[i,j].pa:=strtoint(Form1.Memo1.Lines[4]);
        cells[i,j].dx:=strtoint(Form1.Memo1.Lines[5]);
        cells[i,j].dy:=strtoint(Form1.Memo1.Lines[6]);
        cells[i,j].dz:=strtoint(Form1.Memo1.Lines[7]);
        try cells[i,j].fwm:=strtobool(Form1.Memo1.Lines[8]); except cells[i,j].fwm:=false; end;
      except
        cells[i,j].ta:=0;
        cells[i,j].ra:=0;
        cells[i,j].pa:=0;
        cells[i,j].dx:=0;
        cells[i,j].dy:=0;
        cells[i,j].dz:=0;
        cells[i,j].fwm:=false;
      end;
    end
    else
    begin
      cells[i,j].wmo:='';
      cells[i,j].ta:=0;
      cells[i,j].ra:=0;
      cells[i,j].pa:=0;
      cells[i,j].dx:=0;
      cells[i,j].dy:=0;
      cells[i,j].dz:=0;
    end;

    if fileexists(gameexe+'\levels\'+mapid+'\'+inttostr(i)+'_'+inttostr(j)+'_fo.txt')=true then
    begin
      Form1.Memo1.Lines.Loadfromfile(gameexe+'\levels\'+mapid+'\'+inttostr(i)+'_'+inttostr(j)+'_fo.txt');
      cells[i,j].fmo:=Form1.Memo1.Lines[0];//+Form1.Memo1.Lines[1];
    end
    else
    begin
      cells[i,j].fmo:='';
    end;

   end;

end;


procedure Tform2.LoadMap(fn:string);
var i,j,k,oe,mver:integer;
begin

  dw:=99;
  dh:=99;
  Form1.ClearLevel;
  {for i:=0 to 200 do
  with gfreemesh[i] do
  begin
    enabled:=false;
    fire:=false;
    x:=0;
    y:=0;
    z:=0;
    ta:=0;
    ra:=0;
    pa:=0;
    sx:=0;
    sy:=0;
    sz:=0;
    fdx:=0;
    fdy:=0;
    fdz:=0;
    texture:='0';
  end;

  for i:=0 to 19 do
  begin
    visls[i].enabled:=false;
  end;  }

  mver:=0;
  oe:=envir;
  lip:=true;
  sip:=false;
  clsr:=random(loadscrs);
  Form1.ProcessLoadScreen;
  for i:=0 to 100 do
  for j:=0 to 100 do
    minimapc[i,j]:=false;

  Form1.Memo1.Lines.LoadFromFile(fn);
  port:=true;
  k:=0;

  try
    mver:=readint(k);
    k:=k+1;
  except
    mver:=0;
    k:=0;
  end;

  if mver=0 then k:=0;

  mapid:=readstr(k);
  k:=k+1;
  dw:=readint(k);
  k:=k+1;
  dh:=readint(k);
  k:=k+1;
  envir:=readint(k);
  k:=k+1;
  spx:=readint(k);
  k:=k+1;
  spy:=readint(k);
  k:=k+1;
  epx:=readint(k);
  k:=k+1;
  epy:=readint(k);
  k:=k+1;
  stdx:=readint(k);
  k:=k+1;
  stdy:=readint(k);
  k:=k+1;
  for i:=0 to dw do
  for j:=0 to dh do
  begin
    with cells[i,j] do
    begin
      x:=readint(k);
      k:=k+1;
      y:=readint(k);
      k:=k+1;
      wall:=readbool(k);
      k:=k+1;
      passable:=readbool(k);
      k:=k+1;
      chest:=readbool(k);
      k:=k+1;
      door:=readbool(k);
      k:=k+1;
      trap:=readbool(k);
      k:=k+1;
      chestno:=readint(k);
      k:=k+1;
      doorno:=readint(k);
      k:=k+1;
      traptype:=readint(k);
      k:=k+1;
      power:=readint(k);
      k:=k+1;
      textid:=readint(k);
      k:=k+1;
      spritename:=readstr(k);
      k:=k+1;
      floor:=readbool(k);
      k:=k+1;
      ceil:=readbool(k);
      k:=k+1;
      if mver>3 then
      begin
        doorface:=readint(k);
        k:=k+1;
      end;
      if mver>5 then
      begin
        outdoors:=readbool(k);
        k:=k+1;
      end else outdoors:=false;
      if mver>9 then
      begin
        plz:=readint(k);
        k:=k+1;
      end else plz:=10;
      if mver>10 then
      begin
        blockx1:=readint(k);
        k:=k+1;
        blockx2:=readint(k);
        k:=k+1;
        blocky1:=readint(k);
        k:=k+1;
        blocky2:=readint(k);
        k:=k+1;
      end
      else
      begin
        blockx1:=0;
        blockx2:=0;
        blocky1:=0;
        blocky2:=0;
      end;

      if mver>11 then
      begin
        grass:=readbool(k);
        k:=k+1;
        dens:=readint(k);
        k:=k+1;
        gtp:=readstr(k);
        k:=k+1;
      end
      else
      begin
        grass:=false;
        dens:=0;
        gtp:='';
      end;

    end;

    application.ProcessMessages;
  end;
  for i:=0 to 200 do
  begin
    with gfreesprite[i] do
    begin
      x:=readint(k);
      k:=k+1;
      y:=readint(k);
      k:=k+1;
      z:=readint(k);
      k:=k+1;
      w:=readint(k);
      k:=k+1;
      h:=readint(k);
      k:=k+1;
      dirx:=readflt(k);
      k:=k+1;
      diry:=readflt(k);
      k:=k+1;
      enabled:=readbool(k);
      k:=k+1;
      fixed:=readbool(k);
      k:=k+1;
      name:=readstr(k);
      k:=k+1;
    end;
  end;

  if mver>0 then
  for i:=0 to 200 do
  begin
    with gfreemeshb[i] do
    begin
      x:=readint(k);
      k:=k+1;
      y:=readint(k);
      k:=k+1;
      z:=readint(k);
      k:=k+1;
      ta:=readint(k);
      k:=k+1;
      ra:=readint(k);
      k:=k+1;
      pa:=readint(k);
      k:=k+1;
      enabled:=readbool(k);
      k:=k+1;
      name:=readstr(k);
      k:=k+1;

      if mver>1 then
      begin
        sx:=readint(k);
        k:=k+1;
        sy:=readint(k);
        k:=k+1;
        sz:=readint(k);
        k:=k+1;
        texture:=readstr(k);
        k:=k+1;
      end
      else
      begin
        sx:=100;
        sy:=100;
        sz:=100;
        texture:='0';
      end;

      if mver>4 then
      begin
        fire:=readbool(k);
        k:=k+1;
        fdx:=readint(k);
        k:=k+1;
        fdy:=readint(k);
        k:=k+1;
        fdz:=readint(k);
        k:=k+1;
      end
      else
      begin
        fire:=false;
        fdx:=0;
        fdy:=0;
        fdz:=0;
      end;

      if mver>6 then
      begin
        bhv:=readint(k);
        k:=k+1;
        x1:=readint(k);
        k:=k+1;
        x2:=readint(k);
        k:=k+1;
        y1:=readint(k);
        k:=k+1;
        y2:=readint(k);
        k:=k+1;
        z1:=readint(k);
        k:=k+1;
        z2:=readint(k);
        k:=k+1;
        spd:=readfloat(k);
        k:=k+1;
        loop:=readbool(k);
        k:=k+1;
        rx:=readfloat(k);
        k:=k+1;
        ry:=readfloat(k);
        k:=k+1;
        rz:=readfloat(k);
        k:=k+1;
        rta:=readfloat(k);
        k:=k+1;
        rra:=readfloat(k);
        k:=k+1;
        rpa:=readfloat(k);
        k:=k+1;
      end
      else
      begin
        bhv:=0;
        rx:=x;
        ry:=y;
        rz:=z;
        rta:=ta;
        rra:=ra;
        rpa:=pa;
      end;

      if mver>8 then
      begin
        trscript:=readstr(k);
        k:=k+1;
      end
      else trscript:='';

    end;
  end;

  if mver>2 then
  for i:=0 to 19 do
  begin
    with visls[i] do begin
      amb_r:=readint(k)/255;
      k:=k+1;
      amb_g:=readint(k)/255;
      k:=k+1;
      amb_b:=readint(k)/255;
      k:=k+1;
      diff_r:=readint(k)/255;
      k:=k+1;
      diff_g:=readint(k)/255;
      k:=k+1;
      diff_b:=readint(k)/255;
      k:=k+1;
      Spec_r:=readint(k)/255;
      k:=k+1;
      Spec_g:=readint(k)/255;
      k:=k+1;
      Spec_b:=readint(k)/255;
      k:=k+1;
      ca:=readint(k)/10000;
      k:=k+1;
      la:=readint(k)/10000;
      k:=k+1;
      qa:=readint(k)/10000;
      k:=k+1;
      x:=readint(k);
      k:=k+1;
      y:=readint(k);
      k:=k+1;
      z:=readint(k);
      k:=k+1;
      enabled:=readbool(k);
      k:=k+1;
      if mver>7 then
      begin
        sdx:=readint(k);
        k:=k+1;
        sdy:=readint(k);
        k:=k+1;
        sdz:=readint(k);
        k:=k+1;
        stl:=readint(k);
        k:=k+1;
        spotcutoff:=readint(k);
        k:=k+1;
        spotexponent:=readfloat(k);
        k:=k+1;
      end
      else
      begin
        sdx:=0;
        sdy:=0;
        sdz:=0;
        stl:=0;
        spotcutoff:=180;
        spotexponent:=0;
      end;
    end;
  end;

  for i:=0 to 200 do gfreemesh[i]:=gfreemeshb[i];

  //reading skybox
  if fileexists(gameexe+'\levels\'+mapid+'\skybox.txt')=true then
  begin
    Form1.Memo1.Lines.Loadfromfile(gameexe+'\levels\'+mapid+'\skybox.txt');
    skybox:=strtoint(Form1.Memo1.Lines[0]);
  end
  else skybox:=0;
  //reading overrides
  for i:=0 to dw do
  for j:=0 to dh do
  begin
    ReadCellOverrides(i,j);
    Application.ProcessMessages;
  end;

  //loading light data
  if fileexists(gameexe+'\levels\'+mapid+'\lightdata.txt') then
  begin
    Form1.Memo1.Lines.LoadFromFile(gameexe+'\levels\'+mapid+'\lightdata.txt');
    Form1.playerlight.ConstAttenuation:=strtoint(Form1.Memo1.Lines[0])/100;
    Form1.playerlight.LinearAttenuation:=strtoint(Form1.Memo1.Lines[1])/100;
    Form1.playerlight.QuadraticAttenuation:=strtoint(Form1.Memo1.Lines[2])/100;
    Form1.playerlight.Diffuse.Red:=strtoint(Form1.Memo1.Lines[3])/255;
    Form1.playerlight.Diffuse.Green:=strtoint(Form1.Memo1.Lines[4])/255;
    Form1.playerlight.Diffuse.Blue:=strtoint(Form1.Memo1.Lines[5])/255;
  end
  else
  begin
    Form1.playerlight.ConstAttenuation:=0.5;
    Form1.playerlight.LinearAttenuation:=0.01;
    Form1.playerlight.QuadraticAttenuation:=0.01;
    Form1.playerlight.Diffuse.Red:=255/255;
    Form1.playerlight.Diffuse.Green:=127/255;
    Form1.playerlight.Diffuse.Blue:=0/255;
  end;

  //momster list
  LoadMonsterList;
  lip:=false;

  if Assigned(Form2)=true then
  if (Form2.Visible=true) and (envir<>oe) then
  begin
    Form2.Hide;
    Form2.Show;
  end;

end;

procedure TForm2.LoadSavedLight;
begin
  lip:=true;
  sip:=false;
  //clsr:=random(loadscrs);
  if fileexists(gameexe+'\saves\lightdata.txt') then
  begin
    Form1.Memo1.Lines.LoadFromFile(gameexe+'\saves\lightdata.txt');
    Form1.playerlight.ConstAttenuation:=strtoint(Form1.Memo1.Lines[0])/100;
    Form1.playerlight.LinearAttenuation:=strtoint(Form1.Memo1.Lines[1])/100;
    Form1.playerlight.QuadraticAttenuation:=strtoint(Form1.Memo1.Lines[2])/100;
    Form1.playerlight.Diffuse.Red:=strtoint(Form1.Memo1.Lines[3])/255;
    Form1.playerlight.Diffuse.Green:=strtoint(Form1.Memo1.Lines[4])/255;
    Form1.playerlight.Diffuse.Blue:=strtoint(Form1.Memo1.Lines[5])/255;
  end;
  lip:=false;
end;

procedure TForm2.MonsterListEditor1Click(Sender: TObject);
begin
  Form13.Show;
end;


procedure TForm2.LoadMonsterList;
var hml:boolean;
    i:integer;
    mlfn:string;
begin
  //lip:=true;
  //sip:=false;
  //clsr:=random(loadscrs);
  mlfn:=gameexe+'\levels\'+mapid+'\monsterlist.txt';
  if fileexists(mlfn) then hml:=true else hml:=false;
  if hml=true then
  begin
    Form1.Memo1.Lines.Clear;
    Form1.Memo1.Lines.LoadFromFile(mlfn);
    for i:=0 to 100 do
    begin
      monsterlist[i]:=readbool(i);
    end;
  end
  else
  begin
    for i:=0 to 100 do
    begin
      monsterlist[i]:=true;
    end;
  end;
  //lip:=false;
end;

procedure TForm2.SaveMonsterList;
var hml:boolean;
    i:integer;
    mlfn:string;
begin
  mlfn:=gameexe+'\levels\'+mapid+'\monsterlist.txt';
  Form1.Memo1.Lines.Clear;
  for i:=0 to 100 do
  begin
      addbool(monsterlist[i]);
  end;
  Form1.Memo1.Lines.SaveToFile(mlfn);
end;


procedure TForm2.LightSourceEditor1Click(Sender: TObject);
begin
  form17.show;
end;

function TForm2.LoadCard(fn,loc:string):card;
var tf,rfn,trfn:string;
    i:integer;
begin
  Form1.Memo1.Lines.LoadFromFile(fn);

  with result do
  begin
    name:=readstr(0);
    active:=readbool(1);
    mc:=readint(2);
    hpc:=readint(3);
    dmgph:=readint(4);
    dmgperc:=readint(5);
    addhp:=readint(6);
    addmp:=readint(7);
    addeffect:=readint(8);
    efflgth:=readint(9);
    govskill:=readint(10);
    bont:=readint(11);
    bonam:=readint(12);
    accum:=readbool(13);
    monly:=readbool(14);
    try effstrgth:=readint(15); except effstrgth:=0; end;
    try effdir:=readint(16); except effstrgth:=0; end;
    try consumes:=readint(17); except consumes:=-1; end;
    try mindam:=readint(18); except mindam:=dmgph; end;
    try element:=readint(19); except element:=0; end;
    try sound:=readstr(20); except sound:='0'; end;

    enabled:=true;

    rfn:=ExtractFileName(fn);
    i:=1;
    trfn:='';
    repeat
      if rfn[i]<>'.' then
      begin
        trfn:=trfn+rfn[i];
        i:=i+1;
      end;
    until (rfn[i]='.');
    tf:=gameexe+'\text\'+loc+'\overrides\spells\'+trfn+'.txt';
    if FileExists(tf)=true then
    begin
      Form1.Memo1.Lines.LoadFromFile(tf);
      name:=Form1.Memo1.Lines[0];
    end;

  end;

end;

procedure TForm2.Save1Click(Sender: TObject);
begin
  Button1.Click;
end;

procedure TForm2.SaveCard(cts:card;fn:string);
var i,j:integer;
begin
  Form1.Memo1.Lines.Clear;
  with cts do
  begin
    addstr(cts.name);
    addbool(cts.active);
    addint(mc);
    addint(hpc);
    addint(dmgph);
    addint(dmgperc);
    addint(addhp);
    addint(addmp);
    addint(addeffect);
    addint(efflgth);
    addint(govskill);
    addint(bont);
    addint(bonam);
    addbool(accum);
    addbool(monly);
    addint(effstrgth);
    addint(effdir);
    addint(consumes);
    addint(mindam);
    addint(element);
    addstr(sound);
  end;
  Form1.Memo1.Lines.SaveToFile(fn);
end;

procedure TForm2.SavePerk(pid:integer;fn:string);
begin
  Form1.Memo1.Lines.Clear;
  with bperks[pid] do
  begin
    addbool(enabled);
    addstr(name);
    addint(recst);
    addint(recagi);
    addint(recin);
    addint(recend);
    addint(recsw);
    addint(recbw);
    addint(recar);
    addint(recmg);
    addint(recperk);
    addint(addst);
    addint(addagi);
    addint(addin);
    addint(addend);
    addint(addsw);
    addint(addbw);
    addint(addar);
    addint(addmg);
    addint(addcoded);
    addint(recrace);
    addint(addcard)
  end;
  Form1.Memo1.Lines.SaveToFile(fn);
end;


function TForm2.LoadPerk(pid:integer;fn:string):perk;
var rs:perk;
begin
  Form1.Memo1.Lines.LoadFromFile(fn);
  try
    with rs do
    begin
      enabled:=readbool(0);
      name:=readstr(1);
      recst:=readint(2);
      recagi:=readint(3);
      recin:=readint(4);
      recend:=readint(5);
      recsw:=readint(6);
      recbw:=readint(7);
      recar:=readint(8);
      recmg:=readint(9);
      recperk:=readint(10);
      addst:=readint(11);
      addagi:=readint(12);
      addin:=readint(13);
      addend:=readint(14);
      addsw:=readint(15);
      addbw:=readint(16);
      addar:=readint(17);
      addmg:=readint(18);
      addcoded:=readint(19);
      try
        recrace:=readint(20);
      except
        recrace:=-1;
      end;
      try
        addcard:=readint(21);
      except
        addcard:=-1;
      end;
    end;
  except
    rs.enabled:=false;
  end;
  Result:=rs;
end;

function TForm2.LoadChar(fn:string):character;
var i:integer;
    rs:character;
begin
  Form1.Memo1.Lines.LoadFromFile(fn);
  try
    with rs do
    begin
      name:=readstr(0);
      oname:=readstr(0);
      lvl:=readint(1);
      boss:=readbool(2);
      strength:=readint(3);
      intelligence:=readint(4);
      speed:=readint(5);
      endurance:=readint(6);
      sword:=readint(7);
      bow:=readint(8);
      magic:=readint(9);
      armor:=readint(10);
      for i:=0 to 1000 do
      begin
        spellbook[i]:=readbool(11+i);
      end;
      spec:=readint(1012);
      //load perks
      for i:=0 to 100 do
      begin
        try
          perks[i]:=readbool(1013+i)
        except
          perks[i]:=false;
        end;
      end;
      //done with perks
      try
        element:=readint(1114);
      except
        element:=0;
      end;
      try
        loot:=readint(1115);
        lootchance:=readint(1116);
      except
        loot:=-1;
        lootchance:=50;
      end;
      try
        jrn:=readint(1117);
      except
        jrn:=0;
      end;
    end;
  except

  end;
  Result:=rs;
end;

procedure TForm2.SaveChar(cts:character;fn:string);
var i,j:integer;
begin
  Form1.Memo1.Lines.Clear;
  with cts do
  begin
    addstr(name);  //0
    addint(lvl);   //1
    addbool(boss); //2
    addint(strength); //3
    addint(intelligence); //4
    addint(speed);        //5
    addint(endurance);    //6
    addint(sword);        //7
    addint(bow);          //8
    addint(magic);        //9
    addint(armor);        //10
    for i:=0 to 1000 do
    begin
      addbool(spellbook[i]);  //11
    end;
    addint(spec);  //12
    for i:=0 to 100 do
    begin
      addbool(perks[i]); //13
    end;
    addint(element); //14
    addint(loot); //15
    addint(lootchance); //16
    addint(jrn); //17
  end;
  Form1.Memo1.Lines.SaveToFile(fn);
end;

procedure TForm2.SaveLoot(lts:loot;fn:string);
var i,j:integer;
begin
  Form1.Memo1.Lines.Clear;
  with lts do
  begin
    addstr(name);
    addint(id);
    addint(count);
    addint(p);
    addint(lb_str);
    addint(lb_int);
    addint(lb_spd);
    addint(lb_end);
    addint(lb_sw);
    addint(lb_mg);
    addint(lb_bw);
    addint(lb_ar);
    addint(lb_crd);
    addint(itmtype);
    addint(l_armor);
    addint(crf1);
    addint(crf2);
    addint(l_hat);
    addbool(nohair);
  end;
  Form1.Memo1.Lines.SaveToFile(fn);
end;

function tform2.extractitemoverridename(lng:string;id:integer):string;
var rs:string;
begin
  if fileexists(gameexe+'\text\'+lng+'\overrides\items\'+inttostr(id)+'.txt')=true then
  begin
    Form1.Memo1.Lines.LoadFromFile(gameexe+'\text\'+lng+'\overrides\items\'+inttostr(id)+'.txt');
    rs:=Form1.Memo1.Lines[0];
  end
  else
  begin
    rs:='-nil-';
  end;
  result:=rs;
end;

function TForm2.LoadLoot(fn:string):loot;
var rs:loot;
    orn:string;
begin
  Form1.Memo1.Lines.LoadFromFile(fn);
  try
    with rs do
    begin
      name:=readstr(0);
      id:=readint(1);
      count:=readint(2);
      p:=readint(3);
      lb_str:=readint(4);
      lb_int:=readint(5);
      lb_spd:=readint(6);
      lb_end:=readint(7);
      lb_sw:=readint(8);
      lb_mg:=readint(9);
      lb_bw:=readint(10);
      lb_ar:=readint(11);
      lb_crd:=readint(12);
      try
        itmtype:=readint(13);
      except
        itmtype:=0;
      end;
      try
        l_armor:=readint(14);
      except
        l_armor:=0;
      end;
      try
        crf1:=readint(15);
      except
        crf1:=-1;
      end;
      try
        crf2:=readint(16);
      except
        crf2:=-1;
      end;
      try
        l_hat:=readint(17);
      except
        l_hat:=-1;
      end;
      try
        nohair:=readbool(18);
      except
        nohair:=False;
      end;
    end;
  except end;

  try
    orn:=extractitemoverridename(lang,rs.id);
    if orn='-nil-' then
    begin
      rs.overridename:=rs.name;
    end;
  except
    rs.overridename:=rs.name;
  end;
  Result:=rs;
end;

procedure TForm2.LoadGS(fn:string);
var i,n:integer;
    sta:array[0..10000]of string;
begin
  Form1.Memo1.Lines.Clear;
  Form1.Memo1.Lines.LoadFromFile(fn);
  n:=Form1.Memo1.Lines.Count;
  if n>10001 then n:=10001;
  for i:=0 to n-1 do sta[i]:=form1.Memo1.Lines[i];

  if n>0 then
  begin
    //SetLength(gs,n);
    for i:=0 to n-1 do
    begin
      try
        //ShowMessage('adding global script '+form1.memo1.Lines[i]+'... ('+inttostr(i)+'/'+inttostr(n-1)+')');
        if fileexists(gameexe+'\scripts\'+sta[i]+'.txt') then
          Form1.addglobscript(sta[i]);
      except {showmessage('error adding global script '+form1.memo1.Lines[i])} end;
    end;
  end;

end;

procedure TForm2.SaveGS(fn:string);
var i,n:integer;
begin
  Form1.Memo1.Lines.Clear;
  n:=Length(gs);
  if n>0 then
  for i:=0 to n-1 do
  begin
    form1.memo1.lines.add(gs[i].id);
  end;
  Form1.Memo1.Lines.SaveToFile(fn);
end;

procedure TForm2.SavePlayer(fn:string);
var i,j:integer;
begin
  lip:=true;
  sip:=true;
  //clsr:=random(loadscrs);
  Form1.Memo1.Lines.Clear;
  with player do
  begin
    addint(face);
    addint(hair);
    addint(cloth);
    addint(xp);
    addint(xpreq);
    addint(bonuspoints);
    addint(perkpoints);
    addint(plx);
    addint(ply);
    addint(lookside);
    addint(skeys);
    addint(gkeys);
    addint(sex);
    addint(bstr);
    addint(bint);
    addint(bspd);
    addint(bend);
    addint(bsw);
    addint(bbw);
    addint(bar);
    addint(bmg);
  end;
  addint(level);
  addint(levelsteps);
  for i:=0 to 1000 do
  begin
    addstr(sv[i]);
  end;
  for i:=0 to 1000 do
  begin
    addint(iv[i]);
  end;
  for i:=0 to 1000 do
  begin
    addint(itms[i].count);
  end;
  for i:=0 to 1000 do
  begin
    addbool(player.spellen[i]);
  end;
  addint(asword);
  addint(abow);
  for i:=0 to dw do
  for j:=0 to dh do
  begin
    addbool(minimapc[i,j]);
  end;
  addint(aarm);
  addbool(randommode);
  addint(fdc);
  addint(ahat);
  Form1.Memo1.Lines.SaveToFile(fn);

  lip:=false;
end;

procedure TForm2.Scriptingreference1Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PWideChar(gameexe+'\scripting_ref.docx'), nil, nil, SW_SHOWNORMAL);
end;

procedure TForm2.ScrollBar1Change(Sender: TObject);
begin
  cx:=ScrollBar1.position;
end;

procedure TForm2.ScrollBar2Change(Sender: TObject);
begin
  cy:=ScrollBar2.position;
end;

procedure TForm2.SpeedButton10Click(Sender: TObject);
begin
  form1.getdirsfromlookside(3,orx,ory);
  edit16.Text:=inttostr(strtoint(edit16.Text)+orx*9);
  edit17.Text:=inttostr(strtoint(edit17.Text)+ory*9);
end;

procedure TForm2.SpeedButton11Click(Sender: TObject);
begin
  edit19.Text:='20';
  edit20.Text:='20';
end;

procedure TForm2.SpeedButton12Click(Sender: TObject);
begin
  try gfreesprite[strtoint(ComboBox1.Text)]:=gfreesprite[strtoint(ComboBox1.Text)-1]; except end;
  displayfspritedata(strtoint(ComboBox1.Text));
end;

procedure TForm2.SpeedButton13Click(Sender: TObject);
begin
  setcelldoorface(wcx,wcy);
  Edit41.Text:=inttostr(cells[wcx,wcy].doorface);
end;

procedure TForm2.SpeedButton1Click(Sender: TObject);
begin
  try
    if CheckBox11.Checked=false then
      ScrMemo.Lines.LoadFromFile(gameexe+'\levels\'+mapid+'\script_'+inttostr(wcx)+'_'+inttostr(wcy)+'.txt')
    else
      ScrMemo.Lines.LoadFromFile(gameexe+'\levels\'+mapid+'\sscript_'+inttostr(wcx)+'_'+inttostr(wcy)+'.txt');
  except
    ShowMessage('no script for this cell');
  end;
end;

procedure TForm2.SpeedButton2Click(Sender: TObject);
begin

  if CheckBox11.Checked=false then
    ScrMemo.Lines.SaveToFile(gameexe+'\levels\'+mapid+'\script_'+inttostr(wcx)+'_'+inttostr(wcy)+'.txt')
  else
    ScrMemo.Lines.SaveToFile(gameexe+'\levels\'+mapid+'\sscript_'+inttostr(wcx)+'_'+inttostr(wcy)+'.txt');
end;

procedure TForm2.SpeedButton3Click(Sender: TObject);
begin
  form1.getdirsfromlookside(1,orx,ory);
  edit21.Text:=inttostr(orx);
  edit22.Text:=inttostr(ory);
end;

procedure TForm2.SpeedButton4Click(Sender: TObject);
begin
  form1.getdirsfromlookside(3,orx,ory);
  edit21.Text:=inttostr(orx);
  edit22.Text:=inttostr(ory);
end;

procedure TForm2.SpeedButton5Click(Sender: TObject);
begin
  form1.getdirsfromlookside(2,orx,ory);
  edit21.Text:=inttostr(orx);
  edit22.Text:=inttostr(ory);
end;

procedure TForm2.SpeedButton6Click(Sender: TObject);
begin
  form1.getdirsfromlookside(0,orx,ory);
  edit21.Text:=inttostr(orx);
  edit22.Text:=inttostr(ory);
end;

procedure TForm2.SpeedButton7Click(Sender: TObject);
begin
  form1.getdirsfromlookside(2,orx,ory);
  edit16.Text:=inttostr(strtoint(edit16.Text)+orx*9);
  edit17.Text:=inttostr(strtoint(edit17.Text)+ory*9);
end;

procedure TForm2.SpeedButton8Click(Sender: TObject);
begin
  form1.getdirsfromlookside(0,orx,ory);
  edit16.Text:=inttostr(strtoint(edit16.Text)+orx*9);
  edit17.Text:=inttostr(strtoint(edit17.Text)+ory*9);
end;

procedure TForm2.SpeedButton9Click(Sender: TObject);
begin
  form1.getdirsfromlookside(1,orx,ory);
  edit16.Text:=inttostr(strtoint(edit16.Text)+orx*9);
  edit17.Text:=inttostr(strtoint(edit17.Text)+ory*9);
end;

procedure TForm2.LoadPlayer(fn:string);
var i,j,k:integer;
    rs:character;
begin
  lip:=true;
  sip:=false;
  //clsr:=random(loadscrs);
  Form1.Memo1.Lines.LoadFromFile(fn);
  with player do
  begin
    face:=readint(0);
    hair:=readint(1);
    cloth:=readint(2);
    xp:=readint(3);
    xpreq:=readint(4);
    bonuspoints:=readint(5);
    perkpoints:=readint(6);
    plx:=readint(7);
    ply:=readint(8);
    lookside:=readint(9);
    skeys:=readint(10);
    gkeys:=readint(11);
    sex:=readint(12);
    bstr:=readint(13);
    bint:=readint(14);
    bspd:=readint(15);
    bend:=readint(16);
    bsw:=readint(17);
    bbw:=readint(18);
    bar:=readint(19);
    bmg:=readint(20);
  end;
  level:=readint(21);
  levelsteps:=readint(22);
  for i:=0 to 1000 do
  begin
    sv[i]:=readstr(23+i);
  end;
  for i:=0 to 1000 do
  begin
    iv[i]:=readint(24+1000+i);
  end;
  for i:=0 to 1000 do
  begin
    itms[i].count:=readint(25+2000+i);
  end;
  for i:=0 to 1000 do
  begin
    player.spellen[i]:=readbool(26+3000+i);
  end;
  asword:=readint(27+4000);
  abow:=readint(28+4000);
  k:=0;
  for i:=0 to dw do
  for j:=0 to dh do
  begin
    minimapc[i,j]:=readbool(29+4000+k);
    k:=k+1;
  end;
  aarm:=readint(29+4000+k);
  try randommode:=readbool(30+4000+k); except randommode:=false; end;
  try fdc:=readint(31+4000+k); except fdc:=0; end;
  try ahat:=readint(32+4000+k); except ahat:=-1; end;
  lip:=false;
end;

procedure TForm2.LoadJSeq(fn:string);
var i,n:integer;
begin
  Form1.Memo1.Lines.LoadFromFile(fn);
  SetLength(jseq,Form1.Memo1.Lines.Count);
  n:=Form1.Memo1.Lines.Count-1;
  for i:=0 to n do
  begin
    jseq[i]:=strtoint(Form1.Memo1.Lines[i]);
  end;
end;

procedure TForm2.SaveJSeq(fn:string);
var i,n:integer;
begin
  Form1.Memo1.Clear;
  with Form1.Memo1.Lines do
  begin
    n:=Length(jseq);
    for i:=0 to n-1 do
    begin
      Add(inttostr(jseq[i]));
    end;
  end;
  Form1.Memo1.Lines.SaveToFile(fn);
end;

procedure TForm2.New1Click(Sender: TObject);
begin
  Button8.Click;
end;

procedure TForm2.oggleEditView1Click(Sender: TObject);
begin
  if editmode=false then editmode:=true else editmode:=false;
end;

procedure TForm2.Open1Click(Sender: TObject);
begin
  Button2.Click;
end;

procedure TForm2.Paste1Click(Sender: TObject);
begin

  PasteToArea;
  {if (wcx=wcx2) and (wcy=wcy2) then
  begin
  cells[wcx,wcy]:=cpcell;
  WriteCellMeshData(wcx,wcy);
  end;}
end;

procedure TForm2.PerkEditor1Click(Sender: TObject);
begin
  Form11.Show;
end;

procedure tform2.setcelldoorface(i,j:integer);
begin
  if ((cells[i,j-1].passable=false) or (cells[i,j-1].door=true) or (cells[i,j-1].wall=true)) and
     ((cells[i,j+1].passable=false) or (cells[i,j+1].door=true) or (cells[i,j+1].wall=true)) then
  begin
    cells[i,j].doorface:=90;
  end;
  if ((cells[i-1,j].passable=false) or (cells[i-1,j].door=true) or (cells[i-1,j].wall=true)) and
     ((cells[i+1,j].passable=false) or (cells[i+1,j].door=true) or (cells[i+1,j].wall=true)) then
  begin
    cells[i,j].doorface:=0;
  end;
end;

procedure TForm2.autosetdoors;
var i,j:integer;
begin
  for i:=0 to dw do
  for j:=0 to dh do
  begin
    if (cells[i,j].door=true) {and (cells[i,j].door3d=true)} then
    begin
      setcelldoorface(i,j);
    end;
  end;
end;


procedure TForm2.AutoGetDoorAngles1Click(Sender: TObject);
var i,j:integer;
begin
  autosetdoors;
end;

procedure TForm2.BufferedCellData1Click(Sender: TObject);
begin
  ScrMemo.Clear;
  with scrmemo.Lines do
  begin
    add('passable='+booltostr(cpcell.passable));
    add('wall='+booltostr(cpcell.wall));
    add('floor='+booltostr(cpcell.floor));
    add('ceil='+booltostr(cpcell.ceil));
    add('chest='+booltostr(cpcell.chest));
    add('chestno='+inttostr(cpcell.chestno));
    add('door='+booltostr(cpcell.door));
    add('doorno='+inttostr(cpcell.doorno));
    add('trap='+booltostr(cpcell.trap));
    add('traptype='+inttostr(cpcell.traptype));
    add('power='+inttostr(cpcell.power));
    add('textid='+inttostr(cpcell.textid));
    add('spritename='+cpcell.spritename);
    add('cco='+cpcell.cco);
    add('fco='+cpcell.fco);
    add('wco='+cpcell.wco);
    add('wmo='+cpcell.wmo);
    add('ta='+inttostr(cpcell.ta));
    add('ra='+inttostr(cpcell.ra));
    add('pa='+inttostr(cpcell.pa));
    add('dx='+inttostr(cpcell.dx));
    add('dy='+inttostr(cpcell.dy));
    add('dz='+inttostr(cpcell.dz));
  end;
end;

procedure TForm2.Build1Click(Sender: TObject);
begin
  Button3.Click;
end;

procedure TForm2.Button10Click(Sender: TObject);
begin
  Edit16.Text:=inttostr(wcx*20);
  Edit17.Text:=inttostr(wcy*20);
  Edit18.Text:=inttostr(10);
end;

procedure TForm2.Button11Click(Sender: TObject);
begin
  Edit13.Text:=inttostr(lookside);
  //Edit14.Text:=inttostr(cdy);
end;

procedure TForm2.Button12Click(Sender: TObject);
begin
  Form3.Show;
end;

procedure TForm2.Button13Click(Sender: TObject);
begin
  Form4.Show;
end;

procedure TForm2.Button14Click(Sender: TObject);
var i,j,k:integer;
begin
 k:=1;
  if MessageDlg('Are you sure you want to set cellid automatically?',mtConfirmation,[mbYes,mbCancel],0)=mrYes then
  begin
    for i:=0 to dw do
    for j:=0 to dh do
    begin
      with cells[i,j] do
      begin
        textid:=k;
        k:=k+1;
      end;
    end;
  end;
end;

procedure TForm2.Button15Click(Sender: TObject);
begin
  ScrMemo.Lines.Add(Edit3.Text);
  ScrMemo.Lines.Add(Edit4.Text);
  ScrMemo.Lines.Add(Edit6.Text);
end;

procedure TForm2.Button16Click(Sender: TObject);
begin
  ScrMemo.Clear;
  ScrMemo.Lines.LoadFromFile(gameexe+'\scripts\scr_'+inttostr(cells[wcx,wcy].doorno)+'.txt');
end;

procedure TForm2.Button17Click(Sender: TObject);
begin
  ScrMemo.Lines.SaveToFile(gameexe+'\scripts\scr_'+inttostr(cells[wcx,wcy].doorno)+'.txt');
end;

procedure TForm2.Button18Click(Sender: TObject);
begin
  plx:=wcx;
  ply:=wcy;
  port:=true;
end;

procedure TForm2.Button19Click(Sender: TObject);
begin
  edit23.Text:=mapid;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    if FileExists(savedialog1.FileName)=true then
    begin
      if MessageDlg('This file already exists. Overwrite?',mtConfirmation,mbYesNo,0)=mrYes then
        SaveMap(SaveDialog1.FileName,true);
    end
    else
      SaveMap(SaveDialog1.FileName,true)
  end;
end;

procedure TForm2.Button20Click(Sender: TObject);
begin
  if Edit23.Text<>'' then
    ForceDirectories(gameexe+'\levels\'+Edit23.Text);
end;

procedure TForm2.Button21Click(Sender: TObject);
var i,j:integer;
begin
  if MessageDlg('Are you sure you want to remove all floors and ceilings?',mtConfirmation,[mbYes,mbCancel],0)=mrYes then
  begin
    for i:=0 to dw do
    for j:=0 to dh do
    begin
      cells[i,j].floor:=false;
      cells[i,j].ceil:=false;
    end;
  end;
end;

procedure TForm2.Button22Click(Sender: TObject);
begin
  Form6.Show;
end;

procedure TForm2.Button23Click(Sender: TObject);
begin
  Form7.Show;
end;

procedure TForm2.Button24Click(Sender: TObject);
begin
  Form8.Show;
end;

procedure TForm2.Button25Click(Sender: TObject);
begin
  Edit28.Text:='0';
  Edit29.Text:='0';
  Edit30.Text:='0';
end;

procedure TForm2.WriteCellMeshData(x,y:integer);
begin
  try
    Form1.Memo1.Lines.Clear;
    Form1.Memo1.Lines.Add(cells[x,y].wmo);
    Form1.Memo1.Lines.Add('null');
    Form1.Memo1.Lines.Add(inttostr(cells[x,y].ta));
    Form1.Memo1.Lines.Add(inttostr(cells[x,y].ra));
    Form1.Memo1.Lines.Add(inttostr(cells[x,y].pa));
    Form1.Memo1.Lines.Add(inttostr(cells[x,y].dx));
    Form1.Memo1.Lines.Add(inttostr(cells[x,y].dy));
    Form1.Memo1.Lines.Add(inttostr(cells[x,y].dz));
    Form1.Memo1.Lines.Add(booltostr(cells[x,y].fwm));
    Form1.Memo1.Lines.SaveToFile(gameexe+'\levels\'+mapid+'\'+inttostr(x)+'_'+inttostr(y)+'_mo.txt');
  except end;
end;


procedure TForm2.Button26Click(Sender: TObject);
begin
  with cells[wcx,wcy] do
  begin
    wmo:=Edit24.Text;
    ta:=strtoint(Edit28.Text);
    ra:=strtoint(Edit29.Text);
    pa:=strtoint(Edit30.Text);
    dx:=strtoint(Edit31.Text);
    dy:=strtoint(Edit32.Text);
    dz:=strtoint(Edit33.Text);
    fwm:=CheckBox18.Checked;
  end;
  WriteCellMeshData(wcx,wcy);
end;

procedure TForm2.Button27Click(Sender: TObject);
begin
  Edit31.Text:='0';
  Edit32.Text:='0';
  Edit33.Text:='0';
end;

procedure TForm2.Button28Click(Sender: TObject);
begin
  mapid:=Edit23.Text;
end;

procedure TForm2.Button29Click(Sender: TObject);
begin
  Edit35.Text:='50';
  Edit36.Text:='1';
  Edit37.Text:='1';
  Edit38.Text:='255';
  Edit39.Text:='127';
  Edit40.Text:='0';
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    LoadMap(OpenDialog1.FileName);
  end;
  if fileexists(gameexe+'\levels\'+mapid+'\skybox.txt')=true then
  begin
    Form1.Memo1.Lines.LoadFromFile(gameexe+'\levels\'+mapid+'\skybox.txt');
    Edit25.Text:=Form1.Memo1.Lines[0];
  end;
  Form1.BuildLevel;
  Form1.GoToStart;
  Edit23.Text:=mapid;
  Edit26.Text:=IntToStr(dw);
  Edit27.Text:=IntToStr(dh);
end;

procedure TForm2.savelight(ca,la,qa,r,g,b:real;reas:integer);
begin
  Form1.memo1.Lines.Clear;
  with form1.Memo1.Lines do
  begin
    addint(round(ca*100));
    addint(round(la*100));
    addint(round(qa*100));
    addint(round(r*255));
    addint(round(g*255));
    addint(round(b*255));
    if reas=1 then
      SaveToFile(gameexe+'\levels\'+mapid+'\lightdata.txt');
    if reas=2 then //C:\Delphi\Everdark\Win32\Debug\saves
      SaveToFile(gameexe+'\saves\lightdata.txt');
  end;
end;


procedure TForm2.Button30Click(Sender: TObject);
begin
  with Form1.playerlight do
  begin
    ConstAttenuation:=strtoint(edit35.Text)/100;
    LinearAttenuation:=strtoint(edit36.Text)/100;
    QuadraticAttenuation:=strtoint(edit37.Text)/100;
    Diffuse.Red:=strtoint(edit38.Text)/255;
    Diffuse.Green:=strtoint(edit39.Text)/255;
    Diffuse.Blue:=strtoint(edit40.Text)/255;
  end;
  savelight(strtofloat(edit35.Text)/100,strtofloat(edit36.Text)/100,strtofloat(edit37.Text)/100,strtofloat(edit38.Text)/255,strtofloat(edit39.Text)/255,strtofloat(edit40.Text)/255,1);
end;

procedure TForm2.Button31Click(Sender: TObject);
begin
  with Form1.playerlight do
  begin
    edit35.Text:=inttostr(round(ConstAttenuation*100));
    edit36.Text:=inttostr(round(LinearAttenuation*100));
    edit37.Text:=inttostr(round(QuadraticAttenuation*100));
    edit38.Text:=inttostr(round(Diffuse.Red*255));
    edit39.Text:=inttostr(round(Diffuse.Green*255));
    edit40.Text:=inttostr(round(Diffuse.Blue*255));
  end;
end;

procedure TForm2.Button32Click(Sender: TObject);
begin
  Form11.Show;
end;

procedure TForm2.Button33Click(Sender: TObject);
var i,j:integer;
    slc:boolean;
begin
  for i:=0 to dw do
  for j:=0 to dh do
  begin
    if cells[i,j].spritename='' then cells[i,j].spritename:='0';

  end;
end;

procedure TForm2.Button34Click(Sender: TObject);
begin
  Form1.Memo1.Clear;
  Form1.Memo1.Lines.Add(edit24.Text);
  Form1.Memo1.Lines.SaveToFile(gameexe+'\levels\'+mapid+'\'+inttostr(wcx)+'_'+inttostr(wcy)+'_fo.txt');
end;

procedure TForm2.Button35Click(Sender: TObject);
begin
  ReadCellOverrides(wcx,wcy);
  Edit24.Text:=cells[wcx,wcy].fmo;
end;

procedure TForm2.Button36Click(Sender: TObject);
begin
  Form13.Show;
end;

procedure TForm2.Button37Click(Sender: TObject);
begin
  edit9.Text:=inttostr(wcx);
  edit10.Text:=inttostr(wcy);
end;

procedure TForm2.Button38Click(Sender: TObject);
begin
  edit11.Text:=inttostr(wcx);
  edit12.Text:=inttostr(wcy);
end;

procedure TForm2.Button39Click(Sender: TObject);
begin
  edit24.Text:='void';
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  Form1.BuildLevel;
end;


procedure TForm2.PasteToArea;
var ki,kj,i,j:integer;
    done:boolean;
begin
  //cpcell:=cells[wcx,wcy];

  ki:=0;
  if wcx<wcx2 then ki:=1;
  if wcx>wcx2 then ki:=-1;
  kj:=0;
  if wcy<wcy2 then kj:=1;
  if wcy>wcy2 then kj:=-1;

  i:=wcx;
  j:=wcy;
  done:=false;

  repeat

    //ReadCellOverrides(i,j);
    cells[i,j]:=cpcell;
    WriteCellMeshData(i,j);
    WriteCellOverride(i,j,cpcell.wco,'w');
    WriteCellOverride(i,j,cpcell.fco,'f');
    WriteCellOverride(i,j,cpcell.cco,'c');
    //ReadCellOverrides(i,j);

    if (i=wcx2) and (j=wcy2) then done:=true;

    i:=i+ki;
    if (i-ki=wcx2) then
    begin
      i:=wcx;
      j:=j+kj;
    end;

  until (done=true);

end;

procedure TForm2.Button40Click(Sender: TObject);
var i,j,ki,kj:integer;
    done:boolean;
begin


end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  spx:=strtoint(edit9.Text);
  spy:=strtoint(edit10.Text);
  epx:=strtoint(edit11.Text);
  epy:=strtoint(edit12.Text);
  stdx:=strtoint(edit13.Text);
  stdy:=strtoint(edit14.Text);

end;

procedure TForm2.Button5Click(Sender: TObject);
begin
  Edit9.Text:=inttostr(spx);
  Edit10.Text:=inttostr(spy);
  Edit11.Text:=inttostr(epx);
  Edit12.Text:=inttostr(epy);
  Edit13.Text:=inttostr(stdx);
  Edit14.Text:=inttostr(stdy);
end;

procedure TForm2.Button6Click(Sender: TObject);
begin
  Timer1.Interval:=StrToInt(Edit15.Text);
end;

procedure TForm2.Button7Click(Sender: TObject);
begin
  with gfreesprite[fsw] do
  begin
    x:=strtoint(edit16.Text);
    y:=strtoint(edit17.Text);
    z:=strtoint(edit18.Text);
    w:=strtoint(edit19.Text);
    h:=strtoint(edit20.Text);
    dirx:=strtofloat(edit21.Text);
    diry:=strtofloat(edit22.Text);
    enabled:=CheckBox8.Checked;
    fixed:=CheckBox9.Checked;
    name:=ComboBox2.Text;
  end;
end;

procedure TForm2.Button8Click(Sender: TObject);
begin
  Form1.ClearLevel;
end;


procedure TForm2.Button9Click(Sender: TObject);
var i,j:integer;
begin
  if MessageDlg('Are you sure you want to set floor and ceilings automatically?',mtConfirmation,[mbYes,mbCancel],0)=mrYes then
  begin
    Form1.AutoPlaceFloorCeil;
  end;
end;

procedure TForm2.Cardeditor1Click(Sender: TObject);
begin
 Button12.Click;
end;

procedure TForm2.Charactereditor1Click(Sender: TObject);
begin
  Button13.Click;
end;

procedure TForm2.CheckBox12Click(Sender: TObject);
begin
  cells[wcx,wcy].outdoors:=CheckBox12.Checked;
end;

procedure TForm2.CheckBox14Click(Sender: TObject);
begin
  if CheckBox14.Checked=true then
    cells[wcx,wcy].blocky1:=-1
  else
    cells[wcx,wcy].blocky1:=0;
end;

procedure TForm2.CheckBox15Click(Sender: TObject);
begin
  if CheckBox15.Checked=true then
    cells[wcx,wcy].blocky2:=1
  else
    cells[wcx,wcy].blocky2:=0;
end;

procedure TForm2.CheckBox16Click(Sender: TObject);
begin
  if CheckBox16.Checked=true then
    cells[wcx,wcy].blockx1:=-1
  else
    cells[wcx,wcy].blockx1:=0;
end;

procedure TForm2.CheckBox17Click(Sender: TObject);
begin
  if CheckBox17.Checked=true then
    cells[wcx,wcy].blockx2:=1
  else
    cells[wcx,wcy].blockx2:=0;
end;

procedure TForm2.CheckBox19Click(Sender: TObject);
begin
  cells[wcx,wcy].grass:=CheckBox19.Checked;
end;

procedure TForm2.CheckBox1Click(Sender: TObject);
begin
  cells[wcx,wcy].wall:=CheckBox1.Checked;
end;

procedure TForm2.CheckBox2Click(Sender: TObject);
begin
  cells[wcx,wcy].passable:=CheckBox2.Checked;
end;

procedure TForm2.CheckBox3Click(Sender: TObject);
begin
  cells[wcx,wcy].door:=CheckBox3.Checked;
end;

procedure TForm2.CheckBox4Click(Sender: TObject);
begin
  cells[wcx,wcy].trap:=CheckBox4.Checked;
end;

procedure TForm2.CheckBox5Click(Sender: TObject);
begin
  cells[wcx,wcy].chest:=CheckBox5.Checked;
end;

procedure TForm2.CheckBox6Click(Sender: TObject);
begin
 cells[wcx,wcy].floor:=CheckBox6.Checked;
end;

procedure TForm2.CheckBox7Click(Sender: TObject);
begin
  cells[wcx,wcy].ceil:=CheckBox7.Checked;
end;

procedure tform2.displayfspritedata(fs:integer);
begin
  try
    Edit16.Text:=inttostr(gfreesprite[fs].x);
    Edit17.Text:=inttostr(gfreesprite[fs].y);
    Edit18.Text:=inttostr(gfreesprite[fs].z);
    Edit19.Text:=inttostr(gfreesprite[fs].w);
    Edit20.Text:=inttostr(gfreesprite[fs].h);
    Edit21.Text:=floattostr(gfreesprite[fs].dirx);
    Edit22.Text:=floattostr(gfreesprite[fs].diry);
    ComboBox2.Text:=gfreesprite[fs].name;
    CheckBox8.Checked:=gfreesprite[fs].enabled;
    CheckBox9.Checked:=gfreesprite[fs].fixed;
    fsw:=fs;
  except

  end;
end;


procedure TForm2.EcportMapImage1Click(Sender: TObject);
var ok:boolean; i:integer;
begin
  if SaveDialog2.execute then mbmp.SaveToFile(SaveDialog2.FileName);
end;

procedure TForm2.ComboBox1Change(Sender: TObject);
begin
    displayfspritedata(strtoint(ComboBox1.Text));
end;

procedure TForm2.ComboBox3Change(Sender: TObject);
begin
  Edit3.Text:=IntToStr(ComboBox3.ItemIndex);
  if ComboBox3.ItemIndex=11 then
  begin
    try
      ScrMemo.Lines.LoadFromFile(gameexe+'\scripts\scr_'+inttostr(cells[wcx,wcy].doorno)+'.txt');
    except

    end;
  end;
end;

procedure TForm2.ComboBox4Change(Sender: TObject);
begin
  try
    envir:=(ComboBox4.ItemIndex);
  except end;
end;

procedure TForm2.WriteCellOverride(x,y:integer;orr,letter:string);
var i,j,l:integer;
begin
  try
    Form1.Memo1.Lines.Clear;
    Form1.Memo1.Lines.Add(orr);
    Form1.Memo1.Lines.SaveToFile(gameexe+'\levels\'+mapid+'\'+inttostr(x)+'_'+inttostr(y)+'_'+letter+'.txt');
  except end;
end;

procedure TForm2.ComboBox5Change(Sender: TObject);
begin
  WriteCellOverride(wcx,wcy,combobox5.Text,'w');
end;

procedure TForm2.ComboBox6Change(Sender: TObject);
begin
  WriteCellOverride(wcx,wcy,combobox6.Text,'f');
end;

procedure TForm2.ComboBox7Change(Sender: TObject);
begin
  WriteCellOverride(wcx,wcy,combobox7.Text,'c');
end;

procedure TForm2.ComboBox8Change(Sender: TObject);
begin
  //
end;

procedure TForm2.ComboBox9Change(Sender: TObject);
begin
  cells[wcx,wcy].gtp:=ComboBox9.Text;
end;

procedure TForm2.Copy1Click(Sender: TObject);
begin
  cpcell:=cells[wcx,wcy];
end;

procedure TForm2.Debugmenu1Click(Sender: TObject);
begin
  Form14.Show;
end;

procedure TForm2.Edit1Change(Sender: TObject);
begin

  {try
    wcx:=strtoint(Edit1.Text);
    wcy:=strtoint(Edit2.Text);
  except
  end;}

  try
    Edit8.Text:=cells[strtoint(edit1.Text),strtoint(edit2.Text)].spritename;
  except end;
end;

procedure TForm2.Edit24Change(Sender: TObject);
begin
  //
end;

procedure TForm2.Edit25Change(Sender: TObject);
begin
  try
    Form1.Memo1.Lines.Clear;
    Form1.Memo1.Lines.Add(Edit25.Text);
    Form1.Memo1.Lines.SaveToFile(gameexe+'\levels\'+mapid+'\skybox.txt');
  except end;
end;

procedure TForm2.Edit26Change(Sender: TObject);
begin
  try
    dw:=strtoint(Edit26.Text);
  except end;
end;

procedure TForm2.Edit27Change(Sender: TObject);
begin
  try
    dh:=strtoint(Edit27.Text);
  except end;
end;

procedure TForm2.Edit28Change(Sender: TObject);
begin
  try
    cells[wcx,wcy].ta:=strtoint(edit28.Text);
  except end;
end;

procedure TForm2.Edit29Change(Sender: TObject);
begin
  try
    cells[wcx,wcy].ra:=strtoint(edit29.Text);
  except end;
end;

procedure TForm2.Edit2Change(Sender: TObject);
begin

  {try
    wcx:=strtoint(Edit1.Text);
    wcy:=strtoint(Edit2.Text);
  except
  end;}

  try
    Edit8.Text:=cells[strtoint(edit1.Text),strtoint(edit2.Text)].spritename;
  except end;
end;

procedure TForm2.Edit30Change(Sender: TObject);
begin
  try
    cells[wcx,wcy].pa:=strtoint(edit30.Text);
  except end;
end;

procedure TForm2.Edit31Change(Sender: TObject);
begin
  try
    cells[wcx,wcy].dx:=strtoint(edit31.Text);
  except end;
end;

procedure TForm2.Edit32Change(Sender: TObject);
begin
  try
    cells[wcx,wcy].dy:=strtoint(edit32.Text);
  except end;
end;

procedure TForm2.Edit33Change(Sender: TObject);
begin
  try
    cells[wcx,wcy].dz:=strtoint(edit33.Text);
  except end;
end;

procedure TForm2.Edit3Change(Sender: TObject);
begin
 try
   ComboBox3.ItemIndex:=StrToInt(Edit3.Text);
   cells[wcx,wcy].traptype:=StrToInt(Edit3.Text);
 except end;
end;

procedure TForm2.Edit41Change(Sender: TObject);
begin
  try
    cells[wcx,wcy].doorface:=StrToInt(Edit41.Text);
  except end;
end;

procedure TForm2.Edit42Change(Sender: TObject);
begin
  try
    cells[wcx,wcy].plz:=StrToInt(Edit42.Text);
  except end;
end;

procedure TForm2.Edit45Change(Sender: TObject);
begin
  try
    cells[wcx,wcy].dens:=strtoint(edit45.Text);
  except

  end;
end;

procedure TForm2.Edit4Change(Sender: TObject);
begin
  try
    cells[wcx,wcy].doorno:=StrToInt(Edit4.Text);
  except end;
end;

procedure TForm2.Edit5Change(Sender: TObject);
begin
  try
    cells[wcx,wcy].power:=StrToInt(Edit5.Text);
  except end;
end;

procedure TForm2.Edit6Change(Sender: TObject);
begin
  try
    cells[wcx,wcy].chestno:=StrToInt(Edit6.Text);
  except end;
end;

procedure TForm2.Edit7Change(Sender: TObject);
begin
  try
    cells[wcx,wcy].textid:=strtoint(Edit7.Text);
  except end;
end;

procedure TForm2.Edit8Change(Sender: TObject);
begin
  try
    cells[wcx,wcy].spritename:=Edit8.Text;
  except end;
end;


procedure TForm2.edb(db:integer);
var Excel: Variant;
    i,j,k,sd,sh,ps,eval,v1,v2,v3,v4:integer;
begin
  Excel := CreateOleObject('Excel.Application');
  Excel.Workbooks.Add;
  Excel.Visible := True;
  //export monsters
  if db=0 then
  begin
    excel.cells[1,1]:='name';
    excel.cells[1,2]:='race';
    excel.cells[1,3]:='level';
    excel.cells[1,4]:='attr sum';
    excel.cells[1,5]:='pot dmg';
    excel.cells[1,6]:='pot heal';
    excel.cells[1,7]:='perks';
    excel.cells[1,8]:='eval';
    for i:=0 to 100 do
    begin
      j:=1;
      excel.cells[i+2,j]:=monsters[i].name;
      j:=2;
      excel.cells[i+2,j]:=form1.GetEClassName(monsters[i].spec,strarr);
      j:=3;
      excel.cells[i+2,j]:=monsters[i].lvl;
      j:=4;
      v1:=monsters[i].strength+monsters[i].intelligence+monsters[i].speed+monsters[i].endurance+monsters[i].sword+monsters[i].bow+monsters[i].magic+monsters[i].armor;
      excel.cells[i+2,j]:=v1;
      sd:=0;
      sh:=0;
      ps:=0;
      for k:=0 to 1000 do
      begin
        if monsters[i].spellbook[k]=true then
        begin
          sd:=sd+deck[k].dmgph;
        end;
        if monsters[i].spellbook[k]=true then
        begin
          sh:=sh+deck[k].addhp;
        end;
      end;
      for k:=0 to 100 do
      begin
        if monsters[i].perks[k]=true then
        begin
          ps:=ps+1;
        end;
      end;
      j:=5;
      excel.cells[i+2,j]:=sd;
      j:=6;
      excel.cells[i+2,j]:=sh;
      j:=7;
      excel.cells[i+2,j]:=ps;
      j:=8;
      eval:=round((v1+sd+sh)/monsters[i].lvl);
      excel.cells[i+2,j]:=eval;
    end;
  end;
  if db=1 then
  begin
    excel.cells[1,1]:='name';
    excel.cells[1,2]:='elem';
    excel.cells[1,3]:='dmg';
    excel.cells[1,4]:='dmgp';
    excel.cells[1,5]:='heal';
    excel.cells[1,6]:='rcb';
    excel.cells[1,7]:='cons';
    excel.cells[1,8]:='mp';
    excel.cells[1,9]:='hp';
    excel.cells[1,10]:='effpwr';
    excel.cells[1,11]:='eval';
    excel.cells[1,12]:='totcost';

    for i:=0 to 1000 do
    if deck[i].enabled=true then
    with deck[i] do
    begin
      j:=0;
      j:=j+1;
      excel.cells[i+2,j]:=name;
      j:=j+1;
      if element<>0 then
      begin
        excel.cells[i+2,j]:=1;
        k:=1;
      end
      else
      begin
        k:=0;
        excel.cells[i+2,j]:=0;
      end;
      j:=j+1;
      excel.cells[i+2,j]:=dmgph;
      j:=j+1;
      excel.cells[i+2,j]:=dmgperc;
      j:=j+1;
      excel.cells[i+2,j]:=addhp+addmp;
      j:=j+1;
      excel.cells[i+2,j]:=bonam;
      j:=j+1;
      if consumes=-1 then
      begin
        excel.cells[i+2,j]:=1;
        ps:=0;
      end
      else
      begin
        excel.cells[i+2,j]:=0;
        ps:=1;
      end;
      j:=j+1;
      excel.cells[i+2,j]:=mc;
      j:=j+1;
      excel.cells[i+2,j]:=hpc;
      j:=j+1;
      if addeffect<>0 then v1:=1 else v1:=0;
      excel.cells[i+2,j]:=(effstrgth+efflgth)*v1;
      j:=j+1;
      eval:=round((k*10+ps*10+dmgph+dmgperc+healo+bonam));
      excel.cells[i+2,j]:=eval;
      j:=j+1;
      eval:=(mc+hpc);
      excel.cells[i+2,j]:=eval;
    end;
  end;
end;


procedure TForm2.Exportcarddatabase1Click(Sender: TObject);
begin
  edb(1);
end;

procedure TForm2.Exportdatabase1Click(Sender: TObject);
begin
  edb(0);
end;

procedure TForm2.exteditor1Click(Sender: TObject);
begin
  Button24.Click;
end;

procedure TForm2.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_LEFT then wcx:=wcx-1;
  if Key=VK_RIGHT then wcx:=wcx+1;
  if Key=VK_UP then wcy:=wcy-1;
  if Key=VK_DOWN then wcy:=wcy+1;
  Edit1.Text:=inttostr(wcx);
  Edit2.Text:=inttostr(wcy);
end;

procedure tform2.formspritelist(var cb:TComboBox);
var i:integer;
begin

  with cb do
  begin
    Clear;
    for i:=0 to (length(alitms)-1) do
    begin
      Items.Add(alitms[i].name);
    end;
    Text:='';
  end;

end;

procedure TForm2.FormShow(Sender: TObject);
var i:integer;
begin
   ComboBox4.Items.Clear;
   for i:=0 to sets-1 do
   begin
     //ComboBox4.Items.Add(inttostr(i));
     ComboBox4.Items.Add(env[i].name);
   end;
   ComboBox4.ItemIndex:=(envir);
   formspritelist(edit8);
   formspritelist(ComboBox2);
   formspritelist(ComboBox5);
   formspritelist(ComboBox6);
   formspritelist(ComboBox7);
   form16.readmeshes(edit24);
   ComboBox9.Items.LoadFromFile(gameexe+'\textures\grasslist.txt');
   {ComboBox2.Items.LoadFromFile(gameexe+'\textures\spritelist.txt');
   ComboBox5.Items.LoadFromFile(gameexe+'\textures\spritelist.txt');
   ComboBox6.Items.LoadFromFile(gameexe+'\textures\spritelist.txt');
   ComboBox7.Items.LoadFromFile(gameexe+'\textures\spritelist.txt');}
   ComboBox1.Items.Clear;
   for i:=0 to 200 do
   begin
     ComboBox1.Items.Add(inttostr(i));
   end;
   ComboBox1.Text:='0';
end;

procedure TForm2.Freemesheditor1Click(Sender: TObject);
begin
  form16.show;
end;

procedure TForm2.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  //Form2.ActiveControl:=nil
end;

procedure TForm2.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var clix,cliy:integer;
begin
  clix:=round(((X+cx*40)/40)-0.5);
  cliy:=round(((Y+cy*40)/40)-0.5);
  Label25.Caption:=inttostr(clix)+','+inttostr(cliy);
end;

procedure TForm2.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var clix,cliy:integer;
begin
  //if Button=mbLeft then
  //begin
    clix:=round(((X+cx*40)/40)-0.5);
    cliy:=round(((Y+cy*40)/40)-0.5);

    Edit8.Text:=cells[strtoint(edit1.Text),strtoint(edit2.Text)].spritename;

    if ssShift in shift then
    begin
      wcx2:=clix;
      wcy2:=cliy;
    end
    else
    begin
      wcx:=clix;
      wcy:=cliy;
      wcx2:=clix;
      wcy2:=cliy;
    end;

    //ReadCellOverrides(wcx,wcy);

    Edit1.Text:=inttostr(wcx);
    Edit2.Text:=inttostr(wcy);
    Edit43.Text:=inttostr(wcx2);
    Edit44.Text:=inttostr(wcy2);

    //for trap
    Edit3.Text:=IntToStr(cells[wcx,wcy].traptype);
    Edit4.Text:=IntToStr(cells[wcx,wcy].doorno);
    Edit6.Text:=IntToStr(cells[wcx,wcy].chestno);
    Edit7.Text:=IntToStr(cells[wcx,wcy].textid);

    //movement blocks
    with cells[wcx,wcy] do
    begin
      if blockx1<>0 then checkbox16.Checked:=true else CheckBox16.Checked:=false;
      if blockx2<>0 then checkbox17.Checked:=true else CheckBox17.Checked:=false;
      if blocky1<>0 then checkbox14.Checked:=true else CheckBox14.Checked:=false;
      if blocky2<>0 then checkbox15.Checked:=true else CheckBox15.Checked:=false;
    end;

    //override celltextures
    if fileexists(gameexe+'\levels\'+mapid+'\'+inttostr(wcx)+'_'+inttostr(wcy)+'_w.txt')=true then
    begin
      Form1.Memo1.Lines.LoadFromFile(gameexe+'\levels\'+mapid+'\'+inttostr(wcx)+'_'+inttostr(wcy)+'_w.txt');
      ComboBox5.Text:=Form1.Memo1.Lines[0];
    end
    else ComboBox5.Text:='';
    if fileexists(gameexe+'\levels\'+mapid+'\'+inttostr(wcx)+'_'+inttostr(wcy)+'_f.txt')=true then
    begin
      Form1.Memo1.Lines.LoadFromFile(gameexe+'\levels\'+mapid+'\'+inttostr(wcx)+'_'+inttostr(wcy)+'_f.txt');
      ComboBox6.Text:=Form1.Memo1.Lines[0];
    end
    else ComboBox6.Text:='';
    if fileexists(gameexe+'\levels\'+mapid+'\'+inttostr(wcx)+'_'+inttostr(wcy)+'_c.txt')=true then
    begin
      Form1.Memo1.Lines.LoadFromFile(gameexe+'\levels\'+mapid+'\'+inttostr(wcx)+'_'+inttostr(wcy)+'_c.txt');
      ComboBox7.Text:=Form1.Memo1.Lines[0];
    end
    else ComboBox7.Text:='';

    ReadCellOverrides(wcx,wcy);

    Edit24.Text:=cells[wcx,wcy].wmo;
    Edit28.Text:=inttostr(cells[wcx,wcy].ta);
    Edit29.Text:=inttostr(cells[wcx,wcy].ra);
    Edit30.Text:=inttostr(cells[wcx,wcy].pa);
    Edit31.Text:=inttostr(cells[wcx,wcy].dx);
    Edit32.Text:=inttostr(cells[wcx,wcy].dy);
    Edit33.Text:=inttostr(cells[wcx,wcy].dz);
    CheckBox18.Checked:=cells[wcx,wcy].fwm;

    Edit41.Text:=inttostr(cells[wcx,wcy].doorface);
    Edit42.Text:=inttostr(cells[wcx,wcy].plz);

    CheckBox19.Checked:=cells[wcx,wcy].grass;
    Edit45.Text:=inttostr(cells[wcx,wcy].dens);
    ComboBox9.Text:=cells[wcx,wcy].gtp;

    {if fileexists(gameexe+'\levels\'+mapid+'\'+inttostr(wcx)+'_'+inttostr(wcy)+'_mo.txt')=true then
    begin
      Form1.Memo1.Lines.LoadFromFile(gameexe+'\levels\'+mapid+'\'+inttostr(wcx)+'_'+inttostr(wcy)+'_mo.txt');
      edit24.Text:=Form1.Memo1.Lines[0];
      ComboBox8.Text:=Form1.Memo1.Lines[1];
      Edit28.Text:=Form1.Memo1.Lines[2];
      Edit29.Text:=Form1.Memo1.Lines[3];
      Edit30.Text:=Form1.Memo1.Lines[4];
      Edit31.Text:=Form1.Memo1.Lines[5];
      Edit32.Text:=Form1.Memo1.Lines[6];
      Edit33.Text:=Form1.Memo1.Lines[7];
    end
    else
    begin
      edit24.Text:='';
      ComboBox8.Text:='';
      Edit28.Text:='0';
      Edit29.Text:='0';
      Edit30.Text:='0';
      Edit31.Text:='0';
      Edit32.Text:='0';
      Edit33.Text:='0';
    end;  }



    //power
    Edit5.Text:=inttostr(cells[wcx,wcy].power);

    //angles
    Edit28.Text:=inttostr(cells[wcx,wcy].ta);
    Edit29.Text:=inttostr(cells[wcx,wcy].ra);
    Edit30.Text:=inttostr(cells[wcx,wcy].pa);

  //end;
  if Button=mbRight then
  begin
    with cells[wcx,wcy] do
    begin
      if wall=false then
      begin
        wall:=true;
        door:=false;
        ceil:=false;
        floor:=false;
        passable:=false;
      end
      else
      begin
        wall:=false;
        door:=false;
        ceil:=true;
        floor:=true;
        passable:=true;
      end;
    end;
  end;
  if Button=mbMiddle then
  begin
    with cells[wcx,wcy] do
    begin
      door:=true;
      wall:=false;
      ceil:=true;
      floor:=true;
      passable:=false;
    end;
  end;
end;

procedure TForm2.Itemeditor1Click(Sender: TObject);
begin
  Button23.Click;
end;

procedure TForm2.RenderMap;
var i,j:integer;
    iw,ih:integer;
    ri,rj:integer;
    mx1,my1,mx2,my2:integer;
begin
  try freeandnil(mbmp) except end;
  mbmp:=TBitmap.Create;
  Image1.Picture.Bitmap.Width:=Image1.Width;
  iw:=Image1.Picture.Bitmap.Width;
  Image1.Picture.Bitmap.Height:=Image1.Height;
  ih:=Image1.Picture.Bitmap.Height;
  mbmp.Width:=20*(dw+1);
  mbmp.Height:=20*(dh+1);

  with mbmp.Canvas do
  begin
    Pen.Color:=clBlack;
    Brush.Color:=clWhite;
    Rectangle(0,0,width,height);
    for i:=0 to dw do
    for j:=0 to dh do
    begin

      if ((i=wcx) and (j=wcy)) or
         (((i>=wcx) and (j>=wcy) and (i<=wcx2) and (j<=wcy2) and ((wcx<>wcx2) or (wcy<>wcy2))) or
          ((i<=wcx) and (j<=wcy) and (i>=wcx2) and (j>=wcy2) and ((wcx<>wcx2) or (wcy<>wcy2))) or
          ((i<=wcx) and (j>=wcy) and (i>=wcx2) and (j<=wcy2) and ((wcx<>wcx2) or (wcy<>wcy2))) or
          ((i>=wcx) and (j<=wcy) and (i<=wcx2) and (j>=wcy2) and ((wcx<>wcx2) or (wcy<>wcy2))))
      then
      begin
        Pen.Width:=5;
        Pen.Color:=clBlue;
      end
      else
      begin
        Pen.Width:=1;
        Pen.Color:=clBlack;
      end;
      if cells[i,j].wall=true then Brush.Color:=clBlack else Brush.Color:=clDkGray;
      if cells[i,j].chest=true then Brush.Color:=clYellow;
      if cells[i,j].door=true then Brush.Color:=clPurple;
      if cells[i,j].passable=true then Brush.Style:=bsFDiagonal else Brush.Style:=bsSolid;
      Rectangle(20*i,20*j,20*i+20,20*j+20);

      if (i=spx) and (j=spy) then
      begin
        Brush.Color:=clRed;
        Brush.Style:=bsSolid;
        Pen.Width:=1;
        Ellipse(20*i+3,20*j+3,20*i+20-3,20*j+20-3);
      end;

      if (i=epx) and (j=epy) then
      begin
        Brush.Color:=clLime;
        Brush.Style:=bsSolid;
        Pen.Width:=1;
        Ellipse(20*i+3,20*j+3,20*i+20-3,20*j+20-3);
      end;

      if cells[i,j].spritename<>'0' then
      begin
        Brush.Color:=clTeal;
        Brush.Style:=bsSolid;
        Pen.Width:=1;
        Ellipse(20*i+6,20*j+6,20*i+20-6,20*j+20-6);
      end;

      if (i=spx) and (j=spy) then
      begin

      end;

      if CheckBox10.Checked=true then
      begin
        Pen.Width:=1;
        if cells[i,j].floor=true then
        begin
          Pen.Color:=clBlack;
          Brush.Color:=clRed;
          Brush.Style:=bsSolid;
          Ellipse(20*i+5-2,20*j+15-2,20*i+5+2,20*j+15+2);
        end;
        if cells[i,j].trap=true then
        begin
          Pen.Color:=clBlack;
          Brush.Color:=clYellow;
          Brush.Style:=bsSolid;
          Ellipse(20*i+15-2,20*j+15-2,20*i+15+2,20*j+15+2);
        end;
        if cells[i,j].ceil=true then
        begin
          Pen.Color:=clBlack;
          Brush.Color:=clLime;
          Brush.Style:=bsSolid;
          Ellipse(20*i+5-2,20*j+5-2,20*i+5+2,20*j+5+2);
        end;
        if cells[i,j].outdoors=true then
        begin
          Pen.Color:=clBlack;
          Brush.Color:=clSkyBlue;
          Brush.Style:=bsSolid;
          Ellipse(20*i+15-2,20*j+5-2,20*i+15+2,20*j+5+2);
        end;
        if (cells[i,j].wmo<>'') or (cells[i,j].fwm=true) then
        begin
          Pen.Color:=clBlack;
          if cells[i,j].fwm=false then
            Brush.Color:=clLime
          else
            Brush.Color:=clRed;
          Brush.Style:=bsSolid;
          Rectangle(20*i+2,20*j+8,20*i+6,20*j+12);
        end;
        if cells[i,j].fmo<>'' then
        begin
          Pen.Color:=clBlack;
          if cells[i,j].fwm=false then
            Brush.Color:=clLime
          else
            Brush.Color:=clRed;
          Brush.Style:=bsSolid;
          Rectangle(20*i+14,20*j+8,20*i+18,20*j+12);
        end;
      end;

      if (i=plx) and (j=ply) then
      begin
        Pen.Width:=4;
        Pen.Color:=clRed;
        MoveTo(20*i+10,20*j+10);
        LineTo(20*i+10+10*cdx,20*j+10+10*cdy);
      end;
    end;

    for i:=0 to dw do
    for j:=0 to dh do
    begin
      //drawing blocked directions
      Pen.Color:=clRed;
      Pen.Width:=3;
      if cells[i,j].blockx1<>0 then
      begin
        MoveTo(i*20+10+10*cells[i,j].blockx1,j*20);
        LineTo(i*20+10+10*cells[i,j].blockx1,j*20+20);
      end;
      if cells[i,j].blockx2<>0 then
      begin
        MoveTo(i*20+10+10*cells[i,j].blockx2,j*20);
        LineTo(i*20+10+10*cells[i,j].blockx2,j*20+20);
      end;
      if cells[i,j].blocky1<>0 then
      begin
        MoveTo(i*20,j*20+10+10*cells[i,j].blocky1);
        LineTo(i*20+20,j*20+10+10*cells[i,j].blocky1);
      end;
      if cells[i,j].blocky2<>0 then
      begin
        MoveTo(i*20,j*20+10+10*cells[i,j].blocky2);
        LineTo(i*20+20,j*20+10+10*cells[i,j].blocky2);
      end;
      //drawing teleporters
      if (cells[i,j].trap=true) and (cells[i,j].traptype=8) then
      begin
        Pen.Color:=clMaroon;
        Pen.Width:=2;
        Pen.Style:=psDashDot;
        MoveTo(i*20+10,j*20+10);
        LineTo(cells[i,j].doorno*20+10,cells[i,j].chestno*20+10);
        Pen.Style:=psSolid;
        Pen.Width:=1;
        Ellipse(cells[i,j].doorno*20+10-2,cells[i,j].chestno*20+10-2,cells[i,j].doorno*20+10+2,cells[i,j].chestno*20+10+2);
      end;
    end;

    for i:=0 to 200 do
    begin
      if gfreesprite[i].enabled=true then
      begin
        Pen.Width:=1;
        Pen.Style:=psSolid;
        Brush.Style:=bsFDiagonal;
        if i<>fsw then
          Pen.Color:=clLime
        else
          Pen.Color:=clOlive;
        Brush.Color:=clFuchsia;
        Ellipse(round(gfreesprite[i].x-gfreesprite[i].w/2+10),
                round(gfreesprite[i].y-gfreesprite[i].h/2+10),
                round(gfreesprite[i].x+gfreesprite[i].w/2+10),
                round(gfreesprite[i].y+gfreesprite[i].h/2+10));
        if gfreesprite[i].fixed=true then
        begin
          Pen.Width:=4;
          if i<>fsw then
            Pen.Color:=clLime
          else
            Pen.Color:=clOlive;
          MoveTo(gfreesprite[i].x+10,gfreesprite[i].y+10);
          LineTo(gfreesprite[i].x+10*round(gfreesprite[i].dirx)+10,gfreesprite[i].y+10*round(gfreesprite[i].diry)+10);
        end;
      end;
    end;

    for i:=0 to 200 do
    begin
      if gfreemesh[i].enabled=true then
      begin
        Pen.Width:=2;
        Pen.Style:=psSolid;
        Brush.Style:=bsSolid;
        if i<>(form16.ComboBox1.ItemIndex) then
          Pen.Color:=clWebDarkMagenta
        else
          Pen.Color:=clWebMagenta;
        Brush.Color:=clFuchsia;

        MoveTo(gfreemesh[i].x-5+10,gfreemesh[i].y+10);
        LineTo(gfreemesh[i].x+5+10,gfreemesh[i].y+10);
        MoveTo(gfreemesh[i].x+10,gfreemesh[i].y-5+10);
        LineTo(gfreemesh[i].x+10,gfreemesh[i].y+5+10);

        pen.Width:=1;

      end;

    end;


    for i:=0 to 19 do
    begin
      if visls[i].enabled=true then
      begin
        Pen.Width:=2;
        Pen.Color:=clWebWheat;
        Brush.Style:=bsSolid;
        Brush.Color:=clYellow;
        Ellipse(visls[i].x+10-3,visls[i].y+10-3,visls[i].x+10+3,visls[i].y+10+3);
      end;
    end;

  end;
  mx1:=cx*20;
  my1:=cy*20;
  mx2:=cx*20+round(iw/2);
  my2:=cy*20+round(ih/2);
  with image1.Canvas do
  begin
    Pen.Color:=clBlack;
    Brush.Color:=clSilver;
    Rectangle(0,0,iw,ih);
  end;
  Image1.Canvas.CopyRect(rect(0,0,iw,ih),mbmp.Canvas,rect(mx1,my1,mx2,my2));
  //FreeAndNil(mbmp);
end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin


  if Form2.Visible=true then
  begin
    RenderMap;

    if (CheckBox13.Checked=true) and (GetAsyncKeyState(VK_LBUTTON)=0) then Form2.ActiveControl:=nil;


    CheckBox1.Checked:=cells[wcx,wcy].wall;
    CheckBox2.Checked:=cells[wcx,wcy].passable;
    CheckBox3.Checked:=cells[wcx,wcy].door;
    CheckBox4.Checked:=cells[wcx,wcy].trap;
    CheckBox5.Checked:=cells[wcx,wcy].chest;
    CheckBox6.Checked:=cells[wcx,wcy].floor;
    CheckBox7.Checked:=cells[wcx,wcy].ceil;
    CheckBox12.Checked:=cells[wcx,wcy].outdoors;

    ScrollBar1.Max:=dw;
    ScrollBar2.Max:=dh;

  end;


end;

procedure TForm2.Variableeditor1Click(Sender: TObject);
begin
  button22.Click;
end;

end.
