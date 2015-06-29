object Form17: TForm17
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'LightSource Editor'
  ClientHeight = 221
  ClientWidth = 545
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
  object id: TLabel
    Left = 8
    Top = 16
    Width = 8
    Height = 13
    Caption = 'id'
  end
  object GroupBox1: TGroupBox
    Left = 139
    Top = 42
    Width = 169
    Height = 169
    Caption = 'colour'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 57
      Height = 13
      Caption = 'rgb ambient'
    end
    object Label2: TLabel
      Left = 16
      Top = 57
      Width = 52
      Height = 13
      Caption = 'rgb diffuse'
    end
    object Label3: TLabel
      Left = 16
      Top = 98
      Width = 59
      Height = 13
      Caption = 'rgb specular'
    end
    object Edit1: TEdit
      Left = 16
      Top = 32
      Width = 41
      Height = 21
      TabOrder = 0
      Text = '0'
    end
    object Edit2: TEdit
      Left = 63
      Top = 32
      Width = 41
      Height = 21
      TabOrder = 1
      Text = '0'
    end
    object Edit3: TEdit
      Left = 110
      Top = 32
      Width = 41
      Height = 21
      TabOrder = 2
      Text = '0'
    end
    object Edit4: TEdit
      Left = 16
      Top = 73
      Width = 41
      Height = 21
      TabOrder = 3
      Text = '0'
    end
    object Edit5: TEdit
      Left = 63
      Top = 73
      Width = 41
      Height = 21
      TabOrder = 4
      Text = '0'
    end
    object Edit6: TEdit
      Left = 110
      Top = 73
      Width = 41
      Height = 21
      TabOrder = 5
      Text = '0'
    end
    object Edit7: TEdit
      Left = 16
      Top = 117
      Width = 41
      Height = 21
      TabOrder = 6
      Text = '0'
    end
    object Edit8: TEdit
      Left = 63
      Top = 117
      Width = 41
      Height = 21
      TabOrder = 7
      Text = '0'
    end
    object Edit9: TEdit
      Left = 110
      Top = 117
      Width = 41
      Height = 21
      TabOrder = 8
      Text = '0'
    end
  end
  object GroupBox2: TGroupBox
    Left = 314
    Top = 42
    Width = 226
    Height = 56
    Caption = 'attenuation'
    TabOrder = 1
    object Label4: TLabel
      Left = 16
      Top = 13
      Width = 112
      Height = 13
      Caption = 'con, lin, quad (x10000)'
    end
    object Edit10: TEdit
      Left = 16
      Top = 32
      Width = 41
      Height = 21
      TabOrder = 0
      Text = '0'
    end
    object Edit11: TEdit
      Left = 63
      Top = 32
      Width = 41
      Height = 21
      TabOrder = 1
      Text = '0'
    end
    object Edit12: TEdit
      Left = 110
      Top = 32
      Width = 41
      Height = 21
      TabOrder = 2
      Text = '0'
    end
  end
  object GroupBox3: TGroupBox
    Left = 314
    Top = 99
    Width = 226
    Height = 112
    Caption = 'position'
    TabOrder = 2
    object Label5: TLabel
      Left = 16
      Top = 16
      Width = 25
      Height = 13
      Caption = 'x,y,z'
    end
    object Label6: TLabel
      Left = 16
      Top = 62
      Width = 55
      Height = 13
      Caption = 'direct x,y,z'
    end
    object Edit13: TEdit
      Left = 16
      Top = 35
      Width = 41
      Height = 21
      TabOrder = 0
      Text = '0'
    end
    object Edit14: TEdit
      Left = 63
      Top = 35
      Width = 41
      Height = 21
      TabOrder = 1
      Text = '0'
    end
    object Edit15: TEdit
      Left = 110
      Top = 35
      Width = 41
      Height = 21
      TabOrder = 2
      Text = '0'
    end
    object Button4: TButton
      Left = 157
      Top = 32
      Width = 58
      Height = 25
      Caption = 'act cell'
      TabOrder = 3
      OnClick = Button4Click
    end
    object Edit16: TEdit
      Left = 16
      Top = 75
      Width = 41
      Height = 21
      TabOrder = 4
      Text = '0'
    end
    object Edit17: TEdit
      Left = 63
      Top = 75
      Width = 41
      Height = 21
      TabOrder = 5
      Text = '0'
    end
    object Edit18: TEdit
      Left = 110
      Top = 75
      Width = 41
      Height = 21
      TabOrder = 6
      Text = '0'
    end
  end
  object Edit0: TEdit
    Left = 22
    Top = 15
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '0'
  end
  object Button1: TButton
    Left = 149
    Top = 13
    Width = 75
    Height = 25
    Caption = 'read'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 230
    Top = 13
    Width = 75
    Height = 25
    Caption = 'wtite'
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 465
    Top = 13
    Width = 75
    Height = 25
    Caption = 'process'
    TabOrder = 6
    OnClick = Button3Click
  end
  object CheckBox1: TCheckBox
    Left = 311
    Top = 17
    Width = 97
    Height = 17
    Caption = 'visible'
    TabOrder = 7
  end
  object GroupBox4: TGroupBox
    Left = 7
    Top = 42
    Width = 126
    Height = 169
    Caption = 'attributes'
    TabOrder = 8
    object Label7: TLabel
      Left = 6
      Top = 16
      Width = 22
      Height = 13
      Caption = 'type'
    end
    object Label8: TLabel
      Left = 9
      Top = 67
      Width = 53
      Height = 13
      Caption = 'spot cutoff'
    end
    object Label9: TLabel
      Left = 9
      Top = 111
      Width = 70
      Height = 13
      Caption = 'spot exponent'
    end
    object ComboBox1: TComboBox
      Left = 6
      Top = 32
      Width = 114
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'Omni'
      Items.Strings = (
        'Omni'
        'Spot')
    end
    object Edit19: TEdit
      Left = 9
      Top = 84
      Width = 111
      Height = 21
      TabOrder = 1
      Text = '0'
    end
    object Edit20: TEdit
      Left = 9
      Top = 128
      Width = 111
      Height = 21
      TabOrder = 2
      Text = '0'
    end
  end
end
