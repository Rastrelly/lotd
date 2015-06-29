unit Utalismanedit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UED_main;

type
  TForm6 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Button1: TButton;
    Edit2: TEdit;
    Button2: TButton;
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

procedure TForm6.Button1Click(Sender: TObject);
begin
  if RadioButton1.Checked=true then
    Edit2.Text:=inttostr(iv[strtoint(edit1.Text)])
  else
    Edit2.Text:=sv[strtoint(edit1.Text)];
end;

procedure TForm6.Button2Click(Sender: TObject);
begin
  if RadioButton1.Checked=true then
    iv[strtoint(edit1.Text)]:=strtoint(Edit2.Text)
  else
    sv[strtoint(edit1.Text)]:=Edit2.Text;
end;

procedure TForm6.RadioButton1Click(Sender: TObject);
begin
  RadioButton2.Checked:=false;
end;

procedure TForm6.RadioButton2Click(Sender: TObject);
begin
  RadioButton1.Checked:=false;
end;

end.
