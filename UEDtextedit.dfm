object Form8: TForm8
  Left = 0
  Top = 0
  Caption = 'Text Edit'
  ClientHeight = 262
  ClientWidth = 527
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 35
    Height = 13
    Caption = 'Header'
  end
  object Label2: TLabel
    Left = 8
    Top = 77
    Width = 22
    Height = 13
    Caption = 'Text'
  end
  object Label3: TLabel
    Left = 80
    Top = 8
    Width = 34
    Height = 13
    Caption = 'Locale:'
  end
  object Memo1: TMemo
    Left = 8
    Top = 27
    Width = 321
    Height = 46
    HideSelection = False
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Memo2: TMemo
    Left = 0
    Top = 96
    Width = 527
    Height = 166
    Align = alBottom
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 335
    Top = 27
    Width = 184
    Height = 21
    TabOrder = 2
  end
  object Button1: TButton
    Left = 400
    Top = 54
    Width = 58
    Height = 25
    Caption = 'save'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 464
    Top = 54
    Width = 55
    Height = 25
    Caption = 'load'
    TabOrder = 4
    OnClick = Button2Click
  end
  object CheckBox1: TCheckBox
    Left = 247
    Top = 4
    Width = 97
    Height = 17
    Caption = 'Plain text'
    TabOrder = 5
  end
  object CheckBox2: TCheckBox
    Left = 335
    Top = 4
    Width = 74
    Height = 17
    Caption = 'Script'
    TabOrder = 6
  end
  object Button3: TButton
    Left = 335
    Top = 54
    Width = 59
    Height = 25
    Caption = 'show strarr'
    TabOrder = 7
    OnClick = Button3Click
  end
  object CheckBox3: TCheckBox
    Left = 422
    Top = 4
    Width = 97
    Height = 17
    Caption = 'Journal'
    TabOrder = 8
  end
  object Button4: TButton
    Left = 464
    Top = 81
    Width = 55
    Height = 14
    Caption = 'freejrn'
    TabOrder = 9
    OnClick = Button4Click
  end
  object Edit2: TComboBox
    Left = 117
    Top = 5
    Width = 122
    Height = 21
    ItemIndex = 0
    TabOrder = 10
    Text = 'en'
    Items.Strings = (
      'en'
      'ru')
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 480
    Top = 240
  end
end
