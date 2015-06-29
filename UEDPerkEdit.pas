unit UEDPerkEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm11 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label12: TLabel;
    ComboBox1: TComboBox;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Label3: TLabel;
    Edit12: TEdit;
    Timer1: TTimer;
    Label13: TLabel;
    Edit13: TEdit;
    Label14: TLabel;
    ListBox1: TListBox;
    Label15: TLabel;
    Edit14: TEdit;
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ShowPerkData;
    procedure FillList;
    procedure ListBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form11: TForm11;
  pemode:integer; //indicates the mode of perk editor
  // 1 - for bonus input, 2 - for requirements input


implementation

{$R *.dfm}

uses UEDmapedit, UED_main;

procedure TForm11.FillList;
var i:integer;
    pn:string;
begin
  ListBox1.Clear;
  for i:=0 to 100 do
  begin
    if bperks[i].enabled=true then pn:=bperks[i].name else pn:='--none--';
    ListBox1.Items.Add(pn);
  end;
end;

procedure TForm11.ShowPerkData;
begin
  edit2.Text:=tempperk.name;
  try
    ComboBox1.ItemIndex:=tempperk.addcoded;
  except

  end;
  with tempperk do
  begin

  if pemode=1 then
  begin
    edit4.Text:=inttostr(addst);
    edit5.Text:=inttostr(addagi);
    edit6.Text:=inttostr(addin);
    edit7.Text:=inttostr(addend);
    edit8.Text:=inttostr(addsw);
    edit9.Text:=inttostr(addbw);
    edit10.Text:=inttostr(addmg);
    edit11.Text:=inttostr(addar);
    edit14.Text:=IntToStr(addcard);
  end;
  if pemode=2 then
  begin
    edit4.Text:=inttostr(recst);
    edit5.Text:=inttostr(recagi);
    edit6.Text:=inttostr(recin);
    edit7.Text:=inttostr(recend);
    edit8.Text:=inttostr(recsw);
    edit9.Text:=inttostr(recbw);
    edit10.Text:=inttostr(recmg);
    edit11.Text:=inttostr(recar);
    edit12.Text:=inttostr(recperk);
    Edit13.Text:=inttostr(recrace);
  end;

  end;
end;


procedure TForm11.Button1Click(Sender: TObject);
begin
  bperks[strtoint(Edit1.Text)]:=tempperk;
  bperks[strtoint(Edit1.Text)].enabled:=true;
  Form2.SavePerk(strtoint(Edit1.Text),gameexe+'\perks\p_'+edit1.Text+'.prk');
  ShowPerkData;
  FillList;
end;

procedure TForm11.Button2Click(Sender: TObject);
begin
  tempperk:=Form2.LoadPerk(strtoint(Edit1.Text),gameexe+'\perks\p_'+edit1.Text+'.prk');
  ShowPerkData;
end;

procedure TForm11.Button3Click(Sender: TObject);
begin
  pemode:=1;
  ShowPerkData;
end;

procedure TForm11.Button4Click(Sender: TObject);
begin
  pemode:=2;
  ShowPerkData;
end;

procedure TForm11.Button5Click(Sender: TObject);
begin
  Form1.Memo1.Lines.Clear;
  Form1.Memo1.Lines.Text:=Edit2.Text;
  Form1.Memo1.Lines.SaveToFile(gameexe+'\text\'+Edit3.Text+'\overrides\perks\'+Edit1.Text+'.txt');
end;

procedure TForm11.FormShow(Sender: TObject);
var i:integer;
begin
  pemode:=1;
  ComboBox1.Clear;
  for i:=0 to 100 do
  begin
    ComboBox1.Items.Add(inttostr(i)+')'+cpeids[i])
  end;
  ComboBox1.ItemIndex:=0;
  FillList;
end;

procedure TForm11.ListBox1Click(Sender: TObject);
begin
  Edit1.Text:=IntToStr(ListBox1.ItemIndex);
  Button2.Click;
end;

procedure TForm11.Timer1Timer(Sender: TObject);
begin

  if pemode=1 then
  begin
    Button3.Font.Style:=[fsBold];
    Button4.Font.Style:=[fsItalic];
    Edit14.Visible:=true;
    Label15.Visible:=true;
    Edit12.Visible:=false;
    Label3.Visible:=false;
    Edit13.Visible:=false;
    Label13.Visible:=false;
    Label14.Visible:=false;
  end
  else
  begin
    Button3.Font.Style:=[fsItalic];
    Button4.Font.Style:=[fsBold];
    Edit12.Visible:=true;
    Label3.Visible:=true;
    Edit13.Visible:=true;
    Label13.Visible:=true;
    Label14.Visible:=true;
    Edit14.Visible:=false;
    Label15.Visible:=false;
  end;


  try //<-this one stops error overflow if incorect input given
  if Form11.Visible=true then
  begin

    with tempperk do
    begin

      name:=Edit2.Text;
      addcoded:=(ComboBox1.ItemIndex);

      if pemode=1 then
      begin
        addst:=strtoint(Edit4.Text);
        addagi:=strtoint(Edit5.Text);
        addin:=strtoint(Edit6.Text);
        addend:=strtoint(Edit7.Text);
        addsw:=strtoint(Edit8.Text);
        addbw:=strtoint(Edit9.Text);
        addmg:=strtoint(Edit10.Text);
        addar:=strtoint(Edit11.Text);
        addcard:=strtoint(Edit14.Text);
      end;
      if pemode=2 then
      begin
        recst:=strtoint(Edit4.Text);
        recagi:=strtoint(Edit5.Text);
        recin:=strtoint(Edit6.Text);
        recend:=strtoint(Edit7.Text);
        recsw:=strtoint(Edit8.Text);
        recbw:=strtoint(Edit9.Text);
        recmg:=strtoint(Edit10.Text);
        recar:=strtoint(Edit11.Text);
        recperk:=strtoint(Edit12.Text);
        recrace:=strtoint(Edit13.Text);
      end;

    end;


  end;
  except end;


end;

end.
