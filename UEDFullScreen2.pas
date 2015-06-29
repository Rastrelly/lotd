unit UEDFullScreen2;

interface

uses
  System.SysUtils, System.Classes, GLScene, GLFullScreenViewer, COntrols;

type
  TForm15 = class(TDataModule)
    GLFullScreenViewer1: TGLFullScreenViewer;
    procedure GLFullScreenViewer1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure GLFullScreenViewer1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GLFullScreenViewer1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form15: TForm15;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UED_main;

{$R *.dfm}

procedure TForm15.GLFullScreenViewer1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 Form1.GeneralMouseDown(x,y,0);
end;

procedure TForm15.GLFullScreenViewer1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.GeneralMouseMove(x,y);
end;

procedure TForm15.GLFullScreenViewer1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form1.GeneralMouseUp(x,y,button);
end;

end.
