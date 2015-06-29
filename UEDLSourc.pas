unit UEDLSourc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UEDMapedit;

type
  TForm17 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label2: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label3: TLabel;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    id: TLabel;
    Edit0: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    Button4: TButton;
    Label6: TLabel;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    GroupBox4: TGroupBox;
    ComboBox1: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    Edit19: TEdit;
    Label9: TLabel;
    Edit20: TEdit;
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
  Form17: TForm17;

implementation

{$R *.dfm}

uses UED_main;

procedure TForm17.Button1Click(Sender: TObject);
begin
  with visls[strtoint(edit0.Text)] do
  begin
    edit1.Text:=inttostr(round(amb_r*255));
    edit2.Text:=inttostr(round(amb_g*255));
    edit3.Text:=inttostr(round(amb_b*255));
    edit4.Text:=inttostr(round(diff_r*255));
    edit5.Text:=inttostr(round(diff_g*255));
    edit6.Text:=inttostr(round(diff_b*255));
    edit7.Text:=inttostr(round(Spec_r*255));
    edit8.Text:=inttostr(round(Spec_g*255));
    edit9.Text:=inttostr(round(Spec_b*255));
    Edit10.Text:=inttostr(round(ca*10000));
    Edit11.Text:=inttostr(round(la*10000));
    Edit12.Text:=inttostr(round(qa*10000));
    edit13.Text:=inttostr(round(x));
    edit14.Text:=inttostr(round(y));
    edit15.Text:=inttostr(round(z));
    edit16.Text:=inttostr(sdx);
    edit17.Text:=inttostr(sdy);
    edit18.Text:=inttostr(sdz);
    edit19.Text:=inttostr(spotcutoff);
    edit20.Text:=floattostr(spotexponent);
    ComboBox1.ItemIndex:=stl;
    CheckBox1.Checked:=enabled;

  end;
end;

procedure TForm17.Button2Click(Sender: TObject);
begin

  with visls[strtoint(edit0.Text)] do
  begin
    amb_r:=  (strtoint(edit1.Text)/255);
    amb_g:=(strtoint(edit2.Text)/255);
    amb_b:= (strtoint(edit3.Text)/255);
    diff_r:=  (strtoint(edit4.Text)/255);
    diff_g:=(strtoint(edit5.Text)/255);
    diff_b:= (strtoint(edit6.Text)/255);
    Spec_r:=  (strtoint(edit7.Text)/255);
    Spec_g:=(strtoint(edit8.Text)/255);
    Spec_b:= (strtoint(edit9.Text)/255);
    ca:=strtoint(Edit10.Text)/10000;
    la:=strtoint(Edit11.Text)/10000;
    qa:=strtoint(Edit12.Text)/10000;
    x:=strtoint(edit13.Text);
    y:=strtoint(edit14.Text);
    z:=strtoint(edit15.Text);
    stl:=ComboBox1.ItemIndex;
    sdx:=strtoint(Edit16.Text);
    sdy:=strtoint(Edit17.Text);
    sdz:=strtoint(Edit18.Text);
    spotcutoff:=strtoint(Edit19.Text);
    spotexponent:=strtofloat(Edit20.Text);
    enabled:=CheckBox1.Checked;
  end;

end;

procedure TForm17.Button3Click(Sender: TObject);
begin
 { lsourc[strtoint(edit0.Text)].Position:=Form1.playerlight.Position;
  lsourc[strtoint(edit0.Text)].LightStyle:=Form1.playerlight.LightStyle;
  lsourc[strtoint(edit0.Text)].Ambient:=Form1.playerlight.Ambient;
  lsourc[strtoint(edit0.Text)].diffuse:=Form1.playerlight.diffuse;
  lsourc[strtoint(edit0.Text)].Specular:=Form1.playerlight.Specular;
  lsourc[strtoint(edit0.Text)].ConstAttenuation:=Form1.playerlight.ConstAttenuation;
  lsourc[strtoint(edit0.Text)].LinearAttenuation:=Form1.playerlight.LinearAttenuation;
  lsourc[strtoint(edit0.Text)].QuadraticAttenuation:=Form1.playerlight.QuadraticAttenuation;
  lsourc[strtoint(edit0.Text)].shining:=Form1.playerlight.shining;  }
  Form1.ProcessLights;
end;

procedure TForm17.Button4Click(Sender: TObject);
begin
  edit13.Text:=inttostr(wcx*20);
  edit14.Text:=inttostr(wcy*20);
  Edit15.Text:='10';
end;

end.
