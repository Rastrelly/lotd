unit UEDCadencer;

interface

uses UED_main, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, GLAnimatedSprite, GLScene,
  GLCoordinates, GLObjects, GLMaterial, GLCadencer, GLWin32Viewer,
  GLCrossPlatform, GLBaseClasses, Vcl.ExtCtrls, GlCompositeImage,
  GLFilePNG, GLFileTGA, GLFileJPEG, TGA, GLTexture, GLHUDObjects, Math, GLVectorFileObjects,
  GLGeomObjects, GLFullScreenViewer,mmsystem, Vcl.MPlayer, Vcl.StdCtrls,
  GLSound, GLSMWaveOut, Bass, GLBitmapFont, GLWindowsFont, GLGui, GLFile3DS,
  GLBumpShader, GLShadowPlane, Vcl.Imaging.pngimage, glFileObj,
  GLSkyBox, GLFileWAV, GLFileMP3, GLSMFMOD, OpenAL, GLContext;

procedure HandleItemList;

var mkx,mky,uin:integer;
    cmx,cmy:real;
    i,j:integer;
    ei,ej:integer;
    tch:character;
    desbmn,desmn,pa:string;
    cky:integer;
    mimx,mimy:integer;
    at_w:integer;
    pl_hpperc,pl_mpperc,monster_hpperc:real;
    pl_rwhp,pl_rwmp,mon_rwhp:real;
    delta:real;
    d,dx,dy,sd,sdx,sdy,rkx,rky:real;
    sx1,sy1,sx2,sy2,cx1,cy1,cx2,cy2,ry1,rx1,ry2,rx2:real;
    mx1,mx2,my1,my2:integer;

    ik,sid:integer;
    snm:string;
    scx,scy,sw,sh:integer;
    mngName:string;
    xpwd:real;
    retch:integer;
    tts:string; //text to show
    b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13:string;
    ag:integer;
    basew,baseh,rfw,rfh:integer;

    itmtxt:string;
    gotbonuses:boolean;


implementation


procedure HandleItemList; //works on item list for Cadencer 1
begin
  with Form1 do
  begin

  if itemlistmode=true then
  begin
    if invitmdesc.Visible=false then invitmdesc.Visible:=true;
    if invitmdesctxt.Visible=false then invitmdesctxt.Visible:=true;
    if invitmimage.Visible=false then invitmimage.Visible:=true;
    invitmdesc.Position.Y:=itemlistbg.Position.Y;
    invitmdesc.Width:=GLSceneViewer1.Width-itemlistbg.Width-20;
    if invitmdesc.Width>itemlistbg.Width then invitmdesc.Width:=itemlistbg.Width;
    invitmdesc.Height:=itemlistbg.Height;
    invitmdesc.Position.X:=itemlistbg.Position.X+itemlistbg.Width/2+20+invitmdesc.Width/2;
    ilitemtitle.Position.X:=invitmdesc.Position.X-invitmdesc.Width/2+30;
    ilitemtitle.Position.Y:=invitmdesc.Position.Y-invitmdesc.height/2+40;
    itmtxt:='';
    if showspell=false then
    begin
      with itms[iuc] do
      if count>0 then
      begin
        itmtxt:=itmtxt+strarr[200]+': ';
        if itmtype=0 then itmtxt:=itmtxt+strarr[205];
        if itmtype=1 then itmtxt:=itmtxt+strarr[203];
        if itmtype=2 then itmtxt:=itmtxt+strarr[204];
        if itmtype=3 then itmtxt:=itmtxt+strarr[7];
        itmtxt:=itmtxt+#13#10;
        itmtxt:=itmtxt+#13#10;
        itmtxt:=itmtxt+strarr[201]+#13#10;

        gotbonuses:=false;
        if lb_str<>0 then begin itmtxt:=itmtxt+strarr[36]+': '+inttostr(lb_str)+#13#10;; gotbonuses:=true; end;
        if lb_int<>0 then begin itmtxt:=itmtxt+strarr[37]+': '+inttostr(lb_int)+#13#10;; gotbonuses:=true; end;
        if lb_spd<>0 then begin itmtxt:=itmtxt+strarr[38]+': '+inttostr(lb_spd)+#13#10;; gotbonuses:=true; end;
        if lb_end<>0 then begin itmtxt:=itmtxt+strarr[39]+': '+inttostr(lb_end)+#13#10;; gotbonuses:=true; end;
        if lb_sw<>0 then begin itmtxt:=itmtxt+strarr[40]+': '+inttostr(lb_sw)+#13#10;; gotbonuses:=true; end;
        if lb_mg<>0 then begin itmtxt:=itmtxt+strarr[43]+': '+inttostr(lb_mg)+#13#10;; gotbonuses:=true; end;
        if lb_bw<>0 then begin itmtxt:=itmtxt+strarr[41]+': '+inttostr(lb_bw)+#13#10;; gotbonuses:=true; end;
        if lb_ar<>0 then begin itmtxt:=itmtxt+strarr[42]+': '+inttostr(lb_ar)+#13#10;; gotbonuses:=true; end;
        if lb_crd>=0 then begin itmtxt:=itmtxt+strarr[202]+': '+deck[lb_crd].name+#13#10;; gotbonuses:=true; end;
        if gotbonuses=false then itmtxt:=itmtxt+'-'+#13#10;

      end;
    end
    else
    begin
      itmtxt:=ShowCardInfo(iuc);
    end;

    invitmdesctxt.Text:=itmtxt;

    invitmdesctxt.Position.X:=ilitemtitle.Position.X+10;
    invitmdesctxt.Position.Y:=ilitemtitle.Position.Y+250;

    invitmimage.Position.X:=invitmdesc.Position.X;
    invitmimage.Position.Y:=(invitmdesctxt.Position.Y-ilitemtitle.Position.Y)/2+50;

    if showspell=false then
    begin
      invitmimage.Width:=invitmimage.Height;
      if invitmimage.Material.LibMaterialName<>'itm_'+inttostr(iuc) then invitmimage.Material.LibMaterialName:='itm_'+inttostr(iuc)
    end
    else
    begin
      invitmimage.Width:=invitmimage.Height*0.6;
      if invitmimage.Material.LibMaterialName<>'card_'+inttostr(iuc) then invitmimage.Material.LibMaterialName:='card_'+inttostr(iuc)+'_0';
    end;


  end
  else
  begin
    if invitmdesc.Visible=true then invitmdesc.Visible:=false;
    if invitmimage.Visible=true then invitmimage.Visible:=false;
    if invitmdesctxt.Visible=true then invitmdesctxt.Visible:=false;
  end;

  end;
end;


end.
