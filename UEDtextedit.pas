unit UEDtextedit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UED_main, UEDmapedit,
  Vcl.ExtCtrls;

type
  TForm8 = class(TForm)
    Label1: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    Timer1: TTimer;
    CheckBox2: TCheckBox;
    Button3: TButton;
    CheckBox3: TCheckBox;
    Button4: TButton;
    Edit2: TComboBox;
    function getfreejrn:integer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}

procedure TForm8.Button1Click(Sender: TObject);
begin
  if CheckBox1.Checked=false then
  begin
    Memo1.Lines.SaveToFile(gameexe+'\text\'+Edit2.Text+'\txt_'+Edit1.Text+'_h.txt');
    Memo2.Lines.SaveToFile(gameexe+'\text\'+Edit2.Text+'\txt_'+Edit1.Text+'.txt');
  end
  else
    if (CheckBox2.Checked=false) and (CheckBox3.Checked=false) then
      Memo2.Lines.SaveToFile(gameexe+'\text\'+Edit2.Text+'\'+Edit1.Text+'.txt')
    else
    begin
      if CheckBox2.Checked=true then
        Memo2.Lines.SaveToFile(gameexe+'\scripts\'+Edit1.Text+'.txt');
      if CheckBox3.Checked=true then
        Memo2.Lines.SaveToFile(gameexe+'\text\'+Edit2.Text+'\journal\jrn_'+Edit1.Text+'.txt');
    end;
end;

function tform8.getfreejrn:integer;
var b:boolean;
    k:integer;
begin
  k:=0;
  repeat
    b:=FileExists(gameexe+'\text\'+Form8.Edit2.Text+'\journal\jrn_'+inttostr(k)+'.txt');
    if b=true then k:=k+1;
  until b=false;
  result:=k;
end;

procedure TForm8.Button2Click(Sender: TObject);
begin
  if CheckBox1.Checked=false then
  begin
    Memo1.Lines.LoadFromFile(gameexe+'\text\'+Edit2.Text+'\txt_'+Edit1.Text+'_h.txt');
    Memo2.Lines.LoadFromFile(gameexe+'\text\'+Edit2.Text+'\txt_'+Edit1.Text+'.txt');
  end
  else
    if (CheckBox2.Checked=false) and (CheckBox3.Checked=false) then
      Memo2.Lines.LoadFromFile(gameexe+'\text\'+Edit2.Text+'\'+Edit1.Text+'.txt')
    else
    begin
      if CheckBox2.Checked=true then
        Memo2.Lines.LoadFromFile(gameexe+'\scripts\'+Edit1.Text+'.txt');
      if CheckBox3.Checked=true then
        Memo2.Lines.LoadFromFile(gameexe+'\text\'+Edit2.Text+'\journal\jrn_'+Edit1.Text+'.txt');
    end;
end;

procedure TForm8.Button3Click(Sender: TObject);
var i:integer;
begin
  memo2.Lines.Clear;
  for i:=0 to 10000 do
  begin
    Memo2.Lines.Add(inttostr(i)+') '+strarr[i]);
  end;
end;

procedure TForm8.Button4Click(Sender: TObject);
begin
  edit1.Text:=inttostr(getfreejrn);
end;

procedure TForm8.FormResize(Sender: TObject);
begin
  Memo2.Height:=Form8.ClientHeight-96;
end;

procedure TForm8.Timer1Timer(Sender: TObject);
begin
  if Form8.Visible=true then
  if CheckBox1.Checked=false then
  begin
    Memo1.Enabled:=true;
    CheckBox2.Enabled:=false;
    CheckBox3.Enabled:=false;
  end
  else
  begin
    Memo1.Enabled:=false;
    CheckBox2.Enabled:=true;
    CheckBox3.Enabled:=true;
  end;
end;

end.
