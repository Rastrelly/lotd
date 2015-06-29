object Form10: TForm10
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Form10'
  ClientHeight = 300
  ClientWidth = 450
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 450
    Height = 300
    Align = alClient
    ExplicitLeft = 184
    ExplicitTop = 120
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
  object Memo1: TMemo
    Left = 19
    Top = 183
    Width = 412
    Height = 90
    ReadOnly = True
    TabOrder = 0
  end
  object ProgressBar1: TProgressBar
    Left = 19
    Top = 273
    Width = 412
    Height = 14
    Max = 15
    Smooth = True
    Step = 1
    TabOrder = 1
  end
  object Timer1: TTimer
    Interval = 55
    OnTimer = Timer1Timer
    Left = 408
    Top = 16
  end
end
