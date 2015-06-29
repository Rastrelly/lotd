object Form5: TForm5
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Settings'
  ClientHeight = 489
  ClientWidth = 524
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 133
    Height = 13
    Caption = 'Language (requires restart)'
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 24
    Width = 145
    Height = 21
    TabOrder = 0
    Items.Strings = (
      'en'
      'ru')
  end
  object Button1: TButton
    Left = 154
    Top = 22
    Width = 73
    Height = 25
    Caption = 'Set'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 438
    Top = 359
    Width = 78
    Height = 122
    Caption = 'OK'
    TabOrder = 2
    OnClick = Button2Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 51
    Width = 227
    Height = 169
    Caption = 'Movement'
    TabOrder = 3
    object Label2: TLabel
      Left = 16
      Top = 24
      Width = 82
      Height = 13
      Caption = 'Movement speed'
    end
    object Label3: TLabel
      Left = 16
      Top = 77
      Width = 68
      Height = 13
      Caption = 'Turning speed'
    end
    object TrackBar1: TTrackBar
      Left = 16
      Top = 43
      Width = 208
      Height = 45
      Max = 1999
      Min = 1
      Position = 1
      TabOrder = 0
      OnChange = TrackBar1Change
    end
    object TrackBar2: TTrackBar
      Left = 16
      Top = 96
      Width = 208
      Height = 45
      Max = 100
      Min = 1
      Position = 1
      TabOrder = 1
      OnChange = TrackBar2Change
    end
    object Button3: TButton
      Left = 149
      Top = 128
      Width = 75
      Height = 25
      Caption = 'Default'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 241
    Top = 8
    Width = 275
    Height = 345
    Caption = 'Graphics'
    TabOrder = 4
    object Label4: TLabel
      Left = 9
      Top = 15
      Width = 116
      Height = 13
      Caption = 'Block rendering distance'
    end
    object Label5: TLabel
      Left = 209
      Top = 220
      Width = 61
      Height = 13
      Caption = 'Fog distance'
      Visible = False
    end
    object Label6: TLabel
      Left = 209
      Top = 258
      Width = 106
      Height = 13
      Caption = 'Camera View Distance'
      Visible = False
    end
    object Label10: TLabel
      Left = 16
      Top = 66
      Width = 50
      Height = 13
      Caption = 'Brightness'
    end
    object Label11: TLabel
      Left = 8
      Top = 246
      Width = 54
      Height = 13
      Caption = 'Antialiasing'
    end
    object Label12: TLabel
      Left = 8
      Top = 263
      Width = 124
      Height = 13
      Caption = 'Card size (reqires restart)'
    end
    object Label16: TLabel
      Left = 16
      Top = 96
      Width = 73
      Height = 13
      Caption = 'Texture quality'
    end
    object Edit1: TEdit
      Left = 9
      Top = 31
      Width = 113
      Height = 21
      TabOrder = 0
      Text = '3'
      OnChange = Edit1Change
    end
    object Edit2: TEdit
      Left = 209
      Top = 236
      Width = 113
      Height = 21
      TabOrder = 1
      Text = '600'
      Visible = False
      OnChange = Edit2Change
    end
    object Edit3: TEdit
      Left = 209
      Top = 274
      Width = 113
      Height = 21
      TabOrder = 2
      Text = '600'
      Visible = False
      OnChange = Edit3Change
    end
    object Button4: TButton
      Left = 197
      Top = 310
      Width = 75
      Height = 25
      Caption = 'Default'
      TabOrder = 3
      OnClick = Button4Click
    end
    object TrackBar5: TTrackBar
      Left = 88
      Top = 65
      Width = 177
      Height = 26
      Max = 200
      Min = 1
      Position = 1
      TabOrder = 4
      OnChange = TrackBar5Change
    end
    object CheckBox6: TCheckBox
      Left = 16
      Top = 117
      Width = 241
      Height = 17
      Caption = 'Less block redraws'
      TabOrder = 5
      OnClick = CheckBox6Click
    end
    object ComboBox2: TComboBox
      Left = 70
      Top = 243
      Width = 53
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 6
      Text = '0'
      Items.Strings = (
        '0'
        '2'
        '4'
        '8'
        '16')
    end
    object TrackBar6: TTrackBar
      Left = 8
      Top = 278
      Width = 256
      Height = 26
      Max = 50
      Min = -20
      TabOrder = 7
      OnChange = TrackBar6Change
    end
    object CheckBox8: TCheckBox
      Left = 16
      Top = 135
      Width = 241
      Height = 17
      Caption = 'Show tooltips'
      TabOrder = 8
      OnClick = CheckBox8Click
    end
    object GroupBox6: TGroupBox
      Left = 131
      Top = 31
      Width = 134
      Height = 35
      Caption = 'Fullscreen'
      TabOrder = 9
      object Label15: TLabel
        Left = 3
        Top = 60
        Width = 61
        Height = 13
        Caption = 'Refresh freq'
        Visible = False
      end
      object CheckBox10: TCheckBox
        Left = 8
        Top = 15
        Width = 65
        Height = 17
        Caption = 'Enabled'
        TabOrder = 0
        OnClick = CheckBox10Click
      end
      object ComboBox3: TComboBox
        Left = 8
        Top = 38
        Width = 116
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 1
        Text = '320x240'
        Visible = False
        OnChange = ComboBox3Change
        Items.Strings = (
          '320x240'
          '640x480'
          '800x600'
          '1024x768'
          '1280x1024'
          '1920x1280'
          '320x180'
          '640x360'
          '800x450'
          '1024x576'
          '1280x720'
          '1440x810'
          '1920x1080')
      end
      object Edit5: TEdit
        Left = 3
        Top = 79
        Width = 116
        Height = 21
        TabOrder = 2
        Text = '60'
        Visible = False
      end
      object Button5: TButton
        Left = 71
        Top = 13
        Width = 59
        Height = 25
        Caption = 'init'
        TabOrder = 3
        Visible = False
        OnClick = Button5Click
      end
    end
    object CheckBox11: TCheckBox
      Left = 152
      Top = 245
      Width = 97
      Height = 17
      Caption = 'VSync'
      TabOrder = 10
      OnClick = CheckBox11Click
    end
    object CheckBox12: TCheckBox
      Left = 16
      Top = 154
      Width = 241
      Height = 17
      Caption = 'No 3d doors'
      TabOrder = 11
      OnClick = CheckBox12Click
    end
    object CheckBox13: TCheckBox
      Left = 16
      Top = 173
      Width = 241
      Height = 17
      Caption = 'No additional light src'
      TabOrder = 12
      OnClick = CheckBox13Click
    end
    object CheckBox14: TCheckBox
      Left = 16
      Top = 192
      Width = 241
      Height = 17
      Caption = 'No fire particles'
      TabOrder = 13
      OnClick = CheckBox14Click
    end
    object CheckBox15: TCheckBox
      Left = 16
      Top = 315
      Width = 175
      Height = 17
      Caption = 'Multithread (requires restart)'
      Enabled = False
      TabOrder = 14
      OnClick = CheckBox15Click
    end
    object ComboBox4: TComboBox
      Left = 144
      Top = 96
      Width = 121
      Height = 21
      TabOrder = 15
      Text = 'ComboBox4'
      OnChange = ComboBox4Change
    end
    object CheckBox16: TCheckBox
      Left = 16
      Top = 211
      Width = 241
      Height = 17
      Caption = 'No autogenerated grass'
      TabOrder = 16
      OnClick = CheckBox16Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 332
    Width = 227
    Height = 135
    Caption = 'Sound'
    TabOrder = 5
    object Label7: TLabel
      Left = 41
      Top = 24
      Width = 72
      Height = 13
      Caption = 'Sounds volume'
    end
    object Label8: TLabel
      Left = 44
      Top = 81
      Width = 63
      Height = 13
      Caption = 'Music volume'
    end
    object Label9: TLabel
      Left = 120
      Top = 8
      Width = 65
      Height = 13
      Caption = 'Sound quality'
      Visible = False
    end
    object TrackBar3: TTrackBar
      Left = 16
      Top = 43
      Width = 193
      Height = 45
      Max = 100
      TabOrder = 0
      OnChange = TrackBar3Change
    end
    object TrackBar4: TTrackBar
      Left = 16
      Top = 100
      Width = 193
      Height = 29
      Max = 100
      TabOrder = 1
      OnChange = TrackBar4Change
    end
    object Edit4: TEdit
      Left = 119
      Top = 27
      Width = 86
      Height = 21
      TabOrder = 2
      Text = '44100'
      Visible = False
      OnChange = Edit4Change
    end
    object CheckBox1: TCheckBox
      Left = 22
      Top = 22
      Width = 19
      Height = 17
      TabOrder = 3
      OnClick = CheckBox1Click
    end
    object CheckBox2: TCheckBox
      Left = 22
      Top = 77
      Width = 16
      Height = 17
      TabOrder = 4
      OnClick = CheckBox2Click
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 226
    Width = 227
    Height = 100
    Caption = 'Battle log'
    TabOrder = 6
    object CheckBox3: TCheckBox
      Left = 16
      Top = 20
      Width = 97
      Height = 17
      Caption = 'Show battle log'
      TabOrder = 0
      OnClick = CheckBox3Click
    end
    object CheckBox17: TCheckBox
      Left = 16
      Top = 43
      Width = 193
      Height = 17
      Caption = 'Extended damage info'
      TabOrder = 1
      OnClick = CheckBox17Click
    end
  end
  object GroupBox5: TGroupBox
    Left = 241
    Top = 359
    Width = 191
    Height = 122
    Caption = 'Gameplay'
    TabOrder = 7
    object Label13: TLabel
      Left = 13
      Top = 19
      Width = 42
      Height = 13
      Caption = 'Difficulty'
    end
    object Label14: TLabel
      Left = 21
      Top = 34
      Width = 6
      Height = 13
      Caption = '0'
    end
    object CheckBox4: TCheckBox
      Left = 13
      Top = 50
      Width = 148
      Height = 17
      Caption = 'Leveling'
      TabOrder = 0
      OnClick = CheckBox4Click
    end
    object CheckBox7: TCheckBox
      Left = 13
      Top = 84
      Width = 148
      Height = 17
      Caption = 'Random mode'
      TabOrder = 1
      OnClick = CheckBox7Click
    end
    object CheckBox9: TCheckBox
      Left = 13
      Top = 101
      Width = 97
      Height = 17
      Caption = 'Hardcore'
      TabOrder = 2
      OnClick = CheckBox9Click
    end
    object TrackBar7: TTrackBar
      Left = 61
      Top = 14
      Width = 117
      Height = 37
      Min = -10
      TabOrder = 3
      OnChange = TrackBar7Change
    end
    object CheckBox5: TCheckBox
      Left = 13
      Top = 66
      Width = 148
      Height = 17
      Caption = 'Auto increase deck'
      TabOrder = 4
      OnClick = CheckBox5Click
    end
  end
end
