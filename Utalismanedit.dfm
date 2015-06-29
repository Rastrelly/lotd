object Form6: TForm6
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Variable editor'
  ClientHeight = 81
  ClientWidth = 213
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 27
    Height = 13
    Caption = 'var id'
  end
  object Edit1: TEdit
    Left = 8
    Top = 27
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object RadioButton1: TRadioButton
    Left = 48
    Top = 8
    Width = 33
    Height = 17
    Caption = 'int'
    Checked = True
    TabOrder = 1
    TabStop = True
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 87
    Top = 8
    Width = 42
    Height = 17
    Caption = 'str'
    TabOrder = 2
    OnClick = RadioButton2Click
  end
  object Button1: TButton
    Left = 135
    Top = 25
    Width = 75
    Height = 25
    Caption = 'read'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Edit2: TEdit
    Left = 8
    Top = 54
    Width = 121
    Height = 21
    TabOrder = 4
  end
  object Button2: TButton
    Left = 135
    Top = 54
    Width = 75
    Height = 25
    Caption = 'set'
    TabOrder = 5
    OnClick = Button2Click
  end
end
