object Form7: TForm7
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Item editor'
  ClientHeight = 544
  ClientWidth = 601
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
  object LabeledEdit1: TLabeledEdit
    Left = 8
    Top = 69
    Width = 121
    Height = 21
    EditLabel.Width = 27
    EditLabel.Height = 13
    EditLabel.Caption = 'Name'
    TabOrder = 0
  end
  object LabeledEdit2: TLabeledEdit
    Left = 144
    Top = 69
    Width = 121
    Height = 21
    EditLabel.Width = 30
    EditLabel.Height = 13
    EditLabel.Caption = 'Locale'
    TabOrder = 1
    Text = 'ru'
  end
  object LabeledEdit3: TLabeledEdit
    Left = 280
    Top = 69
    Width = 121
    Height = 21
    EditLabel.Width = 72
    EditLabel.Height = 13
    EditLabel.Caption = 'Override Name'
    TabOrder = 2
  end
  object LabeledEdit4: TLabeledEdit
    Left = 8
    Top = 24
    Width = 121
    Height = 21
    EditLabel.Width = 10
    EditLabel.Height = 13
    EditLabel.Caption = 'Id'
    TabOrder = 3
  end
  object Button1: TButton
    Left = 144
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Load'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 225
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 5
    OnClick = Button2Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 96
    Width = 393
    Height = 215
    Caption = 'Bonuses and effects'
    TabOrder = 6
    object Label1: TLabel
      Left = 16
      Top = 14
      Width = 24
      Height = 13
      Caption = 'Type'
    end
    object Label2: TLabel
      Left = 288
      Top = 91
      Width = 29
      Height = 13
      Caption = 'Armor'
    end
    object Label4: TLabel
      Left = 288
      Top = 131
      Width = 17
      Height = 13
      Caption = 'Hat'
    end
    object LabeledEdit5: TLabeledEdit
      Left = 16
      Top = 66
      Width = 121
      Height = 21
      EditLabel.Width = 42
      EditLabel.Height = 13
      EditLabel.Caption = 'Strength'
      TabOrder = 0
    end
    object LabeledEdit6: TLabeledEdit
      Left = 16
      Top = 106
      Width = 121
      Height = 21
      EditLabel.Width = 55
      EditLabel.Height = 13
      EditLabel.Caption = 'Intelligence'
      TabOrder = 1
    end
    object LabeledEdit7: TLabeledEdit
      Left = 16
      Top = 146
      Width = 121
      Height = 21
      EditLabel.Width = 30
      EditLabel.Height = 13
      EditLabel.Caption = 'Speed'
      TabOrder = 2
    end
    object LabeledEdit8: TLabeledEdit
      Left = 16
      Top = 186
      Width = 121
      Height = 21
      EditLabel.Width = 51
      EditLabel.Height = 13
      EditLabel.Caption = 'Endurance'
      TabOrder = 3
    end
    object ComboBox1: TComboBox
      Left = 16
      Top = 28
      Width = 370
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 4
      Text = 'Misc'
      Items.Strings = (
        'Misc'
        'Sword'
        'Bow'
        'Armor'
        'Hat')
    end
    object LabeledEdit9: TLabeledEdit
      Left = 152
      Top = 66
      Width = 121
      Height = 21
      EditLabel.Width = 30
      EditLabel.Height = 13
      EditLabel.Caption = 'Sword'
      TabOrder = 5
    end
    object LabeledEdit10: TLabeledEdit
      Left = 152
      Top = 106
      Width = 121
      Height = 21
      EditLabel.Width = 27
      EditLabel.Height = 13
      EditLabel.Caption = 'Magic'
      TabOrder = 6
    end
    object LabeledEdit11: TLabeledEdit
      Left = 152
      Top = 146
      Width = 121
      Height = 21
      EditLabel.Width = 20
      EditLabel.Height = 13
      EditLabel.Caption = 'Bow'
      TabOrder = 7
    end
    object LabeledEdit12: TLabeledEdit
      Left = 152
      Top = 186
      Width = 121
      Height = 21
      EditLabel.Width = 29
      EditLabel.Height = 13
      EditLabel.Caption = 'Armor'
      TabOrder = 8
    end
    object LabeledEdit13: TLabeledEdit
      Left = 288
      Top = 66
      Width = 95
      Height = 21
      EditLabel.Width = 23
      EditLabel.Height = 13
      EditLabel.Caption = 'Card'
      TabOrder = 9
    end
    object Edit1: TEdit
      Left = 288
      Top = 106
      Width = 95
      Height = 21
      TabOrder = 10
    end
    object Edit4: TEdit
      Left = 288
      Top = 146
      Width = 95
      Height = 21
      TabOrder = 11
    end
    object CheckBox1: TCheckBox
      Left = 288
      Top = 172
      Width = 97
      Height = 17
      Caption = 'Remove hair'
      TabOrder = 12
    end
  end
  object ListBox1: TListBox
    Left = 410
    Top = 0
    Width = 191
    Height = 544
    Align = alRight
    ItemHeight = 13
    TabOrder = 7
    OnClick = ListBox1Click
  end
  object Button3: TButton
    Left = 306
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Give Player'
    TabOrder = 8
    OnClick = Button3Click
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 312
    Width = 393
    Height = 57
    Caption = 'crafting'
    TabOrder = 9
    object Label3: TLabel
      Left = 143
      Top = 24
      Width = 8
      Height = 13
      Caption = '+'
    end
    object Edit2: TEdit
      Left = 16
      Top = 24
      Width = 121
      Height = 21
      TabOrder = 0
      Text = '-1'
    end
  end
  object Edit3: TEdit
    Left = 165
    Top = 336
    Width = 121
    Height = 21
    TabOrder = 10
    Text = '-1'
  end
  object Panel1: TPanel
    Left = 8
    Top = 375
    Width = 396
    Height = 161
    TabOrder = 11
    object GroupBox3: TGroupBox
      Left = 1
      Top = 1
      Width = 394
      Height = 159
      Align = alClient
      Caption = 'loot list'
      TabOrder = 0
      object Memo1: TMemo
        Left = 15
        Top = 16
        Width = 314
        Height = 140
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object Button4: TButton
        Left = 335
        Top = 16
        Width = 52
        Height = 25
        Caption = 'load'
        TabOrder = 1
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 335
        Top = 47
        Width = 50
        Height = 25
        Caption = 'save'
        TabOrder = 2
        OnClick = Button5Click
      end
    end
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 376
    Top = 16
  end
end
