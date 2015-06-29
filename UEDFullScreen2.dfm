object Form15: TForm15
  OldCreateOrder = False
  Height = 150
  Width = 215
  object GLFullScreenViewer1: TGLFullScreenViewer
    Camera = Form1.mcam
    Width = 800
    Height = 600
    Buffer.AmbientColor.Color = {0000000000000000000000000000803F}
    Buffer.AntiAliasing = aaNone
    ManualRendering = False
    StayOnTop = True
    VSync = vsmNoSync
    RefreshRate = 0
    OnMouseDown = GLFullScreenViewer1MouseDown
    OnMouseUp = GLFullScreenViewer1MouseUp
    OnMouseMove = GLFullScreenViewer1MouseMove
    Left = 144
    Top = 16
  end
end
