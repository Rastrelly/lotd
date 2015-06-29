unit UFreeMeshEd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UED_main, UEDmapedit,
  GLCadencer, GLScene, GLVectorFileObjects, GLCoordinates, GLWin32Viewer,
  GLCrossPlatform, GLBaseClasses, GLObjects, Vcl.ComCtrls, Vcl.ExtCtrls, ioutils;

type
  TForm16 = class(TForm)
    ComboBox1: TComboBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    CheckBox1: TCheckBox;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label1: TLabel;
    Button2: TButton;
    Label2: TLabel;
    Edit8: TEdit;
    Button3: TButton;
    GroupBox3: TGroupBox;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Label3: TLabel;
    GLScene1: TGLScene;
    GLSceneViewer1: TGLSceneViewer;
    camera: TGLCamera;
    preview: TGLFreeForm;
    GLCadencer1: TGLCadencer;
    GLLightSource1: TGLLightSource;
    GLPlane1: TGLPlane;
    GroupBox4: TGroupBox;
    TrackBar3: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar1: TTrackBar;
    Button6: TButton;
    Button5: TButton;
    Button4: TButton;
    Button7: TButton;
    Edit13: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Timer1: TTimer;
    edit12: TComboBox;
    Button8: TButton;
    Button9: TButton;
    Label6: TLabel;
    Edit14: TEdit;
    Button10: TButton;
    Button11: TButton;
    Edit7: TComboBox;
    Memo1: TMemo;
    CheckBox2: TCheckBox;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    GroupBox5: TGroupBox;
    ComboBox2: TComboBox;
    Label7: TLabel;
    Edit18: TEdit;
    Edit19: TEdit;
    CheckBox3: TCheckBox;
    Label8: TLabel;
    Edit20: TEdit;
    Edit21: TEdit;
    Label9: TLabel;
    Edit22: TEdit;
    Edit23: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Edit24: TEdit;
    Button12: TButton;
    Button13: TButton;
    Edit25: TEdit;
    Label13: TLabel;
    Edit26: TEdit;
    function ExtractOnlyFileName(const FileName: string): string;
    procedure readmeshes(var dest: TComboBox);
    procedure ShowFM(i:integer);
    procedure FormShow(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormHide(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form16: TForm16;

implementation

{$R *.dfm}

uses UEDLSourc;

procedure TForm16.ShowFM(i:integer);
begin
  with gfreemeshb[i] do
  begin
    form16.combobox1.ItemIndex:=i;
    CheckBox1.Checked:=enabled;
    Edit1.Text:=inttostr(x);
    Edit2.Text:=inttostr(y);
    Edit3.Text:=inttostr(z);
    Edit4.Text:=inttostr(ta);
    Edit5.Text:=inttostr(ra);
    Edit6.Text:=inttostr(pa);
    Edit7.Text:=name;
    Edit9.Text:=inttostr(sx);
    Edit10.Text:=inttostr(sy);
    Edit11.Text:=inttostr(sz);
    Edit12.Text:=texture;
    Edit15.Text:=inttostr(fdx);
    Edit16.Text:=inttostr(fdy);
    Edit17.Text:=inttostr(fdz);
    Edit18.Text:=inttostr(x1);
    Edit19.Text:=inttostr(x2);
    Edit20.Text:=inttostr(y1);
    Edit21.Text:=inttostr(y2);
    Edit22.Text:=inttostr(z1);
    Edit23.Text:=inttostr(z2);
    Edit24.Text:=floattostr(spd);
    Edit26.Text:=trscript;

    ComboBox2.ItemIndex:=bhv;

    CheckBox2.Checked:=fire;
    CheckBox3.Checked:=loop;

  end;
end;

procedure TForm16.Timer1Timer(Sender: TObject);
begin
  if form16.Visible=true then
  begin
    try Label5.Caption:='dir x='+floattostr(preview.Direction.X)+'; y='+floattostr(preview.Direction.y)+'; z='+floattostr(preview.Direction.z)+
                        '; up x='+floattostr(preview.up.X)+'; y='+floattostr(preview.up.y)+'; z='+floattostr(preview.up.z);
    except end;
  end;
end;

procedure TForm16.TrackBar1Change(Sender: TObject);
begin
  preview.TurnAngle:=strtoint(edit4.Text)+TrackBar1.Position;
end;

procedure TForm16.TrackBar2Change(Sender: TObject);
begin
  preview.RollAngle:=strtoint(edit5.Text)+TrackBar2.Position;
end;

procedure TForm16.TrackBar3Change(Sender: TObject);
begin
  preview.PitchAngle:=strtoint(edit6.Text)+TrackBar3.Position;
end;

procedure TForm16.Button10Click(Sender: TObject);
begin
  with form17 do
  begin
    edit0.Text:=edit14.Text;
    Button1.Click;
    Edit13.Text:=form16.Edit1.Text;
    Edit14.Text:=form16.Edit2.Text;
    Edit15.Text:=form16.Edit3.Text;
  end;
end;

procedure TForm16.Button11Click(Sender: TObject);
begin
  edit9.Text:='100';
  edit10.Text:='100';
  edit11.Text:='100';
end;

procedure TForm16.Button12Click(Sender: TObject);
begin
  edit18.Text:=edit1.Text;
  edit19.Text:=edit1.Text;
  edit20.Text:=edit2.Text;
  edit21.Text:=edit2.Text;
  edit22.Text:=edit3.Text;
  edit23.Text:=edit3.Text;
end;

procedure TForm16.Button13Click(Sender: TObject);
begin
  gfreemeshb[ComboBox1.ItemIndex]:=gfreemeshb[strtoint(edit25.Text)];
  ShowFM(ComboBox1.ItemIndex);
end;

procedure TForm16.Button1Click(Sender: TObject);
var i:integer;
begin
  i:=ComboBox1.ItemIndex;
  with gfreemeshb[i] do
  begin
    x:= strtoint(Edit1.Text);
    y:= strtoint(Edit2.Text);
    z:= strtoint(Edit3.Text);
    rx:=x;
    ry:=y;
    rz:=z;
    ta:=strtoint(Edit4.Text);
    ra:=strtoint(Edit5.Text);
    pa:=strtoint(Edit6.Text);
    rta:=ta;
    rra:=ra;
    rpa:=pa;
    sx:=strtoint(Edit9.Text);
    sy:=strtoint(Edit10.Text);
    sz:=strtoint(Edit11.Text);
    fdx:=strtoint(Edit15.Text);
    fdy:=strtoint(Edit16.Text);
    fdz:=strtoint(Edit17.Text);

    x1:=strtoint(Edit18.Text);
    x2:=strtoint(Edit19.Text);
    y1:=strtoint(Edit20.Text);
    y2:=strtoint(Edit21.Text);
    z1:=strtoint(Edit22.Text);
    z2:=strtoint(Edit23.Text);
    spd:=strtofloat(Edit24.Text);
    bhv:=ComboBox2.ItemIndex;
    loop:=CheckBox3.Checked;

    fire:=CheckBox2.Checked;
    texture:=Edit12.Text;
    texture2:=Edit13.Text;
    name:=Edit7.Text;

    trscript:=Edit26.Text;

    enabled:=CheckBox1.Checked;
  end;
  gfreemesh[i]:=gfreemeshb[i];
  Form1.ModFreeMesh(ComboBox1.ItemIndex);
end;

procedure TForm16.Button2Click(Sender: TObject);
begin
  edit1.Text:=inttostr(wcx*20);
  edit2.Text:=inttostr(wcy*20);
  edit3.Text:=inttostr(10);
end;

procedure TForm16.Button3Click(Sender: TObject);
begin
  form1.Memo1.Lines.Clear;
  Form1.Memo1.Text:=Edit8.Text;
  Form1.Memo1.Lines.SaveToFile(gameexe+'\meshes\'+edit7.Text+'.red');
end;

procedure TForm16.Button4Click(Sender: TObject);
begin
  preview.MaterialLibrary:=Form1.matlib;
  try preview.LoadFromFile(gameexe+'\meshes\'+edit7.Text+'.obj');
  except preview.LoadFromFile(gameexe+'\meshes\'+edit7.Text+'.3ds'); end;
  if edit12.Text<>'0' then
    preview.Material.LibMaterialName:=edit12.Text
  else
    preview.Material.LibMaterialName:='tex_fs_'+edit7.Text;

  with preview do
  begin
    TurnAngle:=strtoint(edit4.Text);
    RollAngle:=strtoint(edit5.Text);
    PitchAngle:=strtoint(edit6.Text);
  end;

end;

procedure TForm16.Button5Click(Sender: TObject);
begin
  camera.Position.X:=camera.Position.X-5;
end;

procedure TForm16.Button6Click(Sender: TObject);
begin
  camera.Position.X:=camera.Position.X+5;
end;

procedure TForm16.Button7Click(Sender: TObject);
begin
  with gfreemesh[ComboBox1.ItemIndex-1] do
  begin
    edit1.Text:=IntToStr(x);
    edit2.Text:=IntToStr(y);
    edit3.Text:=IntToStr(z);
    edit4.Text:=IntToStr(ta);
    edit5.Text:=IntToStr(ra);
    edit6.Text:=IntToStr(pa);
    edit9.Text:=IntToStr(sx);
    edit10.Text:=IntToStr(sy);
    edit11.Text:=IntToStr(sz);
  end;
end;

procedure TForm16.Button8Click(Sender: TObject);
begin
  edit12.Items.LoadFromFile(gameexe+'\textures\uilist.txt');
end;

procedure TForm16.Button9Click(Sender: TObject);
begin
  edit12.Items.LoadFromFile(gameexe+'\textures\spritelist.txt');
end;

procedure TForm16.ComboBox1Change(Sender: TObject);
begin
  ShowFM(ComboBox1.ItemIndex);
end;

procedure TForm16.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   GLSceneViewer1.Enabled:=false;
end;

procedure TForm16.FormHide(Sender: TObject);
begin
   GLSceneViewer1.Enabled:=false;
end;

function TForm16.ExtractOnlyFileName(const FileName: string): string;
begin
  result:=StringReplace(ExtractFileName(FileName),ExtractFileExt(FileName),'',[]);
end;

procedure TForm16.readmeshes(var dest: TComboBox);
var
  SR: TSearchRec;
  S: TStrings;
  i:integer;
  ext:string;
begin
  form16.memo1.Clear; dest.Items.Clear;

  for i:=0 to 1 do
  begin
    if i=0 then ext:='obj' else ext:='3ds';
    if FindFirst(gameexe+'\meshes\*.'+ext, faAnyFile, sr) = 0 then
    begin
      repeat

        dest.Items.Add(extractonlyfilename(gameexe+'\meshes\'+sr.Name));

      until FindNext(sr) <> 0;

      FindClose(sr);
    end;
  end;

  for i:=0 to (form16.memo1.Lines.Count-1) do
  begin
    dest.Items.Add(form16.memo1.Lines[i])
  end;

end;


procedure TForm16.FormShow(Sender: TObject);
var i:integer;
begin

  GLSceneViewer1.Enabled:=true;
  ComboBox1.Items.Clear;
  for i:=0 to 200 do ComboBox1.Items.Add(inttostr(i));

  form2.formspritelist(edit12);
  //edit12.Items.LoadFromFile(gameexe+'\textures\spritelist.txt');
  readmeshes(edit7);

  ShowFM(0);
end;

end.
