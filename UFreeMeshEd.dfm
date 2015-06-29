object Form16: TForm16
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Freemesh Editor'
  ClientHeight = 390
  ClientWidth = 949
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 149
    Width = 25
    Height = 13
    Caption = 'mesh'
  end
  object Label2: TLabel
    Left = 336
    Top = 244
    Width = 37
    Height = 13
    Caption = 'redirect'
  end
  object Label3: TLabel
    Left = 214
    Top = 149
    Width = 36
    Height = 13
    Caption = 'texture'
  end
  object Label4: TLabel
    Left = 449
    Top = 206
    Width = 42
    Height = 13
    Caption = 'texture2'
    Visible = False
  end
  object Label6: TLabel
    Left = 8
    Top = 173
    Width = 54
    Height = 13
    Caption = 'attach light'
  end
  object Label13: TLabel
    Left = 336
    Top = 198
    Width = 98
    Height = 13
    Caption = 'trajectory end script'
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 8
    Width = 145
    Height = 21
    TabOrder = 0
    Text = 'ComboBox1'
    OnChange = ComboBox1Change
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 35
    Width = 185
    Height = 105
    Caption = 'position x,y,z'
    TabOrder = 1
    object Edit1: TEdit
      Left = 16
      Top = 24
      Width = 121
      Height = 21
      TabOrder = 0
      Text = '0'
    end
    object Edit2: TEdit
      Left = 16
      Top = 51
      Width = 121
      Height = 21
      TabOrder = 1
      Text = '0'
    end
    object Edit3: TEdit
      Left = 16
      Top = 78
      Width = 121
      Height = 21
      TabOrder = 2
      Text = '0'
    end
    object Button2: TButton
      Left = 143
      Top = 22
      Width = 35
      Height = 25
      Caption = 'acc'
      TabOrder = 3
      OnClick = Button2Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 199
    Top = 35
    Width = 185
    Height = 105
    Caption = 'rotation ta,ra,pa'
    TabOrder = 2
    object Edit4: TEdit
      Left = 16
      Top = 24
      Width = 121
      Height = 21
      TabOrder = 0
      Text = '0'
    end
    object Edit5: TEdit
      Left = 16
      Top = 51
      Width = 121
      Height = 21
      TabOrder = 1
      Text = '0'
    end
    object Edit6: TEdit
      Left = 16
      Top = 76
      Width = 121
      Height = 21
      TabOrder = 2
      Text = '0'
    end
  end
  object CheckBox1: TCheckBox
    Left = 168
    Top = 10
    Width = 97
    Height = 17
    Caption = 'enabled'
    TabOrder = 3
  end
  object Button1: TButton
    Left = 497
    Top = 146
    Width = 75
    Height = 71
    Caption = 'set'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Edit8: TEdit
    Left = 336
    Top = 257
    Width = 169
    Height = 21
    TabOrder = 5
  end
  object Button3: TButton
    Left = 511
    Top = 253
    Width = 61
    Height = 25
    Caption = 'create'
    TabOrder = 6
    OnClick = Button3Click
  end
  object GroupBox3: TGroupBox
    Left = 387
    Top = 35
    Width = 185
    Height = 105
    Caption = 'scale sx,sy,sz'
    TabOrder = 7
    object Edit9: TEdit
      Left = 16
      Top = 24
      Width = 121
      Height = 21
      TabOrder = 0
      Text = '0'
    end
    object Edit10: TEdit
      Left = 16
      Top = 51
      Width = 121
      Height = 21
      TabOrder = 1
      Text = '0'
    end
    object Edit11: TEdit
      Left = 16
      Top = 76
      Width = 121
      Height = 21
      TabOrder = 2
      Text = '0'
    end
    object Button11: TButton
      Left = 143
      Top = 24
      Width = 33
      Height = 25
      Caption = '100'
      TabOrder = 3
      OnClick = Button11Click
    end
  end
  object GLSceneViewer1: TGLSceneViewer
    Left = 578
    Top = 8
    Width = 363
    Height = 374
    Camera = camera
    Buffer.BackgroundColor = clGray
    FieldOfView = 149.196136474609400000
    Enabled = False
    TabOrder = 8
  end
  object GroupBox4: TGroupBox
    Left = 3
    Top = 284
    Width = 560
    Height = 98
    Caption = 'preview'
    TabOrder = 9
    object Label5: TLabel
      Left = 20
      Top = 104
      Width = 3
      Height = 13
    end
    object TrackBar3: TTrackBar
      Left = 182
      Top = 59
      Width = 75
      Height = 45
      Max = 359
      TabOrder = 0
      OnChange = TrackBar3Change
    end
    object TrackBar2: TTrackBar
      Left = 101
      Top = 59
      Width = 75
      Height = 45
      Max = 359
      TabOrder = 1
      OnChange = TrackBar2Change
    end
    object TrackBar1: TTrackBar
      Left = 20
      Top = 59
      Width = 75
      Height = 45
      Max = 359
      TabOrder = 2
      OnChange = TrackBar1Change
    end
    object Button6: TButton
      Left = 226
      Top = 28
      Width = 31
      Height = 25
      Caption = '+'
      TabOrder = 3
      OnClick = Button6Click
    end
    object Button5: TButton
      Left = 182
      Top = 28
      Width = 31
      Height = 25
      Caption = '-'
      TabOrder = 4
      OnClick = Button5Click
    end
    object Button4: TButton
      Left = 20
      Top = 28
      Width = 75
      Height = 25
      Caption = 'preview'
      TabOrder = 5
      OnClick = Button4Click
    end
  end
  object Button7: TButton
    Left = 271
    Top = 8
    Width = 75
    Height = 21
    Caption = 'attach to prev'
    TabOrder = 10
    OnClick = Button7Click
  end
  object Edit13: TEdit
    Left = 451
    Top = 225
    Width = 106
    Height = 21
    TabOrder = 11
    Text = '0'
    Visible = False
  end
  object edit12: TComboBox
    Left = 256
    Top = 146
    Width = 186
    Height = 21
    Sorted = True
    TabOrder = 12
    Text = '0'
  end
  object Button8: TButton
    Left = 448
    Top = 146
    Width = 36
    Height = 25
    Caption = 'ui'
    TabOrder = 13
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 448
    Top = 173
    Width = 36
    Height = 25
    Caption = 'sl'
    TabOrder = 14
    OnClick = Button9Click
  end
  object Edit14: TEdit
    Left = 68
    Top = 173
    Width = 77
    Height = 21
    TabOrder = 15
    Text = '0'
  end
  object Button10: TButton
    Left = 151
    Top = 173
    Width = 35
    Height = 21
    Caption = 'do'
    TabOrder = 16
    OnClick = Button10Click
  end
  object Edit7: TComboBox
    Left = 39
    Top = 146
    Width = 169
    Height = 21
    TabOrder = 17
  end
  object Memo1: TMemo
    Left = 271
    Top = 299
    Width = 301
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 18
    Visible = False
  end
  object CheckBox2: TCheckBox
    Left = 214
    Top = 173
    Width = 71
    Height = 18
    Caption = 'on fire'
    TabOrder = 19
  end
  object Edit15: TEdit
    Left = 291
    Top = 171
    Width = 34
    Height = 21
    TabOrder = 20
    Text = '0'
  end
  object Edit16: TEdit
    Left = 331
    Top = 171
    Width = 34
    Height = 21
    TabOrder = 21
    Text = '0'
  end
  object Edit17: TEdit
    Left = 371
    Top = 171
    Width = 34
    Height = 21
    TabOrder = 22
    Text = '0'
  end
  object GroupBox5: TGroupBox
    Left = 3
    Top = 195
    Width = 327
    Height = 88
    Caption = 'Behaviour'
    TabOrder = 23
    object Label7: TLabel
      Left = 5
      Top = 46
      Width = 45
      Height = 13
      Caption = 'minmax x'
    end
    object Label8: TLabel
      Left = 104
      Top = 46
      Width = 45
      Height = 13
      Caption = 'minmax y'
    end
    object Label9: TLabel
      Left = 198
      Top = 46
      Width = 44
      Height = 13
      Caption = 'minmax z'
    end
    object Label10: TLabel
      Left = 211
      Top = 16
      Width = 86
      Height = 13
      Caption = 'for rotate minmax'
    end
    object Label11: TLabel
      Left = 211
      Top = 27
      Width = 101
      Height = 13
      Caption = 'replaced w ta, ra, pa'
    end
    object Label12: TLabel
      Left = 101
      Top = 11
      Width = 29
      Height = 13
      Caption = 'speed'
    end
    object ComboBox2: TComboBox
      Left = 5
      Top = 16
      Width = 90
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = '0 - none'
      Items.Strings = (
        '0 - none'
        '1 - move'
        '2 - rotate')
    end
    object Edit18: TEdit
      Left = 3
      Top = 62
      Width = 38
      Height = 21
      TabOrder = 1
      Text = '0'
    end
    object Edit19: TEdit
      Left = 47
      Top = 62
      Width = 38
      Height = 21
      TabOrder = 2
      Text = '0'
    end
    object CheckBox3: TCheckBox
      Left = 151
      Top = 18
      Width = 42
      Height = 17
      Caption = 'loop'
      TabOrder = 3
    end
    object Edit20: TEdit
      Left = 102
      Top = 62
      Width = 38
      Height = 21
      TabOrder = 4
      Text = '0'
    end
    object Edit21: TEdit
      Left = 146
      Top = 62
      Width = 38
      Height = 21
      TabOrder = 5
      Text = '0'
    end
    object Edit22: TEdit
      Left = 196
      Top = 62
      Width = 38
      Height = 21
      TabOrder = 6
      Text = '0'
    end
    object Edit23: TEdit
      Left = 240
      Top = 62
      Width = 38
      Height = 21
      TabOrder = 7
      Text = '0'
    end
    object Edit24: TEdit
      Left = 101
      Top = 27
      Width = 39
      Height = 21
      TabOrder = 8
      Text = '1'
    end
    object Button12: TButton
      Left = 284
      Top = 58
      Width = 36
      Height = 25
      Caption = 'afmc'
      TabOrder = 9
      OnClick = Button12Click
    end
  end
  object Button13: TButton
    Left = 352
    Top = 8
    Width = 75
    Height = 21
    Caption = 'clone'
    TabOrder = 24
    OnClick = Button13Click
  end
  object Edit25: TEdit
    Left = 433
    Top = 8
    Width = 40
    Height = 21
    TabOrder = 25
    Text = '0'
  end
  object Edit26: TEdit
    Left = 336
    Top = 217
    Width = 121
    Height = 21
    TabOrder = 26
  end
  object GLScene1: TGLScene
    Left = 224
    Top = 65528
    object camera: TGLCamera
      DepthOfView = 100.000000000000000000
      FocalLength = 50.000000000000000000
      Position.Coordinates = {0000F0C100000000000000000000803F}
      Direction.Coordinates = {0000803F000000000000008000000000}
      Up.Coordinates = {00000000000000000000803F00000000}
    end
    object preview: TGLFreeForm
    end
    object GLLightSource1: TGLLightSource
      ConstAttenuation = 1.000000000000000000
      Position.Coordinates = {00000000000000000000C8410000803F}
      SpotCutOff = 180.000000000000000000
    end
    object GLPlane1: TGLPlane
      Direction.Coordinates = {0000803F000000000000000000000000}
      Position.Coordinates = {0000000000000000000020C10000803F}
      Up.Coordinates = {00000080000000000000803F00000000}
      Height = 1.000000000000000000
      Width = 1.000000000000000000
    end
  end
  object GLCadencer1: TGLCadencer
    Left = 272
    Top = 65520
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 528
    Top = 8
  end
end
