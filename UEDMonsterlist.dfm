object Form13: TForm13
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'monster list'
  ClientHeight = 524
  ClientWidth = 436
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
  object CheckListBox1: TCheckListBox
    Left = 0
    Top = 0
    Width = 257
    Height = 524
    Align = alLeft
    ItemHeight = 13
    TabOrder = 0
    OnClick = CheckListBox1Click
    ExplicitHeight = 514
  end
  object Button1: TButton
    Left = 263
    Top = 8
    Width = 165
    Height = 25
    Caption = 'Read'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 263
    Top = 39
    Width = 165
    Height = 25
    Caption = 'Save'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 263
    Top = 88
    Width = 75
    Height = 25
    Caption = 'sel all'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 263
    Top = 119
    Width = 75
    Height = 25
    Caption = 'clr all'
    TabOrder = 4
    OnClick = Button4Click
  end
end
