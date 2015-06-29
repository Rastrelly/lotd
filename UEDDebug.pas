unit UEDDebug;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UED_Main, Vcl.ExtCtrls;

type
  TForm14 = class(TForm)
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    GroupBox2: TGroupBox;
    LabeledEdit1: TLabeledEdit;
    Button1: TButton;
    GroupBox3: TGroupBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label4: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    Edit5: TEdit;
    LabeledEdit2: TLabeledEdit;
    Button5: TButton;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    GroupBox4: TGroupBox;
    ListBox1: TListBox;
    Label6: TLabel;
    Edit6: TEdit;
    Edit7: TEdit;
    Label7: TLabel;
    Edit8: TEdit;
    Label8: TLabel;
    Button6: TButton;
    Button7: TButton;
    Label9: TLabel;
    Label10: TLabel;
    Edit9: TEdit;
    Label11: TLabel;
    Button8: TButton;
    procedure FormShow(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
    procedure Edit9Change(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form14: TForm14;

implementation

{$R *.dfm}

procedure TForm14.Button1Click(Sender: TObject);
begin
  levelsteps:=strtoint(LabeledEdit1.Text);
  level:=     strtoint(LabeledEdit2.Text);
end;

procedure TForm14.Button2Click(Sender: TObject);
var bpid:string;
begin
  case ComboBox2.ItemIndex of
  0:bpid:='head_';
  1:bpid:='hair_';
  2:bpid:='hairb_';
  3:bpid:='torso_';
  4:bpid:='hat_';
  end;
  Form1.Memo1.Lines.LoadFromFile(gameexe+'\bodypartdata\'+inttostr(ComboBox1.ItemIndex)+'\'+bpid+edit3.text+'.txt');
  try Edit1.Text:=Form1.Memo1.Lines[0]; except edit1.Text:='0'; end;
  try Edit2.Text:=Form1.Memo1.Lines[1]; except edit2.Text:='0'; end;
  try Edit4.Text:=Form1.Memo1.Lines[2]; except edit4.Text:='0'; end;
  try Edit5.Text:=Form1.Memo1.Lines[3]; except edit5.Text:='0'; end;
  try CheckBox9.Checked:=strtobool(Form1.Memo1.Lines[4]); except CheckBox9.Checked:=false end;
  try CheckBox10.Checked:=strtobool(Form1.Memo1.Lines[5]); except CheckBox10.Checked:=false end;
end;

procedure TForm14.Button3Click(Sender: TObject);
var bpid:string;
begin
  case ComboBox2.ItemIndex of
  0:bpid:='head_';
  1:bpid:='hair_';
  2:bpid:='hairb_';
  3:bpid:='torso_';
  4:bpid:='hat_';
  end;
  Form1.Memo1.Clear;
  Form1.Memo1.Lines.Add(Edit1.Text);
  Form1.Memo1.Lines.Add(Edit2.Text);
  Form1.Memo1.Lines.Add(Edit4.Text);
  Form1.Memo1.Lines.Add(Edit5.Text);
  Form1.Memo1.Lines.Add(booltostr(CheckBox9.Checked));
  Form1.Memo1.Lines.Add(booltostr(CheckBox10.Checked));
  Form1.Memo1.Lines.SaveToFile(gameexe+'\bodypartdata\'+inttostr(ComboBox1.ItemIndex)+'\'+bpid+edit3.text+'.txt');
end;

procedure TForm14.Button4Click(Sender: TObject);
var i,max:integer;
begin
  if ComboBox1.ItemIndex=0 then
    case ComboBox2.ItemIndex of
    0:max:=maxheadsm;
    1:max:=maxhairm;
    2:max:=maxhairm;
    3:max:=1;
    end
  else
    case ComboBox2.ItemIndex of
    0:max:=maxheadsf;
    1:max:=maxhairf;
    2:max:=maxhairf;
    3:max:=1;
    end;

  for i:=0 to max-1 do
  begin
    Edit3.Text:=inttostr(i);
    Button3.Click;
  end;

end;

procedure TForm14.Button5Click(Sender: TObject);
begin
  Form1.ConstructCharacter;
end;

procedure TForm14.Button6Click(Sender: TObject);
var i:integer;
begin
  ListBox1.Items.Clear;
  for i:=0 to Length(alitms)-1 do
  begin
    ListBox1.Items.Add(alitms[i].name);
  end;
end;

procedure TForm14.Button7Click(Sender: TObject);
var i:integer;
begin
  form1.Memo1.Lines.Clear;
  with form1.Memo1.Lines do
  for i:=0 to length(alitms)-1 do
  begin
    add(alitms[i].name+','+inttostr(alitms[i].purpose)+','+inttostr(alitms[i].size)+','+inttostr(alitms[i].size2));
  end;
  form1.Memo1.Lines.SaveToFile(gameexe+'\textures\spritelist.txt');
end;

procedure TForm14.Button8Click(Sender: TObject);
begin
  SetLength(alitms,length(alitms)+1);
  with alitms[Length(alitms)-1] do
  begin
    name:=Edit6.Text;
    purpose:=StrToInt(edit7.Text);
    size:=StrToInt(edit8.Text);
    size2:=StrToInt(edit9.Text);
  end;
  Button6.Click;
end;

procedure TForm14.CheckBox1Click(Sender: TObject);
begin
  block1:=CheckBox1.Checked;
end;

procedure TForm14.CheckBox2Click(Sender: TObject);
begin
  block2:=CheckBox2.Checked;
end;

procedure TForm14.CheckBox3Click(Sender: TObject);
begin
  block3:=CheckBox3.Checked;
end;

procedure TForm14.CheckBox4Click(Sender: TObject);
begin
  block4:=CheckBox4.Checked;
end;

procedure TForm14.CheckBox5Click(Sender: TObject);
begin
  block5:=CheckBox5.Checked;
end;

procedure TForm14.CheckBox6Click(Sender: TObject);
begin
  block6:=CheckBox6.Checked;
end;

procedure TForm14.CheckBox7Click(Sender: TObject);
begin
  block7:=CheckBox7.Checked;
end;

procedure TForm14.CheckBox8Click(Sender: TObject);
begin
  block8:=CheckBox8.Checked;
end;

procedure TForm14.Edit6Change(Sender: TObject);
begin
  alitms[ListBox1.ItemIndex].name:=Edit6.Text;
end;

procedure TForm14.Edit7Change(Sender: TObject);
begin
  try alitms[ListBox1.ItemIndex].purpose:=strtoint(Edit7.Text); except end;
end;

procedure TForm14.Edit8Change(Sender: TObject);
begin
  try alitms[ListBox1.ItemIndex].size:=strtoint(Edit8.Text); except end;
end;

procedure TForm14.Edit9Change(Sender: TObject);
begin
  try alitms[ListBox1.ItemIndex].size2:=strtoint(Edit8.Text); except end;
end;

procedure TForm14.FormShow(Sender: TObject);
begin
  checkbox1.Checked:=block1;
  checkbox2.Checked:=block2;
  checkbox3.Checked:=block3;
  checkbox4.Checked:=block4;
  checkbox5.Checked:=block5;
  checkbox6.Checked:=block6;
  checkbox7.Checked:=block7;
  checkbox8.Checked:=block8;

  LabeledEdit1.Text:=IntToStr(levelsteps);
  LabeledEdit1.Text:=IntToStr(level);

end;

procedure TForm14.ListBox1Click(Sender: TObject);
begin
  edit6.Text:=alitms[ListBox1.ItemIndex].name;
  edit7.Text:=inttostr(alitms[ListBox1.ItemIndex].purpose);
  edit8.Text:=inttostr(alitms[ListBox1.ItemIndex].size);
  edit9.Text:=inttostr(alitms[ListBox1.ItemIndex].size2);
end;

end.
