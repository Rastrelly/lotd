unit UEDFullscreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, GLScene, GLFullScreenViewer;

type
  TForm15old = class(TForm)
    procedure GLFullScreenViewer1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure GLFullScreenViewer1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GLFullScreenViewer1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GLFullScreenViewer1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GLFullScreenViewer1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GLFullScreenViewer1KeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form15old: TForm15old;

implementation

{$R *.dfm}

uses UED_main;

procedure TForm15old.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TForm15old.GLFullScreenViewer1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //Form1.OnKeyDown(key);
end;

procedure TForm15old.GLFullScreenViewer1KeyPress(Sender: TObject; var Key: Char);
begin
  //Form1.OnKeyPress;
end;

procedure TForm15old.GLFullScreenViewer1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //Form1.OnKeyUp;
end;

procedure TForm15old.GLFullScreenViewer1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form1.GeneralMouseDown(x,y);
end;

procedure TForm15old.GLFullScreenViewer1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.GeneralMouseMove(x,y);
end;

procedure TForm15old.GLFullScreenViewer1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form1.GeneralMouseUp(x,y,button);
end;

end.
