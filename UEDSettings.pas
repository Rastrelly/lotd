unit UEDSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UED_Main, Vcl.ComCtrls;

type
  TForm5 = class(TForm)
    ComboBox1: TComboBox;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    TrackBar1: TTrackBar;
    Label2: TLabel;
    Label3: TLabel;
    TrackBar2: TTrackBar;
    Button3: TButton;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Edit1: TEdit;
    Label5: TLabel;
    Edit2: TEdit;
    Label6: TLabel;
    Edit3: TEdit;
    Button4: TButton;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    TrackBar3: TTrackBar;
    TrackBar4: TTrackBar;
    Label8: TLabel;
    Label9: TLabel;
    Edit4: TEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    GroupBox4: TGroupBox;
    CheckBox3: TCheckBox;
    GroupBox5: TGroupBox;
    CheckBox4: TCheckBox;
    Label10: TLabel;
    TrackBar5: TTrackBar;
    CheckBox6: TCheckBox;
    Label11: TLabel;
    ComboBox2: TComboBox;
    Label12: TLabel;
    TrackBar6: TTrackBar;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    Label13: TLabel;
    TrackBar7: TTrackBar;
    Label14: TLabel;
    GroupBox6: TGroupBox;
    CheckBox10: TCheckBox;
    ComboBox3: TComboBox;
    Label15: TLabel;
    Edit5: TEdit;
    Button5: TButton;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox17: TCheckBox;
    Label16: TLabel;
    ComboBox4: TComboBox;
    CheckBox5: TCheckBox;
    CheckBox16: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure SaveSettings;
    procedure CheckBox6Click(Sender: TObject);
    procedure TrackBar5Change(Sender: TObject);
    procedure TrackBar6Change(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure TrackBar7Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure CheckBox11Click(Sender: TObject);
    procedure CheckBox10Click(Sender: TObject);
    procedure CheckBox12Click(Sender: TObject);
    procedure CheckBox13Click(Sender: TObject);
    procedure CheckBox14Click(Sender: TObject);
    procedure CheckBox15Click(Sender: TObject);
    procedure CheckBox16Click(Sender: TObject);
    procedure CheckBox17Click(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  Form5: TForm5;

implementation

{$R *.dfm}

uses UEDFullscreen2;

procedure TForm5.Button1Click(Sender: TObject);
begin
  lang:=ComboBox1.Text;
  //Form1.fillstrarr(lang);
  //Form1.preparematerials;
  //Form1.prepareuiobjects;
  //Form1.definebutsets;
end;

procedure TForm5.SaveSettings;
begin
  with Form1.Memo1.Lines do
  begin
    Clear;
    Add(lang);
    Add(inttostr(mspeed));
    Add(inttostr(tspeed));
    Add(inttostr(mbd));
    Add(inttostr(fogd));

    Add(inttostr(camd));
    Add(inttostr(snd));
    Add(inttostr(msk));
    Add(inttostr(squality));

    Add(booltostr(sndon));
    Add(booltostr(mskon));

    Add(booltostr(showblog));
    Add(booltostr(autopump));

    Add(inttostr(texqual));

    Add(inttostr(brightness));

    Add(BoolToStr(spareproc));

    Add(IntToStr(ComboBox2.ItemIndex));

    Add(IntToStr(cardmod));

    Add(BoolToStr(randommode));

    Add(BoolToStr(showtooltips));

    Add(BoolToStr(hardcore));

    Add(IntToStr(difficulty));

    Add(BoolToStr(fullscreen));

    Add(IntToStr(xres));
    Add(IntToStr(yres));
    Add(IntToStr(RR));

    Add(BoolToStr(vsnc));

    Add(BoolToStr(no3ddoors));
    Add(BoolToStr(nolights));
    Add(BoolToStr(nofire));

    Add(BoolToStr(multithread));

    Add(BoolToStr(pixelated));

    Add(BoolToStr(edi));

    Add(BoolToStr(autocards));

    Add(BoolToStr(nograss));

    SaveToFile(gameexe+'\ed.cfg');
  end;
  Form5.Hide;
end;


procedure TForm5.Button2Click(Sender: TObject);
begin
  Form1.SwitchAA(ComboBox2.ItemIndex);
  SaveSettings;
  Form1.ReadConfig;
  Form1.InitFullscreen;
end;

procedure TForm5.Button3Click(Sender: TObject);
begin
  TrackBar1.Position:=50;
  TrackBar2.Position:=10;
end;

procedure TForm5.Button4Click(Sender: TObject);
begin
  Edit1.Text:='5';
  Edit2.Text:='100';
  Edit3.Text:='250';
  ComboBox2.ItemIndex:=0;
end;

procedure TForm5.Button5Click(Sender: TObject);
begin
  form1.InitFullscreen;
end;

procedure TForm5.CheckBox10Click(Sender: TObject);
begin
  fullscreen:=CheckBox10.Checked;
end;

procedure TForm5.CheckBox11Click(Sender: TObject);
begin
  vsnc:=CheckBox11.Checked;
end;

procedure TForm5.CheckBox12Click(Sender: TObject);
begin
  no3ddoors:=CheckBox12.Checked;
end;

procedure TForm5.CheckBox13Click(Sender: TObject);
begin
  nolights:=CheckBox13.Checked;
end;

procedure TForm5.CheckBox14Click(Sender: TObject);
begin
  nofire:=CheckBox14.Checked;
end;

procedure TForm5.CheckBox15Click(Sender: TObject);
begin
   multithread:=CheckBox15.Checked;
end;

procedure TForm5.CheckBox16Click(Sender: TObject);
begin
  {if CheckBox16.Checked=true then
  begin
    texqual:=-1; CheckBox5.Checked:=false; pixelated:=true;
  end
  else
  begin
   texqual:=0;
   pixelated:=false;
  end;  }
  nograss:=CheckBox16.Checked;
end;

procedure TForm5.CheckBox17Click(Sender: TObject);
begin
  edi:=CheckBox17.Checked;
end;

procedure TForm5.CheckBox1Click(Sender: TObject);
begin
  sndon:=CheckBox1.Checked;
end;

procedure TForm5.CheckBox2Click(Sender: TObject);
begin
  mskon:=CheckBox2.Checked;
end;

procedure TForm5.CheckBox3Click(Sender: TObject);
begin
  showblog:=CheckBox3.Checked;
end;

procedure TForm5.CheckBox4Click(Sender: TObject);
begin
   autopump:=CheckBox4.Checked;
end;

procedure TForm5.CheckBox5Click(Sender: TObject);
begin
  autocards:=CheckBox5.Checked;
end;

procedure TForm5.CheckBox6Click(Sender: TObject);
begin
  spareproc:=CheckBox6.Checked;
end;



procedure TForm5.CheckBox7Click(Sender: TObject);
begin
  randommode:=CheckBox7.Checked;
end;

procedure TForm5.CheckBox8Click(Sender: TObject);
begin
  showtooltips:=CheckBox8.Checked;
end;

procedure TForm5.CheckBox9Click(Sender: TObject);
begin
  hardcore:=CheckBox9.Checked;
end;

procedure TForm5.ComboBox3Change(Sender: TObject);
begin
  case combobox3.ItemIndex of
  0:begin xres:=320; yres:=240; end;
  1:begin xres:=640; yres:=480; end;
  2:begin xres:=800; yres:=600; end;
  3:begin xres:=1024; yres:=768; end;
  4:begin xres:=1280; yres:=1024; end;
  5:begin xres:=1920; yres:=1280; end;
  6:begin xres:=320; yres:=180; end;
  7:begin xres:=640; yres:=360; end;
  8:begin xres:=800; yres:=450; end;
  9:begin xres:=1024; yres:=576; end;
 10:begin xres:=1280; yres:=720; end;
 11:begin xres:=1440; yres:=810; end;
 12:begin xres:=1920; yres:=1080; end;
  end;
end;

procedure TForm5.ComboBox4Change(Sender: TObject);
begin
  case ComboBox4.ItemIndex of
  0:begin
      pixelated:=false;
      qs:='hq';
      texqual:=0;
    end;
  1:begin
      pixelated:=false;
      qs:='lq';
      texqual:=1;
    end;
  2:begin
      pixelated:=true;
      qs:='pq';
      texqual:=-1;
    end;
  end;
end;

procedure TForm5.Edit1Change(Sender: TObject);
begin
  try
    mbd:=strtoint(Edit1.Text);
  except  end;
end;

procedure TForm5.Edit2Change(Sender: TObject);
begin
  try
    fogd:=strtoint(Edit2.Text);
  except  end;
end;

procedure TForm5.Edit3Change(Sender: TObject);
begin
  try
    camd:=strtoint(Edit3.Text);
  except  end;
end;

procedure TForm5.Edit4Change(Sender: TObject);
begin
  try squality:=strtoint(Edit4.Text); except end;
end;

procedure TForm5.FormShow(Sender: TObject);
begin
  //applying translation
  Label1.Caption:=strarr[109];
  Label2.Caption:=strarr[110];
  Label3.Caption:=strarr[111];
  Label4.Caption:=strarr[120];
  Label5.Caption:=strarr[121];
  Label6.Caption:=strarr[122];
  Label7.Caption:=strarr[124];
  Label8.Caption:=strarr[126];
  Label9.Caption:=strarr[125];
  Label10.Caption:=strarr[237];
  Label11.Caption:=strarr[207];
  Label12.Caption:=strarr[235];
  Label13.Caption:=strarr[307];
  Label14.Caption:=IntToStr(difficulty);
  Label16.Caption:=strarr[380];
  Button1.Caption:=strarr[112];
  Button2.Caption:=strarr[90];
  Button3.Caption:=strarr[113];
  Button4.Caption:=strarr[113];
  GroupBox1.Caption:=strarr[114];
  GroupBox2.Caption:=strarr[118];
  GroupBox3.Caption:=strarr[123];
  GroupBox4.Caption:=strarr[160];
  GroupBox5.Caption:=strarr[165];
  GroupBox6.Caption:=strarr[338];
  Form5.Caption:=strarr[108];
  CheckBox1.Checked:=sndon;
  CheckBox2.Checked:=mskon;
  CheckBox3.Checked:=showblog;
  CheckBox3.Caption:=strarr[161];
  CheckBox4.Checked:=autopump;
  CheckBox4.Caption:=strarr[164];
  CheckBox5.Caption:=strarr[383];
  CheckBox6.Caption:=strarr[198];
  CheckBox7.Caption:=strarr[241];
  CheckBox8.Caption:=strarr[267];
  CheckBox9.Caption:=strarr[305];
  CheckBox10.Caption:=strarr[339];
  CheckBox11.Caption:=strarr[340];
  CheckBox12.Caption:=strarr[348];
  CheckBox13.Caption:=strarr[349];
  CheckBox14.Caption:=strarr[350];
  CheckBox15.Caption:=strarr[351];
  CheckBox16.Caption:=strarr[388];
  CheckBox17.Caption:=strarr[372];
  CheckBox5.Checked:=autocards;
  {if texqual=0 then CheckBox5.Checked:=false else CheckBox5.Checked:=true;
  if texqual=-1 then CheckBox16.Checked:=true else CheckBox16.Checked:=false;}
  CheckBox6.Checked:=spareproc;
  CheckBox7.Checked:=randommode;
  CheckBox8.Checked:=showtooltips;
  CheckBox9.Checked:=HARDCORE;
  CheckBox10.Checked:=fullscreen;
  CheckBox11.Checked:=vsnc;
  CheckBox12.Checked:=no3ddoors;
  CheckBox13.Checked:=nolights;
  CheckBox14.Checked:=nofire;
  CheckBox15.Checked:=multithread;
  CheckBox16.Checked:=nograss;
  CheckBox17.Checked:=edi;

  ComboBox4.Clear;
  with ComboBox4.Items DO
  BEGIN
    Add(strarr[381]);
    Add(strarr[382]);
    Add(strarr[365]);
  END;

  if xres=320 then
  begin
    if yres=240 then ComboBox3.ItemIndex:=0 else ComboBox3.ItemIndex:=6;
  end;
  if xres=640 then
  begin
    if yres=480 then ComboBox3.ItemIndex:=1 else ComboBox3.ItemIndex:=7;
  end;
  if xres=800 then
  begin
    if yres=600 then ComboBox3.ItemIndex:=2 else ComboBox3.ItemIndex:=8;
  end;
  if xres=1024 then
  begin
    if yres=768 then ComboBox3.ItemIndex:=3 else ComboBox3.ItemIndex:=9;
  end;
  if xres=1280 then
  begin
    if yres=1024 then ComboBox3.ItemIndex:=4 else ComboBox3.ItemIndex:=10;
  end;
  if xres=1440 then
  begin
    ComboBox3.ItemIndex:=11;
  end;
  if xres=1920 then
  begin
    if yres=1280 then ComboBox3.ItemIndex:=5 else ComboBox3.ItemIndex:=12;
  end;

  //placing data
  Form1.Memo1.Lines.LoadFromFile(gameexe+'\ed.cfg');
  ComboBox1.Text:=Form1.Memo1.Lines[0];

  case texqual of
  0:ComboBox4.ItemIndex:=0;
  1:ComboBox4.ItemIndex:=1;
  -1:ComboBox4.ItemIndex:=2;
  end;

  TrackBar1.Position:=strtoint(Form1.Memo1.Lines[1]);
  TrackBar2.Position:=strtoint(Form1.Memo1.Lines[2]);
  TrackBar3.Position:=snd;
  TrackBar4.Position:=msk;
  TrackBar5.Position:=brightness;
  TrackBar6.Position:=cardmod;
  TrackBar7.Position:=difficulty;
  Edit1.Text:=IntToStr(mbd);
  Edit2.Text:=IntToStr(fogd);
  Edit3.Text:=IntToStr(fogd);
  Edit4.Text:=IntToStr(squality);

end;

procedure TForm5.TrackBar1Change(Sender: TObject);
begin
  mspeed:=TrackBar1.Position;
end;

procedure TForm5.TrackBar2Change(Sender: TObject);
begin
  tspeed:=TrackBar2.Position;
end;

procedure TForm5.TrackBar3Change(Sender: TObject);
begin
  snd:=TrackBar3.Position;
end;

procedure TForm5.TrackBar4Change(Sender: TObject);
begin
  msk:=TrackBar4.Position;
end;

procedure TForm5.TrackBar5Change(Sender: TObject);
begin
  brightness:=TrackBar5.Position;
end;

procedure TForm5.TrackBar6Change(Sender: TObject);
begin
  cardmod:=TrackBar6.Position;
end;

procedure TForm5.TrackBar7Change(Sender: TObject);
begin
  difficulty:=TrackBar7.Position;
  Label14.Caption:=IntToStr(difficulty);
end;


end.
