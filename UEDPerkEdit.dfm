object Form11: TForm11
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'perk editor'
  ClientHeight = 353
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 8
    Height = 13
    Caption = 'id'
  end
  object Label2: TLabel
    Left = 8
    Top = 54
    Width = 26
    Height = 13
    Caption = 'name'
  end
  object Label12: TLabel
    Left = 8
    Top = 308
    Width = 83
    Height = 13
    Caption = 'hardcoded effect'
  end
  object Label4: TLabel
    Left = 8
    Top = 131
    Width = 13
    Height = 13
    Caption = 'str'
  end
  object Label5: TLabel
    Left = 8
    Top = 161
    Width = 14
    Height = 13
    Caption = 'agi'
  end
  object Label6: TLabel
    Left = 8
    Top = 193
    Width = 12
    Height = 13
    Caption = 'int'
  end
  object Label7: TLabel
    Left = 8
    Top = 215
    Width = 12
    Height = 13
    Caption = 'en'
  end
  object Label8: TLabel
    Left = 159
    Top = 139
    Width = 13
    Height = 13
    Caption = 'sw'
  end
  object Label9: TLabel
    Left = 159
    Top = 166
    Width = 14
    Height = 13
    Caption = 'bw'
  end
  object Label10: TLabel
    Left = 159
    Top = 193
    Width = 20
    Height = 13
    Caption = 'mag'
  end
  object Label11: TLabel
    Left = 159
    Top = 215
    Width = 18
    Height = 13
    Caption = 'arm'
  end
  object Label3: TLabel
    Left = 157
    Top = 239
    Width = 21
    Height = 13
    Caption = 'perk'
  end
  object Label13: TLabel
    Left = 141
    Top = 266
    Width = 35
    Height = 13
    Caption = 'species'
  end
  object Label14: TLabel
    Left = 102
    Top = 286
    Width = 203
    Height = 13
    Caption = '0 - living; 1 - angel; 2 - demon; 3 - undead'
  end
  object Label15: TLabel
    Left = 8
    Top = 239
    Width = 21
    Height = 13
    Caption = 'card'
  end
  object Edit1: TEdit
    Left = 8
    Top = 27
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object Edit2: TEdit
    Left = 8
    Top = 73
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'perk name'
  end
  object Edit3: TEdit
    Left = 135
    Top = 73
    Width = 34
    Height = 21
    TabOrder = 2
    Text = 'en'
  end
  object Button1: TButton
    Left = 230
    Top = 8
    Width = 75
    Height = 25
    Caption = 'save'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 230
    Top = 39
    Width = 75
    Height = 25
    Caption = 'load'
    TabOrder = 4
    OnClick = Button2Click
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 327
    Width = 297
    Height = 21
    TabOrder = 5
    Text = 'ComboBox1'
  end
  object Edit4: TEdit
    Left = 32
    Top = 131
    Width = 121
    Height = 21
    TabOrder = 6
    Text = '0'
  end
  object Edit5: TEdit
    Left = 32
    Top = 158
    Width = 121
    Height = 21
    TabOrder = 7
    Text = '0'
  end
  object Edit6: TEdit
    Left = 32
    Top = 185
    Width = 121
    Height = 21
    TabOrder = 8
    Text = '0'
  end
  object Edit7: TEdit
    Left = 32
    Top = 212
    Width = 121
    Height = 21
    TabOrder = 9
    Text = '0'
  end
  object Edit8: TEdit
    Left = 184
    Top = 131
    Width = 121
    Height = 21
    TabOrder = 10
    Text = '0'
  end
  object Edit9: TEdit
    Left = 184
    Top = 158
    Width = 121
    Height = 21
    TabOrder = 11
    Text = '0'
  end
  object Edit10: TEdit
    Left = 184
    Top = 185
    Width = 121
    Height = 21
    TabOrder = 12
    Text = '0'
  end
  object Edit11: TEdit
    Left = 184
    Top = 212
    Width = 121
    Height = 21
    TabOrder = 13
    Text = '0'
  end
  object Button3: TButton
    Left = 8
    Top = 100
    Width = 75
    Height = 25
    Caption = 'SET BONUSES'
    TabOrder = 14
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 89
    Top = 100
    Width = 112
    Height = 25
    Caption = 'SET REQUIREMENTS'
    TabOrder = 15
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 175
    Top = 71
    Width = 75
    Height = 25
    Caption = 'add override'
    TabOrder = 16
    OnClick = Button5Click
  end
  object Edit12: TEdit
    Left = 184
    Top = 239
    Width = 121
    Height = 21
    TabOrder = 17
    Text = '-1'
  end
  object Edit13: TEdit
    Left = 184
    Top = 266
    Width = 121
    Height = 21
    TabOrder = 18
    Text = '-1'
  end
  object ListBox1: TListBox
    Left = 313
    Top = 0
    Width = 167
    Height = 353
    Align = alRight
    ItemHeight = 13
    TabOrder = 19
    OnClick = ListBox1Click
  end
  object Edit14: TEdit
    Left = 32
    Top = 239
    Width = 121
    Height = 21
    TabOrder = 20
    Text = '-1'
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 272
    Top = 72
  end
end
