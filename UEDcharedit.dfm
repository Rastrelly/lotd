object Form4: TForm4
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Character Editor'
  ClientHeight = 535
  ClientWidth = 611
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
    Left = 289
    Top = 53
    Width = 44
    Height = 13
    Caption = 'spellbook'
  end
  object Label2: TLabel
    Left = 162
    Top = 3
    Width = 8
    Height = 13
    Caption = 'id'
  end
  object Label3: TLabel
    Left = 346
    Top = 5
    Width = 40
    Height = 13
    Caption = 'override'
  end
  object Label4: TLabel
    Left = 450
    Top = 53
    Width = 26
    Height = 13
    Caption = 'perks'
  end
  object Label5: TLabel
    Left = 458
    Top = 494
    Width = 17
    Height = 13
    Caption = 'sex'
  end
  object Label8: TLabel
    Left = 160
    Top = 504
    Width = 38
    Height = 13
    Caption = 'element'
  end
  object Label6: TLabel
    Left = 425
    Top = 462
    Width = 18
    Height = 13
    Caption = 'loot'
  end
  object Label7: TLabel
    Left = 519
    Top = 462
    Width = 34
    Height = 13
    Caption = 'chance'
  end
  object Label9: TLabel
    Left = 280
    Top = 504
    Width = 33
    Height = 13
    Caption = 'journal'
  end
  object LabeledEdit1: TLabeledEdit
    Left = 162
    Top = 72
    Width = 121
    Height = 21
    EditLabel.Width = 26
    EditLabel.Height = 13
    EditLabel.Caption = 'name'
    TabOrder = 0
  end
  object LabeledEdit2: TLabeledEdit
    Left = 162
    Top = 155
    Width = 121
    Height = 21
    EditLabel.Width = 41
    EditLabel.Height = 13
    EditLabel.Caption = 'strength'
    TabOrder = 1
  end
  object LabeledEdit3: TLabeledEdit
    Left = 162
    Top = 195
    Width = 121
    Height = 21
    EditLabel.Width = 53
    EditLabel.Height = 13
    EditLabel.Caption = 'intelligence'
    TabOrder = 2
  end
  object LabeledEdit4: TLabeledEdit
    Left = 162
    Top = 235
    Width = 121
    Height = 21
    EditLabel.Width = 29
    EditLabel.Height = 13
    EditLabel.Caption = 'speed'
    TabOrder = 3
  end
  object LabeledEdit5: TLabeledEdit
    Left = 162
    Top = 275
    Width = 121
    Height = 21
    EditLabel.Width = 51
    EditLabel.Height = 13
    EditLabel.Caption = 'endurance'
    TabOrder = 4
  end
  object LabeledEdit6: TLabeledEdit
    Left = 162
    Top = 315
    Width = 121
    Height = 21
    EditLabel.Width = 29
    EditLabel.Height = 13
    EditLabel.Caption = 'sword'
    TabOrder = 5
  end
  object LabeledEdit7: TLabeledEdit
    Left = 162
    Top = 355
    Width = 121
    Height = 21
    EditLabel.Width = 20
    EditLabel.Height = 13
    EditLabel.Caption = 'bow'
    TabOrder = 6
  end
  object LabeledEdit8: TLabeledEdit
    Left = 162
    Top = 395
    Width = 121
    Height = 21
    EditLabel.Width = 27
    EditLabel.Height = 13
    EditLabel.Caption = 'magic'
    TabOrder = 7
  end
  object LabeledEdit9: TLabeledEdit
    Left = 162
    Top = 435
    Width = 121
    Height = 21
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = 'armor'
    TabOrder = 8
  end
  object CheckListBox1: TCheckListBox
    Left = 289
    Top = 72
    Width = 154
    Height = 384
    OnClickCheck = CheckListBox1ClickCheck
    ItemHeight = 13
    TabOrder = 9
  end
  object Edit1: TEdit
    Left = 162
    Top = 19
    Width = 57
    Height = 21
    TabOrder = 10
    Text = '0'
  end
  object Button1: TButton
    Left = 225
    Top = 17
    Width = 49
    Height = 25
    Caption = 'load'
    TabOrder = 11
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 280
    Top = 17
    Width = 51
    Height = 25
    Caption = 'save'
    TabOrder = 12
    OnClick = Button2Click
  end
  object LabeledEdit10: TLabeledEdit
    Left = 162
    Top = 112
    Width = 121
    Height = 21
    EditLabel.Width = 22
    EditLabel.Height = 13
    EditLabel.Caption = 'level'
    TabOrder = 13
  end
  object Edit2: TEdit
    Left = 346
    Top = 19
    Width = 98
    Height = 21
    TabOrder = 14
    Text = 'ru'
  end
  object Edit3: TEdit
    Left = 346
    Top = 45
    Width = 98
    Height = 21
    TabOrder = 15
  end
  object Memo1: TMemo
    Left = 218
    Top = 517
    Width = 185
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 16
    Visible = False
  end
  object LabeledEdit11: TLabeledEdit
    Left = 162
    Top = 477
    Width = 121
    Height = 21
    EditLabel.Width = 176
    EditLabel.Height = 13
    EditLabel.Caption = 'species (living/angel/demon/undead)'
    TabOrder = 17
  end
  object CheckBox1: TCheckBox
    Left = 289
    Top = 478
    Width = 88
    Height = 17
    Caption = 'boss'
    TabOrder = 18
  end
  object Button3: TButton
    Left = 225
    Top = 45
    Width = 49
    Height = 25
    Caption = 'fight'
    TabOrder = 19
    OnClick = Button3Click
  end
  object CheckListBox2: TCheckListBox
    Left = 449
    Top = 72
    Width = 154
    Height = 384
    OnClickCheck = CheckListBox2ClickCheck
    ItemHeight = 13
    TabOrder = 20
  end
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 156
    Height = 535
    Align = alLeft
    ItemHeight = 13
    TabOrder = 21
    OnClick = ListBox1Click
  end
  object Button4: TButton
    Left = 528
    Top = 8
    Width = 75
    Height = 25
    Caption = 'read player'
    TabOrder = 22
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 528
    Top = 39
    Width = 75
    Height = 25
    Caption = 'apply to player'
    TabOrder = 23
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 450
    Top = 8
    Width = 75
    Height = 25
    Caption = 'add perk pnt'
    TabOrder = 24
    OnClick = Button6Click
  end
  object ComboBox1: TComboBox
    Left = 458
    Top = 506
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 25
    Text = 'male'
    Items.Strings = (
      'male'
      'female')
  end
  object ComboBox5: TComboBox
    Left = 204
    Top = 504
    Width = 70
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 26
    Text = 'Neutral'
    Items.Strings = (
      'Neutral'
      'Earth'
      'Air'
      'Water'
      'Fire')
  end
  object Edit4: TEdit
    Left = 449
    Top = 462
    Width = 64
    Height = 21
    TabOrder = 27
  end
  object Edit5: TEdit
    Left = 559
    Top = 462
    Width = 44
    Height = 21
    TabOrder = 28
  end
  object Edit6: TEdit
    Left = 319
    Top = 504
    Width = 106
    Height = 21
    TabOrder = 29
    Text = '-1'
  end
  object Button7: TButton
    Left = 431
    Top = 502
    Width = 21
    Height = 25
    Caption = '...'
    TabOrder = 30
    OnClick = Button7Click
  end
  object Timer1: TTimer
    Interval = 200
    OnTimer = Timer1Timer
    Left = 394
    Top = 368
  end
end
