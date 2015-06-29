unit UEDMonsterlist;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst, UED_main, UEDmapedit;

type
  TForm13 = class(TForm)
    CheckListBox1: TCheckListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure ShowMonData;
    procedure CheckListBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form13: TForm13;

implementation

{$R *.dfm}

procedure TForm13.ShowMonData;
var i:integer;
begin
  for i:=0 to 100 do
  with CheckListBox1 do
  begin
    if monsters[i].oname<>'' then
      Items.Add(inttostr(i)+') '+monsters[i].oname)
    else
      items.Add(inttostr(i));
    Checked[i]:=monsterlist[i];
  end;
end;


procedure TForm13.Button1Click(Sender: TObject);
var i:integer;
begin
  Form2.LoadMonsterList;
  CheckListBox1.Clear;
  ShowMonData;
end;

procedure TForm13.Button2Click(Sender: TObject);
begin
  Form2.SaveMonsterList;
end;

procedure TForm13.Button3Click(Sender: TObject);
var i:integer;
begin
  for i:=0 to 100 do
  begin
    monsterlist[i]:=true;
  end;
  ShowMonData;
end;

procedure TForm13.Button4Click(Sender: TObject);
var i:integer;
begin
  for i:=0 to 100 do
  begin
    monsterlist[i]:=false;
  end;
  ShowMonData;
end;

procedure TForm13.CheckListBox1Click(Sender: TObject);
begin
  monsterlist[CheckListBox1.ItemIndex]:=CheckListBox1.Checked[CheckListBox1.ItemIndex];
end;

end.
