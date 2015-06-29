unit UEDSplash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls, UED_Main,
  Vcl.StdCtrls, Vcl.ComCtrls;

type
  TForm10 = class(TForm)
    Image1: TImage;
    Memo1: TMemo;
    Timer1: TTimer;
    ProgressBar1: TProgressBar;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form10: TForm10;

implementation

{$R *.dfm}

procedure TForm10.FormCreate(Sender: TObject);
var himg:TJPEGImage;
    fbmp:TBitmap;
begin
  himg:=TJPegImage.Create;
  fbmp:=TBitmap.Create;
  himg.LoadFromFile(extractfiledir(Application.ExeName)+'\textures\splashscreen.jpg');
  fbmp.Assign(himg);

  with Image1.Picture.Bitmap do
  begin
    width:=fbmp.Width;
    Height:=fbmp.Height;
  end;

  image1.canvas.CopyRect(rect(0,0,image1.Width,image1.Height),fbmp.Canvas,rect(0,0,fbmp.Width,fbmp.Height));

  freeandnil(fbmp);
  freeandnil(himg);
end;

procedure TForm10.Timer1Timer(Sender: TObject);
begin
  if loadinprogress=true then Form10.Visible:=true
  else Form10.Visible:=false;

  Memo1.Text:=loadmessage;
  ProgressBar1.Position:=lp;

end;

end.
