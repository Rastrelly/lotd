unit UEDcardedit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UED_main, UEDmapedit, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, TGA;

type
  TForm3 = class(TForm)
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Timer1: TTimer;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    LabeledEdit9: TLabeledEdit;
    Button3: TButton;
    Image1: TImage;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    FontDialog1: TFontDialog;
    FontDialog2: TFontDialog;
    LabeledEdit10: TLabeledEdit;
    LabeledEdit11: TLabeledEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    ComboBox3: TComboBox;
    Label2: TLabel;
    Edit2: TEdit;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    LabeledEdit12: TLabeledEdit;
    Label3: TLabel;
    ComboBox4: TComboBox;
    Label4: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Memo1: TMemo;
    Button12: TButton;
    Label8: TLabel;
    ComboBox5: TComboBox;
    Label9: TLabel;
    Edit5: TEdit;
    procedure MakeCard(crd:card;id:integer;s:boolean);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure LabeledEdit7Change(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  tempcard:card;
  f1,f2:TFont;
  temparr:array[0..10000]of string;
  celang:string;

implementation

{$R *.dfm}

procedure TForm3.Button10Click(Sender: TObject);
begin
  Form1.Memo1.Clear;
  form1.memo1.lines.add(LabeledEdit9.Text);
  form1.Memo1.Lines.SaveToFile(gameexe+'\text\'+celang+'\overrides\spells\'+Edit1.Text+'.txt');
end;

procedure TForm3.Button12Click(Sender: TObject);
begin
  Memo1.Lines.SaveToFile(gameexe+'\cards\'+Edit1.Text+'_script.txt');
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  tempcard:=Form2.LoadCard(gameexe+'\cards\'+Edit1.Text+'.crd',celang);
  With tempcard do
  begin
    LabeledEdit1.Text:=inttostr(mc);
    LabeledEdit2.Text:=inttostr(hpc);
    LabeledEdit3.Text:=inttostr(dmgph);
    LabeledEdit4.Text:=inttostr(dmgperc);
    LabeledEdit5.Text:=inttostr(addhp);
    LabeledEdit6.Text:=inttostr(addmp);
    LabeledEdit7.Text:=inttostr(addeffect);
    LabeledEdit8.Text:=inttostr(efflgth);
    LabeledEdit9.Text:=(name);
    LabeledEdit10.Text:=inttostr(bont);
    LabeledEdit11.Text:=inttostr(bonam);
    LabeledEdit12.Text:=inttostr(effstrgth);
    CheckBox1.Checked:=accum;
    CheckBox2.Checked:=monly;
    ComboBox1.ItemIndex:=govskill;
    ComboBox4.ItemIndex:=effdir;
    ComboBox5.ItemIndex:=element;
    Edit3.Text:=IntToStr(consumes);
    Edit4.Text:=IntToStr(mindam);
    Edit5.Text:=sound;
  end;

  if fileexists(gameexe+'\cards\'+Edit1.Text+'_script.txt')=true then
  begin
    Memo1.Lines.LoadFromFile(gameexe+'\cards\'+Edit1.Text+'_script.txt');
  end
  else
    Memo1.Lines.Clear;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  Form2.SaveCard(tempcard,gameexe+'\cards\'+Edit1.Text+'.crd');
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  MakeCard(tempcard,strtoint(Edit1.Text),false);
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
  MakeCard(tempcard,strtoint(Edit1.Text),true);
end;

procedure TForm3.Button5Click(Sender: TObject);
var i:integer;
begin
  for i:=0 to (ComboBox2.Items.Count-1) do
  begin
    tempcard:=Form2.LoadCard(gameexe+'\cards\'+inttostr(i)+'.crd',celang);
    MakeCard(tempcard,i,true);
  end;
end;

procedure TForm3.Button6Click(Sender: TObject);
begin
  Form3.Hide;
  Form3.Show;
end;

procedure TForm3.Button7Click(Sender: TObject);
begin
  if FontDialog1.Execute then
    f1:=FontDialog1.Font;
end;

procedure TForm3.Button8Click(Sender: TObject);
begin
  if FontDialog2.Execute then
    f2:=FontDialog2.Font;
end;

procedure TForm3.Button9Click(Sender: TObject);
begin
  form1.fillstrarr(edit2.Text,temparr);
  celang:=Edit2.Text;
end;

procedure TForm3.MakeCard(crd:card;id:integer;s:boolean);
var cimg,himg:TJPEGImage;
    fbmp,fbmp2:TBitmap;
    n:integer;
    th:integer;
    opng:TPngImage;
    cw,ch:integer;
    esinp,dr:string;
    eff,elem:TTGAImage;
    itmname:string;
begin
  cimg:=TJPegImage.Create;
  himg:=TJPegImage.Create;
  fbmp:=TBitmap.Create;
  fbmp2:=TBitmap.Create;
  for n:=2 downto 0 do
  begin
    cimg.LoadFromFile(gameexe+'\textures\cards\b'+inttostr(crd.govskill)+'_'+inttostr(crd.element)+'.jpg');
    fbmp.Assign(cimg);
    try
      himg.LoadFromFile(gameexe+'\textures\cards\h'+inttostr(id)+'.jpg');
    except
      himg.LoadFromFile(gameexe+'\textures\cards\noimg.jpg');
    end;
    fbmp2.Assign(himg);
    with fbmp.Canvas do
    begin
      CopyRect(Rect(14,14,126,92),fbmp2.Canvas,rect(0,0,fbmp2.Width-1,fbmp2.Height-1));
      {if crd.element<>0 then
      begin
        try elem.Free; except end;
        elem:=TTGAImage.Create;
        elem.LoadFromFile(gameexe+'\textures\'+qs+'\element_'+inttostr(crd.element)+'.tga');
        CopyRect(rect(fbmp.Width-33,1,fbmp.Width-1,1+32),elem.Canvas,rect(0,0,elem.Width,elem.Height));
      end;}
      Font:=f1;
      if n=2 then Font.Color:=clLime;
      if n=1 then Font.Color:=clYellow;
      if n=0 then Font.Color:=clWhite;
      Brush.Style:=bsClear;
      TextOut(16,95,crd.name);
      th:=110;
      Font:=f2;
      if n=2 then Font.Color:=clLime;
      if n=1 then Font.Color:=clYellow;
      if n=0 then Font.Color:=clWhite;
      if crd.dmgph>0 then
      begin
        if crd.mindam=crd.dmgph then
        begin
          TextOut(21,th,temparr[50]+': '+inttostr(crd.dmgph));
          th:=th+Font.Size+2;
        end
        else
        begin
          TextOut(21,th,temparr[50]+': '+inttostr(crd.mindam)+'-'+inttostr(crd.dmgph));
          th:=th+Font.Size+2;
        end;
      end;
      if crd.dmgperc>0 then
      begin
        TextOut(21,th,temparr[50]+': '+inttostr(crd.dmgperc)+'% '+temparr[48]);
        th:=th+Font.Size+2;
      end;
      if crd.addhp>0 then
      begin
        TextOut(21,th,'+'+inttostr(crd.addhp)+' '+temparr[48]);
        th:=th+Font.Size+2;
      end;
      if crd.addmp>0 then
      begin
        TextOut(21,th,'+'+inttostr(crd.addmp)+' '+temparr[49]);
        th:=th+Font.Size+2;
      end;
      if crd.addeffect>0 then
      begin
        //CopyRect(rect(21,th,Font.Size+21,Font.Size+th),form1.matlib.LibMaterialByName('effect_'+inttostr(crd.addeffect)).Material.Texture.Image);
        try eff.Free; except end;
        eff:=TTGAImage.Create;
        eff.LoadFromFile(gameexe+'\textures\'+qs+'\effect_'+inttostr(crd.addeffect)+'.tga');
        CopyRect(rect(21,th,Font.Size*2+21,Font.Size*2+th),eff.Canvas,rect(0,0,eff.Width,eff.Height));
        {TextOut(21,th,Form1.GetETypeName(crd.addeffect,temparr));
        th:=th+Font.Size+2;}
        if crd.effstrgth>0 then esinp:=inttostr(crd.effstrgth)+'/' else esinp:='';
        if crd.effdir=0 then dr:='<' else dr:='>';
        //TextOut(21+font.Size*2+5,th,temparr[51]+': '+esinp+inttostr(crd.efflgth)+' '+temparr[199]+' '+dr);
        TextOut(21+font.Size*2+5,th,' '+esinp+inttostr(crd.efflgth)+' '+temparr[199]+' '+dr);
        th:=th+Font.Size+2;
      end;
      if crd.consumes<>-1 then
      begin
        itmname:=Form2.extractitemoverridename(celang,crd.consumes);
        if itmname='-nil-' then itmname:=itms[crd.consumes].overridename;
        TextOut(21,th,'-1 '+itmname);
        th:=th+Font.Size+2;
      end;
      if abs(crd.bonam)>0 then
      begin
        TextOut(21,th,'-------------');
        th:=th+Font.Size+2;
        TextOut(21,th,Form1.GetEClassName(crd.bont,temparr));
        th:=th+Font.Size+2;
        TextOut(21,th,temparr[96]+': '+inttostr(crd.bonam)+'%');
        th:=th+Font.Size+2;
      end;
      if 1=1 then
      begin
        TextOut(21,th,'-------------');
        th:=th+Font.Size+2;
      end;
      if crd.mc>0 then
      begin
        Font.Color:=clAqua;
        TextOut(21,th,temparr[52]+': '+inttostr(crd.mc)+' '+temparr[49]);
        Font.Color:=clWhite;
        th:=th+Font.Size+2;
      end;
      if crd.hpc>0 then
      begin
        Font.Color:=clRed;
        TextOut(21,th,temparr[52]+': '+inttostr(crd.hpc)+' '+temparr[48]);
        Font.Color:=clWhite;
        th:=th+Font.Size+2;
      end;
      Image1.Canvas.CopyRect(rect(0,0,width,height),fbmp.Canvas,rect(0,0,width,height));
      opng:=TPngImage.Create;
      opng.Assign(fbmp);
      if s=true then
        opng.SaveToFile(gameexe+'\textures\cards\'+celang+'\'+inttostr(id)+'_'+inttostr(n)+'.png');
    end;
  end;
  FreeAndNil(cimg);
  FreeAndNil(himg);
  FreeAndNil(fbmp);
  FreeAndNil(fbmp2);
  FreeAndNil(opng);

end;

procedure TForm3.CheckBox1Click(Sender: TObject);
begin
  tempcard.accum:=CheckBox1.Checked;
end;

procedure TForm3.CheckBox2Click(Sender: TObject);
begin
  tempcard.monly:=CheckBox2.Checked;
end;

procedure TForm3.ComboBox2Change(Sender: TObject);
begin
  try
    Edit1.Text:=inttostr(ComboBox2.ItemIndex);
    Button1.Click;
    Button3.Click;
  except

  end;
end;

procedure TForm3.ComboBox3Change(Sender: TObject);
begin
  LabeledEdit7.Text:=inttostr(ComboBox3.ItemIndex);
end;

procedure TForm3.FormShow(Sender: TObject);
var i:integer;
    tc:card;
    cfn:string;
begin
  f1:=FontDialog1.Font;
  f2:=FontDialog2.Font;
  i:=-1;
  ComboBox2.Items.Clear;
  repeat
    i:=i+1;
    cfn:=gameexe+'\cards\'+inttostr(i)+'.crd';
    try
      tc:=form2.LoadCard(cfn,lang);
    except end;
    if fileexists(cfn)=true then
    begin
      ComboBox2.Items.Add(tc.name);
    end;
  until fileexists(cfn)=false;

  ComboBox3.Items.Clear;
  i:=0;
  repeat
     ComboBox3.Items.Add(Form1.GetETypeName(i,strarr));
     i:=i+1;
  until (Form1.GetETypeName(i,strarr)='--none--');

  edit2.Text:=celang;

end;

procedure TForm3.LabeledEdit7Change(Sender: TObject);
begin
  try
    ComboBox3.Text:=Form1.GetETypeName(strtoint(LabeledEdit7.Text),strarr);
  except end;
end;

procedure TForm3.Timer1Timer(Sender: TObject);
begin
  if Form3.Visible=true then
  begin
    try
      with tempcard do
      begin
        name:=LabeledEdit9.Text;
        mc:=strtoint(LabeledEdit1.Text);
        hpc:=strtoint(LabeledEdit2.Text);
        dmgph:=strtoint(LabeledEdit3.Text);
        dmgperc:=strtoint(LabeledEdit4.Text);
        addhp:=strtoint(LabeledEdit5.Text);
        addmp:=strtoint(LabeledEdit6.Text);
        addeffect:=strtoint(LabeledEdit7.Text);
        efflgth:=strtoint(LabeledEdit8.Text);
        govskill:=ComboBox1.ItemIndex;
        bont:=strtoint(LabeledEdit10.Text);
        bonam:=strtoint(LabeledEdit11.Text);
        effstrgth:=strtoint(LabeledEdit12.Text);
        effdir:=(ComboBox4.ItemIndex);
        consumes:=strtoint(Edit3.Text);
        mindam:=strtoint(Edit4.Text);
        element:=(ComboBox5.ItemIndex);
        sound:=Edit5.Text;
      end;
    except end;
  end;
end;

end.
