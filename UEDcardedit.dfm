object Form3: TForm3
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Card editor'
  ClientHeight = 471
  ClientWidth = 463
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
    Left = 176
    Top = 245
    Width = 67
    Height = 13
    Caption = 'governing skill'
  end
  object Image1: TImage
    Left = 310
    Top = 8
    Width = 140
    Height = 220
  end
  object Label2: TLabel
    Left = 197
    Top = 42
    Width = 13
    Height = 13
    Caption = 'loc'
  end
  object Label3: TLabel
    Left = 176
    Top = 209
    Width = 41
    Height = 13
    Caption = 'direction'
  end
  object Label4: TLabel
    Left = 24
    Top = 328
    Width = 47
    Height = 13
    Caption = 'consumes'
  end
  object Label5: TLabel
    Left = 24
    Top = 166
    Width = 20
    Height = 13
    Caption = 'dmg'
  end
  object Label6: TLabel
    Left = 81
    Top = 184
    Width = 4
    Height = 13
    Caption = '-'
  end
  object Label7: TLabel
    Left = 24
    Top = 360
    Width = 26
    Height = 13
    Caption = 'script'
  end
  object Label8: TLabel
    Left = 186
    Top = 328
    Width = 38
    Height = 13
    Caption = 'element'
  end
  object Label9: TLabel
    Left = 186
    Top = 359
    Width = 29
    Height = 13
    Caption = 'sound'
  end
  object LabeledEdit1: TLabeledEdit
    Left = 24
    Top = 101
    Width = 121
    Height = 21
    EditLabel.Width = 13
    EditLabel.Height = 13
    EditLabel.Caption = 'mc'
    TabOrder = 0
  end
  object LabeledEdit2: TLabeledEdit
    Left = 24
    Top = 141
    Width = 121
    Height = 21
    EditLabel.Width = 17
    EditLabel.Height = 13
    EditLabel.Caption = 'hpc'
    TabOrder = 1
  end
  object LabeledEdit3: TLabeledEdit
    Left = 90
    Top = 181
    Width = 55
    Height = 21
    EditLabel.Width = 61
    EditLabel.Height = 13
    EditLabel.Caption = 'LabeledEdit3'
    TabOrder = 2
  end
  object LabeledEdit4: TLabeledEdit
    Left = 24
    Top = 221
    Width = 121
    Height = 21
    EditLabel.Width = 41
    EditLabel.Height = 13
    EditLabel.Caption = 'dmgperc'
    TabOrder = 3
  end
  object LabeledEdit5: TLabeledEdit
    Left = 24
    Top = 261
    Width = 121
    Height = 21
    EditLabel.Width = 30
    EditLabel.Height = 13
    EditLabel.Caption = 'addhp'
    TabOrder = 4
  end
  object LabeledEdit6: TLabeledEdit
    Left = 24
    Top = 301
    Width = 121
    Height = 21
    EditLabel.Width = 32
    EditLabel.Height = 13
    EditLabel.Caption = 'addmp'
    TabOrder = 5
  end
  object LabeledEdit7: TLabeledEdit
    Left = 176
    Top = 101
    Width = 17
    Height = 21
    EditLabel.Width = 50
    EditLabel.Height = 13
    EditLabel.Caption = 'add effect'
    TabOrder = 6
    OnChange = LabeledEdit7Change
  end
  object LabeledEdit8: TLabeledEdit
    Left = 176
    Top = 141
    Width = 65
    Height = 21
    EditLabel.Width = 62
    EditLabel.Height = 13
    EditLabel.Caption = 'effect length'
    TabOrder = 7
  end
  object ComboBox1: TComboBox
    Left = 176
    Top = 261
    Width = 121
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 8
    Text = 'sword'
    Items.Strings = (
      'sword'
      'bow'
      'magic'
      'armor')
  end
  object Button1: TButton
    Left = 191
    Top = 8
    Width = 50
    Height = 25
    Caption = 'load'
    TabOrder = 9
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 247
    Top = 8
    Width = 50
    Height = 25
    Caption = 'save'
    TabOrder = 10
    OnClick = Button2Click
  end
  object ComboBox2: TComboBox
    Left = 24
    Top = 10
    Width = 121
    Height = 21
    TabOrder = 11
    Text = 'Edit'
    OnChange = ComboBox2Change
  end
  object Edit1: TEdit
    Left = 151
    Top = 10
    Width = 33
    Height = 21
    TabOrder = 12
    Text = '0'
  end
  object LabeledEdit9: TLabeledEdit
    Left = 24
    Top = 53
    Width = 121
    Height = 21
    EditLabel.Width = 27
    EditLabel.Height = 13
    EditLabel.Caption = 'Name'
    TabOrder = 13
  end
  object Button3: TButton
    Left = 303
    Top = 230
    Width = 156
    Height = 25
    Caption = 'Make card image'
    TabOrder = 14
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 303
    Top = 261
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 15
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 384
    Top = 261
    Width = 75
    Height = 25
    Caption = 'All'
    TabOrder = 16
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 151
    Top = 39
    Width = 34
    Height = 25
    Caption = 'Refr.'
    TabOrder = 17
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 303
    Top = 292
    Width = 75
    Height = 25
    Caption = 'title font'
    TabOrder = 18
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 384
    Top = 292
    Width = 75
    Height = 25
    Caption = 'text font'
    TabOrder = 19
    OnClick = Button8Click
  end
  object LabeledEdit10: TLabeledEdit
    Left = 148
    Top = 301
    Width = 49
    Height = 21
    EditLabel.Width = 43
    EditLabel.Height = 13
    EditLabel.Caption = 'bonus vs'
    TabOrder = 20
  end
  object LabeledEdit11: TLabeledEdit
    Left = 203
    Top = 301
    Width = 97
    Height = 21
    EditLabel.Width = 90
    EditLabel.Height = 13
    EditLabel.Caption = 'bonus amount (%)'
    TabOrder = 21
  end
  object CheckBox1: TCheckBox
    Left = 176
    Top = 169
    Width = 97
    Height = 17
    Caption = 'accum. effect'
    TabOrder = 22
    OnClick = CheckBox1Click
  end
  object CheckBox2: TCheckBox
    Left = 176
    Top = 186
    Width = 97
    Height = 17
    Caption = 'monster only'
    TabOrder = 23
    OnClick = CheckBox2Click
  end
  object ComboBox3: TComboBox
    Left = 199
    Top = 101
    Width = 98
    Height = 21
    TabOrder = 24
    Text = 'ComboBox3'
    OnChange = ComboBox3Change
  end
  object Edit2: TEdit
    Left = 216
    Top = 39
    Width = 41
    Height = 21
    TabOrder = 25
    Text = 'en'
  end
  object Button9: TButton
    Left = 263
    Top = 37
    Width = 34
    Height = 25
    Caption = 'ok'
    TabOrder = 26
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 263
    Top = 66
    Width = 34
    Height = 25
    Caption = 'orr'
    TabOrder = 27
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 151
    Top = 63
    Width = 106
    Height = 19
    Caption = 'get local name'
    TabOrder = 28
  end
  object LabeledEdit12: TLabeledEdit
    Left = 243
    Top = 141
    Width = 65
    Height = 21
    EditLabel.Width = 61
    EditLabel.Height = 13
    EditLabel.Caption = 'effect strgth'
    TabOrder = 29
  end
  object ComboBox4: TComboBox
    Left = 176
    Top = 224
    Width = 121
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 30
    Text = 'self'
    Items.Strings = (
      'self'
      'target')
  end
  object Edit3: TEdit
    Left = 77
    Top = 328
    Width = 92
    Height = 21
    TabOrder = 31
    Text = '-1'
  end
  object Edit4: TEdit
    Left = 24
    Top = 181
    Width = 51
    Height = 21
    TabOrder = 32
  end
  object Memo1: TMemo
    Left = 24
    Top = 379
    Width = 431
    Height = 84
    ScrollBars = ssVertical
    TabOrder = 33
  end
  object Button12: TButton
    Left = 61
    Top = 360
    Width = 75
    Height = 16
    Caption = 'save script'
    TabOrder = 34
    OnClick = Button12Click
  end
  object ComboBox5: TComboBox
    Left = 230
    Top = 328
    Width = 70
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 35
    Text = 'Neutral'
    Items.Strings = (
      'Neutral'
      'Earth'
      'Air'
      'Water'
      'Fire')
  end
  object Edit5: TEdit
    Left = 230
    Top = 356
    Width = 121
    Height = 21
    TabOrder = 36
    Text = '0'
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 384
    Top = 296
  end
  object FontDialog1: TFontDialog
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Bookman Old Style'
    Font.Style = [fsBold]
    Left = 328
    Top = 296
  end
  object FontDialog2: TFontDialog
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Bookman Old Style'
    Font.Style = []
    Left = 336
    Top = 296
  end
end
