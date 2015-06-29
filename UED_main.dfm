object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 768
  ClientWidth = 1024
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 8
    Top = 32
    Width = 969
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
    Visible = False
  end
  object GLSceneViewer1: TGLSceneViewer
    Left = 0
    Top = 0
    Width = 1024
    Height = 768
    Camera = mcam
    Buffer.FogEnvironment.FogStart = 10.000000000000000000
    Buffer.FogEnvironment.FogEnd = 100.000000000000000000
    Buffer.BackgroundColor = clBlack
    Buffer.AmbientColor.Color = {0000000000000000000000000000803F}
    Buffer.ContextOptions = [roDoubleBuffer, roStencilBuffer, roRenderToWindow, roStereo, roDebugContext]
    Buffer.FogEnable = True
    Buffer.AntiAliasing = aaNone
    Buffer.DepthPrecision = dp32bits
    FieldOfView = 174.037078857421900000
    OnMouseLeave = GLSceneViewer1MouseLeave
    Align = alClient
    OnDblClick = GLSceneViewer1DblClick
    OnMouseDown = GLSceneViewer1MouseDown
    OnMouseMove = GLSceneViewer1MouseMove
    OnMouseUp = GLSceneViewer1MouseUp
    TabOrder = 1
  end
  object MediaPlayer1: TMediaPlayer
    Left = 512
    Top = 16
    Width = 253
    Height = 30
    AutoRewind = False
    Visible = False
    TabOrder = 2
  end
  object Memo5: TMemo
    Left = 16
    Top = 752
    Width = 505
    Height = 89
    Lines.Strings = (
      'Memo5')
    TabOrder = 3
    Visible = False
  end
  object GLScene1: TGLScene
    OnBeforeProgress = GLScene1BeforeProgress
    Left = 16
    Top = 184
    object mcam: TGLCamera
      DepthOfView = 250.000000000000000000
      FocalLength = 20.000000000000000000
      NearPlaneBias = 0.100000001490116100
      CameraStyle = csInfinitePerspective
      Position.Coordinates = {0000000000000000000048430000803F}
    end
    object dcmaingame: TGLDummyCube
      CubeSize = 1.000000000000000000
      object playerlight: TGLLightSource
        ConstAttenuation = 0.500000000000000000
        Diffuse.Color = {0000803FF8FEFE3E000000000000803F}
        LinearAttenuation = 0.009999999776482582
        QuadraticAttenuation = 0.009999999776482582
        Position.Coordinates = {00000000000000000000A0410000803F}
        LightStyle = lsOmni
        Specular.Color = {CDCCCC3ECDCCCC3ECDCCCC3E0000803F}
        SpotCutOff = 180.000000000000000000
      end
      object GLSkyBox1: TGLSkyBox
        MaterialLibrary = matlib
        CloudsPlaneOffset = 0.200000002980232200
        CloudsPlaneSize = 32.000000000000000000
      end
      object dcgame: TGLDummyCube
        CubeSize = 1.000000000000000000
        object dcgameb: TGLDummyCube
          CubeSize = 1.000000000000000000
        end
        object GLPlane1: TGLPlane
          Direction.Coordinates = {F03B9FB3A1211AB3FFFF7F3F00000000}
          Up.Coordinates = {0000803F00000000F13B9F3300000000}
          Visible = False
          Height = 20.000000000000000000
          Width = 20.000000000000000000
        end
        object GLCube1: TGLCube
          Up.Coordinates = {00000000FFFF7F3F0000000000000000}
          Visible = False
        end
        object GLFreeForm1: TGLFreeForm
          Visible = False
        end
        object playercone: TGLCone
          Material.FrontProperties.Emission.Color = {0000803F0000803F0000803F0000803F}
          Up.Coordinates = {E0D2BB310000803F0000000000000000}
          BottomRadius = 8.000000000000000000
          Height = 15.000000000000000000
        end
        object GLSprite1: TGLSprite
          Visible = False
          Width = 1.000000000000000000
          Height = 1.000000000000000000
          Rotation = 0.000000000000000000
        end
        object GLAnimatedSprite1: TGLAnimatedSprite
          Interval = 100
          AnimationIndex = -1
          AnimationMode = samNone
          PixelRatio = 100
          Rotation = 0
          MirrorU = False
          MirrorV = False
          FrameRate = 10.000000000000000000
          SpriteAnimations = {
            0458434F4C02010201061054537072697465416E696D6174696F6E0200120000
            000002020458434F4C0201020012000000000200020002000200020002000200
            0200020002000200}
        end
      end
    end
    object dcmenu: TGLDummyCube
      CubeSize = 1.000000000000000000
      object titlecard: TGLHUDSprite
        Rotation = 0.000000000000000000
      end
    end
    object dccharscreen: TGLDummyCube
      ObjectsSorting = osNone
      CubeSize = 1.000000000000000000
      object charpic: TGLHUDSprite
        Material.MaterialLibrary = matlib
        Width = 400.000000000000000000
        Height = 550.000000000000000000
        Rotation = 0.000000000000000000
      end
      object csbackground: TGLHUDSprite
        Material.MaterialLibrary = matlib
        Position.Coordinates = {00008C430000BE43000000000000803F}
        Width = 510.000000000000000000
        Height = 700.000000000000000000
        Rotation = 0.000000000000000000
      end
      object bpart1: TGLHUDSprite
        Rotation = 0.000000000000000000
      end
      object bpart2: TGLHUDSprite
        Rotation = 0.000000000000000000
      end
      object bpart3: TGLHUDSprite
        Rotation = 0.000000000000000000
      end
      object bpart4: TGLHUDSprite
        Rotation = 0.000000000000000000
      end
      object bpart5: TGLHUDSprite
        Rotation = 0.000000000000000000
      end
      object bpart6: TGLHUDSprite
        Rotation = 0.000000000000000000
      end
      object bpart7: TGLHUDSprite
        Rotation = 0.000000000000000000
      end
      object bpart8: TGLHUDSprite
        Rotation = 0.000000000000000000
      end
      object bpart9: TGLHUDSprite
        Rotation = 0.000000000000000000
      end
      object bpart10: TGLHUDSprite
        Rotation = 0.000000000000000000
      end
      object bpart11: TGLHUDSprite
        Rotation = 0.000000000000000000
      end
      object bpart12: TGLHUDSprite
        Rotation = 0.000000000000000000
      end
      object bpart13: TGLHUDSprite
        Rotation = 0.000000000000000000
      end
      object dcperkicon: TGLDummyCube
        CubeSize = 1.000000000000000000
      end
    end
    object dctextdummy: TGLDummyCube
      CubeSize = 1.000000000000000000
      object csperkbg: TGLHUDSprite
        Material.MaterialLibrary = matlib
        Position.Coordinates = {00008C430000BE43000000000000803F}
        Width = 510.000000000000000000
        Height = 700.000000000000000000
        Rotation = 0.000000000000000000
      end
      object char_magic: TGLHUDText
        OnPicked = char_magicPicked
        Rotation = 0.000000000000000000
      end
      object char_armor: TGLHUDText
        Rotation = 0.000000000000000000
      end
      object char_bow: TGLHUDText
        Rotation = 0.000000000000000000
      end
      object char_sword: TGLHUDText
        Rotation = 0.000000000000000000
      end
      object char_endurence: TGLHUDText
        Rotation = 0.000000000000000000
      end
      object char_speed: TGLHUDText
        Rotation = 0.000000000000000000
      end
      object char_intelligence: TGLHUDText
        Rotation = 0.000000000000000000
      end
      object char_strength: TGLHUDText
        Rotation = 0.000000000000000000
      end
      object char_name: TGLHUDText
        Position.Coordinates = {0000000000002042000000000000803F}
        BitmapFont = GLWindowsBitmapFont1
        Text = 'TESTING!!'
        Rotation = 0.000000000000000000
      end
      object char_xp: TGLHUDText
        Rotation = 0.000000000000000000
      end
      object icon1: TGLHUDSprite
        Rotation = 0.000000000000000000
      end
      object icon2: TGLHUDSprite
        Rotation = 0.000000000000000000
      end
      object icon3: TGLHUDSprite
        Rotation = 0.000000000000000000
      end
      object icon4: TGLHUDSprite
        Rotation = 0.000000000000000000
      end
      object char_bp: TGLHUDText
        Rotation = 0.000000000000000000
      end
      object icon5: TGLHUDSprite
        Rotation = 0.000000000000000000
      end
      object icon6: TGLHUDSprite
        Rotation = 0.000000000000000000
      end
      object icon7: TGLHUDSprite
        Rotation = 0.000000000000000000
      end
      object icon8: TGLHUDSprite
        Rotation = 0.000000000000000000
      end
      object aitem: TGLHUDSprite
        Material.MaterialLibrary = matlib
        Rotation = 0.000000000000000000
      end
      object aitem_name: TGLHUDText
        BitmapFont = GLWindowsBitmapFont2
        Rotation = 0.000000000000000000
      end
      object spellbook_txt: TGLHUDText
        BitmapFont = GLWindowsBitmapFont1
        Rotation = 0.000000000000000000
      end
      object char_effects: TGLHUDText
        Rotation = 0.000000000000000000
      end
      object element_icon: TGLHUDSprite
        Rotation = 0.000000000000000000
      end
    end
    object dcui: TGLDummyCube
      ObjectsSorting = osNone
      CubeSize = 1.000000000000000000
      object dcuibg0: TGLDummyCube
        CubeSize = 1.000000000000000000
        object trbg: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Rotation = 0.000000000000000000
        end
        object corner_tl: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Rotation = 0.000000000000000000
        end
        object corner_tr: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Rotation = 0.000000000000000000
        end
        object corner_bl: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Rotation = 0.000000000000000000
        end
      end
      object dcuibg: TGLDummyCube
        ObjectsSorting = osNone
        CubeSize = 1.000000000000000000
        object monster_img: TGLHUDSprite
          Rotation = 0.000000000000000000
        end
        object key_silver: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Width = 32.000000000000000000
          Height = 32.000000000000000000
          Rotation = 0.000000000000000000
        end
        object key_gold: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Width = 32.000000000000000000
          Height = 32.000000000000000000
          Rotation = 0.000000000000000000
        end
        object key_silver_no: TGLHUDText
          BitmapFont = GLWindowsBitmapFont2
          Rotation = 0.000000000000000000
        end
        object key_gold_no: TGLHUDText
          BitmapFont = GLWindowsBitmapFont2
          Rotation = 0.000000000000000000
        end
        object monster_ico: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Width = 32.000000000000000000
          Height = 32.000000000000000000
          Rotation = 0.000000000000000000
        end
        object monster_ico_no: TGLHUDText
          BitmapFont = GLWindowsBitmapFont2
          Rotation = 0.000000000000000000
        end
        object PL_HPMP: TGLHUDText
          BitmapFont = GLWindowsBitmapFont2
          Rotation = 0.000000000000000000
        end
        object aitem_ui: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Rotation = 0.000000000000000000
        end
        object xpbar_bg: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Rotation = 0.000000000000000000
        end
      end
      object dcuibg2: TGLDummyCube
        CubeSize = 1.000000000000000000
        object pl_hpbar_bg: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Rotation = 0.000000000000000000
        end
        object pl_mpbar_bg: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Rotation = 0.000000000000000000
        end
        object monster_hpbar_bg: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Rotation = 0.000000000000000000
        end
      end
      object dcuimiddle: TGLDummyCube
        CubeSize = 1.000000000000000000
        object dcperked: TGLDummyCube
          ObjectsSorting = osNone
          CubeSize = 1.000000000000000000
          object perkimage: TGLHUDSprite
            Material.MaterialLibrary = matlib
            Rotation = 0.000000000000000000
          end
          object perk_name: TGLHUDText
            OnPicked = char_magicPicked
            BitmapFont = GLWindowsBitmapFont1
            Rotation = 0.000000000000000000
          end
          object perkdesc: TGLHUDText
            OnPicked = char_magicPicked
            BitmapFont = GLWindowsBitmapFont2
            Rotation = 0.000000000000000000
          end
          object perkdesc2: TGLHUDText
            OnPicked = char_magicPicked
            BitmapFont = GLWindowsBitmapFont2
            Rotation = 0.000000000000000000
          end
        end
        object monster_name: TGLHUDText
          BitmapFont = GLWindowsBitmapFont1
          Rotation = 0.000000000000000000
        end
        object player_hp: TGLHUDText
          BitmapFont = GLWindowsBitmapFont2
          Rotation = 0.000000000000000000
        end
        object player_mp: TGLHUDText
          BitmapFont = GLWindowsBitmapFont2
          Rotation = 0.000000000000000000
        end
        object battle_message: TGLHUDText
          BitmapFont = GLWindowsBitmapFont2
          Rotation = 0.000000000000000000
        end
        object xpbar: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Rotation = 0.000000000000000000
        end
        object teleport_glow: TGLHUDSprite
          Material.BlendingMode = bmTransparency
          Material.Texture.TextureMode = tmModulate
          Material.MaterialLibrary = matlib
          Rotation = 0.000000000000000000
        end
        object minimap: TGLHUDSprite
          Material.FrontProperties.Emission.Color = {0000803F0000803F0000803F0000803F}
          Material.Texture.Disabled = False
          Rotation = 0.000000000000000000
        end
        object pl_hpbar: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Rotation = 0.000000000000000000
        end
        object pl_mpbar: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Rotation = 0.000000000000000000
        end
        object monster_hpbar: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Rotation = 0.000000000000000000
        end
        object invitmdesc: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Rotation = 0.000000000000000000
        end
        object monster_sign: TGLHUDSprite
          Rotation = 0.000000000000000000
        end
      end
      object dcuifront: TGLDummyCube
        CubeSize = 1.000000000000000000
        object usedcard: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Rotation = 0.000000000000000000
        end
        object usedcard2: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Rotation = 0.000000000000000000
        end
        object dmg_pop: TGLHUDText
          BitmapFont = GLWindowsBitmapFont1
          Rotation = 0.000000000000000000
          ModulateColor.Color = {0000803F00000000000000000000803F}
        end
        object dmg_pop2: TGLHUDText
          BitmapFont = GLWindowsBitmapFont1
          Rotation = 0.000000000000000000
          ModulateColor.Color = {0000803F00000000000000000000803F}
        end
        object dmg_pop3: TGLHUDText
          BitmapFont = GLWindowsBitmapFont1
          Rotation = 0.000000000000000000
          ModulateColor.Color = {000000000000803F000000000000803F}
        end
        object dmg_pop4: TGLHUDText
          BitmapFont = GLWindowsBitmapFont1
          Rotation = 0.000000000000000000
          ModulateColor.Color = {000000000000803F000000000000803F}
        end
      end
      object dcrfdark: TGLDummyCube
        CubeSize = 1.000000000000000000
        object reqform_dark: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Rotation = 0.000000000000000000
        end
      end
      object dcrfb: TGLDummyCube
        CubeSize = 1.000000000000000000
        object reqform: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Rotation = 0.000000000000000000
        end
      end
      object dcrf: TGLDummyCube
        ObjectsSorting = osNone
        CubeSize = 1.000000000000000000
        object rf_title: TGLHUDText
          BitmapFont = GLWindowsBitmapFont1
          Rotation = 0.000000000000000000
        end
        object rf_text: TGLHUDText
          BitmapFont = GLWindowsBitmapFont2
          Rotation = 0.000000000000000000
        end
      end
      object dcrff: TGLDummyCube
        ObjectsSorting = osNone
        CubeSize = 1.000000000000000000
        object spellfound: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Rotation = 0.000000000000000000
        end
      end
      object inventory: TGLDummyCube
        ObjectsSorting = osNone
        CubeSize = 1.000000000000000000
        object inventoryf1: TGLDummyCube
          CubeSize = 1.000000000000000000
        end
        object inventoryf2: TGLDummyCube
          CubeSize = 1.000000000000000000
        end
        object invitmdesctxt: TGLHUDText
          BitmapFont = GLWindowsBitmapFont2
          Rotation = 0.000000000000000000
        end
        object invitmimage: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Width = 200.000000000000000000
          Height = 200.000000000000000000
          Rotation = 0.000000000000000000
        end
      end
      object dctooltip: TGLDummyCube
        CubeSize = 1.000000000000000000
        object dcttb: TGLDummyCube
          CubeSize = 1.000000000000000000
          object tooltipbg: TGLHUDSprite
            Material.MaterialLibrary = matlib
            Rotation = 0.000000000000000000
          end
        end
        object dcttf: TGLDummyCube
          CubeSize = 1.000000000000000000
          object tooltiptxt: TGLHUDText
            BitmapFont = GLWindowsBitmapFont2
            Rotation = 0.000000000000000000
          end
        end
      end
    end
    object dcload: TGLDummyCube
      CubeSize = 1.000000000000000000
      object dcloadb: TGLDummyCube
        CubeSize = 1.000000000000000000
        object loadscr_b: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Rotation = 0.000000000000000000
        end
      end
      object dcloadf: TGLDummyCube
        CubeSize = 1.000000000000000000
        object loadscr_f: TGLHUDSprite
          Material.MaterialLibrary = matlib
          Rotation = 0.000000000000000000
        end
        object loadcr_wheel: TGLHUDSprite
          Rotation = 0.000000000000000000
        end
      end
      object dcloadt: TGLDummyCube
        CubeSize = 1.000000000000000000
        object loadtxt: TGLHUDText
          BitmapFont = GLWindowsBitmapFont1
          Rotation = 0.000000000000000000
        end
      end
    end
    object creditsroll: TGLDummyCube
      CubeSize = 1.000000000000000000
    end
  end
  object GLCadencer1: TGLCadencer
    Scene = GLScene1
    Enabled = False
    OnProgress = GLCadencer1Progress
    Left = 152
    Top = 184
  end
  object matlib: TGLMaterialLibrary
    Left = 128
    Top = 8
  end
  object GLWindowsBitmapFont1: TGLWindowsBitmapFont
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWhite
    Font.Height = -20
    Font.Name = 'Bookman Old Style'
    Font.Style = []
    Ranges = <
      item
        StartASCII = ' '
        StopASCII = #8212
        StartGlyphIdx = 0
      end
      item
        StartASCII = #0
        StopASCII = #0
        StartGlyphIdx = 8181
      end>
    Left = 216
    Top = 8
  end
  object GLGuiLayout1: TGLGuiLayout
    GuiComponents = <>
    Left = 440
    Top = 8
  end
  object GLWindowsBitmapFont2: TGLWindowsBitmapFont
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Bookman Old Style'
    Font.Style = []
    Ranges = <
      item
        StartASCII = ' '
        StopASCII = '}'
        StartGlyphIdx = 0
      end
      item
        StartASCII = #0
        StopASCII = #0
        StartGlyphIdx = 94
      end>
    Left = 344
    Top = 8
  end
  object GLCadencer2: TGLCadencer
    Scene = GLScene1
    Enabled = False
    OnProgress = GLCadencer2Progress
    Left = 80
    Top = 184
  end
  object GLBumpShader1: TGLBumpShader
    BumpMethod = bmDot3TexCombiner
    BumpSpace = bsTangentQuaternion
    BumpOptions = [boDiffuseTexture2]
    SpecularMode = smPhong
    DesignTimeEnabled = False
    ParallaxOffset = 0.039999999105930330
    Left = 288
    Top = 184
  end
  object GLSoundLibrary1: TGLSoundLibrary
    Samples = <>
    Left = 384
    Top = 184
  end
  object GLSMWaveOut1: TGLSMWaveOut
    Active = True
    MasterVolume = 1.000000000000000000
    Listener = mcam
    Sources = <
      item
        SoundLibrary = GLSoundLibrary1
        Volume = 1.000000000000000000
        MinDistance = 1.000000000000000000
        MaxDistance = 100.000000000000000000
        InsideConeAngle = 360.000000000000000000
        OutsideConeAngle = 360.000000000000000000
        Origin = playercone
      end>
    Cadencer = GLCadencer1
    Left = 496
    Top = 184
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 600
    Top = 184
  end
  object GLTexCombineShader1: TGLTexCombineShader
    Combiners.Strings = (
      'Tex1:=Tex0+Tex1;')
    DesignTimeEnabled = False
    MaterialLibrary = matlib
    Left = 712
    Top = 184
  end
  object GLFireFXManager1: TGLFireFXManager
    FireDir.Coordinates = {00000000000000000000803F00000000}
    InitialDir.Coordinates = {00000000000000000000803F00000000}
    Cadencer = GLCadencer1
    ParticleSize = 1.500000000000000000
    FireDensity = 1.000000000000000000
    FireEvaporation = 0.500000000000000000
    FireCrown = 1.000000000000000000
    FireBurst = 2.000000000000000000
    FireRadius = 1.000000000000000000
    Disabled = False
    Paused = False
    ParticleInterval = 0.100000001490116100
    UseInterval = True
    Left = 832
    Top = 184
  end
end
