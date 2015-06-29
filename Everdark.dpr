program Everdark;

uses
  Vcl.Forms,
  UED_main in 'UED_main.pas' {Form1},
  UEDmapedit in 'UEDmapedit.pas' {Form2},
  UEDcardedit in 'UEDcardedit.pas' {Form3},
  UEDcharedit in 'UEDcharedit.pas' {Form4},
  UEDSettings in 'UEDSettings.pas' {Form5},
  Utalismanedit in 'Utalismanedit.pas' {Form6},
  UEDItemedit in 'UEDItemedit.pas' {Form7},
  UEDtextedit in 'UEDtextedit.pas' {Form8},
  UEDBattlelog in 'UEDBattlelog.pas' {Form9},
  UEDSplash in 'UEDSplash.pas' {Form10},
  UEDPerkEdit in 'UEDPerkEdit.pas' {Form11},
  UEDMap in 'UEDMap.pas' {Form12},
  UEDMonsterlist in 'UEDMonsterlist.pas' {Form13},
  UEDCadencer in 'UEDCadencer.pas',
  UEDDebug in 'UEDDebug.pas' {Form14},
  UEDFullScreen2 in 'UEDFullScreen2.pas' {Form15: TDataModule},
  UFreeMeshEd in 'UFreeMeshEd.pas' {Form16},
  UEDLSourc in 'UEDLSourc.pas' {Form17};

{$R *.res}
{$R Everdark.REC}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  Application.Title := 'Lo of the Dark';
  Application.CreateForm(TForm10, Form10);
  Application.CreateForm(TForm11, Form11);
  Application.CreateForm(TForm12, Form12);
  Application.CreateForm(TForm13, Form13);
  Application.CreateForm(TForm14, Form14);
  Application.CreateForm(TForm15, Form15);
  Application.CreateForm(TForm16, Form16);
  Application.CreateForm(TForm17, Form17);
  Form10.Show;
  Application.CreateForm(TForm1, Form1);
  Form1.Show;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TForm8, Form8);
  Application.CreateForm(TForm9, Form9);
  Application.Run;
end.
