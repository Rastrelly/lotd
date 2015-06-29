unit UEDItemedit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UED_main,UEDmapedit, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TForm7 = class(TForm)
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    Button1: TButton;
    Button2: TButton;
    Timer1: TTimer;
    GroupBox1: TGroupBox;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    ComboBox1: TComboBox;
    Label1: TLabel;
    LabeledEdit9: TLabeledEdit;
    LabeledEdit10: TLabeledEdit;
    LabeledEdit11: TLabeledEdit;
    LabeledEdit12: TLabeledEdit;
    LabeledEdit13: TLabeledEdit;
    Label2: TLabel;
    Edit1: TEdit;
    ListBox1: TListBox;
    Button3: TButton;
    GroupBox2: TGroupBox;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Panel1: TPanel;
    GroupBox3: TGroupBox;
    Memo1: TMemo;
    Button4: TButton;
    Button5: TButton;
    Label4: TLabel;
    Edit4: TEdit;
    CheckBox1: TCheckBox;
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;
  temploot:loot;

implementation

{$R *.dfm}

procedure TForm7.Button1Click(Sender: TObject);
begin
  temploot:=Form2.LoadLoot(gameexe+'\items\'+inttostr(temploot.id)+'.lot');
  if fileexists(gameexe+'\text\'+labelededit2.text+'\overrides\items\'+inttostr(temploot.id)+'.txt')=true then
  begin
    Form1.Memo1.Lines.Clear;
    Form1.Memo1.Lines.LoadFromFile(gameexe+'\text\'+labelededit2.text+'\overrides\items\'+inttostr(temploot.id)+'.txt');
    LabeledEdit3.Text:=Form1.Memo1.Lines[0];
  end;
  LabeledEdit1.Text:=temploot.name;
  LabeledEdit4.Text:=inttostr(temploot.id);
  LabeledEdit5.Text:=inttostr(temploot.lb_str);
  LabeledEdit6.Text:=inttostr(temploot.lb_int);
  LabeledEdit7.Text:=inttostr(temploot.lb_spd);
  LabeledEdit8.Text:=inttostr(temploot.lb_end);
  LabeledEdit9.Text:=inttostr(temploot.lb_sw);
  LabeledEdit10.Text:=inttostr(temploot.lb_mg);
  LabeledEdit11.Text:=inttostr(temploot.lb_bw);
  LabeledEdit12.Text:=inttostr(temploot.lb_ar);
  LabeledEdit13.Text:=inttostr(temploot.lb_crd);
  Edit1.Text:=inttostr(temploot.l_armor);
  ComboBox1.ItemIndex:=temploot.itmtype;
  Edit2.Text:=inttostr(temploot.crf1);
  Edit3.Text:=inttostr(temploot.crf2);
  Edit4.Text:=inttostr(temploot.l_hat);
  CheckBox1.Checked:=temploot.nohair;

end;

procedure TForm7.Button2Click(Sender: TObject);
begin
  Form2.SaveLoot(temploot,gameexe+'\items\'+inttostr(temploot.id)+'.lot');
  if LabeledEdit2.Text<>'' then
  begin
    Form1.Memo1.Lines.Clear;
    Form1.Memo1.Lines.Add(LabeledEdit3.Text);
    Form1.Memo1.Lines.SaveToFile(gameexe+'\text\'+labelededit2.text+'\overrides\items\'+inttostr(temploot.id)+'.txt');
  end;
end;

procedure TForm7.Button3Click(Sender: TObject);
begin
  itms[strtoint(labelededit4.text)].count:=itms[strtoint(labelededit4.text)].count+1;
end;

procedure TForm7.Button4Click(Sender: TObject);
begin
  Memo1.Lines.LoadFromFile(gameexe+'\items\lootlist.txt');
end;

procedure TForm7.Button5Click(Sender: TObject);
begin
  Memo1.Lines.SaveToFile(gameexe+'\items\lootlist.txt');
end;

procedure TForm7.FormShow(Sender: TObject);
var i:integer;
begin
  ListBox1.Clear;
  For i:=0 to 1000 do
  begin
    if itms[i].name<>'' then
      ListBox1.Items.Add(inttostr(i)+') '+itms[i].name)
    else
      ListBox1.Items.Add(IntToStr(i));
  end;
end;

procedure TForm7.ListBox1Click(Sender: TObject);
begin
  temploot.id:=Listbox1.ItemIndex;
  LabeledEdit4.Text:=inttostr(Listbox1.ItemIndex);
  Button1.Click;
end;

procedure TForm7.Timer1Timer(Sender: TObject);
begin
  if Form7.Visible=true then
  begin
    try
      with temploot do
      begin
        name:=LabeledEdit1.Text;
        id:=strtoint(LabeledEdit4.Text);
        lb_str:=strtoint(LabeledEdit5.Text);
        lb_int:=strtoint(LabeledEdit6.Text);
        lb_spd:=strtoint(LabeledEdit7.Text);
        lb_end:=strtoint(LabeledEdit8.Text);
        lb_sw:=strtoint(LabeledEdit9.Text);
        lb_mg:=strtoint(LabeledEdit10.Text);
        lb_bw:=strtoint(LabeledEdit11.Text);
        lb_ar:=strtoint(LabeledEdit12.Text);
        lb_crd:=strtoint(LabeledEdit13.Text);
        l_armor:=strtoint(Edit1.Text);
        itmtype:=ComboBox1.ItemIndex;
        crf1:=strtoint(Edit2.Text);
        crf2:=strtoint(Edit3.Text);
        l_hat:=strtoint(Edit4.Text);
        nohair:=CheckBox1.Checked;
      end;
    except end;
  end;
end;

end.
