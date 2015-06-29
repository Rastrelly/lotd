unit UEDcharedit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst, Vcl.ExtCtrls, UED_main, UEDmapedit;

type
  TForm4 = class(TForm)
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    CheckListBox1: TCheckListBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Timer1: TTimer;
    LabeledEdit10: TLabeledEdit;
    Label3: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Memo1: TMemo;
    LabeledEdit11: TLabeledEdit;
    CheckBox1: TCheckBox;
    Button3: TButton;
    Label4: TLabel;
    CheckListBox2: TCheckListBox;
    ListBox1: TListBox;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    ComboBox1: TComboBox;
    Label5: TLabel;
    Label8: TLabel;
    ComboBox5: TComboBox;
    Label6: TLabel;
    Edit4: TEdit;
    Label7: TLabel;
    Edit5: TEdit;
    Label9: TLabel;
    Edit6: TEdit;
    Button7: TButton;
    procedure DisplayTempcharData;
    procedure Button1Click(Sender: TObject);
    procedure CheckListBox1ClickCheck(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckListBox2ClickCheck(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;
  tempchar:character;

implementation

{$R *.dfm}

uses UEDtextedit;

procedure TForm4.DisplayTempcharData;
var i:integer;
begin
  with tempchar do
  begin
    LabeledEdit1.Text:=name;
    LabeledEdit2.Text:=inttostr(strength);
    LabeledEdit3.Text:=inttostr(intelligence);
    LabeledEdit4.Text:=inttostr(speed);
    LabeledEdit5.Text:=inttostr(endurance);
    LabeledEdit6.Text:=inttostr(sword);
    LabeledEdit7.Text:=inttostr(bow);
    LabeledEdit8.Text:=inttostr(magic);
    LabeledEdit9.Text:=inttostr(armor);
    LabeledEdit10.Text:=inttostr(lvl);
    LabeledEdit11.Text:=inttostr(spec);

    CheckBox1.Checked:=boss;
    CheckListBox1.Clear;
    CheckListBox2.Clear;
    ComboBox1.ItemIndex:=sex;
    ComboBox5.ItemIndex:=element;
    for i:=0 to 1000 do
    begin
      if deck[i].name<>'' then
        CheckListBox1.Items.Add(deck[i].name)
      else
        CheckListBox1.Items.Add(inttostr(i));
      CheckListBox1.Checked[i]:=spellbook[i];
    end;
    for i:=0 to 100 do
    begin
      if bperks[i].enabled=true then
        CheckListBox2.Items.Add(bperks[i].name)
      else
        CheckListBox2.Items.Add(inttostr(i));
      CheckListBox2.Checked[i]:=tempchar.perks[i];
    end;
    try
      Memo1.Lines.LoadFromFile(gameexe+'\text\'+edit2.text+'\overrides\monsters\'+Edit1.Text+'.txt');
      Edit3.Text:=Memo1.Lines[0];
    except end;
    Edit4.Text:=inttostr(loot);
    Edit5.Text:=inttostr(lootchance);
    edit6.Text:=inttostr(jrn);
  end;
end;


procedure TForm4.Button1Click(Sender: TObject);
var i:integer;
begin
  tempchar:=Form2.LoadChar(gameexe+'\monsters\'+edit1.Text+'.mon');
  DisplayTempcharData;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  Form2.SaveChar(tempchar,gameexe+'\monsters\'+edit1.Text+'.mon');
  try
    Memo1.Clear;
    Memo1.Lines.Add(edit3.Text);
    Memo1.Lines.SaveToFile(gameexe+'\text\'+edit2.text+'\overrides\monsters\'+Edit1.Text+'.txt');
  except end;
end;

procedure TForm4.Button3Click(Sender: TObject);
begin
  Form1.StartBattle(strtoint(Edit1.Text));
end;

procedure TForm4.Button4Click(Sender: TObject);
begin
  tempchar:=player;
  with tempchar do
  begin
    strength:=player.bstr;
    speed:=player.bspd;
    intelligence:=player.bint;
    endurance:=player.bend;
    sword:=player.bsw;
    bow:=player.bbw;
    magic:=player.bmg;
    armor:=player.bar;
  end;
  DisplayTempcharData;
end;

procedure TForm4.Button5Click(Sender: TObject);
begin
  player:=tempchar;
  with tempchar do
  begin
    player.bstr:=strength;
    player.bspd:=speed;
    player.bint:=intelligence;
    player.bend:=endurance;
    player.bsw:=sword;
    player.bbw:=bow;
    player.bmg:=magic;
    player.bar:=armor;
  end;
end;

procedure TForm4.Button6Click(Sender: TObject);
begin
  perkpoints:=perkpoints+1;
end;

procedure TForm4.Button7Click(Sender: TObject);
begin

  if (Edit6.Text='-1') or (Edit6.Text='0') then
  begin
    edit6.Text:=inttostr(Form8.getfreejrn);
  end;

  with form8 do
  begin
    show;
    CheckBox1.Checked:=true;
    CheckBox2.Checked:=false;
    CheckBox3.Checked:=true;
    Edit1.Text:=Form4.Edit6.Text;
    Button2.Click;
  end;
end;

procedure TForm4.CheckListBox1ClickCheck(Sender: TObject);
var i:integer;
begin
  for i:=0 to 1000 do
  with tempchar do
  begin
    spellbook[i]:=CheckListBox1.Checked[i];
  end;
end;

procedure TForm4.CheckListBox2ClickCheck(Sender: TObject);
var i:integer;
begin
  for i:=0 to 100 do
  with tempchar do
  begin
    perks[i]:=CheckListBox2.Checked[i];
  end;
end;

procedure TForm4.FormShow(Sender: TObject);
var i:integer;
begin
  ListBox1.Clear;
  For i:=0 to 100 do
  begin
    if monsters[i].oname<>'' then
      ListBox1.Items.Add(IntToStr(i)+') '+monsters[i].oname)
    else
      ListBox1.Items.Add(IntToStr(i));
  end;
end;

procedure TForm4.ListBox1Click(Sender: TObject);
begin
  Edit1.Text:=inttostr(ListBox1.ItemIndex);
  Button1.Click;
end;

procedure TForm4.Timer1Timer(Sender: TObject);
var i:integer;
begin
  if Form4.Visible=true then
  begin
  try
    with tempchar do
    begin
      name:=LabeledEdit1.Text;
      strength:=StrToInt(LabeledEdit2.Text);
      intelligence:=StrToInt(LabeledEdit3.Text);
      speed:=StrToInt(LabeledEdit4.Text);
      endurance:=StrToInt(LabeledEdit5.Text);
      sword:=StrToInt(LabeledEdit6.Text);
      bow:=StrToInt(LabeledEdit7.Text);
      magic:=StrToInt(LabeledEdit8.Text);
      armor:=StrToInt(LabeledEdit9.Text);
      lvl:=StrToInt(LabeledEdit10.Text);
      boss:=CheckBox1.Checked;
      sex:=Combobox1.ItemIndex;
      element:=ComboBox5.ItemIndex;
      loot:=StrToInt(Edit4.Text);
      lootchance:=StrToInt(Edit5.Text);
      jrn:=StrToInt(Edit6.Text);
      for i:=0 to 1000 do
        spellbook[i]:=CheckListBox1.Checked[i];
      try
        for i:=0 to 100 do
          perks[i]:=CheckListBox2.Checked[i];
      except

      end;
      spec:=StrToInt(LabeledEdit11.Text);
    end;
  except end;
  end;
end;

end.
