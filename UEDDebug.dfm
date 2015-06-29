object Form14: TForm14
  Left = 0
  Top = 0
  Caption = 'debugging and system editing'
  ClientHeight = 489
  ClientWidth = 445
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 185
    Height = 299
    Caption = 'cadencer 1 control blocks'
    TabOrder = 0
    object CheckBox1: TCheckBox
      Left = 16
      Top = 24
      Width = 97
      Height = 17
      Caption = 'CheckBox1'
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object CheckBox2: TCheckBox
      Left = 16
      Top = 47
      Width = 97
      Height = 17
      Caption = 'CheckBox2'
      TabOrder = 1
      OnClick = CheckBox2Click
    end
    object CheckBox3: TCheckBox
      Left = 16
      Top = 70
      Width = 97
      Height = 17
      Caption = 'CheckBox3'
      TabOrder = 2
      OnClick = CheckBox3Click
    end
    object CheckBox4: TCheckBox
      Left = 16
      Top = 93
      Width = 97
      Height = 17
      Caption = 'CheckBox4'
      TabOrder = 3
      OnClick = CheckBox4Click
    end
    object CheckBox5: TCheckBox
      Left = 16
      Top = 116
      Width = 97
      Height = 17
      Caption = 'CheckBox5'
      TabOrder = 4
      OnClick = CheckBox5Click
    end
    object CheckBox6: TCheckBox
      Left = 16
      Top = 139
      Width = 97
      Height = 17
      Caption = 'CheckBox6'
      TabOrder = 5
      OnClick = CheckBox6Click
    end
    object CheckBox7: TCheckBox
      Left = 16
      Top = 162
      Width = 97
      Height = 17
      Caption = 'CheckBox7'
      TabOrder = 6
      OnClick = CheckBox7Click
    end
    object CheckBox8: TCheckBox
      Left = 16
      Top = 185
      Width = 97
      Height = 17
      Caption = 'CheckBox8'
      TabOrder = 7
      OnClick = CheckBox8Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 199
    Top = 8
    Width = 242
    Height = 64
    Caption = 'gamestate'
    TabOrder = 1
    object LabeledEdit1: TLabeledEdit
      Left = 16
      Top = 34
      Width = 49
      Height = 21
      EditLabel.Width = 51
      EditLabel.Height = 13
      EditLabel.Caption = 'level steps'
      TabOrder = 0
      Text = '0'
    end
    object Button1: TButton
      Left = 192
      Top = 36
      Width = 47
      Height = 25
      Caption = 'set'
      TabOrder = 1
      OnClick = Button1Click
    end
    object LabeledEdit2: TLabeledEdit
      Left = 96
      Top = 34
      Width = 49
      Height = 21
      EditLabel.Width = 37
      EditLabel.Height = 13
      EditLabel.Caption = 'level no'
      TabOrder = 2
      Text = '0'
    end
  end
  object GroupBox3: TGroupBox
    Left = 199
    Top = 78
    Width = 242
    Height = 229
    Caption = 'bodypartdata config'
    TabOrder = 2
    object Label1: TLabel
      Left = 16
      Top = 107
      Width = 8
      Height = 13
      Caption = 'w'
    end
    object Label2: TLabel
      Left = 103
      Top = 107
      Width = 6
      Height = 13
      Caption = 'h'
    end
    object Label3: TLabel
      Left = 16
      Top = 75
      Width = 8
      Height = 13
      Caption = 'id'
    end
    object Label4: TLabel
      Left = 16
      Top = 151
      Width = 6
      Height = 13
      Caption = 'x'
    end
    object Label5: TLabel
      Left = 103
      Top = 151
      Width = 6
      Height = 13
      Caption = 'y'
    end
    object ComboBox1: TComboBox
      Left = 16
      Top = 21
      Width = 207
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'male'
      Items.Strings = (
        'male'
        'female')
    end
    object ComboBox2: TComboBox
      Left = 16
      Top = 48
      Width = 207
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = 'face'
      Items.Strings = (
        'face'
        'hair'
        'hair back'
        'torso'
        'hat')
    end
    object Edit1: TEdit
      Left = 16
      Top = 126
      Width = 81
      Height = 21
      TabOrder = 2
      Text = '0'
    end
    object Edit2: TEdit
      Left = 103
      Top = 126
      Width = 81
      Height = 21
      TabOrder = 3
      Text = '0'
    end
    object Edit3: TEdit
      Left = 30
      Top = 75
      Width = 67
      Height = 21
      TabOrder = 4
      Text = '0'
    end
    object Button2: TButton
      Left = 103
      Top = 76
      Width = 34
      Height = 25
      Caption = 'read'
      TabOrder = 5
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 143
      Top = 75
      Width = 34
      Height = 25
      Caption = 'set'
      TabOrder = 6
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 183
      Top = 75
      Width = 48
      Height = 25
      Caption = 'set all'
      TabOrder = 7
      OnClick = Button4Click
    end
    object Edit4: TEdit
      Left = 16
      Top = 170
      Width = 81
      Height = 21
      TabOrder = 8
      Text = '0'
    end
    object Edit5: TEdit
      Left = 103
      Top = 170
      Width = 81
      Height = 21
      TabOrder = 9
      Text = '0'
    end
    object Button5: TButton
      Left = 190
      Top = 106
      Width = 49
      Height = 87
      Caption = 'cc'
      TabOrder = 10
      OnClick = Button5Click
    end
    object CheckBox9: TCheckBox
      Left = 16
      Top = 197
      Width = 81
      Height = 17
      Caption = 'haseb'
      TabOrder = 11
    end
    object CheckBox10: TCheckBox
      Left = 103
      Top = 197
      Width = 97
      Height = 17
      Caption = 'hasbrd'
      TabOrder = 12
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 313
    Width = 433
    Height = 168
    Caption = 'spritelist'
    TabOrder = 3
    object Label6: TLabel
      Left = 221
      Top = 16
      Width = 26
      Height = 13
      Caption = 'name'
    end
    object Label7: TLabel
      Left = 221
      Top = 60
      Width = 39
      Height = 13
      Caption = 'purpose'
    end
    object Label8: TLabel
      Left = 224
      Top = 141
      Width = 18
      Height = 13
      Caption = 'size'
    end
    object Label9: TLabel
      Left = 221
      Top = 106
      Width = 178
      Height = 13
      Caption = '0 - none; 1 - wall deco; 2 - cell deco; '
    end
    object Label10: TLabel
      Left = 270
      Top = 119
      Width = 157
      Height = 13
      Caption = '3 - item on the floor; -1 - unused'
    end
    object Label11: TLabel
      Left = 315
      Top = 142
      Width = 24
      Height = 13
      Caption = 'size2'
    end
    object ListBox1: TListBox
      Left = 16
      Top = 16
      Width = 199
      Height = 149
      ItemHeight = 13
      ScrollWidth = 5
      TabOrder = 0
      OnClick = ListBox1Click
    end
    object Edit6: TEdit
      Left = 221
      Top = 35
      Width = 121
      Height = 21
      TabOrder = 1
      OnChange = Edit6Change
    end
    object Edit7: TEdit
      Left = 221
      Top = 79
      Width = 121
      Height = 21
      TabOrder = 2
      OnChange = Edit7Change
    end
    object Edit8: TEdit
      Left = 248
      Top = 140
      Width = 52
      Height = 21
      TabOrder = 3
      OnChange = Edit8Change
    end
    object Button6: TButton
      Left = 348
      Top = 16
      Width = 75
      Height = 25
      Caption = 'load'
      TabOrder = 4
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 348
      Top = 47
      Width = 75
      Height = 25
      Caption = 'save'
      TabOrder = 5
      OnClick = Button7Click
    end
    object Edit9: TEdit
      Left = 339
      Top = 140
      Width = 52
      Height = 21
      TabOrder = 6
      OnChange = Edit9Change
    end
    object Button8: TButton
      Left = 348
      Top = 75
      Width = 75
      Height = 25
      Caption = 'add'
      TabOrder = 7
      OnClick = Button8Click
    end
  end
end
