object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'MapEd'
  ClientHeight = 976
  ClientWidth = 1040
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1040
    Height = 976
    Align = alClient
    Caption = 'Panel1'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 1
      Top = 802
      Width = 1038
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitLeft = 243
      ExplicitTop = 42
      ExplicitWidth = 758
    end
    object Panel2: TPanel
      Left = 1
      Top = 42
      Width = 242
      Height = 760
      Align = alLeft
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      object GroupBox1: TGroupBox
        Left = 1
        Top = 236
        Width = 240
        Height = 523
        Align = alClient
        Caption = 'Cell Properties'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object GroupBox7: TGroupBox
          Left = 2
          Top = 161
          Width = 236
          Height = 85
          Align = alTop
          Caption = 'Event controls'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnDblClick = GroupBox7DblClick
          object Label18: TLabel
            Left = 14
            Top = 40
            Width = 22
            Height = 13
            Caption = 'par1'
            ParentShowHint = False
            ShowHint = True
          end
          object Label19: TLabel
            Left = 131
            Top = 40
            Width = 22
            Height = 13
            Caption = 'par2'
            ParentShowHint = False
            ShowHint = True
          end
          object Label16: TLabel
            Left = 10
            Top = 64
            Width = 46
            Height = 13
            Caption = 'Event set'
            ParentShowHint = False
            ShowHint = True
          end
          object CheckBox4: TCheckBox
            Left = 13
            Top = 19
            Width = 97
            Height = 17
            Caption = 'event'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = CheckBox4Click
          end
          object Edit3: TEdit
            Left = 69
            Top = 18
            Width = 22
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            Text = '0'
            OnChange = Edit3Change
          end
          object ComboBox3: TComboBox
            Left = 97
            Top = 18
            Width = 125
            Height = 21
            Style = csDropDownList
            ItemIndex = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            Text = 'none'
            OnChange = ComboBox3Change
            Items.Strings = (
              'none'
              'force battle'
              'make passable'
              'remove wall'
              'attr. altar'
              'key shrine silver'
              'key shrine gold'
              'swap walls/passability by ID'
              'teleport to...'
              'external text msg'
              'show book (text ex)'
              'multievent'
              'angelic altar'
              'demonic altar'
              'undead altar'
              'add card'
              'add item'
              'altar of silence'
              'runic altar (n,e,a,w,f)'
              'orb of wisdom (+ 1 perk)')
          end
          object Edit4: TEdit
            Left = 49
            Top = 40
            Width = 56
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            Text = '0'
            OnChange = Edit4Change
          end
          object Edit6: TEdit
            Left = 167
            Top = 40
            Width = 56
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            Text = '0'
            OnChange = Edit6Change
          end
          object Button15: TButton
            Left = 175
            Top = 62
            Width = 50
            Height = 20
            Caption = '>'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            OnClick = Button15Click
          end
          object Button16: TButton
            Left = 117
            Top = 62
            Width = 52
            Height = 20
            Caption = 'l'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 6
            OnClick = Button16Click
          end
          object Button17: TButton
            Left = 62
            Top = 62
            Width = 49
            Height = 20
            Caption = 's'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 7
            OnClick = Button17Click
          end
        end
        object GroupBox8: TGroupBox
          Left = 2
          Top = 378
          Width = 236
          Height = 170
          Align = alTop
          Caption = 'Free sprite'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnDblClick = GroupBox8DblClick
          object Label11: TLabel
            Left = 12
            Top = 119
            Width = 27
            Height = 13
            Caption = 'sprite'
            ParentShowHint = False
            ShowHint = True
          end
          object Label10: TLabel
            Left = 3
            Top = 100
            Width = 18
            Height = 13
            Caption = 'w,h'
            ParentShowHint = False
            ShowHint = True
          end
          object Label9: TLabel
            Left = 3
            Top = 75
            Width = 25
            Height = 13
            Caption = 'x,y,z'
            ParentShowHint = False
            ShowHint = True
          end
          object SpeedButton3: TSpeedButton
            Left = 186
            Top = 21
            Width = 15
            Height = 15
            Caption = '^'
            OnClick = SpeedButton3Click
          end
          object SpeedButton4: TSpeedButton
            Left = 186
            Top = 37
            Width = 15
            Height = 15
            Caption = 'v'
            OnClick = SpeedButton4Click
          end
          object SpeedButton5: TSpeedButton
            Left = 169
            Top = 31
            Width = 15
            Height = 15
            Caption = '<'
            OnClick = SpeedButton5Click
          end
          object SpeedButton6: TSpeedButton
            Left = 204
            Top = 31
            Width = 15
            Height = 15
            Caption = '>'
            OnClick = SpeedButton6Click
          end
          object Label26: TLabel
            Left = 127
            Top = 99
            Width = 10
            Height = 13
            Caption = 'dr'
            ParentShowHint = False
            ShowHint = True
          end
          object SpeedButton7: TSpeedButton
            Left = 151
            Top = 31
            Width = 15
            Height = 15
            Caption = '<'
            OnClick = SpeedButton7Click
          end
          object SpeedButton8: TSpeedButton
            Left = 221
            Top = 31
            Width = 15
            Height = 15
            Caption = '>'
            OnClick = SpeedButton8Click
          end
          object SpeedButton9: TSpeedButton
            Left = 186
            Top = 6
            Width = 15
            Height = 15
            Caption = '^'
            OnClick = SpeedButton9Click
          end
          object SpeedButton10: TSpeedButton
            Left = 186
            Top = 52
            Width = 15
            Height = 15
            Caption = 'v'
            OnClick = SpeedButton10Click
          end
          object SpeedButton11: TSpeedButton
            Left = 96
            Top = 95
            Width = 23
            Height = 21
            Caption = 'df'
            OnClick = SpeedButton11Click
          end
          object SpeedButton12: TSpeedButton
            Left = 97
            Top = 13
            Width = 48
            Height = 22
            Caption = 'cln prev'
            OnClick = SpeedButton12Click
          end
          object ComboBox1: TComboBox
            Left = 5
            Top = 13
            Width = 86
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            Text = 'ComboBox1'
            OnChange = ComboBox1Change
          end
          object Button7: TButton
            Left = 197
            Top = 118
            Width = 35
            Height = 21
            Caption = 'set'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = Button7Click
          end
          object ComboBox2: TComboBox
            Left = 45
            Top = 118
            Width = 148
            Height = 21
            ParentShowHint = False
            ShowHint = True
            Sorted = True
            TabOrder = 2
            OnChange = Edit8Change
          end
          object Edit22: TEdit
            Left = 184
            Top = 96
            Width = 45
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            Text = '0'
          end
          object Edit21: TEdit
            Left = 137
            Top = 96
            Width = 44
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            Text = '0'
          end
          object Edit20: TEdit
            Left = 62
            Top = 95
            Width = 28
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            Text = '0'
          end
          object Edit19: TEdit
            Left = 32
            Top = 95
            Width = 29
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 6
            Text = '0'
          end
          object CheckBox9: TCheckBox
            Left = 4
            Top = 54
            Width = 112
            Height = 17
            Caption = 'fixed direction (x,y)'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 7
          end
          object Button10: TButton
            Left = 171
            Top = 71
            Width = 58
            Height = 22
            Caption = 'act. cell c.'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 8
            OnClick = Button10Click
          end
          object Edit18: TEdit
            Left = 122
            Top = 71
            Width = 46
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 9
            Text = '0'
          end
          object Edit17: TEdit
            Left = 76
            Top = 71
            Width = 45
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 10
            Text = '0'
          end
          object Edit16: TEdit
            Left = 32
            Top = 71
            Width = 43
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 11
            Text = '0'
          end
          object CheckBox8: TCheckBox
            Left = 4
            Top = 36
            Width = 60
            Height = 17
            Caption = 'Enabled'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 12
          end
        end
        object GroupBox10: TGroupBox
          Left = 2
          Top = 15
          Width = 236
          Height = 146
          Align = alTop
          Caption = 'general'
          TabOrder = 2
          OnDblClick = GroupBox10DblClick
          object Label2: TLabel
            Left = 12
            Top = 19
            Width = 31
            Height = 13
            Caption = 'Cell ID'
            ParentShowHint = False
            ShowHint = True
          end
          object Label14: TLabel
            Left = 12
            Top = 42
            Width = 19
            Height = 13
            Caption = 'x, y'
            ParentShowHint = False
            ShowHint = True
          end
          object Label1: TLabel
            Left = 92
            Top = 122
            Width = 30
            Height = 13
            Caption = 'power'
            ParentShowHint = False
            ShowHint = True
          end
          object Label27: TLabel
            Left = 174
            Top = 16
            Width = 46
            Height = 13
            Caption = 'door face'
          end
          object SpeedButton13: TSpeedButton
            Left = 210
            Top = 35
            Width = 23
            Height = 22
            Caption = 'a'
            OnClick = SpeedButton13Click
          end
          object Label28: TLabel
            Left = 15
            Top = 122
            Width = 29
            Height = 13
            Caption = 'z shift'
          end
          object Label29: TLabel
            Left = 204
            Top = 72
            Width = 24
            Height = 13
            Caption = 'block'
          end
          object Edit7: TEdit
            Left = 53
            Top = 16
            Width = 57
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnChange = Edit7Change
          end
          object Button14: TButton
            Left = 116
            Top = 16
            Width = 44
            Height = 21
            Caption = 'Auto'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = Button14Click
          end
          object Edit2: TEdit
            Left = 90
            Top = 40
            Width = 31
            Height = 21
            Enabled = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            Text = '1'
            OnChange = Edit2Change
          end
          object Edit1: TEdit
            Left = 53
            Top = 40
            Width = 31
            Height = 21
            Enabled = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            Text = '1'
            OnChange = Edit1Change
          end
          object Button18: TButton
            Left = 124
            Top = 40
            Width = 36
            Height = 21
            Hint = 'jump to specified cell'
            Caption = 'j'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            OnClick = Button18Click
          end
          object CheckBox1: TCheckBox
            Left = 12
            Top = 84
            Width = 35
            Height = 17
            Caption = 'wall'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            OnClick = CheckBox1Click
          end
          object CheckBox2: TCheckBox
            Left = 60
            Top = 84
            Width = 65
            Height = 17
            Caption = 'passable'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 6
            OnClick = CheckBox2Click
          end
          object CheckBox3: TCheckBox
            Left = 129
            Top = 84
            Width = 43
            Height = 17
            Caption = 'door'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 7
            OnClick = CheckBox3Click
          end
          object CheckBox5: TCheckBox
            Left = 12
            Top = 100
            Width = 97
            Height = 17
            Caption = 'chest'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 8
            OnClick = CheckBox5Click
          end
          object Edit5: TEdit
            Left = 128
            Top = 122
            Width = 24
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 9
            Text = '1'
            OnChange = Edit5Change
          end
          object Edit41: TEdit
            Left = 174
            Top = 35
            Width = 36
            Height = 21
            TabOrder = 10
            Text = '0'
            OnChange = Edit41Change
          end
          object CheckBox12: TCheckBox
            Left = 60
            Top = 100
            Width = 67
            Height = 17
            Caption = 'outdoors'
            TabOrder = 11
            OnClick = CheckBox12Click
          end
          object Edit42: TEdit
            Left = 47
            Top = 122
            Width = 41
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 12
            Text = '1'
            OnChange = Edit42Change
          end
          object CheckBox14: TCheckBox
            Left = 188
            Top = 91
            Width = 33
            Height = 17
            Caption = '-y'
            TabOrder = 13
            OnClick = CheckBox14Click
          end
          object CheckBox15: TCheckBox
            Left = 188
            Top = 126
            Width = 35
            Height = 17
            Caption = '+y'
            TabOrder = 14
            OnClick = CheckBox15Click
          end
          object CheckBox16: TCheckBox
            Left = 174
            Top = 107
            Width = 31
            Height = 17
            Caption = '-x'
            TabOrder = 15
            OnClick = CheckBox16Click
          end
          object CheckBox17: TCheckBox
            Left = 206
            Top = 107
            Width = 31
            Height = 17
            Caption = '+x'
            TabOrder = 16
            OnClick = CheckBox17Click
          end
          object Edit43: TEdit
            Left = 53
            Top = 62
            Width = 31
            Height = 21
            Enabled = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 17
            Text = '1'
            OnChange = Edit1Change
          end
          object Edit44: TEdit
            Left = 90
            Top = 62
            Width = 31
            Height = 21
            Enabled = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 18
            Text = '1'
            OnChange = Edit2Change
          end
          object Button40: TButton
            Left = 11
            Top = 61
            Width = 36
            Height = 25
            Caption = 'tosel'
            TabOrder = 19
            Visible = False
            OnClick = Button40Click
          end
        end
        object GroupBox9: TGroupBox
          Left = 2
          Top = 246
          Width = 236
          Height = 132
          Align = alTop
          Caption = 'cell decoration'
          TabOrder = 3
          OnDblClick = GroupBox9DblClick
          object Label3: TLabel
            Left = 6
            Top = 34
            Width = 47
            Height = 13
            Caption = 'Cell sprite'
            ParentShowHint = False
            ShowHint = True
          end
          object Label13: TLabel
            Left = 5
            Top = 61
            Width = 125
            Height = 13
            Caption = 'overrides (wall, floor, ceil)'
            ParentShowHint = False
            ShowHint = True
          end
          object Label30: TLabel
            Left = 61
            Top = 102
            Width = 23
            Height = 13
            Caption = 'dens'
          end
          object CheckBox6: TCheckBox
            Left = 8
            Top = 16
            Width = 76
            Height = 17
            Caption = 'floor'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = CheckBox6Click
          end
          object CheckBox7: TCheckBox
            Left = 62
            Top = 16
            Width = 54
            Height = 17
            Caption = 'ceiling'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = CheckBox7Click
          end
          object Button9: TButton
            Left = 117
            Top = 15
            Width = 75
            Height = 17
            Caption = 'auto floor/ceil'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            OnClick = Button9Click
          end
          object Button21: TButton
            Left = 197
            Top = 15
            Width = 38
            Height = 17
            Caption = 'no f/c'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            OnClick = Button21Click
          end
          object Edit8: TComboBox
            Left = 59
            Top = 37
            Width = 175
            Height = 21
            ParentShowHint = False
            ShowHint = True
            Sorted = True
            TabOrder = 4
            OnChange = Edit8Change
          end
          object Button33: TButton
            Left = 5
            Top = 46
            Width = 49
            Height = 15
            Caption = 'clr empt.'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            OnClick = Button33Click
          end
          object ComboBox5: TComboBox
            Left = 4
            Top = 75
            Width = 75
            Height = 21
            ParentShowHint = False
            ShowHint = True
            Sorted = True
            TabOrder = 6
            OnChange = ComboBox5Change
          end
          object ComboBox6: TComboBox
            Left = 82
            Top = 75
            Width = 75
            Height = 21
            ParentShowHint = False
            ShowHint = True
            Sorted = True
            TabOrder = 7
            OnChange = ComboBox6Change
          end
          object ComboBox7: TComboBox
            Left = 160
            Top = 75
            Width = 75
            Height = 21
            ParentShowHint = False
            ShowHint = True
            Sorted = True
            TabOrder = 8
            OnChange = ComboBox7Change
          end
          object CheckBox19: TCheckBox
            Left = 7
            Top = 100
            Width = 51
            Height = 17
            Caption = 'grass'
            TabOrder = 9
            OnClick = CheckBox19Click
          end
          object Edit45: TEdit
            Left = 90
            Top = 99
            Width = 67
            Height = 21
            TabOrder = 10
            OnChange = Edit45Change
          end
          object ComboBox9: TComboBox
            Left = 159
            Top = 99
            Width = 75
            Height = 21
            ParentShowHint = False
            ShowHint = True
            Sorted = True
            TabOrder = 11
            OnChange = ComboBox9Change
          end
        end
      end
      object GroupBox5: TGroupBox
        Left = 1
        Top = 1
        Width = 240
        Height = 235
        Align = alTop
        Caption = 'Map properties'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnDblClick = GroupBox5DblClick
        object Label12: TLabel
          Left = 9
          Top = 166
          Width = 88
          Height = 13
          Caption = 'Level environment'
          ParentShowHint = False
          ShowHint = True
        end
        object Label22: TLabel
          Left = 9
          Top = 185
          Width = 48
          Height = 13
          Caption = 'Level light'
          ParentShowHint = False
          ShowHint = True
        end
        object Label23: TLabel
          Left = 9
          Top = 203
          Width = 59
          Height = 13
          Caption = 'Atten (c/l/q)'
          ParentShowHint = False
          ShowHint = True
        end
        object Label24: TLabel
          Left = 9
          Top = 216
          Width = 56
          Height = 13
          Caption = 'Color (RGB)'
          ParentShowHint = False
          ShowHint = True
        end
        object Label15: TLabel
          Left = 5
          Top = 19
          Width = 31
          Height = 13
          Caption = 'Map id'
          ParentShowHint = False
          ShowHint = True
        end
        object Label20: TLabel
          Left = 5
          Top = 43
          Width = 86
          Height = 13
          Caption = 'Map width, height'
          ParentShowHint = False
          ShowHint = True
        end
        object Label17: TLabel
          Left = 166
          Top = 43
          Width = 35
          Height = 13
          Caption = 'Skybox'
          ParentShowHint = False
          ShowHint = True
        end
        object ComboBox4: TComboBox
          Left = 112
          Top = 166
          Width = 123
          Height = 21
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Text = '0'
          OnChange = ComboBox4Change
        end
        object Edit35: TEdit
          Left = 71
          Top = 200
          Width = 43
          Height = 21
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Text = '50'
        end
        object Edit36: TEdit
          Left = 120
          Top = 200
          Width = 43
          Height = 21
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Text = '1'
        end
        object Edit37: TEdit
          Left = 169
          Top = 200
          Width = 43
          Height = 21
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Text = '1'
        end
        object Edit38: TEdit
          Left = 71
          Top = 217
          Width = 43
          Height = 21
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          Text = '255'
        end
        object Edit39: TEdit
          Left = 120
          Top = 217
          Width = 43
          Height = 21
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          Text = '127'
        end
        object Edit40: TEdit
          Left = 169
          Top = 217
          Width = 43
          Height = 21
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          Text = '0'
        end
        object Button29: TButton
          Left = 214
          Top = 200
          Width = 21
          Height = 16
          Caption = 'd'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          OnClick = Button29Click
        end
        object Button30: TButton
          Left = 214
          Top = 216
          Width = 21
          Height = 16
          Caption = 's'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          OnClick = Button30Click
        end
        object Button31: TButton
          Left = 63
          Top = 185
          Width = 38
          Height = 15
          Caption = 'read'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 9
          OnClick = Button31Click
        end
        object Edit23: TEdit
          Left = 42
          Top = 16
          Width = 81
          Height = 21
          ParentShowHint = False
          ShowHint = True
          TabOrder = 10
        end
        object Button28: TButton
          Left = 126
          Top = 16
          Width = 33
          Height = 21
          Caption = 'set'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 11
          OnClick = Button28Click
        end
        object Button19: TButton
          Left = 161
          Top = 16
          Width = 40
          Height = 21
          Caption = 'read'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 12
          OnClick = Button19Click
        end
        object Button20: TButton
          Left = 204
          Top = 16
          Width = 32
          Height = 21
          Caption = 'dir'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 13
          OnClick = Button20Click
        end
        object Edit26: TEdit
          Left = 94
          Top = 43
          Width = 33
          Height = 21
          ParentShowHint = False
          ShowHint = True
          TabOrder = 14
          Text = '0'
          OnChange = Edit26Change
        end
        object Edit27: TEdit
          Left = 129
          Top = 43
          Width = 33
          Height = 21
          ParentShowHint = False
          ShowHint = True
          TabOrder = 15
          Text = '0'
          OnChange = Edit27Change
        end
        object Edit25: TEdit
          Left = 207
          Top = 43
          Width = 29
          Height = 21
          ParentShowHint = False
          ShowHint = True
          TabOrder = 16
          Text = '0'
          OnChange = Edit25Change
        end
        object GroupBox2: TGroupBox
          Left = 4
          Top = 72
          Width = 233
          Height = 86
          Caption = 'start/exit'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 17
          object Label4: TLabel
            Left = 11
            Top = 13
            Width = 23
            Height = 13
            Caption = 'start'
            ParentShowHint = False
            ShowHint = True
          end
          object Label5: TLabel
            Left = 130
            Top = 13
            Width = 18
            Height = 13
            Caption = 'exit'
            ParentShowHint = False
            ShowHint = True
          end
          object Label6: TLabel
            Left = 11
            Top = 56
            Width = 41
            Height = 13
            Caption = 'direction'
            ParentShowHint = False
            ShowHint = True
          end
          object Edit9: TEdit
            Left = 6
            Top = 29
            Width = 43
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            Text = '0'
          end
          object Edit10: TEdit
            Left = 55
            Top = 29
            Width = 43
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            Text = '0'
          end
          object Edit11: TEdit
            Left = 125
            Top = 29
            Width = 43
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            Text = '0'
          end
          object Edit12: TEdit
            Left = 171
            Top = 29
            Width = 43
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            Text = '0'
          end
          object Edit13: TEdit
            Left = 55
            Top = 59
            Width = 43
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            Text = '0'
          end
          object Edit14: TEdit
            Left = 13
            Top = 78
            Width = 43
            Height = 21
            Enabled = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            Text = '0'
            Visible = False
          end
          object Button4: TButton
            Left = 122
            Top = 56
            Width = 46
            Height = 25
            Caption = 'set'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 6
            OnClick = Button4Click
          end
          object Button5: TButton
            Left = 171
            Top = 56
            Width = 43
            Height = 25
            Caption = 'read'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 7
            OnClick = Button5Click
          end
          object Button11: TButton
            Left = 6
            Top = 69
            Width = 46
            Height = 16
            Cancel = True
            Caption = 'lookside'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 8
            OnClick = Button11Click
          end
          object Button37: TButton
            Left = 101
            Top = 27
            Width = 18
            Height = 25
            Caption = 's'
            TabOrder = 9
            OnClick = Button37Click
          end
          object Button38: TButton
            Left = 215
            Top = 27
            Width = 18
            Height = 25
            Caption = 's'
            TabOrder = 10
            OnClick = Button38Click
          end
        end
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 1038
      Height = 41
      Align = alTop
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      object Label7: TLabel
        Left = 337
        Top = 0
        Width = 61
        Height = 13
        Caption = 'Refresh rate'
        ParentShowHint = False
        ShowHint = True
      end
      object Edit15: TEdit
        Left = 337
        Top = 14
        Width = 57
        Height = 21
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Text = '200'
      end
      object Button6: TButton
        Left = 397
        Top = 14
        Width = 17
        Height = 21
        Caption = 'k'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = Button6Click
      end
      object Button2: TButton
        Left = 175
        Top = 10
        Width = 75
        Height = 25
        Caption = 'load'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = Button2Click
      end
      object Button1: TButton
        Left = 94
        Top = 10
        Width = 75
        Height = 25
        Caption = 'save'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = Button1Click
      end
      object Button3: TButton
        Left = 13
        Top = 10
        Width = 75
        Height = 25
        Caption = 'build'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = Button3Click
      end
      object Button8: TButton
        Left = 256
        Top = 10
        Width = 75
        Height = 25
        Caption = 'clear'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = Button8Click
      end
      object Button12: TButton
        Left = 587
        Top = 10
        Width = 67
        Height = 25
        Caption = 'Card editor'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnClick = Button12Click
      end
      object Button13: TButton
        Left = 653
        Top = 10
        Width = 95
        Height = 25
        Caption = 'Character editor'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        OnClick = Button13Click
      end
      object Button22: TButton
        Left = 418
        Top = 10
        Width = 50
        Height = 25
        Caption = 'Var Edit'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
        OnClick = Button22Click
      end
      object Button23: TButton
        Left = 525
        Top = 10
        Width = 60
        Height = 25
        Caption = 'Item Edit'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
        OnClick = Button23Click
      end
      object Button24: TButton
        Left = 469
        Top = 10
        Width = 55
        Height = 25
        Caption = 'Text Edit'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 10
        OnClick = Button24Click
      end
      object CheckBox10: TCheckBox
        Left = 902
        Top = 6
        Width = 146
        Height = 17
        Caption = 'show marks in editor'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 11
      end
      object Button32: TButton
        Left = 749
        Top = 10
        Width = 66
        Height = 25
        Caption = 'Perk editor'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 12
        OnClick = Button32Click
      end
      object Button36: TButton
        Left = 816
        Top = 10
        Width = 75
        Height = 25
        Caption = 'ML editor'
        TabOrder = 13
        OnClick = Button36Click
      end
      object CheckBox13: TCheckBox
        Left = 902
        Top = 21
        Width = 146
        Height = 17
        Caption = 'autoremove focus'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 14
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 805
      Width = 1038
      Height = 170
      Align = alBottom
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      object GroupBox4: TGroupBox
        Left = 1
        Top = 42
        Width = 795
        Height = 127
        Align = alClient
        Caption = 'Script text'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object ScrMemo: TMemo
          Left = 2
          Top = 15
          Width = 791
          Height = 110
          Align = alClient
          ParentShowHint = False
          ScrollBars = ssVertical
          ShowHint = True
          TabOrder = 0
        end
      end
      object Panel6: TPanel
        Left = 796
        Top = 42
        Width = 241
        Height = 127
        Align = alRight
        TabOrder = 1
        object GroupBox3: TGroupBox
          Left = 4
          Top = 6
          Width = 231
          Height = 124
          Caption = 'cell meshes'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          object Label8: TLabel
            Left = 10
            Top = 41
            Width = 154
            Height = 13
            Caption = 'Turn angle/roll angle/pitch angle'
            ParentShowHint = False
            ShowHint = True
          end
          object Label21: TLabel
            Left = 10
            Top = 78
            Width = 55
            Height = 13
            Caption = 'Move X,Y,Z'
            ParentShowHint = False
            ShowHint = True
          end
          object ComboBox8: TComboBox
            Left = 211
            Top = 73
            Width = 37
            Height = 21
            ItemIndex = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            Text = '.obj'
            Visible = False
            OnChange = ComboBox8Change
            Items.Strings = (
              '.obj'
              '.3ds')
          end
          object Edit28: TEdit
            Left = 10
            Top = 57
            Width = 45
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            Text = '0'
            OnChange = Edit28Change
          end
          object Edit29: TEdit
            Left = 60
            Top = 57
            Width = 45
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            Text = '0'
            OnChange = Edit29Change
          end
          object Edit30: TEdit
            Left = 110
            Top = 57
            Width = 45
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            Text = '0'
            OnChange = Edit30Change
          end
          object Button25: TButton
            Left = 157
            Top = 57
            Width = 41
            Height = 21
            Caption = 'default'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            OnClick = Button25Click
          end
          object Button26: TButton
            Left = 198
            Top = 95
            Width = 27
            Height = 21
            Caption = 'ok'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            OnClick = Button26Click
          end
          object Edit31: TEdit
            Left = 10
            Top = 95
            Width = 45
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 6
            Text = '0'
            OnChange = Edit31Change
          end
          object Edit32: TEdit
            Left = 60
            Top = 95
            Width = 45
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 7
            Text = '0'
            OnChange = Edit32Change
          end
          object Edit33: TEdit
            Left = 110
            Top = 95
            Width = 45
            Height = 21
            ParentShowHint = False
            ShowHint = True
            TabOrder = 8
            Text = '0'
            OnChange = Edit33Change
          end
          object Button27: TButton
            Left = 157
            Top = 95
            Width = 41
            Height = 21
            Caption = 'default'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 9
            OnClick = Button27Click
          end
          object Button34: TButton
            Left = 202
            Top = 57
            Width = 21
            Height = 21
            Hint = 'Floor mesh override'
            Caption = 'fo'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 10
            OnClick = Button34Click
          end
          object Button35: TButton
            Left = 202
            Top = 39
            Width = 21
            Height = 17
            Hint = 'Floor mesh override'
            Caption = '^'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 11
            OnClick = Button35Click
          end
          object Button39: TButton
            Left = 199
            Top = 17
            Width = 26
            Height = 21
            Caption = 'void'
            TabOrder = 12
            OnClick = Button39Click
          end
          object CheckBox18: TCheckBox
            Left = 80
            Top = 78
            Width = 97
            Height = 17
            Caption = 'forcewallmesh'
            TabOrder = 13
          end
          object Edit24: TComboBox
            Left = 10
            Top = 17
            Width = 177
            Height = 21
            Sorted = True
            TabOrder = 14
          end
        end
      end
      object Panel7: TPanel
        Left = 1
        Top = 1
        Width = 1036
        Height = 41
        Align = alTop
        TabOrder = 2
        object GroupBox6: TGroupBox
          Left = 1
          Top = 1
          Width = 849
          Height = 39
          Align = alClient
          Caption = 'Script controls'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          object SpeedButton1: TSpeedButton
            Left = 5
            Top = 18
            Width = 35
            Height = 16
            Caption = 'load'
            ParentShowHint = False
            ShowHint = True
            OnClick = SpeedButton1Click
          end
          object SpeedButton2: TSpeedButton
            Left = 46
            Top = 18
            Width = 33
            Height = 16
            Caption = 'save'
            ParentShowHint = False
            ShowHint = True
            OnClick = SpeedButton2Click
          end
          object CheckBox11: TCheckBox
            Left = 85
            Top = 17
            Width = 97
            Height = 17
            Caption = 'search script'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
          end
        end
        object GroupBox11: TGroupBox
          Left = 850
          Top = 1
          Width = 185
          Height = 39
          Align = alRight
          Caption = 'cursor'
          TabOrder = 1
          object Label25: TLabel
            Left = 16
            Top = 21
            Width = 3
            Height = 13
          end
        end
      end
    end
    object Panel5: TPanel
      Left = 243
      Top = 42
      Width = 796
      Height = 760
      Align = alClient
      Caption = 'Panel5'
      TabOrder = 3
      object Image1: TImage
        Left = 1
        Top = 1
        Width = 777
        Height = 741
        Align = alClient
        Center = True
        ParentShowHint = False
        ShowHint = True
        OnMouseDown = Image1MouseDown
        OnMouseMove = Image1MouseMove
        OnMouseUp = Image1MouseUp
        ExplicitLeft = -1
        ExplicitTop = 0
      end
      object ScrollBar1: TScrollBar
        Left = 1
        Top = 742
        Width = 794
        Height = 17
        Align = alBottom
        PageSize = 0
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnChange = ScrollBar1Change
      end
      object ScrollBar2: TScrollBar
        Left = 778
        Top = 1
        Width = 17
        Height = 741
        Align = alRight
        Kind = sbVertical
        PageSize = 0
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnChange = ScrollBar2Change
      end
    end
  end
  object Timer1: TTimer
    Interval = 200
    OnTimer = Timer1Timer
    Left = 664
    Top = 72
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'map'
    Filter = 'Map files (*.map)|*.map|All files (*.*)|*.*'
    Left = 528
    Top = 72
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'map'
    Filter = 'Map files (*.map)|*.map|All files (*.*)|*.*'
    Left = 592
    Top = 72
  end
  object MainMenu1: TMainMenu
    Left = 480
    Top = 72
    object File1: TMenuItem
      Caption = 'File'
      object New1: TMenuItem
        Caption = 'New'
        ShortCut = 16462
        OnClick = New1Click
      end
      object Save1: TMenuItem
        Caption = 'Save'
        ShortCut = 16467
        OnClick = Save1Click
      end
      object Open1: TMenuItem
        Caption = 'Open'
        ShortCut = 16463
        OnClick = Open1Click
      end
      object Exportdatabase1: TMenuItem
        Caption = 'Export monster database'
        OnClick = Exportdatabase1Click
      end
      object Exportcarddatabase1: TMenuItem
        Caption = 'Export card database'
        OnClick = Exportcarddatabase1Click
      end
      object EcportMapImage1: TMenuItem
        Caption = 'Ecport Map Image'
        OnClick = EcportMapImage1Click
      end
    end
    object Edit34: TMenuItem
      Caption = 'Edit'
      object Copy1: TMenuItem
        Caption = 'Copy'
        ShortCut = 16429
        OnClick = Copy1Click
      end
      object Paste1: TMenuItem
        Caption = 'Paste'
        ShortCut = 8237
        OnClick = Paste1Click
      end
      object BufferedCellData1: TMenuItem
        Caption = 'Buffered Cell Data'
        OnClick = BufferedCellData1Click
      end
    end
    object Map1: TMenuItem
      Caption = 'Map'
      object Build1: TMenuItem
        Caption = 'Build'
        ShortCut = 16450
        OnClick = Build1Click
      end
      object Random1: TMenuItem
        Caption = 'Random'
        OnClick = Random1Click
      end
      object AutoGetDoorAngles1: TMenuItem
        Caption = 'Auto Get Door Angles'
        OnClick = AutoGetDoorAngles1Click
      end
      object oggleEditView1: TMenuItem
        Caption = 'Toggle Edit View'
        OnClick = oggleEditView1Click
      end
    end
    object Editors1: TMenuItem
      Caption = 'Editors'
      object Variableeditor1: TMenuItem
        Caption = 'Variable editor'
        OnClick = Variableeditor1Click
      end
      object exteditor1: TMenuItem
        Caption = 'Text editor'
        OnClick = exteditor1Click
      end
      object Itemeditor1: TMenuItem
        Caption = 'Item editor'
        OnClick = Itemeditor1Click
      end
      object Cardeditor1: TMenuItem
        Caption = 'Card editor'
        OnClick = Cardeditor1Click
      end
      object Charactereditor1: TMenuItem
        Caption = 'Character editor'
        OnClick = Charactereditor1Click
      end
      object PerkEditor1: TMenuItem
        Caption = 'Perk Editor'
        OnClick = PerkEditor1Click
      end
      object MonsterListEditor1: TMenuItem
        Caption = 'Monster List Editor'
        OnClick = MonsterListEditor1Click
      end
      object Freemesheditor1: TMenuItem
        Caption = 'Freemesh editor'
        OnClick = Freemesheditor1Click
      end
      object LightSourceEditor1: TMenuItem
        Caption = 'LightSource Editor'
        OnClick = LightSourceEditor1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Debugmenu1: TMenuItem
        Caption = 'Debug and gameplay menu'
        OnClick = Debugmenu1Click
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object Scriptingreference1: TMenuItem
        Caption = 'Scripting reference'
        OnClick = Scriptingreference1Click
      end
    end
  end
  object SaveDialog2: TSaveDialog
    DefaultExt = 'bmp'
    Filter = 'Bitmap|*.bmp'
    Left = 528
    Top = 120
  end
end
