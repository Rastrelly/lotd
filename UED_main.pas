unit UED_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, GLAnimatedSprite, GLScene,
  GLCoordinates, GLObjects, GLMaterial, GLCadencer, GLWin32Viewer,
  GLCrossPlatform, GLBaseClasses, Vcl.ExtCtrls, GlCompositeImage,
  GLFilePNG, GLFileTGA, GLFileJPEG, TGA, GLTexture, GLHUDObjects, Math, GLVectorFileObjects,
  GLGeomObjects, GLFullScreenViewer,mmsystem, Vcl.MPlayer, Vcl.StdCtrls,
  GLSound, GLSMWaveOut, Bass, GLBitmapFont, GLWindowsFont, GLGui, GLFile3DS,
  GLBumpShader, GLShadowPlane, Vcl.Imaging.pngimage, glFileObj,
  GLSkyBox, GLFileWAV, GLFileMP3, GLSMFMOD, OpenAL, GLContext, GLScreen,
  GLShadowVolume, GLMultiMaterialShader, GLTexCombineShader, GLFireFX;

type

  globscript = record
    text:string;
    active:boolean;
    refr:integer;
    a,b:integer;
    id:string;
  end;

  gamebutton = record
    x,y,w,h:integer;
    state:integer; //0 - static, 1- mouse over, 2 - pressed
    visible:boolean;
    caption:string;
    matname:string; //name of currently assigned material
    matoverride:string; //name of material to be loaded INSTEAD of "but_"
                        //leave empty to avoid override
    tooltip:string;
  end;

  tooltiparea = record
    x1,y1,x2,y2:integer;
    text:string;
  end;

  soundinf = record
    name:string;
    id:integer;
  end;

  character = record
    lvl:integer;
    xp:integer;
    xpreq:integer;
    strength,intelligence,speed,endurance:integer; //final parameters
    bstr,bint,bspd,bend:integer; //basic unmodified parameters
    sword,bow,armor,magic:integer; //final skills
    bsw,bbw,bar,bmg:integer; //basic unmodogied skills
    hp,hpmax:integer;
    mana,manamax:integer;
    eng,engmax:integer;
    e,estr:array[1..100]of integer; //effects. i.e. paralyzed, blessed, etc.
    //1 - paralysis, 2 - blessing, 3 - rage (free casting)
    spellbook:array[0..1000]of boolean;
    spellen:array[0..1000]of boolean;
    name:string;
    sex:integer; //0 - male; 1 - female
    bonuspoints:integer;
    face,hair,cloth,hat:integer;
    spec:integer; //0 - living; 1 - angel; 2 - demon; 3 - undead
    boss:boolean;
    oname:string;
    perks:array[0..100]of boolean;
    hand:array[0..6]of integer; //numbers of cards in player hand
    luc:integer;
    element:integer; //0 - n, 1 - e, 2 - a, 3 - w, 4 - f
    loot,lootchance:integer;
    jrn:integer; //battle journal id
  end;

  perk = record
    enabled:boolean;  //if this perk even exists
    recst,recagi,recin,recend,recsw,recbw,recmg,recar,recperk,recrace:integer;//requirements
    addst,addagi,addin,addend,addsw,addbw,addmg,addar,addcard:integer;//bonuses
    addcoded:integer; //coded effect id
    name:string; //perk localized name
    id:integer; //perk id
  end;

  lcell = record
    x,y:integer;
    passable:boolean;
    wall:boolean;
    chest:boolean;
    chestno:integer;
    door:boolean;
    doorno:integer;
    trap:boolean;
    traptype:integer;
    power:integer;
    textid:integer;
    spritename:string;
    fco,cco,wco,wmo,fmo:string; //floor, ceiling, wall texture overrides; wall mesh override; floor mesh override
    ceil,floor:boolean;
    ta,ra,pa:integer; //turn, roll and pitch angles
    dx,dy,dz:integer; //position modifiers
    fwm:boolean; //shows wall mesh even if wall is disabled

    //format 2
    mark:boolean; //is this cell visible on minimap
    r,g,b:integer; //color

    //format 3
    lmap:string;

    //format 4
    door3d:boolean;
    doorface:integer;

    //format 6
    outdoors:boolean;

    //format 10
    plz:integer; //player position z axis

    //format 11
    blockx1,blockx2:integer;
    blocky1,blocky2:integer;

    //format 12
    grass:boolean;
    dens:integer;
    gtp:string;

  end;

  spritelistitem=record
    name:string;
    purpose:integer; //0 - none; 1 - wall deco; 2 - cell deco; 3 - item on the floor; -1 - unused;
    size,size2:integer; //size of sprite (x,y)
  end;

  freesprite=record
    enabled:boolean;
    fixed:boolean;
    x,y,z:integer;
    name:string;
    w,h:integer;
    dirx,diry:real;
  end;

  lsrc=RECORD
    x,y,z:integer;
    ca,la,qa:real;
    amb_r,amb_g,amb_b,spec_r,spec_g,spec_b,diff_r,diff_g,diff_b:real;
    enabled:boolean;
    //format 8
    sdx,sdy,sdz:integer;
    stl:integer; //0 - omni, 1 - spot
    spotcutoff:integer;
    spotexponent:real;
  END;

  freemesh=record
    enabled:boolean;
    x,y,z:integer;
    rx,ry,rz,rta,rra,rpa:real;
    ta,ra,pa:integer;
    name:string;
    sx,sy,sz:integer;
    texture,texture2:string;
    fire:boolean;
    fdx,fdy,fdz:integer; //fire offset

    //format 7
    bhv:integer; //0 - none, 1 - move, 2 - rotate
    x1,x2,y1,y2,z1,z2:integer; //(==ta12,ra12,pa12)
    loop:boolean;
    spd:real;

    //format 9
    trscript:string;
  end;

  card=record
    name:string; //card name
    active:boolean; //was or wasn't used by player
    mc,hpc:integer; //eats mana and HP
    dmgph:integer; //deals physical damage
    dmgperc:integer; //deals percent damage
    addhp:integer; //adds hp
    addmp:integer; //adds mp
    addeffect:integer; //adds status effect
    efflgth:integer; //for how many turns effect will last
    govskill:integer; //governing skilll
    bont,bonam:integer; //bonus to species, bonus amount (%)
    accum:boolean; //effect is renewed or accumulated for this card
    monly:boolean; //game will not give this card to a player
    enabled:boolean; //is this card actually eligible
    effstrgth:integer; //effect power (if 0 - defined by length)
    effdir:integer; //0 - self, 1 - target
    consumes:integer; //-1 - none; else - item id
    mindam:integer; //if this card does damage that varies, this is lowest possible
    element:integer; //0 - n, 1 - e, 2 - a, 3 - w, 4 - f
    sound:string; //if <> 0 then plays specified sound
    perkbon:integer; //perk which provideas bonus for this card (unused)
  end;

  trapex=record  //external trap
    tex,tey,tet:integer;
  end;

  envr=record
    name:string;
    enabled:boolean;
  end;

  rqftp=record
    active:boolean;
    ttl_text,main_text:string;
    textfld:boolean;
    tp:integer; {0 - OK msg; 1 - OK/canscel;}
    fcase:integer; {0 - enter char name}
    pos:integer; //0 - standard, 1 - top
    img:string;
    ch1,ch2,ch3,ch4,ch5,ch6:string; //choice scripts
  end;

  loot=record
    id:integer;
    name:string;
    overridename:string;
    count:integer;
    p:integer;
    lb_str,lb_int,lb_spd,lb_end:integer;
    lb_sw,lb_mg,lb_bw,lb_ar:integer;
    lb_crd:integer;
    l_armor:integer; //armor from char appearance armor roster
    l_hat:integer; //hat from char appearance hat roster
    nohair:boolean;//removes hair when equipped
    itmtype:integer; //0 - misc, 1 - sword, 2 - bow, 3 - armor, 4 - hat
    crf1,crf2:integer; //crafting components (-1 - none)
  end;

  pop=record
    x,y,kx,ky,fx,fy:real;
    enabled:boolean;
    txt:string;
    tp:integer; // 0 - dmg, 1 - heal, 2 - mag
  end;

  edisp=record
    en,el,es:integer;
  end;

  room=record //a room for mapgen
    purp:integer;
    x,y:integer; //center
    w,h:integer; //width,height
    shape:integer; //0 - square, 1 - circle
    connection:integer; //has a corridor to room no
  end;

  tltip=record //tooltip description
    text:string;
    visible:boolean;
    x,y,w,h:integer;
  end;

  usdc=record
    sx,sy,x,y,kx,ky:real;
  end;

  glscrn=record
    Width,Height:integer;
  end;

  TForm1 = class(TForm)
    GLScene1: TGLScene;
    GLCadencer1: TGLCadencer;
    matlib: TGLMaterialLibrary;
    GLWindowsBitmapFont1: TGLWindowsBitmapFont;
    GLGuiLayout1: TGLGuiLayout;
    GLCube1: TGLCube;
    GLPlane1: TGLPlane;
    mcam: TGLCamera;
    dcgame: TGLDummyCube;
    dcmenu: TGLDummyCube;
    playerlight: TGLLightSource;
    dcui: TGLDummyCube;
    dccharscreen: TGLDummyCube;
    csbackground: TGLHUDSprite;
    char_name: TGLHUDText;
    char_strength: TGLHUDText;
    char_intelligence: TGLHUDText;
    char_speed: TGLHUDText;
    char_endurence: TGLHUDText;
    char_sword: TGLHUDText;
    char_bow: TGLHUDText;
    char_armor: TGLHUDText;
    char_magic: TGLHUDText;
    dctextdummy: TGLDummyCube;
    char_xp: TGLHUDText;
    icon1: TGLHUDSprite;
    icon2: TGLHUDSprite;
    icon3: TGLHUDSprite;
    dcuibg: TGLDummyCube;
    dcuimiddle: TGLDummyCube;
    GLWindowsBitmapFont2: TGLWindowsBitmapFont;
    GLCadencer2: TGLCadencer;
    Memo1: TMemo;
    titlecard: TGLHUDSprite;
    charpic: TGLHUDSprite;
    icon4: TGLHUDSprite;
    char_bp: TGLHUDText;
    bpart1: TGLHUDSprite;
    bpart2: TGLHUDSprite;
    bpart3: TGLHUDSprite;
    bpart4: TGLHUDSprite;
    bpart5: TGLHUDSprite;
    bpart6: TGLHUDSprite;
    GLFreeForm1: TGLFreeForm;
    key_silver: TGLHUDSprite;
    key_gold: TGLHUDSprite;
    key_silver_no: TGLHUDText;
    key_gold_no: TGLHUDText;
    reqform: TGLHUDSprite;
    rf_title: TGLHUDText;
    rf_text: TGLHUDText;
    playercone: TGLCone;
    GLSprite1: TGLSprite;
    dcuifront: TGLDummyCube;
    monster_img: TGLHUDSprite;
    monster_name: TGLHUDText;
    player_hp: TGLHUDText;
    player_mp: TGLHUDText;
    battle_message: TGLHUDText;
    usedcard: TGLHUDSprite;
    usedcard2: TGLHUDSprite;
    GLSceneViewer1: TGLSceneViewer;
    spellfound: TGLHUDSprite;
    monster_ico: TGLHUDSprite;
    monster_ico_no: TGLHUDText;
    PL_HPMP: TGLHUDText;
    GLBumpShader1: TGLBumpShader;
    icon5: TGLHUDSprite;
    icon6: TGLHUDSprite;
    icon7: TGLHUDSprite;
    icon8: TGLHUDSprite;
    GLSkyBox1: TGLSkyBox;
    dcrf: TGLDummyCube;
    dcrff: TGLDummyCube;
    dcrfb: TGLDummyCube;
    aitem: TGLHUDSprite;
    aitem_ui: TGLHUDSprite;
    aitem_name: TGLHUDText;
    GLSoundLibrary1: TGLSoundLibrary;
    GLSMWaveOut1: TGLSMWaveOut;
    MediaPlayer1: TMediaPlayer;
    xpbar_bg: TGLHUDSprite;
    xpbar: TGLHUDSprite;
    Timer1: TTimer;
    spellbook_txt: TGLHUDText;
    bpart7: TGLHUDSprite;
    bpart8: TGLHUDSprite;
    bpart9: TGLHUDSprite;
    perk_name: TGLHUDText;
    dcperked: TGLDummyCube;
    perkdesc: TGLHUDText;
    csperkbg: TGLHUDSprite;
    perkdesc2: TGLHUDText;
    teleport_glow: TGLHUDSprite;
    minimap: TGLHUDSprite;
    Memo5: TMemo;
    inventory: TGLDummyCube;
    inventoryf1: TGLDummyCube;
    inventoryf2: TGLDummyCube;
    perkimage: TGLHUDSprite;
    dcperkicon: TGLDummyCube;
    pl_hpbar: TGLHUDSprite;
    pl_mpbar: TGLHUDSprite;
    monster_hpbar: TGLHUDSprite;
    dcuibg2: TGLDummyCube;
    pl_hpbar_bg: TGLHUDSprite;
    pl_mpbar_bg: TGLHUDSprite;
    monster_hpbar_bg: TGLHUDSprite;
    dcuibg0: TGLDummyCube;
    corner_tl: TGLHUDSprite;
    corner_tr: TGLHUDSprite;
    corner_bl: TGLHUDSprite;
    invitmdesc: TGLHUDSprite;
    invitmdesctxt: TGLHUDText;
    invitmimage: TGLHUDSprite;
    dmg_pop: TGLHUDText;
    dmg_pop2: TGLHUDText;
    char_effects: TGLHUDText;
    dmg_pop3: TGLHUDText;
    dmg_pop4: TGLHUDText;
    trbg: TGLHUDSprite;
    dcrfdark: TGLDummyCube;
    reqform_dark: TGLHUDSprite;
    dctooltip: TGLDummyCube;
    tooltipbg: TGLHUDSprite;
    dcttb: TGLDummyCube;
    dcttf: TGLDummyCube;
    tooltiptxt: TGLHUDText;
    dcload: TGLDummyCube;
    dcloadb: TGLDummyCube;
    dcloadf: TGLDummyCube;
    loadscr_b: TGLHUDSprite;
    loadscr_f: TGLHUDSprite;
    loadcr_wheel: TGLHUDSprite;
    dcloadt: TGLDummyCube;
    loadtxt: TGLHUDText;
    creditsroll: TGLDummyCube;
    GLAnimatedSprite1: TGLAnimatedSprite;
    dcgameb: TGLDummyCube;
    GLTexCombineShader1: TGLTexCombineShader;
    GLFireFXManager1: TGLFireFXManager;
    element_icon: TGLHUDSprite;
    bpart10: TGLHUDSprite;
    bpart11: TGLHUDSprite;
    bpart12: TGLHUDSprite;
    bpart13: TGLHUDSprite;
    dcmaingame: TGLDummyCube;
    monster_sign: TGLHUDSprite;
    //my procedures
    procedure cleargslist;
    procedure removeglobscript(name:string);
    function preparescript(stxt:string):string;
    function findgsid(name:string):integer;
    procedure addglobscript(name:string);
    procedure stopglobscript(name:string);
    procedure runglobscript(name:string);
    procedure processglobscripts;
    function CheckJournalUnlocked(j:integer):boolean;
    procedure ChangeJPage(k:integer);
    procedure OpenJPos(jpage:integer);
    procedure UpdateJournal(j:integer);
    procedure ClearJournal;
    procedure LoadGame;
    procedure ProcDispell(effdir,es:integer; var user,target:character);
    procedure ControlBattle;
    function gethpcdrop(hpc:integer;user:character):integer;
    procedure ProcessBasicHUD;
    procedure ProcessPerkPanel;
    function getslitem(text:string;id,ps:integer):string;
    function GetNextEnabledPerk(direc:integer):integer;
    procedure genperklist;
    procedure NGLaunch;
    procedure AddPerkPoints(n:integer);
    procedure AddAttrPoints(n:integer;useperk:boolean);
    procedure LevelUp;
    function RandomLoot:integer;
    function CalcMaxHP(chr:character;uselvl:integer;ignorebl:boolean):integer;
    function GetUnownedItem:integer;
    procedure ProcessFreemeshBehaviour(dlt:real);
    procedure CadencerRun(deltatime:real);
    procedure PositionLight;
    procedure ProcessButtons;
    procedure Firestart(i:integer);
    function checklsvisibility(x,y,lsx,lsy:integer):boolean;
    procedure ProcessLights;
    function GetDist(x1,y1,x2,y2:integer):real;
    procedure cleanuplights;
    procedure ChangeLevelNormally;
    procedure ChangeLevel(way:integer;param:string);
    procedure ToggleMenu;
    procedure ExitGame;
    procedure ModFreeMesh(i:integer);
    function CheckDoorSpot(x,y:integer):boolean;
    function CalcDmg(cid,gsl,ustr,uint,uspd,uend,tstr,tint,tspd,tend:integer;user,target:character;ubl,wascrit:boolean):integer;
    procedure GeneralMouseMove(x,y:integer);
    procedure GeneralMouseDown(x,y,b:integer);
    procedure GeneralMouseUp(x,y:integer;button:TMouseButton);
    procedure InitFullscreen;
    procedure StartNewGame;
    procedure AddItem(n1,n2:integer);
    procedure TryToCraft(it1,it2:integer);
    function GetRandomMonsterToFight:integer;
    procedure FullMBW(d:integer);
    procedure ProcessLoadScreen;
    procedure handletooltip(ttx,tty:integer;tttxt:string;ttvis:boolean);
    function ShowCardInfo(iuc:integer):string;
    procedure KillPlayer;
    procedure GetDirsFromLookside(ls:integer; var dirx,diry:integer);
    function GetRfWidth(text:string):integer;
    procedure ToggleSpell(sts:integer);
    procedure fillefflist;
    procedure ShowChEffects;
    procedure HideChEffects;
    procedure AddToBL(mn:integer);
    procedure SwitchAA(i:integer);
    //procedure AddHealPop(side:integer; text:string);
    procedure AddDmgPop(side:integer; text:string; ptype:integer);
    procedure HandleDMGPops(dt:real);
    function MonsterAI:integer;
    procedure SkipTurn;
    procedure ShuffleHand(var hando:character;forceall:boolean);
    procedure formperkvisuals(perkman:character);
    procedure AutoPlaceFloorCeil;
    function getilundercursor(x,y:integer):integer;
    procedure SetupItemList;
    function CheckCodedPerkEff(chr:character;n:integer):integer;
    function checkperkrq(pn:integer):boolean;
    procedure StartBattle(fo:integer);
    procedure readbpartdata(sex,bpt,id:integer);
    procedure DoOALPreps;
    procedure PrepareSound(sndname:string; sprp:integer);
    procedure AddToBattleLog(bltxt:string);
    procedure ShowBattleLog;
    procedure HideBattleLog;
    procedure defineparbonuses;
    procedure TryToEscape;
    procedure DoSound(sndn:string);
    function preparerftext(txt:string):string;
    procedure ShuffleCard(sd,ns:integer; owner:character);
    procedure SetCard(sd,ns,id:integer);
    procedure InventoryButtonClick(t:integer);
    procedure AddXP(reason,amount:integer; var cta:character);
    procedure readscript(st:string);
    procedure dofunc(sfn:string;cpn:integer);
    procedure PlayerTurn(sd:integer);
    procedure definebutsets;
    procedure ReadConfig;
    procedure fillstrarr(locale:string; var strarr:array of string);
    procedure UseCard(no,side:integer; var user,target:character);
    function GetEClassName(etype:integer;strarr:array of string):string;
    function GetETypeName(etype:integer;strarr:array of string):string;
    function GetETypeDesc(etype:integer;strarr:array of string):string;
    function GetElName(etype:integer;strarr:array of string):string;
    procedure MonsterTurn;
    procedure PlayerBTurn;
    procedure PlayerDrawCard(n:integer);
    procedure ActivateTrap(ttp,x,y,v:integer);
    procedure MovePlayer(kx,ky,rs:integer);
    function GetSets:integer;
    function FindNextSpell(searchcstart:integer;ch:character):integer;
    procedure RandomMap;
    procedure SaveGame;
    procedure AddNewCard(sd:boolean;fc:integer;showpops,xpb,ignoremana:boolean;var plr:character);
    procedure ResetStats;
    procedure VisualizeBattle(oppon:integer);
    procedure ShowRequestForm(rttl,rtext:string;rtype,rcase,rpos:integer;rimg:string);
    procedure DisplayRequestForm;
    procedure OpenUI(shen:boolean);
    procedure ActivateCell(x,y:integer);
    procedure PlayerSearch(x,y:integer);
    procedure ConstructCharacter;
    procedure MonitorBlockVisibility(px,py,d:integer;full:boolean);
    procedure OrientFSprite(id:integer);
    procedure CheckLevelSwitch;
    procedure GoToStart;
    procedure FreeCell(i,j:integer);
    procedure BuildCell(i,j:integer);
    procedure ModFreeSprite(i:integer);
    procedure BuildLevel;
    procedure FastAddMaterial(fn,mn,qs:string;emit:real;mode:integer);
    procedure ClickGButton(id:integer);
    procedure prepareuiobjects;
    procedure preparematerials;
    procedure ClearLevel;
    procedure FormCreate(Sender: TObject);
    procedure GLCadencer1Progress(Sender: TObject; const deltaTime,
      newTime: Double);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure char_magicPicked(Sender: TObject);
    procedure GLSceneViewer1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GLSceneViewer1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GLSceneViewer1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GLCadencer2Progress(Sender: TObject; const deltaTime,
      newTime: Double);
    procedure FormResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure WorkOnMinimap;
    procedure GLSceneViewer1DblClick(Sender: TObject);
    procedure ControlMusic;
    procedure LoadSounds;
    procedure GLSceneViewer1MouseLeave(Sender: TObject);
    function GetAppVersionStr: string;
    procedure GLScene1BeforeProgress(Sender: TObject; const deltaTime,
      newTime: Double);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PositionCamera(deltatime:real);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    //procedure Joystick1JoystickMove(Sender: TObject; JoyID: TJoystickID;
    //  Buttons: TJoystickButtons; XDeflection, YDeflection: Integer);
    //procedure Joystick1JoystickButtonChange(Sender: TObject; JoyID: TJoystickID;
    //  Buttons: TJoystickButtons; XDeflection, YDeflection: Integer);
    //standard procedures

  private
    { Private declarations }
    procedure WMSysCommand(var message: TWMSysCommand); message WM_SysCommand;
  public
    { Public declarations }
  end;

  TEDThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure SncCds;
    procedure Execute; override;
  end;

const
  numbuffers = 1001;
  numsources = 1001;
  music = 0;
  sound = 1;
  mb=58; //<-buttons limit
  lskmod=800;
  toteff=24;



var
  Form1: TForm1;
  EDThread: TEDThread;

  //CADENCER VARIABLE SET

  err:string='';

  cdrstate:boolean=false;
  wannaexit:boolean=false;

  bphase:integer=0; //battle phase controller var
  puc:boolean;

  multithread:boolean=false;

  epos:array[1..100]of boolean;  //defines in fillepos if effect is positive or
                                 //negative

  mkx,mky,mkz,uin:integer;
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
  alitms:array of spritelistitem;
  alc:integer;

  jseq:array of integer;
  jspos:integer=0;


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

  //END CADENCER VARIABLE SET


  lip:boolean=true; //is ingame load happening
  lp:integer;
  sip:boolean=false; //saving in progr
  loadscrs:integer;
  clsr:integer=0;
  edi:boolean=false; //ext dmg info

  env:array[0..100]of envr;

  verno:string;

  //OPENAL VARIABES

  buffer1,buffer2 :  TALuint; //deprecated
  source1,source2 :  TALuint; //deprecated

  bfr,bfr2: array [0..numbuffers] of TALuint;
  src,src2: array [0..numsources] of TALuint;
  sourcepos: array [0..2] of TALfloat= ( 0.0, 0.0, 0.0 );
  sourcevel: array [0..2] of TALfloat= ( 0.0, 0.0, 0.0 );
  listenerpos: array [0..2] of TALfloat= ( 0.0, 0.0, 0.0);
  listenervel: array [0..2] of TALfloat= ( 0.0, 0.0, 0.0);
  listenerori: array [0..5] of TALfloat= ( 0.0, 0.0, -1.0, 0.0, 1.0, 0.0);
  buse:integer=0;
  musicarr,soundarr:array[0..1000]of soundinf;
  cpm:integer;

  //item list vars
  itemlist:array[0..9,0..9,0..9]of integer;
  itemslot:array[0..9,0..9]of TGLHUDSprite;
  itemslot_frame:array[0..9,0..9]of TGLHUDSprite;
  itemslot_icon:array[0..9,0..9]of TGLHUDSprite;
  itemslot_text:array[0..9,0..9]of TGLHUDText;
  itemlistbg:TGLHUDSprite;
  ilitemtitle,itemlisttitle:TGLHUDText;
  itemlistmode:boolean=false;
  ilpage:integer=0;
  iuc:integer;  //item under cursor

  lsourc:array[0..19]of TGLLightSource;
  visls:array[0..19]of lsrc;



  //GAME VARIABLES


  gameexe:string;
  spareproc:boolean=false;
  showtooltips:boolean=true;
  hardcore:boolean=false;
  difficulty:integer=0;
  scrn:glscrn;
  pixelated:boolean=false;
  nograss:boolean=false;

  randommode:boolean=false;

  loadinprogress:boolean=false;
  loadmessage:string='';

  mm:boolean=false; //camera handmovement
  mposx,mposy:integer;
  editmode:boolean=false;

  ia:boolean; //insanity avoided this turn

  //current level data
  dw:integer=19; //dungeon width
  dh:integer=19; //dungeon height
  level:integer=1; //dungeon level
  envir:integer=0; //texture set id
  mapid:string; //map name (for cell overrides)
  sets:integer=1; //number of existing texture sets
  cells:array[0..100,0..100]of lcell; //data about current level
  minimapc:array[0..100,0..100]of boolean; //array of cells where player has been
  mmap:TBitmap; //whole minimap
  mmshow:TBitmap; //minimap part to show
  spx,spy,epx,epy,stdx,stdy:integer; //coords of level entrance and level exit
  etrap:array[0..100]of trapex; //a current external trap being performed
  actcx,actcy:integer; //last activated cell coords
  fullscreen:boolean=false;
  fsinit:boolean=false;
  xres:integer=1024;
  yres:integer=768;
  RR:integer=60;
  vsnc:boolean=false;
  dcrec:integer=0; //turns before disc card will be available
  dp:string;

  //cpu usage debug variables
  block1:boolean=true;
  block2:boolean=true;
  block3:boolean=true;
  block4:boolean=true;
  block5:boolean=true;
  block6:boolean=true;
  block7:boolean=true;
  block8:boolean=true;

  //end cpu usage debug vars


  //battle/playerstate data

  port:boolean=false; //marks if camera needs to get to
                      //required position immediately
  battlelist:array[0..10]of integer;
  mapmode:boolean=false; //show overhead view
  invmode:boolean=false; //show char stats and inventory
  spelltosee:integer; //index of visible inventory spell
  gmmode:boolean=true;  //game mode
  mmmode:boolean=false; //main menu mode
  chargen:boolean=false; //character generation screen
  statsup:boolean=false; //levelup state
  btlmode:boolean=false; //occurs when going to fight
  intren:boolean=false; //status of interface renewal
  rqform:boolean=false; //status of request form
  showspell:boolean=false; //if itemlist is on, shows spells instead of items
  player:character;
  enemy:character; eno:integer;
  fdc:integer;//card loaded into player.hand[6], fighting disc. card
  plx:integer=5; //current player position
  ply:integer=5;
  reqx,reqy,reqz:integer;
  lookside:integer=0;//direction
  cdx:integer=1; //camera
  cdy:integer=0; //direction
  turn:integer; //whose turn is it (0 - player, 1 - comp)
  matchc:integer;
  maxbody:integer;
  maxhatsf,maxhatsm:integer;
  maxheadsf,maxheadsm:integer;
  maxhairf,maxhairm:integer;
  maxclothf,maxclothm:integer;
  monsters:array[0..100]of character;
  monsterlist:array[0..100]of boolean;
  monstersno:integer; //number of monsters in database
  deck:array[0..1000]of card; //array of cards
  itms:array[0..1000]of loot; //array of lootable items
  ibstr,ibint,ibspd,ibend:integer; //item bonuses
  ibsw,ibbw,ibar,ibmg:integer; //bonuses to skills
  totcards:integer;//total number of cards in current deck
  totitems:integer;//total number of items
  bmsg,bmsgold,bmsgn:string; //text message under hand
  ucn,ucn2:integer; //index of last used card
  levelsteps:integer; //how many steps did player make on this level
  lsk:real; //monster strength coefficient
  lspellfound:integer;
  acx,acy:integer; //last activated cell coords
  skybox:integer; //skybox no
  pitem:integer; //currently picked item
  usepitem:boolean=false; //indicates if pitem will be used when activating cells
  nosearch:boolean=false; //disables next search request
  keepturn:boolean=false; //allows to make a turn twice
  luc:integer; //last used card IN HAND
  showblog:boolean; //show or hide battlelog
  autopump:boolean; //allow or disable monster leveling
  autocards:boolean; //also give monster cards when pumping
  tsb:integer; //turns since last battle
  texqual:integer; //texture quality 1 - good, 0 - bad
  qs,altqs:string; //quality suffix - hq or lq
  asword,abow,aarm,ahat:integer; //id of sword and bow currently equipped
  showperks:boolean; //show or hide perk window
  currperk:integer; //currently visible perk
  bperks:array[-1..101]of perk; //acttual list of perks
  perklist:array[-1..101]of integer;
  cpeids:array[0..100]of string;
  perkpoints:integer;
  tempperk:perk;
  teleportframe:real=0; //indicates opacity of teleport glow
  showmm:boolean=true; //show minimap or not
  brightness:integer=100; //light amplification
  pbt:boolean=true; //playerbturn requirement var
  skipped:boolean=false; //did player skip last turn?
  bodprop:real; //proportions of the body tw/th
  hpkept,mpkept:integer; //hp and mp for multiplayer
  dmpop:array[0..100]of pop;
  ucf1,ucf2:usdc;
  toteffp,toteffe:integer; //number of effs on pl. and enemy
  euphcard:integer=49; //card that is placed when euphoria effect is active
  no3ddoors:boolean=false;
  nolights:boolean=false;
  nofire:boolean=false;

  //GLScene related variables
  tcomb:array of TGLTexCombineShader;
  tcmb:integer=0;
  floor:array[0..100,0..100]of TGLFreeForm;
  ceil:array[0..100,0..100]of TGLPlane;
  wall:array[0..100,0..100]of TGLFreeForm;
  door:array[0..100,0..100]of TGLFreeForm;
  chest:array[0..100,0..100]of TGLPlane;
  sprite:array[0..100,0..100]of TGLPlane;
  grasssprite:array[0..100,0..100,0..100]of TGLSprite;
  fsprite:array[0..200]of TGLPlane;
  fmesh:array[0..200]of TGLFreeForm;
  gfreesprite:array[0..200]of freesprite;
  gfreemesh,gfreemeshb:array[0..200]of freemesh;
  firedummy:array[0..200]of TGLSphere;
  gbtn:array[0..mb]of TGLHUDSprite; //visual button
  gbtnt:array[0..mb]of TGLHUDText;  //button caption
  gbtnv:array[0..mb]of gamebutton;  //button descriptor
  effstate:array[0..1,1..100]of TGLHudSprite;
  efflgtht:array[0..1,1..100]of TGLHUDText;
  efflist:array[0..1,1..100]of edisp;
  perkicon:array[0..100]of TGLHUDSprite;
  ico_battlelist:array[0..10]of TGLHUDSprite; //monsters in battlelist
  cardind:array[0..5]of TGLHUDSprite; //cards displayed when shuffling
  ab:integer; //number of active button
  oldab:integer;
  mmbutset,imbutset,gmbutset:array[0..mb]of boolean;
  lam:string; //last added material name
  showenemy:boolean=false;
  leveledup:boolean=false;
  mbd:integer; //block rendering distance
  fogd:integer; //fog distance
  camd:integer; //camera view distance
  mx,my:integer; //mouse coordinates
  cardmod:integer; //modifies card size at startup
  dmpops:array[0..100]of TGLHUDText; //numerical popups
  cttt:string='';

  rooms:array[0..20]of room;
  tta:array[0..100]of tooltiparea;
  ttam:integer=0; //maximum of tta's

  cimx1:boolean=false;
  cimx2:boolean=false;
  cimy:boolean=false; //<-these two show if card is moving

  //paperdoll params
  head_w,head_h,head_dx,head_dy,hairf_w,hairf_h,hairf_dx,hairf_dy,hairb_dx,hairb_dy,hairb_w,hairb_h,hat_w,hat_h,hat_dx,hat_dy:real;
  haseb,hasbrd:boolean;

  //gameplay globals
  gkeys,skeys:integer; //number of corresponding keys
  skupch:integer=15; //chance of skill raising
  mspeed,tspeed:integer; //speed of turning and movement
  manado:boolean=false; //<-mana bonus due to perk effect

  //sound parameters
  snd,msk,pmsk:integer;
  squality:integer;
  cmusic,amusic:string;
  sndon,mskon:boolean;
  sloaded:boolean=false;
  b1c:integer=0;
  b2c:integer=0;
  s1c:integer=0;
  s2c:integer=0;

  //request form
  rf_ttl_text,rf_main_text:string;
  rf_textfld:boolean;
  rf_type:integer; {0 - OK msg; 1 - OK/cancel;}
  rf_case:integer; {0 - enter char name}
  rf_pos:integer; //0 - standard, 1 - top
  rf_img:string;
  rqfpool:array[0..10000]of rqftp;  //array of pending request forms
  bchoice:integer; //selected button no in choice form
  afterch:string; //afterchoice script name

  //localization info
  lang:string;
  strarr:array[0..10000]of string;

  //script variables
  stext:array [1..10000] of string; //text of whole script
  fname:array [1..10000] of string; //name of function
  aname:array [1..10000]of string; //active group of symbols
  sp:array[1..10,1..10000]of string; //string params
  ip:array[1..10,1..10000]of integer;//integer params
  cp:array of integer; //cursor position

  rf_img_d:string; //image to demand from request form

  sw_,bw_,mg_,ar_,tsw,tbw,tmg,tar:integer;//battle output
  dmgo,healo,rmanao,effstro,cside:integer; //main effects external params

  gs:array of globscript;

  //global variables
  vs:array[0..1000]of boolean;
  sv:array[0..1000]of string;
  iv:array[0..1000]of integer;
  rvi:array[0..10000]of integer; //integer text
  rvs:array [0..10000]of string;  //string text
  ifworked:array[0..10000]of boolean; //true if IF was true

  recalc:boolean;
  dtout:real=1;


implementation

{$R *.dfm}


uses UEDmapedit,UEDcardedit, UEDSettings,UEDBattlelog, UEDSplash, UEDMap,
     UEDFullScreen2, UEDThread;



{function checkmodeset(gm,im,ilm,cg,bm:boolean):boolean;
begin
  if (gmmode=gm) and (invmode-im) and (itemlistmode=ilm) and (chargen)
end;}

procedure tform1.cleargslist;
begin
  SetLength(gs,0);
  //gs[0].active:=false;
end;


function tform1.findgsid(name:string):integer;
var ts:globscript;
    i,n:integer;
    done:boolean;
begin
  n:=Length(gs);
  i:=0; done:=false;

  if n>0 then
  begin

    repeat

      if (gs[i].id=name) then
      begin
        done:=true;
      end
      else
      begin
        i:=i+1;
      end;

    until (i>=n-1) or (done=true);

    if (i>=(n-1)) and (done=false) then i:=-1;

  end;

  if n=0 then i:=-1;

  result:=i;

end;

procedure tform1.addglobscript(name:string);
var ts:globscript;
    stxt:string;
begin
  //adds a global script to a pool
  Memo1.Lines.LoadFromFile(gameexe+'\scripts\'+name+'.txt');
  stxt:=Memo1.Text;
  ts.text:=preparescript(stxt);
  ts.active:=true;
  ts.a:=Length(gs);
  ts.id:=name;
  SetLength(gs,ts.a+1);
  gs[ts.a]:=ts;
end;


procedure tform1.removeglobscript(name:string);
var i:integer;
    n,j:integer;
begin
  n:=findgsid(name);
  if n<>-1 then
  begin
    j:=Length(gs);
    if n<j-1 then
    begin
      for i:=n to j-1 do
      begin
        gs[i]:=gs[i+1];
      end;
    end;
    SetLength(gs,j-1);
  end;
end;

procedure tform1.stopglobscript(name:string);
var k:integer;
begin
  k:=findgsid(name);
  if k<>-1 then
    gs[k].active:=false;
end;

procedure tform1.runglobscript(name:string);
var k:integer;
begin
  k:=findgsid(name);
  if k<>-1 then
    gs[k].active:=true;
end;

procedure tform1.processglobscripts;
var i,n:integer;
begin

  if wannaexit=false then
  try

    n:=Length(gs);

    if n>0 then
    begin

      for i:=0 to (n-1) do
      begin
        with gs[i] do
        begin
          if active=true then
          begin
            readscript(text);
          end;
        end;
      end;

    end;

  except end;

end;


function getbattlelistlength:integer;
var i,r:integer;
begin
  //gets how many enemies is there in bl
  r:=0;
  for i:=1 to 10 do
  begin
    if battlelist[i]<>-2 then r:=r+1;
  end;
  result:=r;
end;

function getcharworth(charact:character):integer;
begin
  with charact do
  begin
    result:=(hpmax+strength+endurance+speed+intelligence+bow+sword+armor+magic)*(lvl+getbattlelistlength);
  end;
end;


procedure TEDThread.SncCds;
begin
  Form1.CadencerRun(dtout);
end;

procedure TEDThread.Execute;
begin
  if recalc=true then
  begin
    Synchronize(SncCds);
    recalc:=false;
  end;

  if recalc=false then EDThread.Terminate;
end;

procedure TForm1.WMSysCommand(var message: TWMSysCommand);
begin
  if message.CmdType = SC_MINIMIZE then
    Application.Minimize
  else
    inherited;
end;

function CheckMouseOnHUDObj(x,y:integer;ox,oy,ow,oh:integer;txt:boolean):boolean;
begin
  if txt=false then
  begin
    if (x>(ox-ow/2)) and (x<(ox+ow/2)) and (y>(oy-oh/2)) and (y<(oy+oh/2)) then
    begin
      result:=true
    end
    else result:=false;
  end
  else
  begin
    if (x>(ox)) and (x<(ox+ow)) and (y>(oy)) and (y<(oy+oh)) then
    begin
      result:=true
    end
    else result:=false;
  end;
end;




procedure TForm1.handletooltip(ttx,tty:integer;tttxt:string;ttvis:boolean);
var tt:tltip;
    ftxt:string;
    i:integer;
    lns,stg,ttw,tth:integer;
    rx1,rx2,ry1,ry2,x1,x2,y1,y2:integer;
    visar:array[0..3]of integer;
    vh,vw:integer;
    finx,finy:integer;
    fk1,fk2,k1,k2:integer;
    ttglsw,ttglsh:integer;
    laststg:integer;
    mtxt,lmtxt:string;

begin
  //
  if (ttvis=true) and (showtooltips=true) and (tttxt<>'') and (tttxt<>cttt) then
  begin

    cttt:=tttxt;
    ttglsw:=scrn.Width;
    ttglsh:=scrn.Height;

    dctooltip.Visible:=true;

    with tt do
    begin
      x:=ttx;
      y:=tty;
      text:=tttxt;
      visible:=ttvis;
    end;

    if length(tttxt)>0 then
    begin
      lns:=0;
      stg:=0;
      ftxt:='';
      mtxt:='';
      lmtxt:='';

      for i:=1 to length(tttxt) do
      begin
        if ((tttxt[i]=#10) or (tttxt[i]=#13)) and (stg<>0) then
        begin
          lns:=lns+1;
          stg:=61;
        end;

        if ((tttxt[i]<>#10) and (tttxt[i]<>#13)) then
        begin
          ftxt:=ftxt+tttxt[i];
          mtxt:=mtxt+tttxt[i];
          stg:=stg+1;
        end;


        if (stg>60) or ((stg>=40) and ( (tttxt[i]=' ')or(tttxt[i]='.')or(tttxt[i]=',')or(tttxt[i]=';') )) then
        begin
          stg:=0;
          lns:=lns+1;
          ftxt:=ftxt+#13#10;
        end;

        if ((stg=0) or (stg=61)) and (length(mtxt)>length(lmtxt)) then begin lmtxt:=mtxt; mtxt:=''; end;

      end;

      tooltiptxt.Text:=ftxt;

      if lns=0 then
        tt.w:=tooltiptxt.BitmapFont.CalcStringWidth(mtxt)+30
      else
        tt.w:=tooltiptxt.BitmapFont.CalcStringWidth(lmtxt)+30;

      if tt.w<200 then tt.w:=200;

      tt.h:=GLWindowsBitmapFont2.Font.Size*(lns+1)+40;

      fk1:=1;
      fk2:=1;

      if (ttx+tt.w)>scrn.Width then fk1:=-1;
      if (tty+tt.h)>scrn.Height then fk2:=-1;
      with tooltipbg do
      begin
        Width:=tt.w;
        Height:=tt.h;
        Position.X:=ttx+fk1*tt.w/2;
        Position.Y:=tty+fk2*tt.h/2;
        Visible:=true;
      end;

      tooltiptxt.Position.X:=tooltipbg.Position.X-tt.w/2+15;
      tooltiptxt.Position.Y:=tooltipbg.Position.Y-tt.h/2+15;
      tooltiptxt.Visible:=true;
      //tooltiptxt.MoveLast;

    end;

  end
  else
  begin
    if (tttxt<>cttt) then
      dctooltip.Visible:=false;
  end;
end;


function TForm1.GetAppVersionStr: string;
var
  Exe: string;
  Size, Handle: DWORD;
  Buffer: TBytes;
  FixedPtr: PVSFixedFileInfo;
begin
  Exe := ParamStr(0);
  Size := GetFileVersionInfoSize(PChar(Exe), Handle);
  if Size = 0 then
    RaiseLastOSError;
  SetLength(Buffer, Size);
  if not GetFileVersionInfo(PChar(Exe), Handle, Size, Buffer) then
    RaiseLastOSError;
  if not VerQueryValue(Buffer, '\', Pointer(FixedPtr), Size) then
    RaiseLastOSError;
  Result := Format('%d.%d.%d.%d',
    [LongRec(FixedPtr.dwFileVersionMS).Hi,  //major
     LongRec(FixedPtr.dwFileVersionMS).Lo,  //minor
     LongRec(FixedPtr.dwFileVersionLS).Hi,  //release
     LongRec(FixedPtr.dwFileVersionLS).Lo]) //build
end;



procedure TForm1.TryToCraft(it1,it2:integer);
var i,wtc:integer;
begin
  wtc:=-1;

  for i:=0 to (totitems-1) do
  with itms[i] do
  begin
    if ((crf1=it1) and (crf2=it2)) or ((crf1=it2) and (crf2=it1)) then
    begin
      wtc:=i;
    end;
  end;

  if (wtc<>-1) then
  begin
    itms[it1].count:=itms[it1].count-1;
    itms[it2].count:=itms[it2].count-1;
    AddItem(wtc,1);
  end
  else
  begin
    ShowRequestForm(strarr[318],strarr[319],0,1,0,'');
  end;
end;


procedure TForm1.fillefflist;
var i,k:integer;
begin

  for k:=0 to 1 do
  for i:=1 to 100 do
  with efflist[k,i] do
  begin
    en:=-1;
    es:=0;
    el:=0;
  end;


  k:=1;
  for i:=1 to 100 do
  with efflist[0,k] do
  begin
    if player.e[i]>0 then
    begin
      en:=i;
      el:=player.e[i];
      es:=player.estr[i];
      k:=k+1;
    end;
  end;

  k:=1;
  for i:=1 to 100 do
  with efflist[1,k] do
  begin
    if enemy.e[i]>0 then
    begin
      en:=i;
      el:=enemy.e[i];
      es:=enemy.estr[i];
      k:=k+1;
    end;
  end;

end;

{

    with effstate[j,i] do
    begin
      Width:=32;
      Height:=32;
      Material.MaterialLibrary:=matlib;
      if j=0 then
      begin
        Position.X:=scrn.Width-16;
        Position.Y:=40+32*i;
      end
      else
      begin
        Position.X:=16;
        Position.Y:=40+32*i;
      end;
    end;
    efflgtht[j,i]:=TGLHUDText.CreateAsChild(dcuifront);
    with efflgtht[j,i] do
    begin
      BitmapFont:=GLWindowsBitmapFont1;
      if j=0 then
      begin
        Position.X:=scrn.Width-32-45;
        Position.Y:=30+32*i;
      end
      else
      begin
        Position.X:=16+32+5;
        Position.Y:=30+32*i;
      end;
    end;



}


procedure TForm1.KillPlayer;
begin
  Form1.ClearLevel;
  Form2.LoadMap(gameexe+'\levels\mm_map.map');
  level:=-1;
  BuildLevel;
  GoToStart;
  gmmode:=false;
  invmode:=false;
  itemlistmode:=false;
  mmmode:=true;
  Form1.ResetStats;
  ShowRequestForm(strarr[128],strarr[129],0,1,1,'');
end;



procedure TForm1.ShowChEffects;
var a,i:integer;
    vc:character;
    tote:array[0..1]of integer;
    eh:array[0..1]of integer;
begin

  tote[0]:=0; tote[1]:=0;

  for a:=0 to 1 do
  begin
    if a=0 then vc:=player;
    if a=1 then vc:=enemy;

    for i:=1 to 100 do
    begin
      if vc.e[i]>0 then tote[a]:=tote[a]+1;
    end;

    eh[a]:=round(scrn.Height/(tote[a]+1));
    if eh[a]>32 then eh[a]:=32;

    for i:=1 to 100 do
    with efflist[a,i] do
    begin
      if el>0 then
      begin
        effstate[a,i].Visible:=true;
        effstate[a,i].Material.LibMaterialName:='effect_'+inttostr(en);
        efflgtht[a,i].Visible:=true;
        if eh[a]<25 then efflgtht[a,i].BitmapFont:=GLWindowsBitmapFont2 else efflgtht[a,i].BitmapFont:=GLWindowsBitmapFont1;
        efflgtht[a,i].Text:=inttostr(el);

        effstate[a,i].Width:=eh[a];
        effstate[a,i].Height:=eh[a];

        if (en=5) or (en=7) or (en=8) or (en=14) or (en=15) or (en=16) or (en=17) or (en=18) or (en=19) or (en=20) or (en=24)
        then efflgtht[a,i].Text:=efflgtht[a,i].Text+'/'+inttostr(es);
        if a=0 then
        begin
          effstate[a,i].Position.X:=scrn.Width-16;
          effstate[a,i].Position.Y:=40+eh[a]*i;
          efflgtht[a,i].Position.X:=scrn.Width-32-55;
          efflgtht[a,i].Position.Y:=30+eh[a]*i;
        end
        else
        begin
          effstate[a,i].Position.X:=16;
          effstate[a,i].Position.Y:=40+eh[a]*i;
          efflgtht[a,i].Position.X:=16+32+5;
          efflgtht[a,i].Position.Y:=30+eh[a]*i;
        end;
      end
      else
      begin
        effstate[a,i].Visible:=false;
        efflgtht[a,i].Visible:=false;
      end;
    end;
  end;

end;


procedure TForm1.HideChEffects;
var i,j:integer;
begin
  for i:=0 to 1 do
  for j:=1 to 100 do
  begin
    effstate[i,j].Visible:=false;
    efflgtht[i,j].Visible:=false;
  end;
end;


{procedure TForm1.AddHealPop(side:integer; text:string);
begin
  with dmpop[2+side] do
  begin
    if Random(2)=0 then kx:=1 else kx:=-1;
    ky:=1;
    fx:=(Random(100)+50)/100;
    fy:=(Random(100)-150)/100;
    enabled:=true;
    txt:=text;

    if side=0 then
    begin
      x:=monster_img.Position.X;
      y:=monster_img.Position.Y;
    end;

    if side=1 then
    begin
      x:=pl_hpbar.Position.X;
      y:=pl_hpbar.Position.Y;
    end;

  end;
end;       }


procedure TForm1.AddDmgPop(side:integer; text:string; ptype:integer);
var n:integer;
begin

  //getting n
  n:=-1;
  repeat
    n:=n+1;
  until (n=100) or (dmpop[n].enabled=false);

  if n=100 then n:=0;

  //adding popup
  with dmpop[n] do
  begin
    if Random(2)=0 then kx:=1 else kx:=-1;
    ky:=1;
    fx:=(Random(100)+50)/100;
    fy:=(Random(100)-150)/100;
    enabled:=true;
    txt:=text;

    if ptype=0 then
    begin
      if side=0 then
      begin
        x:=monster_img.Position.X;
        y:=monster_img.Position.Y;
      end;

      if side=1 then
      begin
        x:=pl_hpbar.Position.X;
        y:=pl_hpbar.Position.Y;
      end;
    end;

    if (ptype=1) or (ptype=2) then
    begin
      if side=0 then
      begin
        x:=pl_hpbar.Position.X;
        y:=pl_hpbar.Position.Y;
      end;

      if side=1 then
      begin
        x:=monster_img.Position.X;
        y:=monster_img.Position.Y;
      end;
    end;

    tp:=ptype;

  end;
end;


procedure TForm1.HandleDMGPops(dt:real);
var i:integer;
begin

  //metadada

  for i:=0 to 100 do
  with dmpop[i] do
  begin

    if enabled=true then
    begin

      if fx>0 then fx:=fx-dt*(fx/2);
      if fx<=0 then fx:=0;
      if fx=0 then kx:=0;

      fy:=fy+(dt*2);

      x:=x+kx*fx;
      y:=y+ky*fy;

      if (x>scrn.Width) or (x<0) or (y>scrn.Height) then
      begin
        enabled:=false;
      end;

    end;

  end;

  //presenting

  for i:=0 to 100 do
  with dmpops[i] do
  if dmpop[i].enabled=true then
  begin
    if Visible=false then Visible:=true;
    Position.X:=dmpop[i].x;
    Position.Y:=dmpop[i].y;
    Text:=dmpop[i].txt;

    if dmpop[i].tp=0 then
    begin
      ModulateColor.Red:=1;
      ModulateColor.Green:=0;
      ModulateColor.Blue:=0;
    end;

    if dmpop[i].tp=1 then
    begin
      ModulateColor.Red:=0;
      ModulateColor.Green:=1;
      ModulateColor.Blue:=0;
    end;

    if dmpop[i].tp=2 then
    begin
      ModulateColor.Red:=0;
      ModulateColor.Green:=0;
      ModulateColor.Blue:=1;
    end;

  end
  else
  begin
    if Visible=true then visible:=false;
  end;



  {dmg_pop.Position.X:=dmpop[0].x;
  dmg_pop.Position.Y:=dmpop[0].y;
  dmg_pop.Text:=dmpop[0].txt;
  dmg_pop.Visible:=dmpop[0].enabled;

  dmg_pop2.Position.X:=dmpop[1].x;
  dmg_pop2.Position.Y:=dmpop[1].y;
  dmg_pop2.Text:=dmpop[1].txt;
  dmg_pop2.Visible:=dmpop[1].enabled;

  dmg_pop3.Position.X:=dmpop[3].x;
  dmg_pop3.Position.Y:=dmpop[3].y;
  dmg_pop3.Text:=dmpop[3].txt;
  dmg_pop3.Visible:=dmpop[3].enabled;

  dmg_pop4.Position.X:=dmpop[3].x;
  dmg_pop4.Position.Y:=dmpop[3].y;
  dmg_pop4.Text:=dmpop[3].txt;
  dmg_pop4.Visible:=dmpop[3].enabled;   }

end;


//MINIMAP
procedure TForm1.WorkOnMinimap;
var i,ii,x,y,n,k,j,jj,finw,finh:integer;
    mmpx,mmpy,bmh,bmw:integer;
    copyto:TRect;
begin

  try mmap.Free except end;
  mmap:=TBitmap.Create;
  mmap.Width:=(dw+1)*20;
  mmap.Height:=(dh+1)*20;

  with mmap.Canvas do
  begin

  for i:=0 to dw do
  for j:=0 to dh do
  begin
    Pen.Color:=clBlack;
    Brush.Color:=clBlack;
    Rectangle(i*20,j*20,i*20+20,j*20+20);//draw black square
  end;

  for i:=0 to dw do
  for j:=0 to dh do
  begin
    if minimapc[i,j]=true then
    begin
      Pen.Color:=clBlack;
      for n:=-1 to 1 do
      for k:=-1 to 1 do
      begin

        if (cells[i+n,j+k].passable=true) and (cells[i+n,j+k].wall=false) then
        begin
          Brush.Color:=clWhite;
        end
        else
        begin
          if (cells[i+n,j+k].door=true) then
            Brush.Color:=clPurple;
          if (cells[i+n,j+k].wall=true) then
            Brush.Color:=clDkGray;
          if (cells[i+n,j+k].chest=true) then
            Brush.Color:=clYellow;
        end;

        if CheckCodedPerkEff(player,9)>0 then
        begin
          if (cells[i+n,j+k].passable=true) and (cells[i+n,j+k].wall=true) then
          begin
            Brush.Color:=clTeal;
          end;
        end;

        if (minimapc[i+n,j+k]=true) and (cells[i+n,j+k].passable=true)  then Brush.Color:=clWhite;
        Rectangle((i+n)*20,(j+k)*20,(i+n)*20+20,(j+k)*20+20); //draw square of required type

      end;
    end;
  end;

  Pen.Color:=clRed;
  Brush.Color:=clRed;
  Ellipse(plx*20+5,ply*20+5,plx*20+15,ply*20+15);  //player position
  Pen.Width:=5;
  MoveTo(plx*20+10,ply*20+10);
  LineTo(plx*20++10+10*cdx,ply*20+10+10*cdy);
  Pen.Width:=1;

  if mmap.Width<mmap.Height then
  begin
    finw:=mmap.Height;
    finh:=mmap.Height;
  end
  else
  begin
    finw:=mmap.Width;
    finh:=mmap.Width;
  end;

  try mmshow.Free except end;
  mmshow:=TBitmap.Create;
  mmshow.Width:=finw;
  mmshow.Height:=finh;

  with mmshow.Canvas do
  begin
    Brush.Color:=clBlack;
    Pen.Color:=clWhite;
    Rectangle(0,0,finw-1,finh-1);
  end;

  bmh:=mmap.Height;
  bmw:=mmap.Width;
  mmpx:=round(finw/2);
  mmpy:=Round(finh/2);

  copyto:=Rect(mmpx-Round(bmw/2)+1,mmpy-Round(bmh/2)+1,mmpx+Round(bmw/2)-1,mmpy+Round(bmh/2)-1);

  mmshow.canvas.CopyRect(copyto,mmap.Canvas,rect(0,mmap.Height,mmap.Width,0));

  end;

  if Form12.Visible=true then
  begin
    Form12.Image1.Canvas.CopyRect(Form12.Image1.ClientRect,mmap.Canvas,Rect(0,0,mmap.Width,mmap.Height));
  end;

  //mmshow.Canvas.CopyRect(rect(0,0,mmshow.Width,mmshow.Height),mmap.Canvas,
  //                       rect(round((plx*20)-mmshow.Width/2),round((ply*20)-mmshow.Height/2),round((plx*20)+mmshow.Width/2),round((plx*20)+mmshow.Height/2)));

  minimap.Material.Texture.Assign(mmshow);

  //mmshow.Free;
  //mmap.Free;

end;

procedure TForm1.SwitchAA(i:integer);
begin
  case i of
  0:begin
      GLSceneViewer1.Buffer.AntiAliasing:=aaNone;
    end;
  1:begin
      GLSceneViewer1.Buffer.AntiAliasing:=aa2x;
    end;
  2:begin
      GLSceneViewer1.Buffer.AntiAliasing:=aa4x;
    end;
  3:begin
      GLSceneViewer1.Buffer.AntiAliasing:=aa8x;
    end;
  4:begin
      GLSceneViewer1.Buffer.AntiAliasing:=aa16x;
    end;
  end;
end;


//OPEN AL

procedure TForm1.DoOALPreps;
var
  argv: array of PalByte;
  format: TALEnum;
  size: TALSizei;
  freq: TALSizei;
  loop: TALInt;
  data: TALVoid;
begin
  //AlutInit(nil,argv);
  //AlGenBuffers(numbuffers, @buffer);
  //AlGenSources(numsources, @source);
end;


{procedure TForm1.PrepareSound(sndname:string; sprp:integer);
var
  argv: array of PalByte;
  format: TALEnum;
  size: TALSizei;
  freq: TALSizei;
  loop: TALInt;
  data: TALVoid;
  //cbuf: TAluInt;

begin

  try

    alDeleteBuffers(1,@buffer1);
    alDeleteSources(1,@source1);

    AlGenBuffers(1, @buffer1);

    AlutLoadWavFile(sndname, format, data, size, freq, loop);
    AlBufferData(buffer1, format, data, size, freq);
    AlutUnloadWav(format, data, size, freq);

    AlGenSources(1, @source1);
    AlSourcei ( source1, AL_BUFFER, buffer1);
    AlSourcef ( source1, AL_PITCH, 1.0 );
    AlSourcef ( source1, AL_GAIN, msk/100 );
    AlSourcefv ( source1, AL_POSITION, @sourcepos);
    AlSourcefv ( source1, AL_VELOCITY, @sourcevel);
    AlSourcei ( source1, AL_LOOPING, AL_TRUE);
    AlListenerfv ( AL_POSITION, @listenerpos);
    AlListenerfv ( AL_VELOCITY, @listenervel);
    AlListenerfv ( AL_ORIENTATION, @listenerori);    }

  {else
  begin
    //alBufferDat
    //alDeleteSources(1,@source2);
    //alDeleteBuffers(1,@buffer2);


    AlGenBuffers(1, @buffer2);
    AlGenSources(1, @source2);
    buse:=buse+1;
    AlutLoadWavFile(sndname, format, data, size, freq, loop);
    AlBufferData(buffer2, format, data, size, freq);
    AlutUnloadWav(format, data, size, freq);

    AlSourcei ( source2, AL_BUFFER, buffer2);
    AlSourcef ( source2, AL_PITCH, 1.0 );
    AlSourcef ( source2, AL_GAIN, snd/100 );
    AlSourcefv ( source2, AL_POSITION, @sourcepos);
    AlSourcefv ( source2, AL_VELOCITY, @sourcevel);
    AlSourcei ( source2, AL_LOOPING, loop);
    AlListenerfv ( AL_POSITION, @listenerpos);
    AlListenerfv ( AL_VELOCITY, @listenervel);
    AlListenerfv ( AL_ORIENTATION, @listenerori);
  end;  }

 { except ShowMessage('Sound Error') end;

end;}

//BATTLE LOG


procedure tform1.AddToBattleLog(bltxt:string);
begin
  if showblog=true then
  with Form9 do
  begin
    Memo1.Lines.Add(bltxt);
  end;
end;

procedure tform1.ShowBattleLog;
begin
  if showblog=true then
  with Form9 do
  begin
    Show;
    Memo1.Lines.Clear;
  end;
end;

procedure tform1.HideBattleLog;
begin
  if showblog=true then
  with Form9 do
  begin
    Hide;
  end;
end;


//items and parameter bonuses

function TForm1.CheckCodedPerkEff(chr:character;n:integer):integer;
var i:integer; res:integer;
begin

  res:=0;
  //function checks if player has a perk
  //with this particular "coded effect"
  for i:=0 to 100 do
  begin
    if (chr.perks[i]=true) and (bperks[i].addcoded=n) then
    begin
      res:=res+1;
    end;
  end;
  result:=res;

end;

function TForm1.checkperkrq(pn:integer):boolean;
var res:boolean;
begin
  with bperks[pn] do
  begin
    if (player.strength>=recst) and
       (player.speed>=recagi) and
       (player.intelligence>=recin) and
       (player.endurance>=recend) and
       (player.sword>=recsw) and
       (player.magic>=recmg) and
       (player.bow>=recbw) and
       (player.armor>=recar) then
     begin
       if recperk=-1 then
       begin
         res:=true;
       end
       else
       begin
         if (player.perks[recperk]=true) then
         begin
           res:=true
         end
         else
         begin
           res:=false;
           //ShowMessage('Required perk ('+inttostr(recperk)+') not opened');
         end;
       end;
     end
     else
     begin
       //ShowMessage('Parameters don`t fit');
       res:=false;
     end;

     if (recrace<>-1) and (recrace<>player.spec) then res:=false; //race doesn't fit

     {if player.strength<recst then ShowMessage('Not enough Strength!');
     if player.speed<recagi then ShowMessage('Not enough agility!');
     if player.intelligence<recin then ShowMessage('Not enough intelligence!');
     if (player.endurance<recend) then ShowMessage('Not enough endurance!');
     if player.sword<recsw then ShowMessage('Not enough sword!');
     if player.magic<recmg then ShowMessage('Not enough magic!');
     if player.bow<recbw then ShowMessage('Not enough bow!');
     if player.armor<recar then ShowMessage('Not enough armor!');
     if (player.perks[recperk]<>true) then ShowMessage('Required perk not opened');
     if (recperk<>-1) then ShowMessage('Perk required');     }
  end;
  result:=res;
end;



procedure tform1.defineparbonuses;
var i:integer;
begin


  //resetting
  ibstr:=0;
  ibint:=0;
  ibspd:=0;
  ibend:=0;
  ibsw:=0;
  ibmg:=0;
  ibar:=0;
  ibbw:=0;

  //bonuses from loot
  for i:=0 to 1000 do
  begin

    with itms[i] do
    begin

      if (count>0) and ((itmtype=0) or (abow=i) or (asword=i) or (aarm=i) or (ahat=i)) then
      begin
        ibstr:=ibstr+lb_str*count;
        ibint:=ibint+lb_int*count;
        ibspd:=ibspd+lb_spd*count;
        ibend:=ibend+lb_end*count;
        ibsw:=ibsw+lb_sw*count;
        ibmg:=ibmg+lb_mg*count;
        ibbw:=ibbw+lb_bw*count;
        ibar:=ibar+lb_ar*count;
      end;

    end;

  end;
  //end bonuses from loot
  for i:=0 to 100 do
  begin
    if (bperks[i].enabled=true) and player.perks[i]=true then
    begin
      ibstr:=ibstr+bperks[i].addst;
      ibint:=ibint+bperks[i].addin;
      ibspd:=ibspd+bperks[i].addagi;
      ibend:=ibend+bperks[i].addend;
      ibsw:=ibsw+bperks[i].addsw;
      ibbw:=ibbw+bperks[i].addbw;
      ibar:=ibar+bperks[i].addar;
      ibmg:=ibmg+bperks[i].addmg;
    end;
  end;
  //bonuses from perks


  //end bonuses from perks


  //assigning parameters
  with player do
  begin
    strength:=bstr+ibstr;
    intelligence:=bint+ibint;
    speed:=bspd+ibspd;
    endurance:=bend+ibend;
    sword:=bsw+ibsw;
    bow:=bbw+ibbw;
    armor:=bar+ibar;
    magic:=bmg+ibmg;
  end;

end;


//-----sound-----
{procedure Tform1.DoSound(sndn:string);
var ik:integer;
    sid:integer;
    snm:string;
begin

  //playing sound
  try if sndon=true then
  begin

    ik:=-1;

    repeat
      ik:=ik+1;
      snm:=soundarr[ik].name; //reading possible name from DB
      if (sndn=snm) then
      begin
        sid:=ik; //getting index if name fits
      end;
    until (sndn=snm) or (ik>=1000);

    if ik>=1000 then
    begin
      sid:=-1; //disabling playback if name won't fit
    end;

    if sid<>-1 then
    begin
      alSourcePlay(SRC[sid]); //playing
    end;


  end; except end;

end;        }


//-----scripts------
function tform1.preparescript(stxt:string):string;
var temps:string;
    i:integer;
begin
  temps:='';
  for i:=1 to length(stxt) do
  begin
    if (stxt[i]<>#10) and (stxt[i]<>#13) then temps:=temps+stxt[i];
  end;
  Result:=temps;
end;



procedure processparam(ptxt:string;pno,pt,cpn:integer);
var fp:string;
    isvar,iskey:boolean;
    i:integer;
begin
  //ptxt - parameter text from sp[]
  //pno - number of param
  //pt - type: 0 - str, 1 - int

  fp:='';
  isvar:=false;
  iskey:=false;

  for i:=1 to length(ptxt) do
  begin
    if (ptxt[i]<>'&') and (ptxt[i]<>'^') and (ptxt[i]<>' ') and
       (ptxt[i]<>#13) and (ptxt[i]<>#10) and (ptxt[i]<>',') and
       (ptxt[i]<>';') then
      fp:=fp+ptxt[i];
    if ptxt[i]='&' then isvar:=true;
    if ptxt[i]='^' then iskey:=true;
  end;

  //ShowMessage(fp);

  if isvar=true then
  begin
    sp[pno,cpn]:=fp;
    try ip[pno,cpn]:=strtoint(fp); except end;
    rvs[cpn]:='@';
    rvi[cpn]:=-1;
  end;

  if (iskey=true) and (isvar=false) then
  begin
    //checking keywords

    if fp='aa' then
    begin

      //ShowMessage('aa');
      if usepitem=true then
      begin
        rvi[cpn]:=pitem;
        //ShowMessage(inttostr(rvi[cpn]));
        if itms[rvi[cpn]].overridename<>'' then
          rvs[cpn]:=itms[rvi[cpn]].overridename
        else
          rvs[cpn]:=itms[rvi[cpn]].name;
      end
      else
      begin
        rvi[cpn]:=-1;
        rvs[cpn]:='^';
        //ShowMessage(inttostr(rvi[cpn]));
      end;

    end;

    if fp='sw' then
    begin
      rvi[cpn]:=sw_;
      rvs[cpn]:='^';
    end;

    if fp='bw' then
    begin
      rvi[cpn]:=bw_;
      rvs[cpn]:='^';
    end;

    if fp='mg' then
    begin
      rvi[cpn]:=mg_;
      rvs[cpn]:='^';
    end;

    if fp='ar' then
    begin
      rvi[cpn]:=ar_;
      rvs[cpn]:='^';
    end;

    if fp='tsw' then
    begin
      rvi[cpn]:=tsw;
      rvs[cpn]:='^';
    end;

    if fp='tbw' then
    begin
      rvi[cpn]:=tbw;
      rvs[cpn]:='^';
    end;

    if fp='tmg' then
    begin
      rvi[cpn]:=tmg;
      rvs[cpn]:='^';
    end;

    if fp='tar' then
    begin
      rvi[cpn]:=tar;
      rvs[cpn]:='^';
    end;

    if fp='lookside' then
    begin
      rvi[cpn]:=lookside;
      rvs[cpn]:='^';
    end;

    if fp='pn' then
    begin
      rvi[cpn]:=0;
      rvs[cpn]:=player.name;
    end;

    if fp='choice' then
    begin
      rvi[cpn]:=bchoice;
      rvs[cpn]:='^';
    end;


  end;

  if (isvar=false) and (iskey=false) then
  begin
    rvs[cpn]:=fp;
    try rvi[cpn]:=strtoint(fp) except end;
  end;
end;


function readnextword(st:string;cpn:integer):string;
var i:integer;
    qw:string;
begin
  qw:='';

  repeat
    cp[cpn]:=cp[cpn]+1;
    if ((st[cp[cpn]]<>' ') and (st[cp[cpn]]<>',') and (st[cp[cpn]]<>';')) then
      qw:=qw+st[cp[cpn]];
  until ((st[cp[cpn]]=',') or (st[cp[cpn]]=';'));

  result:=qw;
  //ShowMessage('ReadNextWord: "'+qw+'"');
end;

function checknextword(st:string;cpn:integer):string;
var i:integer;
    k:integer;
    qw:string;
begin
  //same as readnextword, but does not move carriage
  qw:='';
  k:=cp[cpn];

  repeat
    k:=k+1;
    if ((st[k]<>' ') and (st[k]<>',') and (st[k]<>';')) then
      qw:=qw+st[k];
  until ((st[k]=',') or (st[k]=';'));

  result:=qw;
  //ShowMessage('ReadNextWord: "'+qw+'"');
end;

procedure TForm1.AddToBL(mn:integer);
var j:integer; done:boolean;
begin
  j:=0;
  done:=false;
  repeat
    if battlelist[j]=-2 then
    begin
      done:=true;
      battlelist[j]:=mn;
    end;
    j:=j+1;
  until (j=11) or (done=true);
end;










procedure tform1.dofunc(sfn:string;cpn:integer);
var gf,lor:boolean;
    tw,r:string;
    lop:string;
    m1,m2:string;
    ii,j,lov1,lov2,av,tcpx,tcpy:integer;
    n1,n2,n3,n4,n5,n6,n7,n8,n9,n10:integer;
    s1,s2,s3,s4,s5,s6:string;
    done:boolean;
    cpr:integer;
begin
  gf:=false;
  fname[cpn]:=aname[cpn];

  if fname[cpn]='SetInt' then
  begin
  //form: setint &1 10;
    gf:=true;
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];

    iv[n1]:=n2;

    //ShowMessage('iv['+inttostr(ip[1,cpn])+']='+inttostr(rvi[cpn]));
  end;

  {  Memo1.Lines.LoadFromFile(gameexe+'\levels\'+mapid+'\sscript_'+inttostr(x)+'_'+inttostr(y)+'.txt');
    stext:=Memo1.Text;
    stext:=preparescript(stext);
    readscript(stext);}

  if fname[cpn]='SetStr' then
  begin
  //form: setstr &1 text;
    gf:=true;
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    processparam(sp[2,cpn],2,0,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      sv[ip[1,cpn]]:=sv[ip[2,cpn]]
    else
      sv[ip[1,cpn]]:=rvs[cpn];
  end;


  if fname[cpn]='StartScript' then
  begin
  //form: setstr &1 text;
    gf:=true;

    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[2,cpn]]
    else
      n1:=rvi[cpn];

    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,0,cpn);
    s1:=rvs[cpn];

    Memo1.Lines.LoadFromFile(gameexe+'\scripts\'+s1+'.txt');
    if n1=0 then
    begin
      s2:=Memo1.Text;
      s2:=preparescript(s2);
      readscript(s2);
    end
    else
    begin
      addglobscript(s1);
    end;

  end;

  if fname[cpn]='StopScript' then
  begin

    gf:=true;

    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],1,0,cpn);
    s1:=rvs[cpn];

    stopglobscript(s1);

  end;

  if fname[cpn]='RunScript' then
  begin

    gf:=true;

    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],1,0,cpn);
    s1:=rvs[cpn];

    runglobscript(s1);

  end;

  if fname[cpn]='RemoveScript' then
  begin

    gf:=true;

    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],1,0,cpn);
    s1:=rvs[cpn];

    removeglobscript(s1);

  end;

  if fname[cpn]='ClearGlobalScripts' then
  begin

    gf:=true;

    cleargslist;

  end;


  if fname[cpn]='Concat' then
  begin
  //form: setstr &1 text;
    gf:=true;
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      sv[ip[1,cpn]]:=sv[ip[2,cpn]]
    else
      sv[ip[1,cpn]]:=rvs[cpn];

    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      sv[ip[1,cpn]]:=sv[ip[2,cpn]]
    else
      sv[ip[1,cpn]]:=rvs[cpn];

  end;


  if fname[cpn]='Random' then
  begin
  //form: setint &1 10;
    gf:=true;
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      iv[ip[1,cpn]]:=random(iv[ip[2,cpn]])
    else
      iv[ip[1,cpn]]:=random(rvi[cpn]);

    //ShowMessage('iv['+inttostr(ip[1,cpn])+']='+inttostr(rvi[cpn]));
  end;

  if fname[cpn]='GetItemCount' then
  begin
  //form: setint &1 10;
    gf:=true;
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];

    iv[n1]:=itms[n2].count;

    //ShowMessage('iv['+inttostr(ip[1,cpn])+']='+inttostr(rvi[cpn]));
  end;


  if fname[cpn]='GetFSpriteState' then
  begin
  //
    gf:=true;
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];

    if gfreesprite[n1].enabled=true then
      iv[n2]:=1
    else
      iv[n2]:=0;

    //ShowMessage('iv['+inttostr(ip[1,cpn])+']='+inttostr(rvi[cpn]));
  end;


    if fname[cpn]='GetFMeshState' then
  begin
  //
    gf:=true;
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];

    if gfreemesh[n1].enabled=true then
      iv[n2]:=1
    else
      iv[n2]:=0;

    //ShowMessage('iv['+inttostr(ip[1,cpn])+']='+inttostr(rvi[cpn]));
  end;


  if fname[cpn]='GetEventState' then
  begin
  //
    gf:=true;
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    sp[3,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];
    processparam(sp[3,cpn],3,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n3:=iv[ip[3,cpn]]
    else
      n3:=rvi[cpn];

    if cells[n1,n2].trap=true then
      iv[n3]:=1
    else
      iv[n3]:=0;

    //ShowMessage('iv['+inttostr(ip[1,cpn])+']='+inttostr(rvi[cpn]));
  end;

  if fname[cpn]='GetEventType' then
  begin
  //
    gf:=true;

    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    sp[3,cpn]:=readnextword(stext[cpn],cpn);

    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];
    processparam(sp[3,cpn],3,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n3:=iv[ip[3,cpn]]
    else
      n3:=rvi[cpn];

    iv[n3]:=cells[n1,n2].traptype;

    //ShowMessage('iv['+inttostr(ip[1,cpn])+']='+inttostr(rvi[cpn]));
  end;

  if fname[cpn]='DisableEvent' then
  begin
  //
    gf:=true;
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];


    cells[n1,n2].trap:=false;

  end;

  if fname[cpn]='SetupEvent' then
  begin
  //
    gf:=true;
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    sp[3,cpn]:=readnextword(stext[cpn],cpn);
    sp[4,cpn]:=readnextword(stext[cpn],cpn);
    sp[5,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];
    processparam(sp[3,cpn],3,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n3:=iv[ip[3,cpn]]
    else
      n3:=rvi[cpn];
    processparam(sp[4,cpn],4,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n4:=iv[ip[4,cpn]]
    else
      n4:=rvi[cpn];
    processparam(sp[5,cpn],5,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n5:=iv[ip[5,cpn]]
    else
      n5:=rvi[cpn];

    with cells[n1,n2] do
    begin
      trap:=true;
      traptype:=n3;
      doorno:=n4;
      chestno:=n5;
    end;


    //ShowMessage('iv['+inttostr(ip[1,cpn])+']='+inttostr(rvi[cpn]));
  end;


  if (fname[cpn]='If') then
  begin
    gf:=true;
    ifworked[cpn]:=false;
    //ShowMessage('Logical Operator');

    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    sp[3,cpn]:=readnextword(stext[cpn],cpn);

    //logical value 1
    processparam(sp[1,cpn],1,1,cpn);
    //ShowMessage('rvs[cpn]='+rvs[cpn]+', rvi[cpn]='+inttostr(rvi[cpn]));
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      lov1:=iv[ip[1,cpn]]
    else
      lov1:=rvi[cpn];

    //ShowMessage('lov1='+inttostr(lov1)+'; ip1='+inttostr(ip[1,cpn])+';  rvi[cpn]='+inttostr(rvi[cpn]));

    //logical operator
    processparam(sp[2,cpn],2,0,cpn);
    lop:=rvs[cpn];
    //ShowMessage('lop='+lop);

    //logical value 2
    processparam(sp[3,cpn],3,1,cpn);
    //ShowMessage('rvs[cpn]='+rvs[cpn]+', rvi[cpn]='+inttostr(rvi[cpn]));
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      lov2:=iv[ip[3,cpn]]
    else
      lov2:=rvi[cpn];

    //ShowMessage('lov2='+inttostr(lov2)+'; ip3='+inttostr(ip[3,cpn])+';  rvi[cpn]='+inttostr(rvi[cpn]));

    //checking if logical statement is true or false
    if lop='<' then begin
          if lov1<lov2 then lor:=true else lor:=false;
        end;
    if lop='>' then begin
          if lov1>lov2 then lor:=true else lor:=false;
        end;
    if lop='<=' then begin
          if lov1<=lov2 then lor:=true else lor:=false;
        end;
    if lop='>=' then begin
          if lov1>=lov2 then lor:=true else lor:=false;
        end;
    if lop='<>' then begin
          if lov1<>lov2 then lor:=true else lor:=false;
        end;
    if lop='=' then begin
          if lov1=lov2 then lor:=true else lor:=false;
        end;

    if lor=false then
    begin
      repeat
        tw:=readnextword(stext[cpn],cpn);
      until (tw='EndIf') or (tw='Else');
    end;

    if lor=true then ifworked[cpn]:=true;

    //ShowMessage(inttostr(lov1)+lop+inttostr(lov2)+' outcomes in '+booltostr(lor));

  end;


  if (fname[cpn]='Else') and (ifworked[cpn]=true) then
  begin
    gf:=true;
    ifworked[cpn]:=false;
    repeat
      tw:=readnextword(stext[cpn],cpn);
    until (tw='EndIf') or (tw='Else');
  end;



  if fname[cpn]='Math' then
  begin
    gf:=true;

    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    sp[3,cpn]:=readnextword(stext[cpn],cpn);
    sp[4,cpn]:=readnextword(stext[cpn],cpn);

    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      av:=iv[ip[1,cpn]]
    else
      av:=rvi[cpn];

    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      lov1:=iv[ip[2,cpn]]
    else
      lov1:=rvi[cpn];

    //logical operator
    processparam(sp[3,cpn],3,0,cpn);
    lop:=rvs[cpn];

    //logical value 2
    processparam(sp[4,cpn],4,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      lov2:=iv[ip[4,cpn]]
    else
      lov2:=rvi[cpn];

    if lop='+' then
    begin
      iv[av]:=lov1+lov2;
    end;

    if lop='-' then
    begin
      iv[av]:=lov1-lov2;
    end;

    if lop='*' then
    begin
      iv[av]:=lov1*lov2;
    end;

    if lop='/' then
    begin
      iv[av]:=round(lov1/lov2);
    end;

    //ShowMessage('iv['+inttostr(av)+']='+inttostr(lov1)+lop+inttostr(lov2)+'='+inttostr(iv[av]));

  end;

  if fname[cpn]='PlaySound' then
  begin

    gf:=true;

    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,0,cpn);

    DoSound(sp[1,cpn]);

  end;

  if fname[cpn]='ShowMsg' then
  begin
    gf:=true;

    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,0,cpn);

    Memo1.Lines.LoadFromFile(gameexe+'\text\'+lang+'\txt_'+sp[1,cpn]+'_h.txt');
    m1:=Memo1.Text;

    Memo1.Lines.LoadFromFile(gameexe+'\text\'+lang+'\txt_'+sp[1,cpn]+'.txt');
    m2:=Memo1.Text;

    ShowRequestForm(m1,m2,0,1,0,'');

  end;


  if fname[cpn]='ShowImg' then
  begin
    gf:=true;
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,0,cpn);
    Memo1.Lines.LoadFromFile(gameexe+'\text\'+lang+'\txt_'+sp[1,cpn]+'_h.txt');
    m1:=Memo1.Text;
    Memo1.Lines.LoadFromFile(gameexe+'\text\'+lang+'\txt_'+sp[1,cpn]+'.txt');
    m2:=Memo1.Text;

    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,0,cpn);

    ShowRequestForm(m1,m2,0,11,0,sp[2,cpn]);
  end;

  if fname[cpn]='ShowScroll' then
  begin
    gf:=true;
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,0,cpn);
    Memo1.Lines.LoadFromFile(gameexe+'\text\'+lang+'\txt_'+sp[1,cpn]+'_h.txt');
    m1:=Memo1.Text;
    Memo1.Lines.LoadFromFile(gameexe+'\text\'+lang+'\txt_'+sp[1,cpn]+'.txt');
    m2:=Memo1.Text;
    ShowRequestForm(m1,m2,0,10,0,'');
  end;

  //read/set params

  if fname[cpn]='ReadPlayerParam' then
  begin
    gf:=true;

    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    //showmessage('sp1='+sp[1,cpn]);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      av:=iv[ip[1,cpn]]
    else
      av:=rvi[cpn];

    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[2,cpn]]
    else
      n1:=rvi[cpn];

    if (av=1) then
    begin
      iv[n1]:=player.strength
    end;
    if (av=2) then
    begin
      iv[n1]:=player.intelligence
    end;
    if (av=3) then
    begin
      iv[n1]:=player.endurance
    end;
    if (av=4) then
    begin
      iv[n1]:=player.speed
    end;
    if (av=5) then
    begin
      iv[n1]:=player.sword
    end;
    if (av=6) then
    begin
      iv[n1]:=player.bow
    end;
    if (av=7) then
    begin
      iv[n1]:=player.magic
    end;
    if (av=8) then
    begin
      iv[n1]:=player.armor
    end;
    if (av=9) then
    begin
      iv[n1]:=player.hpmax
    end;
    if (av=10) then
    begin
      iv[n1]:=player.manamax
    end;
    if (av=11) then
    begin
      iv[n1]:=player.lvl
    end;

    //ShowMessage('av='+inttostr(av)+'; iv[n1]='+inttostr(iv[n1]));

  end;



  if fname[cpn]='SetupCell' then
  begin
    gf:=true;

    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      tcpx:=iv[ip[1,cpn]]
    else
      tcpx:=rvi[cpn];
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      tcpy:=iv[ip[2,cpn]]
    else
      tcpy:=rvi[cpn];

    //ShowMessage('SetupCell ('+inttostr(tcpx)+','+inttostr(tcpy)+')');

    with cells[tcpx,tcpy] do
    begin
      //wall
      j:=3;
      sp[j,cpn]:=readnextword(stext[cpn],cpn);
      processparam(sp[j,cpn],j,1,cpn);
      if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
        av:=iv[ip[j,cpn]]
      else
        av:=rvi[cpn];
      if av=0 then wall:=false else wall:=true;

      //passable
      j:=4;
      sp[j,cpn]:=readnextword(stext[cpn],cpn);
      processparam(sp[j,cpn],j,1,cpn);
      if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
        av:=iv[ip[j,cpn]]
      else
        av:=rvi[cpn];
      if av=0 then passable:=false else passable:=true;

      //floor
      j:=5;
      sp[j,cpn]:=readnextword(stext[cpn],cpn);
      processparam(sp[j,cpn],j,1,cpn);
      if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
        av:=iv[ip[j,cpn]]
      else
        av:=rvi[cpn];
      if av=0 then floor:=false else floor:=true;

      //ceiling
      j:=6;
      sp[j,cpn]:=readnextword(stext[cpn],cpn);
      processparam(sp[j,cpn],j,1,cpn);
      if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
        av:=iv[ip[j,cpn]]
      else
        av:=rvi[cpn];
      if av=0 then ceil:=false else ceil:=true;

      //door or chest
      j:=7;
      sp[j,cpn]:=readnextword(stext[cpn],cpn);
      processparam(sp[j,cpn],j,1,cpn);
      if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
        av:=iv[ip[j,cpn]]
      else
        av:=rvi[cpn];
      if av=0 then
      begin
        door:=False;
        chest:=false;
      end;
      if av=1 then
      begin
        door:=true;
        chest:=false;
      end;
      if av>1 then
      begin
        door:=False;
        chest:=true;
      end;

      //power
      j:=8;
      sp[j,cpn]:=readnextword(stext[cpn],cpn);
      processparam(sp[j,cpn],j,1,cpn);
      if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
        av:=iv[ip[j,cpn]]
      else
        av:=rvi[cpn];
      power:=av;

      //cell sprite
      j:=9;
      sp[j,cpn]:=readnextword(stext[cpn],cpn);
      processparam(sp[j,cpn],j,0,cpn);
      if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
        spritename:=sv[ip[j,cpn]]
      else
        spritename:=rvs[cpn];

      //cell id
      j:=10;
      sp[j,cpn]:=readnextword(stext[cpn],cpn);
      processparam(sp[j,cpn],j,1,cpn);
      if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
        av:=iv[ip[j,cpn]]
      else
        av:=rvi[cpn];
      textid:=av;

    end;

    BuildCell(tcpx,tcpy);

  end;




  if fname[cpn]='Teleport' then
  begin

    gf:=true;

    //player X
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      plx:=iv[ip[1,cpn]]
    else
      plx:=rvi[cpn];

    //player Y
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      ply:=iv[ip[2,cpn]]
    else
      ply:=rvi[cpn];

    //player lookside
    sp[3,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[3,cpn],3,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      lookside:=iv[ip[3,cpn]]
    else
      lookside:=rvi[cpn];

    port:=true;

  end;

  if fname[cpn]='JumpTo' then
  begin

    gf:=true;

    //player X
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      plx:=iv[ip[1,cpn]]
    else
      plx:=rvi[cpn];

    //player Y
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      ply:=iv[ip[2,cpn]]
    else
      ply:=rvi[cpn];

    //player lookside
    sp[3,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[3,cpn],3,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      lookside:=iv[ip[3,cpn]]
    else
      lookside:=rvi[cpn];

    port:=false;

  end;

  if fname[cpn]='ToggleLight' then
  begin

    gf:=true;

    //light id
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    with visls[n1] do
    begin
      if enabled=true then enabled:=false else enabled:=true;
    end;

    ProcessLights;
  end;


  if fname[cpn]='FMeshBehaviour' then
  begin

    gf:=true;

    //fmesh id
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    //bhv
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];

    //loop (0/1)
    sp[3,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[3,cpn],3,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n3:=iv[ip[3,cpn]]
    else
      n3:=rvi[cpn];

    //spd x 1000
    sp[4,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[4,cpn],4,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n4:=iv[ip[4,cpn]]
    else
      n4:=rvi[cpn];

    //x1
    sp[5,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[5,cpn],5,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n5:=iv[ip[5,cpn]]
    else
      n5:=rvi[cpn];

    //x2
    sp[6,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[6,cpn],6,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n6:=iv[ip[6,cpn]]
    else
      n6:=rvi[cpn];

    //y1
    sp[7,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[7,cpn],7,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n7:=iv[ip[7,cpn]]
    else
      n7:=rvi[cpn];

    //y2
    sp[8,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[8,cpn],8,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n8:=iv[ip[8,cpn]]
    else
      n8:=rvi[cpn];

    //z1
    sp[9,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[9,cpn],9,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n9:=iv[ip[9,cpn]]
    else
      n9:=rvi[cpn];

    //z2
    sp[10,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[10,cpn],10,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n10:=iv[ip[10,cpn]]
    else
      n10:=rvi[cpn];

    with gfreemesh[n1] do
    begin
      bhv:=n2;
      if n3=0 then loop:=false else loop:=true;
      spd:=n4/1000;
      x1:=n5;
      x2:=n6;
      y1:=n7;
      y2:=n8;
      z1:=n9;
      z2:=n10;
    end;

    ModFreeMesh(n1);
  end;


  if fname[cpn]='ChangeFSprite' then
  begin

    gf:=true;

    //sprite id
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    //player Y
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,0,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      s1:=sv[ip[2,cpn]]
    else
      s1:=rvs[cpn];

    gfreesprite[n1].name:=s1;

    ModFreeSprite(n1);
  end;


  if fname[cpn]='GetPlayerInAC' then
  begin

    gf:=true;

    //var
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    if (plx=actcx) and (ply=actcy) then
      iv[n1]:=1
    else iv[n1]:=0;

  end;

  if fname[cpn]='GetPlayerInCoords' then
  begin

    gf:=true;

    //var
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    //x
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];

    //y
    sp[3,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[3,cpn],3,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n3:=iv[ip[3,cpn]]
    else
      n3:=rvi[cpn];

    if (plx=n2) and (ply=n3) then
      iv[n1]:=1
    else iv[n1]:=0;

  end;


  if fname[cpn]='AddAttrPoints' then
  begin

    gf:=true;

    //var
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    AddAttrPoints(n1,false);

  end;


  if fname[cpn]='AddPerkPoints' then
  begin

    gf:=true;

    //var
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    AddPerkPoints(n1);

  end;


  if fname[cpn]='SetActiveItem' then
  begin

    gf:=true;

    //0 - sw, 1 - bw, 2 - arm
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];

    case n1 of
    0:begin
        asword:=n2;
      end;
    1:begin
        abow:=n2;
      end;
    2:begin
        aarm:=n2;
      end;
    3:begin
        ahat:=n2;
      end;
    end;

  end;


  if fname[cpn]='ChangeFMesh' then
  begin

    gf:=true;

    //sprite id
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    //player Y
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,0,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      s1:=sv[ip[2,cpn]]
    else
      s1:=rvs[cpn];

    gfreemesh[n1].name:=s1;

    ModFreeMesh(n1);
  end;


  if fname[cpn]='ChangeFMeshTrScript' then
  begin

    gf:=true;

    //sprite id
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    //script name
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,0,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      s1:=sv[ip[2,cpn]]
    else
      s1:=rvs[cpn];

    gfreemesh[n1].trscript:=s1;

    ModFreeMesh(n1);
  end;

  if fname[cpn]='UpdateJournal' then
  begin

    gf:=true;

    //journal id
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    UpdateJournal(n1);

  end;

  if fname[cpn]='CheckJournalUnlocked' then
  begin

    gf:=true;

    //journal id
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    //varno
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];


    if CheckJournalUnlocked(n1)=true then
    begin
      iv[n2]:=1;
    end
    else
    begin
      iv[n2]:=0;
    end;

  end;


  if fname[cpn]='CompareFSprite' then
  begin

    gf:=true;

    //sprite id
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    //player Y
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,0,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      s1:=sv[ip[2,cpn]]
    else
      s1:=rvs[cpn];

    //var no
    sp[3,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[3,cpn],3,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[3,cpn]]
    else
      n2:=rvi[cpn];

    if gfreesprite[n1].name=s1 then
    begin
      iv[n2]:=1;
    end
    else
    begin
      iv[n2]:=0;
    end;

  end;



  if fname[cpn]='CompareFMesh' then
  begin

    gf:=true;

    //sprite id
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    //player Y
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,0,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      s1:=sv[ip[2,cpn]]
    else
      s1:=rvs[cpn];

    //var no
    sp[3,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[3,cpn],3,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[3,cpn]]
    else
      n2:=rvi[cpn];

    if gfreemesh[n1].name=s1 then
    begin
      iv[n2]:=1;
    end
    else
    begin
      iv[n2]:=0;
    end;

  end;


  if fname[cpn]='GetFMeshCoord' then
  begin

    gf:=true;

    //mesh id
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    //axis
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,0,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      s1:=sv[ip[2,cpn]]
    else
      s1:=rvs[cpn];

    //var no
    sp[3,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[3,cpn],3,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[3,cpn]]
    else
      n2:=rvi[cpn];

    with gfreemesh[n1] do
    begin
      if (s1='X') or (s1='x') then iv[n2]:=x;
      if (s1='Y') or (s1='y') then iv[n2]:=y;
      if (s1='Z') or (s1='z') then iv[n2]:=z;
    end;

  end;


  if fname[cpn]='GetPLZ' then
  begin

    gf:=true;

    //cell x
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    //cell y
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];


    //var no
    sp[3,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[3,cpn],3,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n3:=iv[ip[3,cpn]]
    else
      n3:=rvi[cpn];

    with cells[n1,n2] do
    begin
      iv[n3]:=plz;
    end;

  end;


  if fname[cpn]='SetPLZ' then
  begin

    gf:=true;

    //cell x
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    //cell y
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];


    //plz
    sp[3,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[3,cpn],3,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n3:=iv[ip[3,cpn]]
    else
      n3:=rvi[cpn];

    with cells[n1,n2] do
    begin
      plz:=n3;
    end;

  end;


  if fname[cpn]='AddToBattleList' then
  begin

    gf:=true;

    //monster no
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    AddToBL(n1);

  end;


  if fname[cpn]='SetFSpritePos' then
  begin

    gf:=true;

    //sprite id
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    //x
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];


    //y
    sp[3,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[3,cpn],3,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n3:=iv[ip[3,cpn]]
    else
      n3:=rvi[cpn];

    //z
    sp[4,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[4,cpn],4,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n4:=iv[ip[4,cpn]]
    else
      n4:=rvi[cpn];

    with gfreesprite[n1] do
    begin
      x:=n2;
      y:=n3;
      z:=n4;
    end;

    ModFreeSprite(n1);
  end;



  if fname[cpn]='SetFMeshPos' then
  begin

    gf:=true;

    //sprite id
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    //x
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];


    //y
    sp[3,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[3,cpn],3,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n3:=iv[ip[3,cpn]]
    else
      n3:=rvi[cpn];

    //z
    sp[4,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[4,cpn],4,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n4:=iv[ip[4,cpn]]
    else
      n4:=rvi[cpn];

    with gfreemesh[n1] do
    begin
      x:=n2;
      y:=n3;
      z:=n4;
    end;

    ModFreeMesh(n1);
  end;

  if fname[cpn]='SetFMeshAng' then
  begin

    gf:=true;

    //sprite id
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    //x
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];


    //y
    sp[3,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[3,cpn],3,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n3:=iv[ip[3,cpn]]
    else
      n3:=rvi[cpn];

    //z
    sp[4,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[4,cpn],4,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n4:=iv[ip[4,cpn]]
    else
      n4:=rvi[cpn];

    with gfreemesh[n1] do
    begin
      ta:=n2;
      ra:=n3;
      pa:=n4;
    end;

    ModFreeMesh(n1);
  end;


  if fname[cpn]='SetFSpriteState' then
  begin

    gf:=true;

    //sprite id
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    //sprite state
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];

    if n2=0 then
      gfreesprite[n1].enabled:=false
    else
      gfreesprite[n1].enabled:=true;

    ModFreeSprite(n1);
  end;


  if fname[cpn]='SetFMeshState' then
  begin

    gf:=true;

    //sprite id
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    //sprite state
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];

    if n2=0 then
      gfreemesh[n1].enabled:=false
    else
      gfreemesh[n1].enabled:=true;

    ModFreeMesh(n1);
  end;



  if fname[cpn]='AddItem' then
  begin
  //form: AddItem 1 10;
    gf:=true;
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    sp[2,cpn]:=readnextword(stext[cpn],cpn);

    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];

    if n1=-1 then n1:=RandomLoot;

    AddItem(n1,n2);

  end;


  if fname[cpn]='RemoveThisWall' then
  begin
    gf:=true;
    cells[actcx,actcy].wall:=false;
    cells[actcx,actcy].passable:=true;
    BuildCell(actcx,actcy);
  end;

  if fname[cpn]='RemoveWall' then
  begin
    gf:=true;
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    sp[2,cpn]:=readnextword(stext[cpn],cpn);

    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];

    cells[n1,n2].wall:=false;
    cells[n1,n2].passable:=true;
    BuildCell(n1,n2);
  end;


  if fname[cpn]='RemoveThisSprite' then
  begin
    gf:=true;
    cells[actcx,actcy].spritename:='0';
    BuildCell(actcx,actcy);
  end;

  if fname[cpn]='MakeThisPassable' then
  begin
    gf:=true;
    cells[actcx,actcy].passable:=true;
    BuildCell(actcx,actcy);
  end;

  if fname[cpn]='MakeThisUnpassable' then
  begin
    gf:=true;
    cells[actcx,actcy].passable:=false;
    BuildCell(actcx,actcy);
  end;


  if fname[cpn]='SetCellSprite' then
  begin

    gf:=true;

    //sprite name
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,0,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      cells[actcx,actcy].spritename:=sv[ip[1,cpn]]
    else
      cells[actcx,actcy].spritename:=rvs[cpn];

    //ShowMessage(cells[actcx,actcy].spritename);

    BuildCell(actcx,actcy);

  end;


  if fname[cpn]='NoSearch' then
  begin
    gf:=true;
    nosearch:=true;
  end;

  if fname[cpn]='SwapCard' then
  begin
  //form: AddItem 3,5;
    gf:=true;
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    sp[2,cpn]:=readnextword(stext[cpn],cpn);

    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];

    if cside=0 then
      player.hand[n1]:=n2;
    if cside=1 then
      enemy.hand[n1]:=n2;

  end;

  if fname[cpn]='UnlockCard' then
  begin
  //form: AddItem 3,5;
    gf:=true;
    sp[1,cpn]:=readnextword(stext[cpn],cpn);

    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    AddNewCard(true,n1,true,true,false,player);
    //ShowRequestForm(strarr[25],strarr[33],0,5,0,'');


    //hand[n1]:=n2;
  end;

  if fname[cpn]='KeepTurn' then
  begin
    gf:=true;
    keepturn:=true;
    //ShowMessage('Keep turn');
  end;

  if fname[cpn]='CleanChoice' then
  begin
    gf:=true;
    for ii:=0 to 5 do
    begin
      gbtnv[40+ii].visible:=false;
      gbtnv[40+ii].caption:='-';
    end;
    afterch:='';
    rf_img_d:='';
    //ShowMessage('Keep turn');
  end;

  if fname[cpn]='Choice' then
  begin
  //form: Choice 3,text;
    gf:=true;
    sp[1,cpn]:=readnextword(stext[cpn],cpn);

    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    sp[2,cpn]:=readnextword(stext[cpn],cpn);

    processparam(sp[2,cpn],2,0,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      s1:=sv[ip[2,cpn]]
    else
      s1:=rvs[cpn];

    //ShowMessage('Choice. Input: "'+sp[1,cpn]+'"; "'+sp[2,cpn]+'". Output: "'+inttostr(n1)+'"; "'+s1+'".');

    Memo1.Lines.LoadFromFile(gameexe+'\text\'+lang+'\'+s1+'.txt');

    //ShowMessage(s1);

    m1:=Memo1.Text;

    gbtnv[40+n1].caption:=m1;

  end;

  if fname[cpn]='ImageCh' then
  begin
  //form: ChoiceImage text;
    gf:=true;

    sp[1,cpn]:=readnextword(stext[cpn],cpn);

    processparam(sp[1,cpn],1,0,cpn);

    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      s1:=sv[ip[1,cpn]]
    else
      s1:=rvs[cpn];

    //ShowMessage(s1);

    rf_img_d:=s1;
    //spellfound.Material.LibMaterialName:=rf_img_d;

  end;

  if fname[cpn]='ShowChoice' then
  begin

    gf:=true;
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,0,cpn);
    Memo1.Lines.LoadFromFile(gameexe+'\text\'+lang+'\txt_'+sp[1,cpn]+'_h.txt');
    m1:=Memo1.Text;
    Memo1.Lines.LoadFromFile(gameexe+'\text\'+lang+'\txt_'+sp[1,cpn]+'.txt');
    m2:=Memo1.Text;

    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,0,cpn);
    afterch:=sp[2,cpn];

    for ii:=0 to 5 do
    begin
      if gbtnv[40+ii].caption='-' then
        gbtnv[40+ii].visible:=false
      else
        gbtnv[40+ii].visible:=true;
    end;

    ShowRequestForm(m1,m2,0,25,0,rf_img_d);

    //bchoice:=-1;

    //repeat
    //  Application.ProcessMessages;
    //until (bchoice>-1);

    //ShowMessage('Keep turn');
  end;


  if fname[cpn]='UnlockPerk' then
  begin

    gf:=true;

    //perk no
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    player.perks[n1]:=true;

    ShowRequestForm(strarr[180],strarr[181]+': '+bperks[n1].name,0,1,0,'');

  end;



  if fname[cpn]='PerkUnlocked' then
  begin

    gf:=true;

    //perk no
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    if player.perks[n1]=true then n2:=1 else n2:=0;

    //where to write
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      iv[iv[ip[2,cpn]]]:=n2
    else
      iv[rvi[cpn]]:=n2;

  end;

  if fname[cpn]='ChangeLighting' then
  begin

    gf:=true;

    //ca
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    //la
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];

    //qa
    sp[3,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[3,cpn],3,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n3:=iv[ip[3,cpn]]
    else
      n3:=rvi[cpn];

    //r
    sp[4,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[4,cpn],4,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n4:=iv[ip[4,cpn]]
    else
      n4:=rvi[cpn];

    //g
    sp[5,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[5,cpn],5,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n5:=iv[ip[5,cpn]]
    else
      n5:=rvi[cpn];

    //b
    sp[6,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[6,cpn],6,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n6:=iv[ip[6,cpn]]
    else
      n6:=rvi[cpn];

    with playerlight do
    begin
      if n1<>-1 then LinearAttenuation:=n1/100;
      if n2<>-1 then ConstAttenuation:=n2/100;
      if n3<>-1 then QuadraticAttenuation:=n3/100;
      if n4<>-1 then Diffuse.Red:=n4/255;
      if n5<>-1 then Diffuse.Green:=n5/255;
      if n6<>-1 then Diffuse.Blue:=n6/255;
    end;

  end;


  if fname[cpn]='ResetLighting' then
  begin
    Form1.playerlight.ConstAttenuation:=0.5;
    Form1.playerlight.LinearAttenuation:=0.01;
    Form1.playerlight.QuadraticAttenuation:=0.01;
    Form1.playerlight.Diffuse.Red:=255/255;
    Form1.playerlight.Diffuse.Green:=127/255;
    Form1.playerlight.Diffuse.Blue:=0/255;
    gf:=true;
  end;

  if fname[cpn]='KillPlayer' then
  begin
    gf:=true;
    mmmode:=true;
    gmmode:=false;
    KillPlayer;
  end;

  if fname[cpn]='EndGame' then
  begin
    gf:=true;
    mmmode:=true;
    gmmode:=false;
    Form1.ClearLevel;
    Form1.ResetStats;
    ShowRequestForm(strarr[242],strarr[243],0,1,1,'');
  end;

  if fname[cpn]='GetPassable' then
  begin

    gf:=true;

    //x
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    //y
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];

    //var
    sp[3,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[3,cpn],3,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n3:=iv[ip[3,cpn]]
    else
      n3:=rvi[cpn];

    if cells[n1,n2].passable=true then iv[n3]:=1 else iv[n3]:=0;

    ModFreeSprite(n1);
  end;

  if fname[cpn]='ToggleWall' then
  begin

    gf:=true;

    //cell x
    sp[1,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[1,cpn],1,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n1:=iv[ip[1,cpn]]
    else
      n1:=rvi[cpn];

    //cell y
    sp[2,cpn]:=readnextword(stext[cpn],cpn);
    processparam(sp[2,cpn],2,1,cpn);
    if ((rvs[cpn]='@') and (rvi[cpn]=-1)) then
      n2:=iv[ip[2,cpn]]
    else
      n2:=rvi[cpn];

    if cells[n1,n2].wall=true then
    begin
      cells[n1,n2].wall:=false;
      cells[n1,n2].passable:=true;
    end
    else
    begin
      cells[n1,n2].wall:=true;
      cells[n1,n2].passable:=false;
    end;

    BuildCell(n1,n2);

  end;


  if gf=true then
  begin
    //ShowMessage(aname);
    aname[cpn]:='';
  end;


end;

function arrangefreecp:integer;
var i,j,k,fcp:integer;
begin

  j:=Length(cp);

  if j=0 then
  begin
    SetLength(cp,1);
    cp[0]:=-1;
    j:=Length(cp);
  end;

  i:=0;
  k:=0;
  repeat
    if cp[i]=-1 then k:=i else i:=i+1;
  until (cp[i]=-1) or (i>=j-1);

  if (i=j-1) and (k<>-1) then
  begin
    SetLength(cp,(Length(cp)+1));
    j:=Length(cp);
    i:=j-1;
  end;

  result:=i;

end;


procedure TForm1.readscript(st:string);
var n:integer;
begin
  n:=arrangefreecp;
  cp[n]:=1;
  aname[n]:='';
  stext[n]:=st;
  repeat
    try
      if (st[cp[n]]<>' ') and (st[cp[n]]<>#13) and (st[cp[n]]<>#10) and (st[cp[n]]<>';') and (st[cp[n]]<>',') then
      begin
        aname[n]:=aname[n]+st[cp[n]];
        //ShowMessage('Curr aname: '+aname);
        dofunc(aname[n],n);
      end;
      if st[cp[n]]=';' then aname[n]:='';
      cp[n]:=cp[n]+1;
    except end;
  until (cp[n]>=length(st));
  cp[n]:=-1;
end;



//config
procedure TForm1.ReadConfig;
begin
  Memo1.Lines.LoadFromFile(gameexe+'\ed.cfg');
  lang:=Memo1.Lines[0];
  mspeed:=strtoint(Memo1.Lines[1]);
  tspeed:=strtoint(Memo1.Lines[2]);
  mbd:=strtoint(Memo1.Lines[3]);
  fogd:=strtoint(Memo1.Lines[4]);
  camd:=strtoint(Memo1.Lines[5]);
  snd:=strtoint(Memo1.Lines[6]);
  msk:=strtoint(Memo1.Lines[7]);
  squality:=strtoint(Memo1.Lines[8]);
  sndon:=strtobool(Memo1.Lines[9]);
  mskon:=strtobool(Memo1.Lines[10]);
  showblog:=strtobool(Memo1.Lines[11]);
  autopump:=strtobool(Memo1.Lines[12]);
  texqual:=strtoint(Memo1.Lines[13]);
  brightness:=strtoint(Memo1.Lines[14]);
  spareproc:=StrToBool(Memo1.Lines[15]);
  try SwitchAA(StrToInt(Memo1.Lines[16])) except SwitchAA(0); end;
  cardmod:=StrToInt(Memo1.Lines[17]);
  randommode:=strtobool(Memo1.Lines[18]);
  showtooltips:=strtobool(Memo1.Lines[19]);
  hardcore:=strtobool(Memo1.Lines[20]);
  difficulty:=strtoint(Memo1.Lines[21]);
  fullscreen:=strtobool(Memo1.Lines[22]);
  xres:=strtoint(Memo1.Lines[23]);
  yres:=strtoint(Memo1.Lines[24]);
  RR:=strtoint(Memo1.Lines[25]);
  vsnc:=strtobool(Memo1.Lines[26]);
  no3ddoors:=strtobool(Memo1.Lines[27]);
  nolights:=strtobool(Memo1.Lines[28]);
  nofire:=strtobool(Memo1.Lines[29]);
  try multithread:=strtobool(Memo1.Lines[30]); except multithread:=true end;
  try pixelated:=strtobool(Memo1.Lines[31]); except pixelated:=false end;
  try edi:=strtobool(Memo1.Lines[32]); except edi:=false end;
  try autocards:=strtobool(Memo1.Lines[33]); except autocards:=false end;
  try nograss:=strtobool(Memo1.Lines[34]); except nograss:=false end;

  if texqual=-1 then begin qs:='pq'; altqs:='lq' end;
  if texqual=0 then begin qs:='lq'; altqs:='hq' end;
  if texqual=1 then begin qs:='hq'; altqs:='lq' end;

  GLSceneViewer1.Buffer.AmbientColor.Red:=(brightness/200);
  GLSceneViewer1.Buffer.AmbientColor.Green:=(brightness/200);
  GLSceneViewer1.Buffer.AmbientColor.Blue:=(brightness/200);

  if GLSceneViewer1.Buffer.FogEnvironment.FogEnd<>mbd*20 then
  begin
    GLSceneViewer1.Buffer.FogEnvironment.FogEnd:=mbd*10;
  end;

  if mcam.DepthOfView<>mbd*20 then
  begin
    mcam.DepthOfView:=mbd*20;
    mcam.FocalLength:=100;
  end;



  if vsnc=true then
  begin
    if GLSceneViewer1.VSync=vsmNoSync then GLSceneViewer1.VSync:=vsmSync;
  end
  else
  begin
    if GLSceneViewer1.VSync=vsmSync then GLSceneViewer1.VSync:=vsmNoSync;
  end;

end;


//LOCALE

procedure TForm1.fillstrarr(locale:string;var strarr:array of string);
var i,j:integer;
    cs:string;
begin

  Memo1.Lines.LoadFromFile(gameexe+'\text\'+locale+'\strings.txt');
  cs:=Memo1.Lines.Text;
  j:=0;

  for i:=0 to 10000 do strarr[i]:='';

  for i:=1 to length(cs) do
  begin
    if (cs[i]<>'@') and (cs[i]<>'&') and (cs[i]<>#13) and (cs[i]<>#10) then
      strarr[j]:=strarr[j]+cs[i];
    if (cs[i]='&') then strarr[j]:=strarr[j]+#13#10;
    if (cs[i]='@') then j:=j+1;
  end;

end;


//BATTLE

procedure downeff;
var i:integer;
begin
  //lowering effects
  for i:=1 to 100 do
  begin
    if player.e[i]>0 then player.e[i]:=player.e[i]-1;
    if enemy.e[i]>0 then enemy.e[i]:=enemy.e[i]-1;
  end;
end;


procedure UpdateBmsg(txt:string);
begin
  bmsgold:=bmsgn;
  bmsgn:=txt;
  bmsg:=bmsgold+#13#10+bmsgn;
end;

procedure TForm1.ShuffleCard(sd,ns:integer; owner:character);  //OBSOLETE
var i,k:integer;
    done:boolean;
begin

  if sd=0 then
  begin
    repeat
      owner.hand[ns]:=Random(totcards);
    until ((owner.spellbook[owner.hand[ns]]=true) and  (owner.spellen[owner.hand[ns]]=true));
  end
  else
  begin
    repeat
      owner.hand[ns]:=Random(totcards);
    until ((owner.spellbook[owner.hand[ns]]=true) and  (owner.spellen[owner.hand[ns]]=true));
  end;

end;

procedure TForm1.SetCard(sd,ns,id:integer);
var i,k,kk:integer;
    done:boolean;
begin
  if sd=0 then player.hand[ns]:=id else enemy.hand[ns]:=id
end;

procedure TForm1.ShuffleHand(var hando:character;forceall:boolean);//ow:integer);
var i,k,kk:integer;
    done:boolean;
    csen:boolean;
    att:integer;
    stage:integer;
    minddef:integer;
begin

    {if ow=0 then
    begin
      hando:=player;
      csen:=true;
      //ShowMessage('shuffling player hand');
    end
    else
    begin
      hando:=enemy;
      csen:=false;
      //ShowMessage('shuffling enemy hand');
    end;    }

    //if turn=0 then csen:=true else csen:=false;

    if hando.name=player.name then csen:=true else csen:=false;

    stage:=1;

    //ShowMessage('shuffling for '+hando.name);

    for i:=0 to 5 do
    begin

      try

      stage:=2;

      if (
         ( (hando.speed<35) and (keepturn=false) ) or ( (i=hando.luc) and (keepturn=true) ) or ( (hando.speed>=35) and (i=hando.luc) and (keepturn=false) ) or ( forceall=true )
         ) and (hando.e[21]=0)
      then
      begin

        stage:=3;

        att:=0;

        //pick random card from monster's deck
        done:=false;
        repeat

          k:=Random(totcards);

          if ((hando.spellbook[k]=true) and (hando.spellen[k]=true) and (deck[k].enabled=true) and (csen=true)) or
              ((hando.spellbook[k]=true) and (csen=false) and (deck[k].enabled=true)) then
          begin
            done:=true;
            if csen=true then
            begin
              cardind[i].Width:=gbtnv[10+i].w*2;
              cardind[i].Height:=gbtnv[10+i].h*2;
            end;
          end;

          att:=att+1;
        until (done=true) or (att>100000);

        stage:=4;
        //safety measure
        if att>100000 then
        begin
          kk:=0;
          done:=false;

          repeat
            if (hando.spellbook[kk]=true) and (deck[kk].enabled=true) then
            begin
              k:=kk;
              done:=true;
              if csen=true then
              begin
                cardind[i].Width:=gbtnv[10+i].w*2;
                cardind[i].Height:=gbtnv[10+i].h*2;
              end;
            end;
            kk:=kk+1;
          until (done=true);

        end;

        stage:=5;

        hando.hand[i]:=k;

        stage:=6;

      end;
      except
         ShowMessage('Shuffle error: stage='+inttostr(stage)+' ('+hando.name+', att='+inttostr(att)+', i='+inttostr(i)+', k='+inttostr(k)+')');
      end;
    end;

    try
      hando.luc:=-1;
    except

    end;

    if hando.e[21]>0 then //euphoria
    begin
      minddef:=random(CheckCodedPerkEff(hando,15)*100+hando.intelligence);
      for i:=0 to 5 do
      begin
        if minddef<70 then //<-blocking this shite from spreading
        begin
          hando.hand[i]:=49;
        end;
      end;
    end;

    stage:=7;


    if showtooltips=true then
    for i:=0 to 5 do
    begin
      gbtnv[10+i].tooltip:=deck[player.hand[i]].name+#13#10+'--------------------------'+#13#10+ShowCardInfo(player.hand[i]);
    end;
    gbtnv[53].tooltip:=deck[fdc].name+#13#10+'--------------------------'+#13#10+ShowCardInfo(fdc);


    {if ow=0 then
    begin
      for i:=0 to 5 do
        player.hand[i]:=hando.hand[i];
    end;
    if ow=1 then
    begin
      for i:=0 to 5 do
        enemy.hand[i]:=hando.hand[i];
    end;}

end;

procedure TForm1.VisualizeBattle(oppon:integer);
var i,j,at_w:integer;
    lmn,desmn:string;
begin
  monster_img.Material.LibMaterialName:='mon_'+inttostr(oppon);
  fillefflist;
  ShowChEffects;
  monster_sign.Material.LibMaterialName:='element_'+inttostr(enemy.element);
  {for j:=0 to 1 do
  for i:=1 to 10 do
  begin
    FreeAndNil(effstate[j,i]);
    FreeAndNil(efflgtht[j,i]);
    if j=0 then
    begin
      if player.e[i]>0 then
      begin
        effstate[j,i]:=TGLHUDSprite.CreateAsChild(dcuifront);
        with effstate[j,i] do
        begin
          Width:=32;
          Height:=32;
          Material.MaterialLibrary:=matlib;
          lmn:='effect_'+inttostr(i);
          Material.LibMaterialName:=lmn;
          Position.X:=scrn.Width-16;
          Position.Y:=40+32*i;
        end;
        efflgtht[j,i]:=TGLHUDText.CreateAsChild(dcuifront);
        with efflgtht[j,i] do
        begin
          BitmapFont:=GLWindowsBitmapFont1;
          Text:=inttostr(player.e[i]);
          Position.X:=scrn.Width-32-45;
          Position.Y:=30+32*i;
        end;
      end;
    end;
    if j=1 then
    begin
      if enemy.e[i]>0 then
      begin
        effstate[j,i]:=TGLHUDSprite.CreateAsChild(dcuifront);
        with effstate[j,i] do
        begin
          Width:=32;
          Height:=32;
          Material.MaterialLibrary:=matlib;
          lmn:='effect_'+inttostr(i);
          Material.LibMaterialName:=lmn;
          Position.X:=16;
          Position.Y:=40+32*i;
        end;
        efflgtht[j,i]:=TGLHUDText.CreateAsChild(dcuifront);
        with efflgtht[j,i] do
        begin
          BitmapFont:=GLWindowsBitmapFont1;
          Text:=inttostr(enemy.e[i]);
          Position.X:=16+32+5;
          Position.Y:=30+32*i;
        end;
      end;
    end;
  end;  }

end;


function diffmod(d,par:real):real;
begin
  result:=((1+(0.5*power(d,3))/500)*par);
end;

function TForm1.GetRandomMonsterToFight:integer;
var mopn:integer; done:boolean;
begin
  done:=false;
  repeat
    mopn:=Random(monstersno-1);
    if ((monsters[mopn].lvl-player.lvl)<(2+level)) and
       (monsters[mopn].boss=false) and (monsters[mopn].name<>'none') and
       (monsterlist[mopn]=true) then done:=true;
  until done=true;
  result:=mopn;
end;


procedure TForm1.StartBattle(fo:integer);
var mopn,i:integer;
    done:boolean;
    delta:integer;
    skpts,atpts,stg,chp:integer;
    pebon:real;
    rlsk:real;

begin

  //ShowMessage('starting battle');

  monster_img.Width:=10;
  monster_img.Height:=10;

  dcrec:=4-round(player.intelligence/100);

  {ucf1.x:=monster_img.Position.X;
  ucf1.y:=monster_img.Position.Y;
  ucf2.x:=monster_img.Position.X;
  ucf2.y:=monster_img.Position.Y;}

  Form1.ShowBattleLog;

  ucn:=-1;
  ucn2:=-1;

  //ShowMessage('picking enemy...');

  if fo=-1 then  //fight with a random monster or specific?
  begin
    mopn:=GetRandomMonsterToFight;
  end
  else mopn:=fo;

  //ShowMessage('applying enemy no '+inttostr(mopn));
  try

  eno:=mopn;
  enemy:=monsters[eno];

  //ShowMessage('Opponent: '+enemy.name+'; pumping up...');

  //making enemy stronger

  rlsk:=lsk;
  if rlsk>2 then rlsk:=2;
  rlsk:=diffmod(difficulty,rlsk);

  with enemy do
  begin
    strength:=round(strength+strength*rlsk);
    strength:=round(diffmod(difficulty,strength));
    intelligence:=round(intelligence+intelligence*rlsk);
    intelligence:=round(diffmod(difficulty,intelligence));
    speed:=round(speed+speed*rlsk);
    speed:=round(diffmod(difficulty,speed));
    endurance:=round(endurance+endurance*rlsk);
    endurance:=round(diffmod(difficulty,endurance));
    sword:=round(sword+sword*rlsk);
    sword:=round(diffmod(difficulty,sword));
    magic:=round(magic+magic*rlsk);
    magic:=round(diffmod(difficulty,magic));
    bow:=round(bow+bow*rlsk);
    bow:=round(diffmod(difficulty,bow));
    armor:=round(armor+armor*rlsk);
    armor:=round(diffmod(difficulty,armor));
  end;

  //ShowMessage('autoleveling...');

  //applying autoloeveling


  if autopump=true then
  with enemy do
  begin

    if lvl<player.lvl then
    begin
      delta:=player.lvl-lvl;

      delta:=delta+random(round(0.5*delta))-round(0.25*delta);

      //delta:=delta+(random(4)-2);
      if delta<=0 then delta:=1;

      skpts:=10*delta;
      atpts:=4*delta;

      repeat
        chp:=random(4);
        if chp=0 then sword:=sword+1;
        if chp=1 then bow:=bow+1;
        if chp=2 then magic:=magic+1;
        if chp=3 then armor:=armor+1;
        skpts:=skpts-1;
      until (skpts=0);

      repeat
        chp:=random(4);
        if chp=0 then strength:=strength+1;
        if chp=1 then intelligence:=intelligence+1;
        if chp=2 then speed:=speed+1;
        if chp=3 then endurance:=endurance+1;
        atpts:=atpts-1;
      until (atpts=0);

      if autocards=true then
      begin
        stg:=delta;
        if stg>0 then repeat
          AddNewCard(true,-1,false,false,true,enemy);
          stg:=stg-1;
        until (stg<=0);
      end;

      lvl:=lvl+delta;

    end;

  end;

  UpdateJournal(enemy.jrn);

  //finish autoleveling

  //ShowMessage('Enemy leveling done');

  UpdateBmsg(strarr[63]+' '+(enemy.name)+' ('+inttostr(mopn)+')');
  Form1.AddToBattleLog(strarr[63]+' '+(enemy.name)+' ('+inttostr(mopn)+')');

  //ShowMessage('pumping player...');

  with player do
  begin
    hpmax:=CalcMaxHP(player,1,false);
    hp:=hpmax;
    manamax:=intelligence;
    pebon:=CheckCodedPerkEff(player,7);
    if pebon>0 then manamax:=round((1+0.25*pebon)*manamax);
    mana:=manamax;
    for i:=1 to 100 do
    begin
      e[i]:=0;
      estr[i]:=0;
    end;
    pebon:=CheckCodedPerkEff(player,8);
    if pebon>0 then e[3]:=round(2*pebon);
    pebon:=CheckCodedPerkEff(player,14);
    if pebon>0 then e[8]:=round(2*pebon);
    if pebon>0 then estr[8]:=5+round(player.endurance/10);
  end;

  //ShowMessage('additionally pumping enemy...');

  with enemy do
  begin
    hpmax:=CalcMaxHP(enemy,0,true);
    hp:=hpmax;
    manamax:=intelligence;
    pebon:=CheckCodedPerkEff(enemy,7);
    if pebon>0 then manamax:=round((1+0.25*pebon)*manamax);
    mana:=manamax;
    for i:=1 to 100 do
    begin
      e[i]:=0;
      estr[i]:=0;
    end;
    pebon:=CheckCodedPerkEff(enemy,8);
    if pebon>0 then e[3]:=round(pebon*2);
    pebon:=CheckCodedPerkEff(enemy,14);
    if pebon>0 then e[8]:=round(2*pebon);
    if pebon>0 then estr[8]:=5+round(enemy.endurance/10);
  end;

  //ShowMessage('Visualisation proc');

  Form1.VisualizeBattle(eno);

  //ShowMessage('shuffling player');
  player.luc:=-1;
  enemy.luc:=-1;
  keepturn:=false;
  ShuffleHand(player,true);
  ShuffleHand(enemy,true);
  //ShowMessage('picking turn');

  if random(player.speed)<=Random(enemy.speed) then
  begin
    turn:=1;
  end
  else
    turn:=0;

  //ShowMessage('Preparing to shuffle');

  //ShuffleHand](0);
  //ShuffleHand(1);

  //ShowMessage('Shuffle done');

  //ShowMessage('starting battle at last');

   btlmode:=true;

   if hpkept<>-1 then player.hp:=hpkept;
   if mpkept<>-1 then player.mana:=mpkept;

   bphase:=1;

  except
    ShowMessage('Error starting battle.');
  end;

end;

function TForm1.GetETypeName(etype:integer;strarr:array of string):string;
var estring:string;

begin
  case etype of //<-assigning effect title
  1:begin estring:=strarr[53] end; //paralysis
  2:begin estring:=strarr[54] end; //blessing
  3:begin estring:=strarr[55] end; //rage
  4:begin estring:=strarr[56] end; //resist paral
  5:begin estring:=strarr[57] end; //regen
  6:begin estring:=strarr[58] end; //irritate
  7:begin estring:=strarr[59] end; //shock
  8:begin estring:=strarr[60] end; //shield
  9:begin estring:=strarr[170] end; //insanity
  10:begin estring:=strarr[184] end; //poison
  11:begin estring:=strarr[61] end;//dispell
  12:begin estring:=strarr[146] end; //suck
  13:begin estring:=strarr[195] end; //break paral
  14:begin estring:=strarr[244] end; //mana flow
  15:begin estring:=strarr[246] end; //armorpierce
  16:begin estring:=strarr[252] end; //+str
  17:begin estring:=strarr[253] end; //+int
  18:begin estring:=strarr[254] end; //+speed
  19:begin estring:=strarr[255] end; //+end
  20:begin estring:=strarr[260] end; //+all 4
  21:begin estring:=strarr[281] end; //euphoria
  22:begin estring:=strarr[332] end; //heal poison
  23:begin estring:=strarr[343] end; //sleep
  24:begin estring:=strarr[386] end; //curse

  else begin estring:='--none--' end
  end;
  result:=estring;

end;


function TForm1.GetETypeDesc(etype:integer;strarr:array of string):string;
var estring:string;
    i:integer;
begin
  case etype of //<-assigning effect title
  1:begin estring:=strarr[221] end; //paralysis     -
  2:begin estring:=strarr[222] end; //blessing      +
  3:begin estring:=strarr[223] end; //rage          +
  4:begin estring:=strarr[224] end; //resist paral  +
  5:begin estring:=strarr[225] end; //regen         +
  6:begin estring:=strarr[226] end; //irritate      -
  7:begin estring:=strarr[227] end; //shock         -
  8:begin estring:=strarr[228] end; //shield        +
  9:begin estring:=strarr[229] end; //insanity      -
  10:begin estring:=strarr[230] end; //poison       -
  11:begin estring:=strarr[231] end;//dispell       +
  12:begin estring:=strarr[232] end; //suck         +
  13:begin estring:=strarr[233] end; //break paral  +
  14:begin estring:=strarr[245] end; //mana flow    +
  15:begin estring:=strarr[247] end; //armorpierce  +
  16:begin estring:=strarr[256] end; //+str         +
  17:begin estring:=strarr[257] end; //+int         +
  18:begin estring:=strarr[258] end; //+speed       +
  19:begin estring:=strarr[259] end; //+end         +
  20:begin estring:=strarr[261] end; //+all 4       +
  21:begin estring:=strarr[282] end; //euphoria     -
  22:begin estring:=strarr[333] end; //heal poison  +
  23:begin estring:=strarr[344] end; //sleep        -
  24:begin estring:=strarr[387] end; //curse        -
  else begin estring:='--none--' end
  end;
  result:=estring;

end;

function TForm1.GetEClassName(etype:integer;strarr:array of string):string;
var estring:string;

begin
  case etype of //<-assigning enemy class name
  0:begin estring:=strarr[91] end;
  1:begin estring:=strarr[92] end;
  2:begin estring:=strarr[93] end;
  3:begin estring:=strarr[94] end;
  else begin estring:='--none--' end
  end;
  result:=estring;

end;


function TForm1.GetElName(etype:integer;strarr:array of string):string;
var estring:string;

begin
  case etype of //<-assigning enemy class name
  0:begin estring:=strarr[353] end;
  1:begin estring:=strarr[354] end;
  2:begin estring:=strarr[355] end;
  3:begin estring:=strarr[356] end;
  4:begin estring:=strarr[357] end;
  else begin estring:='--none--' end
  end;
  result:=estring;

end;


procedure TForm1.Timer1Timer(Sender: TObject);
begin
  {if buse>15 then
  begin
    alDeleteBuffers(buse,@buffer2);
    alDeleteSources(buse,@source2);
    buse:=0;
  end;}
  intren:=true;
end;

function checkoppelem(e1,e2:integer):boolean;
begin
  if (((e1=1) and (e2=2)) or ((e1=2) and (e2=1))) or
     (((e1=3) and (e2=4)) or ((e1=4) and (e2=3))) then Result:=true else result:=false;
end;

procedure TForm1.TryToEscape;
var i:integer;
    ecb:real;
    te1,te2:integer;
    givexp:integer;
begin
  //players tries to leave the battle

  if CheckCodedPerkEff(player,5)>0 then
  begin
    ecb:=0.25;
  end
  else
  begin
    ecb:=0;
  end;

  if (player.e[1]>0) or (player.e[23]>0) then ecb:=ecb-0.5;
  if (enemy.e[1]>0) or (enemy.e[23]>0) then ecb:=ecb+0.5;

  te1:=round((1+ecb)*random(player.speed));
  te2:=enemy.speed;

  if (te1>te2) then
  begin
    btlmode:=false;
    givexp:=round((enemy.hpmax*enemy.lvl)/4);
    givexp:=givexp+givexp*CheckCodedPerkEff(player,14);
    AddXP(1,givexp,player);
    for i:=1 to 100 do
    begin
      player.e[i]:=0;
      enemy.e[i]:=0;
      player.estr[i]:=0;
      enemy.estr[i]:=0;
      {FreeAndNil(effstate[0,i]);
      FreeAndNil(effstate[1,i]);
      FreeAndNil(efflgtht[0,i]);
      FreeAndNil(efflgtht[1,i]);  }
      //Form1.ShowRequestForm(strarr[249],strarr[250]+': '+inttostr(te1)+'. '+strarr[251]+': '+inttostr(te2),0,1,0,'');
    end;
    Form1.VisualizeBattle(0);
  end
  else
  begin
    Form1.ShowRequestForm(strarr[248],strarr[250]+': '+inttostr(te1)+'. '+strarr[251]+': '+inttostr(te2),0,1,0,'');
  end;


end;

function calcpercdmg(hp,perc:integer):integer;
begin
  result:=round(hp*(perc/100));
end;


function TForm1.CalcDmg(cid,gsl,ustr,uint,uspd,uend,tstr,tint,tspd,tend:integer;user,target:character;ubl,wascrit:boolean):integer;
var dmg,tempv,pebon:integer;
begin


  dmg:=0;

  with deck[cid] do begin


  if (dmgph>0) or (dmgperc>0) then
  begin

    tempv:=mindam+random(dmgph-mindam);
    dmg:=dmg+tempv; //basic damage


    tempv:=dmg;

    if ubl=true then AddToBattleLog(strarr[133]+': '+inttostr(tempv));

    //adding damage based off skill
    if dmg>0 then
    begin
      dmg:=round(dmg+dmg*((gsl)/100)); //skill damage boost
      tempv:=round(dmg*((gsl)/100));
      if ubl=true then AddToBattleLog(strarr[135]+': '+inttostr(tempv)+' ('+inttostr(dmg)+')');
    end;

    //using defence and shield effect
    tempv:=round((dmg*(target.armor/100)));

    if CheckCodedPerkEff(target,20)>0 then
    begin
      tempv:=round((tempv*(target.sword/100)));
    end;

    if target.e[8]>0 then tempv:=tempv+((target.estr[8]));

    if ubl=true then
    begin
      if user.e[15]>0 then tempv:=round(tempv-tempv*random(user.estr[15])/100);  //lowers enemy defence if piercer
    end
    else
    begin
      if user.e[15]>0 then tempv:=round(tempv-tempv*user.estr[15]/100);
    end;

    if user.e[21]>0 then tempv:=round(1.25*tempv);  //raises defence if in euphoria
    dmg:=dmg-tempv;
    if ubl=true then AddToBattleLog(strarr[136]+': '+inttostr(tempv)+' ('+inttostr(dmg)+')');




    pebon:=CheckCodedPerkEff(target,11);
    if pebon>0 then
    begin
      if pebon>50 then pebon:=50;
      dmg:=dmg-round(dmg*(random(51)+pebon)/100);
      AddToBattleLog(strarr[193]+' ('+inttostr(dmg)+')');
    end;

    //using strength damage increase or intelligence damage increase
    if (govskill=0) or (govskill=1) then
    begin
      if ubl=true then tempv:=round(dmg*(ustr/2+random(round(ustr/2)))/100) else tempv:=round(dmg*(ustr/2+(round(ustr/2)))/100);
      dmg:=dmg+tempv;
      if ubl=true then AddToBattleLog(strarr[137]+': '+inttostr(tempv)+' ('+inttostr(dmg)+')');
    end
    else
    begin
      if ubl=true then tempv:=round(dmg*(uint/2+random(round(uint/2)))/100) else tempv:=round(dmg*(uint/2+(round(uint/2)))/100);
      dmg:=dmg+tempv;
      if ubl=true then AddToBattleLog(strarr[208]+': '+inttostr(tempv)+' ('+inttostr(dmg)+')');
    end;


    //checking for bonus
    if target.spec=bont then
    begin
      dmg:=dmg+round(dmg*(bonam/100));
      tempv:=round(dmg*(bonam/100));
      if ubl=true then AddToBattleLog(strarr[138]+': '+inttostr(tempv)+' ('+inttostr(dmg)+')');
    end;

    //checking elemental bonus
    if (checkoppelem(target.element,deck[cid].element)=true) then
    begin
      dmg:=dmg*2;
      AddToBattleLog('Elemental multiplyer x2. Dmg='+inttostr(dmg));
    end;

    if (target.element=deck[cid].element) and (deck[cid].element<>0) then
    begin
      dmg:=round(dmg/2);
      AddToBattleLog('Elemental multiplyer x2. Dmg='+inttostr(dmg));
    end;

    if (user.element=deck[cid].element) and (deck[cid].element<>0) then
    begin
      dmg:=round(dmg*1.3);
      AddToBattleLog('Elemental multiplyer 33% from user affinity. Dmg='+inttostr(dmg));
    end;

    //using irritation effect
    if user.e[6]>0 then
    begin
      dmg:=round(dmg/2);
      if ubl=true then AddToBattleLog(strarr[139]+': '+inttostr(dmg));
    end;

    //using speed damage decrease
    if ubl=true then tempv:=round(dmg*random(round(tspd/100))) else tempv:=round(dmg*(tspd/100));
    dmg:=dmg-tempv;
    if ubl=true then AddToBattleLog(strarr[140]+': '+inttostr(tempv)+' ('+inttostr(dmg)+')');

    //considering effects
    if user.e[2]>0 then
    begin
      dmg:=dmg*2; //blessing doubles damage
      if ubl=true then AddToBattleLog(strarr[141]+': '+inttostr(dmg));
    end;

    if user.e[3]>0 then
    begin
      if ubl=true then tempv:=(random(user.e[3])+1) else tempv:=(user.e[3])+1;
      dmg:=dmg*tempv;  //rage increases damage by (1 - its length)
      if ubl=true then AddToBattleLog(strarr[142]+': '+inttostr(tempv)+' ('+inttostr(dmg)+')');
    end;

    //making minimal damage
    if dmg<0 then dmg:=1;

    //applying crit IN THE END
    if wascrit=true then
    begin
      pebon:=CheckCodedPerkEff(user,1);
      dmg:=dmg*2*pebon;
    end;

  end;

  dmg:=dmg+calcpercdmg(target.hp,dmgperc); //percent damage

  tempv:=calcpercdmg(target.hp,dmgperc);
  if ubl=true then AddToBattleLog(strarr[134]+': '+inttostr(tempv)+' ('+inttostr(dmg)+')');

  //checking curse
  if user.e[24]>0 then
  begin
    if random(100)<user.estr[23] then
    begin
      dmg:=0;
    end;
  end;

  end;

  result:=dmg;

end;


function CheckSoundExists(sound:string):boolean;
begin
  if FileExists(gameexe+'\sounds\audio\'+sound+'.wav')=true then Result:=true else Result:=false;
end;

function setupdp(inp:string):string;
begin
  if edi=true then result:=inp+': ' else result:='';
end;

function tform1.gethpcdrop(hpc:integer;user:character):integer;
begin
  result:=round(hpc/(CheckCodedPerkEff(user,19)+1))
end;

procedure TForm1.ProcDispell(effdir,es:integer;var user,target:character);
var estr,etr:integer;
    i,j,k:integer;
    p:character;
    sp:boolean;//search positive?
    ip:boolean;
begin

  estr:=es;

  if effdir=0 then
  begin
    p:=user;
    sp:=false; //remove negative from player
  end
  else
  begin
    p:=target;
    sp:=true; //remove positive from enemy
  end;

  for i:=1 to toteff do
  begin
    ip:=false;
    if (epos[i]=sp) and (p.e[i]>0) then
    begin
      repeat
        estr:=estr-1;
        if p.estr[i]>0 then
          p.estr[i]:=p.estr[i]-estr;
        if p.estr[i]<=0 then
          p.e[i]:=0;
      until (estr=0) or (p.e[i]=0);
    end;
  end;

  if effdir=0 then user:=p else target:=p;

end;

procedure Tform1.UseCard(no,side:integer; var user,target:character);
var i,acd:integer;
    dmg:integer;
    heal:integer;
    rmana:integer;
    etype,estr,etr,elg:integer; estring:string;
    bmsgk:string;
    sw,mg,bw,ar:integer;
    ustr,uint,uspd,uend:integer;
    tstr,tint,tspd,tend:integer;
    gsl,gslc:integer;
    tempv:integer;
    wascrit:boolean;
    dstrike:boolean; dmg2:integer;
    pebon:integer;
    e5s:integer;
    dp:string;
    hpcdrop:integer;
    stxt:string;
begin

   wascrit:=false;
   user.luc:=no;

  //makes the player use a card if it meets conditions

  if (user.e[5]>0) and (user.estr[5]>0) then
  begin
    e5s:=round((user.endurance*user.estr[5])/10);
    user.hp:=user.hp+e5s;
    if user.hp>user.hpmax then user.hp:=user.hpmax;
    dp:=setupdp(strarr[377]);
    AddDmgPop(side,dp+inttostr(e5s),1);
  end;

  if ((itms[deck[user.hand[no]].consumes].count>0) and (side=0)) or (side=1) or (deck[user.hand[no]].consumes=-1) then begin
  if ((user.e[1]=0) and (user.e[23]=0)) or (deck[user.hand[no]].addeffect=13) then begin  //<-all that stuff won't work for
                                                                                    //a paralyzed player or a player with no required items
  acd:=user.hand[no];
  if side=0 then
  begin
    //showmessage('using card no '+inttostr(player.hand[no])+' - card in hand '+inttostr(no)+' ('+deck[player.hand[no]].name+')');
    ucn2:=acd;
    manado:=true;
  end;

  if side=1 then
  begin
    //showmessage('using card no '+inttostr(enemy.hand[no])+' - card in hand '+inttostr(no)+' ('+deck[enemy.hand[no]].name+')');
    ucn:=acd;
  end;

  //defining additional params for effects
  with user do
  begin
    ustr:=strength;
    if e[16]>0 then ustr:=round(ustr*(1+estr[16]/100));
    if e[20]>0 then ustr:=round(ustr*(1+estr[20]/100));
    uint:=intelligence;
    if e[17]>0 then uint:=round(uint*(1+estr[17]/100));
    if e[20]>0 then uint:=round(uint*(1+estr[20]/100));
    uspd:=speed;
    if e[18]>0 then uspd:=round(uspd*(1+estr[18]/100));
    if e[20]>0 then uspd:=round(uspd*(1+estr[20]/100));
    uend:=endurance;
    if e[19]>0 then uend:=round(uend*(1+estr[19]/100));
    if e[20]>0 then uend:=round(uend*(1+estr[20]/100));
  end;
  with target do
  begin
    tstr:=strength;
    if e[16]>0 then tstr:=round(tstr*(1+estr[16]/100));
    if e[20]>0 then tstr:=round(tstr*(1+estr[20]/100));
    tint:=intelligence;
    if e[17]>0 then tint:=round(tint*(1+estr[17]/100));
    if e[20]>0 then tint:=round(tint*(1+estr[20]/100));
    tspd:=speed;
    if e[18]>0 then tspd:=round(tspd*(1+estr[18]/100));
    if e[20]>0 then tspd:=round(tspd*(1+estr[20]/100));
    tend:=endurance;
    if e[19]>0 then tend:=round(tend*(1+estr[19]/100));
    if e[20]>0 then tend:=round(tend*(1+estr[20]/100));
  end;


  sw:=round(user.sword+(user.sword*(ustr/100)));
  bw:=round(user.bow+(user.bow*(uspd/100)));
  mg:=round(user.magic+(user.magic*(uint/100)));
  ar:=round(user.armor+(user.armor*(uend/100)));

  //setting GSL var to represent governing skill
  case deck[acd].govskill of
  0:begin
     gsl:=sw;
     gslc:=user.sword;
    end;
  1:begin
     gsl:=bw;
     gslc:=user.bow;
    end;
  2:begin
     gsl:=mg;
     gslc:=user.magic;
    end;
  3:begin
     gsl:=ar;
     gslc:=user.armor;
    end;
  end;

  {ustr:=user.strength;
  uspd:=user.speed;
  uint:=user.intelligence;
  uend:=user.endurance;
  if side=0 then
  begin
    ustr:=ustr+ibstr;
    uint:=uint+ibint;
    uspd:=uspd+ibspd;
    uend:=uend+ibend;
  end; }

  //sending output variables for script
  sw_:=sw;
  bw_:=bw;
  mg_:=mg;
  ar_:=ar;
  tsw:=target.sword;
  tbw:=target.bow;
  tmg:=target.magic;
  tar:=target.armor;


  with deck[acd] do
  begin

    //playing sound
    if (sound='0') or (CheckSoundExists(sound)=false) then
    begin
      case govskill of
      0:begin
          DoSound('skl_sword');
        end;
      1:begin
          DoSound('skl_bow');
        end;
      2:begin
          DoSound('skl_magic');
        end;
      3:begin
          DoSound('skl_armour');
        end;
      end;
    end
    else
    begin
      DoSound(sound);
    end;


    if ((user.hp>=hpc) and (user.mana>=mc)) or (side=1) then
    begin

      if (deck[user.hand[no]].consumes<>-1) and (side=0) then
      begin
        itms[deck[acd].consumes].count:=itms[deck[acd].consumes].count-1;
        ShowRequestForm(strarr[313],strarr[313]+': '+itms[deck[acd].consumes].overridename+'. '+strarr[314]+': '+inttostr(itms[deck[acd].consumes].count),0,1,0,'');
      end;

      if side=0 then
      begin
        ucf2.sy:=gbtn[10+no].Position.Y;
        ucf2.sx:=gbtn[10+no].Position.X;
        if no=6 then
        begin
          ucf2.sy:=gbtn[53].Position.Y;
          ucf2.sx:=gbtn[53].Position.X;
        end;
        ucf2.x:=ucf2.sx;
        ucf2.y:=ucf2.sy;
        cimx2:=true;
        Form1.usedcard2.Material.LibMaterialName:='card_'+inttostr(acd)+'_0';
      end;
      if side=1 then
      begin
        ucf1.sy:=monster_img.Position.Y;
        ucf1.sx:=monster_img.Position.X;
        ucf1.x:=ucf1.sx;
        ucf1.y:=ucf1.sy;
        cimx1:=True;
        Form1.usedcard.Material.LibMaterialName:='card_'+inttostr(acd)+'_0';
      end;

      bmsgk:=user.name+' '+strarr[103]+' '+deck[acd].name+'. ';
      AddToBattleLog(user.name+' '+strarr[103]+' '+deck[acd].name+'. ');

      //collecting damage amount

      //defining if there was a crit
      pebon:=CheckCodedPerkEff(user,1);
      if pebon>0 then
      begin
        if (Random(100))>89 then
        begin
          wascrit:=true;
          AddToBattleLog(strarr[178]+' ('+inttostr(dmg)+')');
        end;
      end;
      dmg:=CalcDmg(acd,gsl,ustr,uint,uspd,uend,tstr,tint,tspd,tend,user,target,true,wascrit);
      if (gsl=0) and (CheckCodedPerkEff(user,17)>0) and (Random(1000)<gslc) then
        dmg2:=CalcDmg(acd,gsl,ustr,uint,uspd,uend,tstr,tint,tspd,tend,user,target,true,false)
      else
        dmg2:=0;

      //adding health
      heal:=0;
      heal:=heal+addhp;

      if heal>0 then
      begin
        heal:=round(heal+heal*(gsl/100));

        if user.spec=bont then heal:=heal+round(heal*(bont/100));

        //checking elemental bonus
        if (user.element=deck[acd].element) and (deck[acd].element<>0) then
        begin
          heal:=heal*2;
        end;

        pebon:=CheckCodedPerkEff(user,10);
        if pebon>0 then heal:=heal*2*pebon;

      end;

      //adding mana
      rmana:=0;
      rmana:=rmana+addmp;

      if rmana>0 then
      begin

        rmana:=round(rmana+rmana*(gsl/100));

        if user.spec=bont then rmana:=rmana+round(rmana*(bont/100));

      end;

      if user.mana>user.manamax then user.mana:=user.manamax;

      //adding status effect
      etype:=addeffect;
      elg:=0;
      estr:=0;

      elg:=elg+efflgth;
      if effstrgth=0 then
        estr:=estr+efflgth
      else
        estr:=estr+effstrgth;

      estring:=GetETypeName(etype,strarr);

      if ((estr>0) and (etype>0)) then
      begin

        elg:=round(elg+elg*(gsl/100));
        estr:=round(estr+estr*(gsl/100));

      end;

      //applying effects

      if (estr>0) and (etype>0) then
      begin

        if effdir=0 then //self
        begin
          if ((etype=1) and (user.e[4]=0)) or (etype<>1) then
          begin

            if user.spec=bont then estr:=estr+round(estr*(bont/100));
            if (user.element=deck[acd].element) and (deck[acd].element<>0) then estr:=round(estr*1.3);

            if accum=true then
            begin
              user.e[etype]:=user.e[etype]+elg;
              user.estr[etype]:=user.estr[etype]+estr;
            end
            else
            begin
              user.e[etype]:=elg;
              user.estr[etype]:=estr;
            end;

            bmsgk:=bmsgk+' '+user.name+' '+strarr[69]+' '+estring+' '+strarr[70]+' '+inttostr(elg)+' '+strarr[71]+'.';
          end;

        end;

        if effdir=1 then //targ
        begin
          if ((etype=1) and (target.e[4]=0)) or (etype<>1) then
          begin

            if target.spec=bont then estr:=estr+round(estr*(bont/100));
            if (target.element=deck[acd].element) and (deck[acd].element<>0) then estr:=round(estr*1.3);

            if accum=true then
            begin
              target.e[etype]:=target.e[etype]+elg;
              target.estr[etype]:=target.estr[etype]+estr;
            end
            else
            begin
              target.e[etype]:=elg;
              target.estr[etype]:=estr;
            end;

            bmsgk:=bmsgk+' '+user.name+' '+strarr[72]+' '+estring+' '+strarr[73]+' '+target.name+' '+strarr[70]+' '+inttostr(elg)+' '+strarr[71]+'.';
          end;
        end;

        if (etype=11) then //dispell
        begin
          form1.ProcDispell(effdir,estr,user,target);
          if user.e[11]>0 then user.e[11]:=0;
        end;

        if (etype=12) then
        begin
          if target.spec=bont then estr:=estr+round(estr*(bont/100));
          heal:=heal+estr;
          dmg:=dmg+estr;
          bmsgk:=bmsgk+' '+user.name+' '+strarr[147]+' '+inttostr(estr)+' '+strarr[148]+' '+target.name+'.';
          estr:=0;
          user.e[etr]:=0;
        end;

        if (etype=13) then  //breaking paral
        begin

          case deck[acd].govskill of
          0:if user.e[1]>0 then user.e[1]:=user.e[1]-round(ustr/10);
          1:if user.e[1]>0 then user.e[1]:=user.e[1]-round(uspd/10);
          2:if user.e[1]>0 then user.e[1]:=user.e[1]-round(user.magic/10);
          3:if user.e[1]>0 then user.e[1]:=user.e[1]-round(user.armor/10);
          end;

          if user.e[1]<0 then user.e[1]:=0;
          bmsgk:=bmsgk+' '+user.name+' '+strarr[196]+'.'

        end;

        if (etype=22) then  //removing poison (always self)
        begin
          repeat
            estr:=estr-1;
            user.e[10]:=user.e[10]-1;
            bmsgk:=bmsgk+' '+user.name+' '+strarr[74]+' '+GetETypeName(etr,strarr)+'.'
          until (estr=0) or (user.e[10]<=0);
          user.e[22]:=0;
          if user.e[10]<0 then user.e[10]:=0;
        end;

      end;

      //sending calculated data away
      dmgo:=dmg;
      healo:=heal;
      rmanao:=rmana;
      effstro:=estr;
      cside:=side;

      //RUNNING CARD SCRIPT
      if fileexists(gameexe+'\cards\'+inttostr(acd)+'_script.txt')=true then
      begin
        Memo1.Lines.LoadFromFile(gameexe+'\cards\'+inttostr(acd)+'_script.txt');

        stxt:=Memo1.Text;
        //ShowMessage('Reading script');
        stxt:=preparescript(stxt);
        readscript(stxt);
      end;

      //returning data
      sw:=sw_;
      bw:=bw_;
      mg:=mg_;
      ar:=ar_;
      dmg:=dmgo;
      heal:=healo;
      rmana:=rmanao;
      estr:=effstro;


      //APPLYING CALCULATED DAMAGE, HEALING

      if dmg>0 then
      begin
        //dealing damage
        AddToBattleLog(strarr[143]+': '+inttostr(dmg));
        target.hp:=target.hp-dmg-dmg2;
        //showing output
        bmsgk:=bmsgk+user.name+' '+strarr[64]+' '+target.name+' '+strarr[65]+' '+inttostr(dmg)+' '+strarr[66];

        dp:=setupdp(strarr[373]);
        if wascrit=true then
        begin
          bmsgk:=bmsgk+' '+strarr[178];
          AddDmgPop(side,dp+inttostr(dmg)+'!',0);
        end
        else
          AddDmgPop(side,dp+inttostr(dmg),0);

        dp:=setupdp(strarr[379]);
        if dmg2>0 then AddDmgPop(side,dp+'+'+inttostr(dmg2),0);

        //remove sleep if target hit
        if target.e[23]>0 then target.e[23]:=0;
      end;

      if heal>0 then
      begin
        //healing
        user.hp:=user.hp+heal;
        bmsgk:=bmsgk+' '+user.name+' '+strarr[68]+' '+inttostr(heal)+' '+strarr[66];
        if user.hp>user.hpmax then user.hp:=user.hpmax;
        dp:=setupdp(strarr[376]);
        AddDmgPop(side,dp+inttostr(heal),1);
      end;

      if rmana>0 then
      begin
        //restoring mana
        user.mana:=user.mana+rmana;
        if rmana>0 then
          bmsgk:=bmsgk+' '+user.name+' '+strarr[67]+' '+inttostr(rmana)+' '+strarr[66];
        dp:=setupdp(strarr[377]);
        AddDmgPop(side,dp+inttostr(rmana),2);
      end;

      UpdateBmsg(bmsgk);

      //raising skill
      with user do
      if (random(100)>gslc) and (Random(100)<skupch) and (side=0) then
      begin
        case govskill of
        0:begin
            bsw:=bsw+1;
            if side=0 then AddXP(0,user.sword,user);
          end;
        1:begin
            bbw:=bbw+1;
            if side=0 then AddXP(3,user.bow,user);
          end;
        2:begin
            bmg:=bmg+1;
            if side=0 then AddXP(5,user.magic,user);
          end;
        3:begin
            bar:=bar+1;
            if side=0 then AddXP(4,user.armor,user);
          end;
        end;
      end;

      //taking hp cost
      hpcdrop:=gethpcdrop(hpc,user);
      user.hp:=user.hp-hpcdrop;
      if hpc>0 then
      begin
        dp:=setupdp(strarr[378]);
        AddDmgPop(side,dp+inttostr(hpcdrop),0);
      end;

      //taking spell cost
      if user.e[3]=0 then
      begin

        if side=0 then
        begin
          user.mana:=user.mana-mc;
          if mc>0 then
          begin
            dp:=setupdp(strarr[378]);
            AddDmgPop(0,dp+'-'+inttostr(mc),2);
          end;
        end;
      end;

    end
    else
    begin
      if mc>user.mana then
        Form1.ShowRequestForm(strarr[75],strarr[76],0,1,1,'');
      if hpc>user.hp then
        Form1.ShowRequestForm(strarr[75],strarr[77],0,1,1,'');
    end;
  end; end; //<-end of paralyzed conditions
  end //<-end for consumable check
  else
  begin
    if (side=0) and (itms[deck[user.hand[no]].consumes].count<=0) then
    begin
      Form1.ShowRequestForm(strarr[315],strarr[316]+': '+itms[deck[user.hand[no]].consumes].overridename,0,1,1,'');
    end;
  end;

  puc:=true;

end;

function TForm1.MonsterAI:integer;
var cardball:array[0..5]of integer;
    i,j,k,b:integer;
begin
  //returns card for enemy to use

  {active:boolean; //was or wasn't used by player
    mc,hpc:integer; //eats mana and HP
    dmgph:integer; //deals physical damage
    dmgperc:integer; //deals percent damage
    addhp:integer; //adds hp
    addmp:integer; //adds mp
    addeffect:integer; //adds status effect
    efflgth:integer; //for how many turns effect will last
    govskill:integer; //governing skilll
    bont,bonam:integer; //bonus to species, bonus amount (%)
    accum:boolean; //effect is renewed or accumulated for this card
    monly:boolean; //game will not give this card to a player
    enabled:boolean; //is this card actually eligible}


    {     1 Paralysis@
          2 Blessing@
          3 Rage@
          4 Resist Paralysis@
          5 Regeneration@
          6 Irritation@
          7 Shock@
          8 Shield@
          9 Insanity@
          11 Dispell@  }

  for i:=0 to 5 do
  with deck[enemy.hand[i]] do
  begin
    b:=0;
    //evaluating damage
    if (player.hp/player.hpmax)<0.25 then k:=2 else k:=1;
    b:=b+k*round(dmgph+(player.hpmax*dmgperc/100));

    //evaluating healing
    if (enemy.hp/enemy.hpmax)<0.25 then k:=2 else k:=1;
    b:=b+k*healo;

    //evaluating effects
    if ((enemy.hp/enemy.hpmax)<0.25) or ((player.hp/player.hpmax)<0.25) then k:=1 else
    begin
      if (enemy.hp/enemy.hpmax)>0.75 then k:=20;
      if (enemy.hp/enemy.hpmax)<=0.75 then k:=10;
    end;

    if (enemy.hp<=gethpcdrop(hpc,enemy)) then
    begin
      b:=0;
    end;

    if (addeffect<>0) then
    begin
      if (effdir=0) and (enemy.e[addeffect]=0) then b:=b+round((k*efflgth+k*effstrgth)/2);
      if (effdir=1) and (player.e[addeffect]=0) then b:=b+round((k*efflgth+k*effstrgth)/2);
    end;

    if (enemy.hp/enemy.hpmax)<0.25 then k:=40;
    if (addeffect<>0) then
    begin
      if (addeffect=5) and (effdir=0) and (enemy.e[5]=0) then b:=b+2*k*efflgth;
    end;

    cardball[i]:=b;
  end; //evaluation done

  //picking the top one
  k:=0;
  for i:=0 to 5 do
  begin
    if cardball[i]>k then
    begin
      k:=cardball[i];
      j:=i;
    end;
  end;

  //if enemy.e[21]>0 then j:=0;

  result:=j;
end;


procedure Tform1.MonsterTurn;
var i,ctu,att:integer;
    done:boolean;
    pdam:integer;
    manb:integer;
begin

  //ShowMessage('monster turn');

  skipped:=false;

  i:=0;
  att:=0;
  ctu:=-1;
  done:=false;
  pdam:=0;

  if player.e[7]>0 then                 //player shock
  begin
    player.hp:=player.hp-(player.estr[7]);
    dp:=setupdp(strarr[375]);
    AddDmgPop(0,dp+inttostr(player.estr[7]),0);
    AddToBattleLog(strarr[240]+': '+inttostr(player.estr[7]));
  end;
  if player.e[10]>0 then   //player poison
  begin
    player.hp:=player.hp-player.e[10];
    dp:=setupdp(strarr[374]);
    AddDmgPop(0,dp+inttostr(player.e[10]),0);
    AddToBattleLog(strarr[239]+': '+inttostr(player.e[10]));
  end;
  {if enemy.e[21]>0 then
  begin
    for i:=0 to 5 do enemy.hand[i]:=49;
  end;}

  //ShowMessage('picking card');
  {if enemy.e[9]=0 then begin //check for insanity
  repeat

    with enemy do
    begin

        //consider effects
        /*1 Paralysis@
          2 Blessing@
          3 Rage@
          4 Resist Paralysis@
          5 Regeneration@
          6 Irritation@
          7 Shock@
          8 Shield@
          9 Insanity@
          11 Dispell@  */

        if (((e[2]<=1) and (deck[hand[i]].addeffect=2)) or
           ((e[3]<=1) and (deck[hand[i]].addeffect=3)) or
           ((e[4]<=1) and (deck[hand[i]].addeffect=4)) or
           ((e[8]<=1) and (deck[hand[i]].addeffect=8)) or
           ((player.e[1]<=1) and (deck[hand[i]].addeffect=1)) or
           ((player.e[5]<=1) and (deck[hand[i]].addeffect=5)) or
           ((player.e[6]<=1) and (deck[hand[i]].addeffect=6)) or
           ((player.e[7]<=1) and (deck[hand[i]].addeffect=7)) or
           ((player.e[9]<=1) and (deck[hand[i]].addeffect=9)) or
           ((player.e[10]<=1) and (deck[hand[i]].addeffect=10))) or (((e[1]>=0) and (deck[hand[i]].addeffect=13))) then
        begin
          ctu:=i;
        end;



        if e[1]=0 then //<- ignore all if paralyzed
        begin

          //low health
          if hp<round(0.25*hpmax) then
          begin
            //not use card stealing health
            if ctu<>-1 then
            if deck[hand[i]].hpc>0 then
            begin
              ctu:=-1;
            end;

            //use healing
            if deck[hand[i]].addhp>0 then
            begin
              ctu:=i;
            end;
          end;

        end;

        //use whatever
        if ((Random(100)<10) and (ctu=-1)) or ((e[1]<>0) and (ctu=-1)) then
        begin
          if enemy.hp>0 then
          ctu:=i;
        end;

    end;


    if ctu<>-1 then done:=true;

    i:=i+1;

    if (i>5) and (done=false) then
    begin
      att:=att+1;
      if att>20 then done:=true;
      i:=0;
    end;

  until (done=true); end else ctu:=random(6);

  if ctu<>-1 then //got a card to use!
  begin
    //ShowMessage('card picked: '+inttostr(ctu) +' - this should be '+(deck[enemy.hand[ctu]].name)+'('+inttostr(enemy.hand[ctu])+')');
    UseCard(ctu,1,enemy,player);
    done:=true;
  end;   }

  ctu:=MonsterAI;

  if (ctu=-1) or (ctu>5) then //if for some reason no card was picked
  begin
    ctu:=random(6);
  end;

  UseCard(ctu,1,enemy,player);

  if enemy.e[7]>0 then  //enemy shock
  begin
    enemy.hp:=enemy.hp-enemy.estr[7];
    dp:=setupdp(strarr[375]);
    AddDmgPop(1,dp+inttostr(enemy.estr[7]),0);
    AddToBattleLog(strarr[240]+': '+inttostr(enemy.estr[7]));
  end;
  if enemy.e[10]>0 then   //enemy poison
  begin
    enemy.hp:=enemy.hp-enemy.e[10];
    dp:=setupdp(strarr[374]);
    AddDmgPop(1,dp+inttostr(player.e[10]),0);
    AddToBattleLog(strarr[239]+': '+inttostr(enemy.e[10]));
  end;

  //giving player some mana

  manb:=0;

  manb:=random(Round(player.magic/10));

  player.mana:=player.mana+manb;

  if player.e[14]>0 then
  begin
    manb:=manb+player.estr[14];
    player.mana:=player.mana+manb;
  end;

  if manb>0 then
  begin
    dp:=setupdp(strarr[377]);
    AddDmgPop(0,dp+'+'+inttostr(manb),2);
  end;

  if player.mana>player.manamax then player.mana:=player.manamax;

  Form1.VisualizeBattle(eno);

  pbt:=false;


end;


//MAIN GAME

procedure TForm1.AddXP(reason,amount:integer; var cta:character);
var s1,s2:string;
    sn:string;
    sl:integer;
    ram:integer;
    pebon:integer;
    infotext:string;
begin
  cta.xp:=cta.xp+amount;
  ram:=amount;
  pebon:=CheckCodedPerkEff(player,4);
  if pebon>0 then
  begin
    cta.xp:=cta.xp+round(0.1*amount);
    ram:=amount+round(0.1*amount*pebon);
  end;
  case reason of
  0:begin
      s1:=strarr[105]+': '+strarr[40]; //sword raised
      sn:=strarr[40];
      sl:=player.sword;
    end;
  1:begin
      s1:=strarr[106];
    end;
  2:begin
      s1:=strarr[107];
    end;
  3:begin
      s1:=strarr[105]+': '+strarr[41]; //bow raised
      sn:=strarr[41];
      sl:=player.bow;
    end;
  4:begin
      s1:=strarr[105]+': '+strarr[42]; //armor raised
      sn:=strarr[42];
      sl:=player.armor;
    end;
  5:begin
      s1:=strarr[105]+': '+strarr[43]; //magic raised
      sn:=strarr[43];
      sl:=player.magic;
    end;
  end;

  s2:=strarr[104]+': '+inttostr(amount);

  if (reason=0) or (reason=3) or (reason=4) or (reason=5) then
  begin
    s2:=strarr[104]+': '+inttostr(ram)+#10#13+sn+': '+inttostr(sl);
  end;

  ShowRequestForm(s1,s2,0,1,0,'');
end;



function TForm1.GetSets:integer;
var i:integer;
begin
  i:=-1;
  repeat
    i:=i+1;
  until (fileexists(gameexe+'\textures\'+qs+'\'+inttostr(i)+'\tex_0.tga')=false);
  result:=i;
end;


procedure TForm1.AddNewCard(sd:boolean;fc:integer;showpops:boolean;xpb:boolean;ignoremana:boolean;var plr:character);
var i,runs,gskill,gskilln:integer; done,hall:boolean;
    addedspell:integer;
    infotext:string;
begin
  //adds new card to spellbook
  //sd defines if governing skill will depend on card

  //first - defining if player has ALL cards
  if fc=-1 then
  begin

    hall:=true;
    for i:=0 to (totcards-1) do
    begin
      if plr.spellbook[i]=false then hall:=False;
    end;

    //getting governing skill
    gskilln:=0;
    if plr.sword>gskilln then begin gskill:=0; gskilln:=plr.sword; end;
    if plr.bow>gskilln then begin gskill:=1; gskilln:=plr.bow; end;
    if plr.magic>gskilln then begin gskill:=2; gskilln:=plr.magic; end;
    if plr.armor>gskilln then begin gskill:=3; gskilln:=plr.armor; end;

    //if player still has cards to get, then proceed
    if hall=false then
    begin
      i:=0;
      runs:=0;
      done:=false;

      //showmessage('looking for card. totcards='+inttostr(totcards));

      repeat

        if plr.spellbook[i]=false then
        begin

          if (deck[i].monly=false) then
          begin

            if (((gskill=deck[i].govskill) or (runs>1)) and (sd=true) and
                ((deck[i].mc<plr.manamax) or (ignoremana=true))) or
               ((Random(100)<10) and (sd=false)) then
            begin
              plr.spellbook[i]:=true;
              addedspell:=i;
              Done:=true;
            end;

          end;

        end;

        i:=i+1;

        if i>(totcards-1) then begin i:=0; runs:=runs+1; end;

        if (runs>500) then addedspell:=-1;

      until ((done=true) or (runs>500));

      lspellfound:=addedspell;

      if lspellfound<>-1 then
        spellfound.Material.LibMaterialName:='card_'+inttostr(addedspell)+'_0'
      else
      begin
        spellfound.Material.LibMaterialName:='card_xp';
        if xpb=true then
          AddXP(2,plr.lvl*levelsteps,plr);
      end;

    end;

  end
  else
  begin
    if plr.spellbook[fc]=false then
    begin
      plr.spellbook[fc]:=true;
      addedspell:=fc;
      lspellfound:=addedspell;
      spellfound.Material.LibMaterialName:='card_'+inttostr(addedspell)+'_0'
    end
    else
    begin
      spellfound.Material.LibMaterialName:='card_xp';
      if xpb=true then
        AddXP(2,plr.lvl*levelsteps,plr);
    end;
  end;
  infotext:=spellfound.Material.LibMaterialName;
  if showpops=true then
    ShowRequestForm(strarr[25],strarr[33],0,5,0,infotext);
end;

procedure TForm1.ResetStats;
var i:integer;
begin
  level:=0;
  with player do
  begin
    bstr:=10;
    bend:=10;
    bint:=10;
    bspd:=10;
    bsw:=10;
    bbw:=10;
    bar:=10;
    bmg:=10;
    bonuspoints:=0;
    perkpoints:=0;
    xp:=0;
    lvl:=1;
    xpreq:=1000;
    name:='Character';
    spec:=0;
    sex:=0;
    element:=0;
    for i:=0 to 1000 do
    begin
      player.spellbook[i]:=false;
      player.spellen[i]:=true;
    end;
    for i:=0 to 1000 do
    begin
      itms[i].count:=0;
    end;
    for i:=0 to 100 do
    begin
      player.perks[i]:=false;
    end;
    {perkpoints:=1;
    itms[0].count:=1;
    itms[4].count:=1;
    itms[5].count:=1;
    itms[8].count:=1;
    itms[17].count:=15;
    asword:=4;
    abow:=5;
    aarm:=8;
    player.spellbook[10]:=true;
    player.spellbook[7]:=true;
    player.spellbook[1]:=true;}
    skeys:=0;
    gkeys:=0;
    levelsteps:=0;
    level:=0;
    hpkept:=-1;
    mpkept:=-1;
    for i:=0 to 10 do battlelist[i]:=-2;

  end;

  for i:=0 to 1000 do
  begin
    iv[i]:=0;
    sv[i]:='';
  end;

  defineparbonuses;

end;


procedure TForm1.GoToStart;
begin
  plx:=spx;
  ply:=spy;
  lookside:=stdx;
end;


//procedure TForm1.Joystick1JoystickButtonChange(Sender: TObject;
//  JoyID: TJoystickID; Buttons: TJoystickButtons; XDeflection,
// YDeflection: Integer);
//begin
   //using joystick
//  if btlmode=false then
//  begin
    {if (jbButton1 in Joystick1.JoyButtons) then
    begin
      ActivateCell(plx+cdx,ply+cdy);
    end;

    if (jbButton2 in Joystick1.JoyButtons) then
    begin
      PlayerSearch(plx+cdx,ply+cdy);
    end;

    if (jbButton3 in Joystick1.JoyButtons) then
    begin
      OpenUI;
    end;  }

//  end;
//end;

{procedure TForm1.Joystick1JoystickMove(Sender: TObject; JoyID: TJoystickID;
  Buttons: TJoystickButtons; XDeflection, YDeflection: Integer);
begin
   //using joystick
  if btlmode=false then
  begin

    if Joystick1.XPosition<10 then
    begin
      PlayerTurn(-1);
    end;

    if Joystick1.XPosition>10 then
    begin
      PlayerTurn(1);
    end;

    if Joystick1.YPosition>0 then
    begin
      MovePlayer(cdx,cdy,random(100));
    end;

    if Joystick1.YPosition<0 then
    begin
      MovePlayer(cdx,cdy,random(100));
    end;

  end;
end;  }

procedure TForm1.PlayerSearch(x,y:integer);
var stxt:string;
begin

  //CELLSCRIPT
  if fileexists(gameexe+'\levels\'+mapid+'\sscript_'+inttostr(x)+'_'+inttostr(y)+'.txt') then
  begin
    Memo1.Lines.LoadFromFile(gameexe+'\levels\'+mapid+'\sscript_'+inttostr(x)+'_'+inttostr(y)+'.txt');
    stxt:=Memo1.Text;
    //ShowMessage('Reading script');
    stxt:=preparescript(stxt);
    readscript(stxt);
  end;

  //player searches for hidden items or explores cell

  if (nosearch=false) then
  with cells[x,y] do
  begin
    if trap=true then
    begin
      nosearch:=true;
      case traptype of
      0:begin
          nosearch:=false;
        end;
      1:begin
          ShowRequestForm(strarr[79],strarr[324],0,1,0,'');
        end;
      4:begin
          ShowRequestForm(strarr[79],strarr[325],0,1,0,'');
        end;
      5:begin
          ShowRequestForm(strarr[79],strarr[326],0,1,0,'');
        end;
      6:begin
          ShowRequestForm(strarr[79],strarr[327],0,1,0,'');
        end;
      8:begin
          ShowRequestForm(strarr[79],strarr[323],0,1,0,'');
        end;
      12:begin
          ShowRequestForm(strarr[79],strarr[328],0,1,0,'');
        end;
      13:begin
          ShowRequestForm(strarr[79],strarr[329],0,1,0,'');
        end;
      14:begin
          ShowRequestForm(strarr[79],strarr[330],0,1,0,'');
        end;
      16:begin
          ShowRequestForm(strarr[79],strarr[322],0,1,0,'');
         end;
      else
        begin
          ShowRequestForm(strarr[79],strarr[331],0,1,0,'');
        end;
      end;

    end;
  end;

  if nosearch=false then
  begin

  with cells[x,y] do
  begin

    if (wall=false) and (passable=true) then
    begin

      ShowRequestForm(strarr[79],strarr[80],0,1,0,'');

    end;

    if (wall=true) and (passable=false) then
    begin

      ShowRequestForm(strarr[79],strarr[81],
      0,1,0,'');

    end;

    if (wall=true) and (passable=true) then
    begin

      ShowRequestForm(strarr[79],strarr[82],
      0,1,0,'');

    end;

    if (door=true) and (passable=false) then
    begin

      if power=0 then
      ShowRequestForm(strarr[79],strarr[83],
      0,1,0,'');

      if power=1 then
      ShowRequestForm(strarr[79],strarr[84],
      0,1,0,'');

      if power=2 then
      ShowRequestForm(strarr[79],strarr[85],
      0,1,0,'');

    end;

    if (chest=true) and (passable=false) then
    begin

      if power=0 then
      ShowRequestForm(strarr[79],strarr[86],
      0,1,0,'');

      if power=1 then
      ShowRequestForm(strarr[79],strarr[87],
      0,1,0,'');

      if power=2 then
      ShowRequestForm(strarr[79],strarr[88],
      0,1,0,'');

    end;

  end;
  end
  else
  begin
    nosearch:=false;
  end;



end;


procedure TForm1.FullMBW(d:integer);
begin
  MonitorBlockVisibility(plx,ply,d,true);
end;


function TForm1.GetDist(x1,y1,x2,y2:integer):real;
begin
  result:=sqrt(sqr(x1-x2)+sqr(y1-y2));
end;

function tform1.checklsvisibility(x,y,lsx,lsy:integer):boolean;
var i,j,k:integer;
    xs,ys,gpx,gpy,gplsx,gplsy:integer;
    dx,dy,dt,kx,ky,rxs,rys:real;
    ikx,iky:integer;
    rs:boolean;
begin

  gpx:=round(x/20);
  gpy:=round(y/20);
  gplsx:=round(lsx/20);
  gplsy:=round(lsy/20);

  dx:=gplsx-gpx;
  dy:=gplsy-gpy;

  dt:=sqrt(sqr(dx)+sqr(dy));

  kx:=dx/dt; ky:=dy/dt;

  if kx<0 then ikx:=-1;
  if kx=0 then ikx:=0;
  if kx>0 then ikx:=1;

  i:=0; rxs:=gpx; rys:=gpy; rs:=true;
  repeat
    rxs:=rxs+kx;
    rys:=rys+ky;
    if ((cells[round(rxs),round(rys)].wall=true) and (cells[round(rxs),round(rys)].wco='')) or
       ((cells[round(rxs),round(rys)].door=true) and (cells[round(rxs),round(rys)].passable=false)) then
    begin
      rs:=false;
    end;
  until ((round(rxs)=gplsx) and (round(rys)=gplsy)) or ((rxs<0) or (rys<0) or (rxs>dw) or (rys>dh));

  result:=rs;
end;


procedure TForm1.ProcessLights;
var i,j,k:integer;
    cmin,cminid,min,gpx,gpy:integer;
    cud:real;
    notused,done:boolean;
    i1,i2,j1,j2:integer;
    lts:array[0..19]of integer;
    dst:array[0..19]of real;
begin

  //ShowMessage('proc lights');

  if nolights=false then
  begin

    for k:=0 to 19 do lts[k]:=k;

    gpx:=plx*20+10;
    gpy:=ply*20+10;
    min:=dw*40;


    repeat
      done:=true;
      for i:=0 to 18 do
      begin
        if (GetDist(gpx,gpy,visls[lts[i]].x,visls[lts[i]].y)>GetDist(gpx,gpy,visls[lts[i+1]].x,visls[lts[i+1]].y)) then
        begin
          k:=lts[i+1];
          lts[i+1]:=lts[i];
          lts[i]:=k;
          done:=false;
        end;
      end;
    until (done=true);

    for i:=0 to 6 do
    begin
     // if CheckLSVisibility(gpx,gpy,visls[lts[i]].x,visls[lts[i]].y)=true then
      begin
        with lsourc[i] do
        begin
          Shining:=visls[lts[i]].enabled;
          visible:=shining;

          ConstAttenuation:=    visls[lts[i]].ca;
          LinearAttenuation:=   visls[lts[i]].la;
          QuadraticAttenuation:=visls[lts[i]].qa;
          Ambient.Red:=         visls[lts[i]].amb_r;
          Ambient.Green:=       visls[lts[i]].amb_g;
          Ambient.Blue:=        visls[lts[i]].amb_b;
          Specular.Red:=        visls[lts[i]].spec_r;
          Specular.Green:=      visls[lts[i]].spec_g;
          Specular.Blue:=       visls[lts[i]].spec_b;
          Diffuse.Red:=         visls[lts[i]].diff_r;
          Diffuse.Green:=       visls[lts[i]].diff_g;
          Diffuse.Blue:=        visls[lts[i]].diff_b;
          Position.X:=          visls[lts[i]].x;
          Position.Y:=          visls[lts[i]].y;
          Position.Z:=          visls[lts[i]].z;
          SpotCutOff:=          visls[lts[i]].spotcutoff;
          SpotExponent:=        visls[lts[i]].spotexponent;
          SpotDirection.X:=     visls[lts[i]].sdx;
          SpotDirection.Y:=     visls[lts[i]].sdy;
          SpotDirection.Z:=     visls[lts[i]].sdz;

          if visls[lts[i]].stl=0 then LightStyle:=lsOmni else LightStyle:=lsSpot;

        end;
      end;
      {else
      begin
        with lsourc[i] do
        begin
          Shining:=FALSE;
          visible:=shining;
        end;
      end; }
    end;

  end;

end;

procedure TForm1.ProcessFreemeshBehaviour(dlt:real);
var i:integer;
    kx,ky,kz:integer;
    tx,ty,tz:integer;
    rollx,rolly,rollz:boolean;
    mxa,mma:integer;
    tlend:boolean;
    stxt:string;
begin

  for i:=0 to 200 do with gfreemesh[i] do if (enabled=true) and (bhv<>0) then
  begin

    tlend:=false;

    case bhv of

      1:begin

          if x<x2 then kx:=1 else kx:=-1;
          if x=x2 then kx:=0;

          if y<y2 then ky:=1 else ky:=-1;
          if y=y2 then ky:=0;

          if z<z2 then kz:=1 else kz:=-1;
          if z=z2 then kz:=0;

          if (kx=0) and (ky=0) and (kz=0) then
          begin
            if loop=true then
            begin
              tx:=x2; ty:=y2; tz:=z2;
              x2:=x1; y2:=y1; z2:=z1;
              x1:=tx; y1:=ty; z1:=tz;
            end else begin
              bhv:=0;
            end;

            tlend:=true;

          end
          else
          begin
            rx:=rx+kx*spd;
            ry:=ry+ky*spd;
            rz:=rz+kz*spd;
            x:=round(rx);
            y:=round(ry);
            z:=round(rz);
          end;

        end;

      2:begin

          {if loop=true then
          begin
            if ((x1=0) and (x2=360)) or ((x1=360) and (x2=0)) then rollx:=true else rollx:=false;
            if ((y1=0) and (y2=360)) or ((y1=360) and (y2=0)) then rolly:=true else rolly:=false;
            if ((z1=0) and (z2=360)) or ((z1=360) and (z2=0)) then rollz:=true else rollz:=false;
          end
          else}
          begin
            rollx:=false;
            rolly:=false;
            rollz:=false;
          end;

          if ta<x2 then kx:=1;
          if ta>x2 then kx:=-1;
          if ta=x2 then kx:=0;
          if ra<y2 then ky:=1;
          if ra>y2 then ky:=-1;
          if ra=y2 then ky:=0;
          if pa<z2 then kz:=1;
          if pa>z2 then kz:=-1;
          if pa=z2 then kz:=0;

          mma:=0; mxa:=360;

          {if (ta=mxa) and (rollx=true) and (kx=1) then begin ta:=mma; rta:=mma; end;
          if (ta=mma) and (rollx=true) and (kx=-1) then begin ta:=mxa; rta:=mxa; end;
          if (ra=mxa) and (rolly=true)and (ky=1) then begin ra:=mma; rra:=mma; end;
          if (ra=mma) and (rolly=true)and (ky=-1) then begin ra:=mxa; rra:=mxa; end;
          if (pa=mxa) and (rollz=true)and (kz=1) then begin pa:=mma; rpa:=mma; end;
          if (pa=mma) and (rollz=true)and (kz=-1) then begin pa:=mxa; rpa:=mxa; end;}

          if ((kx=0) and (ky=0) and (kz=0)) and (rollx=false) and (rolly=false) and (rollz=false) then
          begin
            if loop=true then begin
              tx:=x2; ty:=y2; tz:=z2;
              x2:=x1; y2:=y1; z2:=z1;
              x1:=tx; y1:=ty; z1:=tz;
            end else begin
              bhv:=0;
            end;

            tlend:=true;

          end
          else
          begin
            rta:=rta+kx*spd;
            rra:=rra+ky*spd;
            rpa:=rpa+kz*spd;
          end;

          if rta>360 then rta:=0;
          if rra>360 then rra:=0;
          if rpa>360 then rpa:=0;
          if rta<0 then rta:=360;
          if rra<0 then rra:=360;
          if rpa<0 then rpa:=360;

          ta:=round(rta);
          ra:=round(rra);
          pa:=round(rpa);

        end;

      end;

      if tlend=true then
      begin
        //CELLSCRIPT
        if fileexists(gameexe+'\scripts\'+trscript+'.txt')=true then
        begin
          Memo1.Lines.LoadFromFile(gameexe+'\scripts\'+trscript+'.txt');
          stxt:=Memo1.Text;
          //ShowMessage('Reading script');
          stxt:=preparescript(stxt);
          readscript(stxt);
        end;

    end;

    ModFreeMesh(i);

  end;
end;


procedure TForm1.MonitorBlockVisibility(px,py,d:integer;full:boolean);
var i,j,k:integer;
    x1,x2,y1,y2:integer;
    cmin,cminid,min,gpx,gpy:integer;
    cd:real;
    notused:boolean;
    i1,i2,j1,j2:integer;
    lts:array[0..6]of integer;
begin
  try

  with cells[plx,ply] do
  begin
    if (outdoors=true) and (skybox<>0) then GLSkyBox1.Visible:=true
    else GLSkyBox1.Visible:=false;
  end;

  if full=false then
  begin
    x1:=px-mbd;
    y1:=py-mbd;
    x2:=px+mbd;
    y2:=py+mbd;
    if x1<0 then i1:=0 else i1:=x1;
    if x2>dw then i2:=dw else i2:=x2;
    if y1<0 then j1:=0 else j1:=y1;
    if y2>dh then j2:=dh else j2:=y2;
  end;

  if full=true then
  begin
    i1:=0; i2:=dw;
    j1:=0; j2:=dh;
  end;

  for i:=i1 to i2 do
  for j:=j1 to j2 do
  begin

    //hiding walls
    if cells[i,j].wall=true then
    begin
      if (i>(plx-d)) and (i<(plx+d)) and (j>(ply-d)) and (j<(ply+d)) then
        wall[i,j].Visible:=true
      else
        wall[i,j].Visible:=false;
    end;

    //hiding doors
    if (cells[i,j].door=true) and (cells[i,j].passable=false) then
    begin
      if (i>(plx-d)) and (i<(plx+d)) and (j>(ply-d)) and (j<(ply+d)) then
        door[i,j].Visible:=true
      else
        door[i,j].Visible:=false;
    end;

    if (cells[i,j].door=true) and (cells[i,j].passable=true) then
    begin
      if cells[i,j].door3d=false then
        door[i,j].Visible:=false;
    end;

    //hiding chests
    if (cells[i,j].chest=true) and (cells[i,j].passable=false) then
    begin
      if (i>(plx-d)) and (i<(plx+d)) and (j>(ply-d)) and (j<(ply+d)) then
        chest[i,j].Visible:=true
      else
        chest[i,j].Visible:=false;
      chest[i,j].Direction.X:=-cdx;
      chest[i,j].Direction.Y:=-cdy;
      chest[i,j].Direction.Z:=0;
      chest[i,j].Up.Z:=1;
      chest[i,j].Up.Y:=0;
      chest[i,j].Up.X:=0;
    end;

    if (cells[i,j].chest=true) and (cells[i,j].passable=true) then
    begin
      chest[i,j].Visible:=false;
    end;

    //hiding floor and ceiling
    if cells[i,j].ceil=true then
    begin
      if (i>(plx-d)) and (i<(plx+d)) and (j>(ply-d)) and (j<(ply+d)) then
      begin
        ceil[i,j].Visible:=true;
      end
      else
      begin
        ceil[i,j].Visible:=false;
      end;
    end;
    if cells[i,j].floor=true then
    begin
      if (i>(plx-d)) and (i<(plx+d)) and (j>(ply-d)) and (j<(ply+d)) then
      begin
        floor[i,j].Visible:=true;
      end
      else
      begin
        floor[i,j].Visible:=false;
      end;
    end;

    //hiding sprites
    if cells[i,j].spritename<>'0' then
    begin
      if (i>(plx-d)) and (i<(plx+d)) and (j>(ply-d)) and (j<(ply+d)) then
        sprite[i,j].Visible:=true
      else
        sprite[i,j].Visible:=false;
      sprite[i,j].Direction.X:=-cdx;
      sprite[i,j].Direction.Y:=-cdy;
      sprite[i,j].Direction.Z:=0;
      sprite[i,j].Up.Z:=1;
      sprite[i,j].Up.Y:=0;
      sprite[i,j].Up.X:=0;
    end;

    //hiding grass
    if (cells[i,j].grass=true) and (cells[i,j].dens>0) and (nograss=false) then
    begin
      if (i>(plx-d)) and (i<(plx+d)) and (j>(ply-d)) and (j<(ply+d)) then
      begin
        for k:=0 to cells[i,j].dens-1 do
        begin
          grasssprite[i,j,k].Visible:=true;
        end
      end
      else
      begin
        for k:=0 to cells[i,j].dens-1 do
        begin
          grasssprite[i,j,k].Visible:=false;
        end
      end;
    end;

    {with GLShadowVolume1.Occluders do
    begin
      Clear;
      try AddCaster(floor[i,j]); except end;
      try AddCaster(wall[i,j]); except end;
      try AddCaster(ceil[i,j]); except end;
    end;}

  end;

  for i:=0 to 200 do
  begin

    //freemesh processing
    if gfreemesh[i].enabled=true then
    begin
      if (gfreemesh[i].x>(plx*20-d*20)) and (gfreemesh[i].x<(plx*20+d*20)) and
         (gfreemesh[i].y>(ply*20-d*20)) and (gfreemesh[i].y<(ply*20+d*20)) then
      begin
        fmesh[i].Visible:=true;
      end
      else
      begin
        fmesh[i].Visible:=false;
      end;
    end;

    //freesprite processing
    if (gfreesprite[i].enabled=true) then
    begin

      if (gfreesprite[i].x>(plx*20-d*20)) and (gfreesprite[i].x<(plx*20+d*20)) and
         (gfreesprite[i].y>(ply*20-d*20)) and (gfreesprite[i].y<(ply*20+d*20)) then
      begin
        fsprite[i].Visible:=true;
      end
      else
      begin
        fsprite[i].Visible:=false;
      end;

      if fsprite[i].Visible=true then
      begin
        OrientFSprite(i);
      end;

    end;

  end;

  except
    BuildLevel;
  end;

end;

procedure TForm1.OrientFSprite(id:integer);
begin
  with fsprite[id] do
  begin
    if gfreesprite[id].fixed=false then
    begin
      Direction.X:=-cdx;
      Direction.Y:=-cdy;
      Direction.Z:=0;
    end
    else
    begin
      Direction.X:=gfreesprite[id].dirx;
      Direction.Y:=gfreesprite[id].diry;
      Direction.Z:=0;
    end;
    Up.Z:=1;
    Up.Y:=0;
    Up.X:=0;
  end;
end;

function TForm1.FindNextSpell(searchcstart:integer;ch:character):integer;
var i,att:integer;
begin
  i:=searchcstart;
  att:=0;
  repeat
    i:=i+1;
    if i>(totcards-1) then i:=0;
    if i=0 then att:=att+1;
  until (ch.spellbook[i]=true) or (att>100);
  result:=i;
end;

function TForm1.preparerftext(txt:string):string;
var p_i,p_sm,p_cs,p_l:integer; p_ttr,p_kw,p_stx,p_ot,p_sts:string; p_isk:boolean;
begin
  //reads text and replaces special symbols with required ones

  //ShowMessage('Text to process: '+txt);

  if txt<>'' then
  begin

    //ShowMessage('Text is fine...');

    p_l:=length(txt);
    p_stx:='';
    p_ttr:=txt;
    p_sm:=0;
    p_i:=0;

    repeat

      p_i:=p_i+1;
      p_kw:='';

      if p_ttr[p_i]='@' then
      begin
        //checking keyword

        //ShowMessage('Keyword symbol');

        p_sm:=0;
        p_cs:=0;

        repeat

          if (((p_ttr[p_i+p_sm]=' ') or (p_ttr[p_i+p_sm]=',') or (p_ttr[p_i+p_sm]=';') or
               (p_ttr[p_i+p_sm]=':') or (p_ttr[p_i+p_sm]='"') or (p_ttr[p_i+p_sm]='`') or
               (p_ttr[p_i+p_sm]='*') or (p_ttr[p_i+p_sm]='!') or (p_ttr[p_i+p_sm]='@') or
               (p_ttr[p_i+p_sm]='#') or (p_ttr[p_i+p_sm]='$') or (p_ttr[p_i+p_sm]='%') or
               (p_ttr[p_i+p_sm]='^') or (p_ttr[p_i+p_sm]='&') or (p_ttr[p_i+p_sm]='*') or
               (p_ttr[p_i+p_sm]='(') or (p_ttr[p_i+p_sm]=')') or (p_ttr[p_i+p_sm]='-') or
               (p_ttr[p_i+p_sm]='_') or (p_ttr[p_i+p_sm]='+') or (p_ttr[p_i+p_sm]='=') or
               (p_ttr[p_i+p_sm]='|') or (p_ttr[p_i+p_sm]='/') or (p_ttr[p_i+p_sm]='?') or
               (p_ttr[p_i+p_sm]='\') or (p_ttr[p_i+p_sm]='.') or ((p_i+p_sm)>=p_l))) and
               (p_sm>0) then
          begin
            p_isk:=true;
            p_sts:=p_ttr[p_i+p_sm];
          end
          else
          begin
            p_kw:=p_kw+p_ttr[p_i+p_sm];
            p_isk:=false;
            p_sm:=p_sm+1;
          end;

        until (p_isk=true);

        if p_kw='@PlName' then
        begin
          p_cs:=1;
        end;

        //keyword cases
        //1 - player ame
        //0 - no actual keyword found
        case p_cs of
        1:begin
            p_ot:=player.name+p_sts;
          end;
        0:begin
            p_ot:=p_kw+p_sts;
          end;
        end;

        p_i:=p_i+P_sm;

      end
      else
      begin
        p_ot:=p_ttr[p_i];
      end;

      //ShowMessage('Added block: '+ot);

      p_stx:=p_stx+p_ot;

    until (p_i>=p_l);

  end
  else
  begin
    p_stx:='';
  end;

  result:=p_stx;


end;


procedure TForm1.ShowRequestForm(rttl,rtext:string;rtype,rcase,rpos:integer; rimg:string);
var i:integer;
    tt:string;
begin

  //showing rf

  //cases:
  //5 - show discovered spell

  i:=0;
  repeat
    i:=i+1;
  until (rqfpool[i].active=false);

  with rqfpool[i] do
  begin
    active:=true;
    ttl_text:=rttl;
    main_text:=rtext;
    fcase:=rcase;
    tp:=rtype;
    pos:=rpos;
    img:=rimg;
  end;

end;

procedure TForm1.DisplayRequestForm;
var i:integer;
begin

  //displaying first form in stack
  reqform.MoveLast;
  rqform:=true;
  with rqfpool[1] do
  begin
    rf_ttl_text:=ttl_text;
    rf_main_text:=preparerftext(main_text);
    rf_case:=fcase;
    rf_type:=tp;
    rf_pos:=pos;
    rf_img:=img;
  end;

  ////moving stack for one step
  i:=0;
  repeat
    i:=i+1;
    with rqfpool[i] do
    begin
      ttl_text:=rqfpool[i+1].ttl_text;
      main_text:=rqfpool[i+1].main_text;
      fcase:=rqfpool[i+1].fcase;
      tp:=rqfpool[i+1].tp;
      pos:=rqfpool[i+1].pos;
      active:=rqfpool[i+1].active;
      img:=rqfpool[i+1].img;
    end;
  until (rqfpool[i].active=false);


end;

procedure TForm1.InventoryButtonClick(t:integer);
begin
  //click on button 33, 34 or 35 - inventory item
  if (t=-1) or (t=1) then
  begin
    repeat
      pitem:=pitem+t;
      if pitem<0 then pitem:=totitems;
      if pitem>(totitems-1) then pitem:=0;
    until (itms[pitem].count>0);
  end;
  if t=0 then
  begin
    if (usepitem=false) then usepitem:=true else usepitem:=false;
    if (itms[pitem].itmtype<>0) then
    begin
      if itms[pitem].itmtype=1 then asword:=pitem;
      if itms[pitem].itmtype=2 then abow:=pitem;
      if itms[pitem].itmtype=3 then aarm:=pitem;
      if itms[pitem].itmtype=4 then ahat:=pitem;
      intren:=true;
    end;
  end;
end;


procedure TForm1.PlayerDrawCard(n:integer);
begin
  UseCard(n,0,player,enemy);
  if keepturn=false then
  begin
    turn:=turn+1;
  end
  else
  begin
    keepturn:=false;
  end;
  ia:=false;
end;

procedure TForm1.SkipTurn;
begin
  if (turn=0) and (player.speed>=35) and (skipped=false) then
  begin
    ShuffleHand(player,true);
    keepturn:=true;
    skipped:=true;
  end;

  if keepturn=false then
  begin
    turn:=turn+1;
    skipped:=false;
  end
  else
  begin
    keepturn:=false;
  end;

  ia:=false;
end;


procedure TForm1.ToggleSpell(sts:integer);
var hes,tots,ii:integer;
begin
  if player.spellen[sts]=false then
    player.spellen[sts]:=true  //turning spell on
  else
  begin
    hes:=0; tots:=0;
    for ii:=0 to 1000 do
    begin
      if (player.spellbook[ii]=true) and (player.spellen[ii]=true) then hes:=hes+1;
      if player.spellbook[ii]=true then tots:=tots+1;
    end;
    //showmessage(inttostr(hes)+'/'+inttostr(tots)+'='+floattostr(hes/tots));
    if (hes/tots)>0.34 then player.spellen[sts]:=false else ShowRequestForm(strarr[283],strarr[284],0,1,0,'');
    //turning spell off if it's not less then 1/3 is active
  end;
end;


function TForm1.CheckJournalUnlocked(j:integer):boolean;
var n,i:integer;
    d:boolean;
begin
  d:=false;
  n:=Length(jseq);
  for i:=0 to (n-1) do
  begin
    if jseq[i]=j then d:=true;
  end;
  Result:=d;
end;


procedure TForm1.UpdateJournal(j:integer);
var n,i:integer;
    d:boolean;
begin

  d:=CheckJournalUnlocked(j);
  n:=Length(jseq);

  if d=false then
  begin
    SetLength(jseq,n+1);
    jseq[n]:=j;
    //Showmessage('n='+inttostr(n)+'; j='+inttostr(j));
    ShowRequestForm(strarr[389],strarr[390],0,1,0,'');
  end;

end;



procedure TForm1.StartNewGame;
begin
  ClearJournal;
  chargen:=false;
  Form2.LoadMap(gameexe+'\levels\startmap.map');
  level:=-1;
  BuildLevel;
  GoToStart;
  ActivateCell(17,9);
end;


procedure TForm1.ChangeLevelNormally;
begin
  ChangeLevel(0,'');
end;



procedure TForm1.ChangeLevel(way:integer;param:string);
var ltg:string;
begin
  level:=level+1;

  if way<>0 then ltg:=param else ltg:='map_'+inttostr(level);

  if (FileExists(gameexe+'\levels\'+ltg+'.map')=true) and (randommode=false) then
  begin
    Form2.LoadMap(gameexe+'\levels\'+ltg+'.map');
  end
  else
  begin
    Form1.RandomMap;
  end;
  levelsteps:=0;
  Form1.BuildLevel;
  Form1.GoToStart;
  if hardcore=true then SaveGame;
  ProcessLights;
end;

procedure TForm1.NGLaunch;
var stxt:string;
begin
  gmmode:=true;
  chargen:=true;
  invmode:=true;
  intren:=true;
  mmmode:=false;
  ResetStats;
  if (fileexists(gameexe+'\scripts\startscript.txt')=true) and (loadinprogress=false) then
  begin
    Memo1.Lines.LoadFromFile(gameexe+'\scripts\startscript.txt');
    stxt:=Memo1.Text;
    stxt:=preparescript(stxt);
    readscript(stxt);
  end;
  ShowRequestForm(strarr[89],'',0,0,0,'');
end;

procedure TForm1.ClearJournal;
begin
  SetLength(jseq,1);
  jseq[0]:=0;
end;

function GetQJText(jid:integer):string;
var ftx,tx:string;
begin
  Form1.Memo1.Lines.LoadFromFile(gameexe+'\text\'+lang+'\journal\jrn_'+inttostr(jid)+'.txt');
  tx:=Form1.Memo1.Text;
  result:=tx;
end;

procedure TForm1.LoadGame;
var i:integer;
begin
  cleargslist;
  with form2 do
  begin
    LoadMap(gameexe+'\saves\saved.map');
    player:=LoadChar(gameexe+'\saves\chsave1.sav');
    LoadJSeq(gameexe+'\saves\jseq.txt');
    cleargslist;
    try LoadGS(gameexe+'\saves\gslist.txt'); except end;
    LoadPlayer(gameexe+'\saves\chsave2.sav');
    form2.LoadSavedLight;
    defineparbonuses;
    gmmode:=true;
    mmmode:=false;
    btlmode:=false;
    for i:=0 to 10 do battlelist[i]:=-2;
    hpkept:=-1;
    mpkept:=-1;
    BuildLevel;
  end;
end;

procedure TForm1.ChangeJPage(k:integer);
begin
  jspos:=jspos+k;
  if (k<0) and (jspos<0) then
  begin
    jspos:=Length(jseq)-1;
  end;
  if (k>0) and (jspos>Length(jseq)-1) then
  begin
    jspos:=0;
  end;
  OpenJPos(jspos);
end;

procedure TForm1.OpenJPos(jpage:integer);
var qjtext:string;
begin
  qjtext:=GetQJText(jseq[jpage]);
  qjtext:=strarr[391]+' '+inttostr(jpage+1)+'/'+IntToStr(length(jseq))+#13#10+#13#10+qjtext;
  ShowRequestForm(strarr[389],qjtext,1,44,0,'');
end;


procedure TForm1.ClickGButton(id:integer);
var pni,ii,hes:integer;
    fpn,qjtext,stxt:string;
begin

  if (rqform=false) or (id=40) or (id=41) or (id=42) or (id=43) or (id=44)
      or (id=45) or (id=48) or (id=49) or (id=55) or (id=56) or (id=57) or (id=58) then

  case id of
  0:begin
      OpenUI(false);
      if chargen=true then
      begin
        StartNewGame;
      end;
      if (btlmode=true) and (invmode=false) then VisualizeBattle(eno);
    end;
  1:begin
      if player.bonuspoints>0 then
      begin
        player.bonuspoints:=player.bonuspoints-1;
        player.bstr:=player.bstr+1;
        intren:=true;
      end;
    end;
  2:begin
      if player.bonuspoints>0 then
      begin
        player.bonuspoints:=player.bonuspoints-1;
        player.bint:=player.bint+1;
        intren:=true;
      end;
    end;
  3:begin
      if player.bonuspoints>0 then
      begin
        player.bonuspoints:=player.bonuspoints-1;
        player.bspd:=player.bspd+1;
        intren:=true;
      end;
    end;
  4:begin
      if player.bonuspoints>0 then
      begin
        player.bonuspoints:=player.bonuspoints-1;
        player.bend:=player.bend+1;
        intren:=true;
      end;
    end;
  5:begin
      PlayerSearch(plx+cdx,ply+cdy);
    end;
  6:begin
      ActivateCell(plx+cdx,ply+cdy);
    end;
  7:begin
      OpenUI(false);
    end;
  51:begin
      ToggleMenu;
    end;
  52:begin
      ToggleMenu;
    end;
  //perks
  8:begin
      currperk:=GetNextEnabledPerk(1);
      intren:=true;
    end;
  9:begin
      currperk:=GetNextEnabledPerk(-1);
      intren:=true;
    end;
  18:begin
       if (perkpoints>0) and (player.perks[perklist[currperk]]=false) then
       begin
         if checkperkrq(perklist[currperk])=true then
         begin
           player.perks[perklist[currperk]]:=true;
           perkpoints:=perkpoints-1;

           if bperks[perklist[currperk]].addcard<>-1 then
           begin
             AddNewCard(true,bperks[perklist[currperk]].addcard,true,false,false,player);
             //ShowRequestForm(strarr[25],strarr[33],0,5,0,'');
           end;

         end
         else
         begin
           ShowRequestForm(strarr[183],strarr[175],0,1,0,'');
         end;
       end
       else
       begin
         if (player.perks[perklist[currperk]]=false) then
         begin //ShowMessage(strarr[171]);
           ShowRequestForm(strarr[352],strarr[171],0,1,0,'');
         end;
       end;
       intren:=true;
     end;
  19:begin
       if showperks=false then showperks:=true else showperks:=false;
       genperklist;
       intren:=true;
     end;
  //end perks
  48:begin
      //rqform OK

      //just OK
      if rf_case=0 then
      begin

        //0 - entering player name
        fpn:='';
        ii:=Length(rf_main_text);

        if ii>0 then
        for pni:=1 to (ii) do
        begin
          if (rf_main_text[pni]<>#10) and (rf_main_text[pni]<>#13) then fpn:=fpn+rf_main_text[pni];
        end;

        player.name:=fpn;
        intren:=true;
      end;

      //1 and 2 - simple closing the form

      //3 - wanna next level
      if rf_case=3 then
      begin
        ChangeLevelNormally;
      end;

      //20 - wanna be an angel
      if rf_case=20 then
      begin
        player.bint:=player.bint+20;
        player.spec:=1;
        ShowRequestForm(strarr[98],strarr[102],0,1,0,'');
      end;
      //21 - wanna be a demon
      if rf_case=21 then
      begin
        player.bstr:=player.bstr+20;
        player.spec:=2;
        ShowRequestForm(strarr[98],strarr[102],0,1,0,'');
      end;
      //22 - wanna be an undead
      if rf_case=22 then
      begin
        player.bend:=player.bend+20;
        player.spec:=3;
        ShowRequestForm(strarr[98],strarr[102],0,1,0,'');
      end;

      if rf_case=30 then
      begin
        ExitGame;
      end;

      if rf_case=39 then
      begin
        player.element:=0;
        ShowRequestForm(strarr[363],strarr[361]+' '+GetElName(player.element,strarr)+'.',0,1,0,'');
      end;

      if rf_case=40 then
      begin
        player.element:=1;
        ShowRequestForm(strarr[363],strarr[361]+' '+GetElName(player.element,strarr)+'.',0,1,0,'');
      end;

      if rf_case=41 then
      begin
        player.element:=2;
        ShowRequestForm(strarr[363],strarr[361]+' '+GetElName(player.element,strarr)+'.',0,1,0,'');
      end;

      if rf_case=42 then
      begin
        player.element:=3;
        ShowRequestForm(strarr[363],strarr[361]+' '+GetElName(player.element,strarr)+'.',0,1,0,'');
      end;

      if rf_case=43 then
      begin
        player.element:=4;
        ShowRequestForm(strarr[363],strarr[361]+' '+GetElName(player.element,strarr)+'.',0,1,0,'');
      end;

      if rf_case=44 then
      begin
        OpenJPos(jspos);
      end;

      rqform:=false;
    end;
  {journal}
  54:begin
       //open journal
       jspos:=0;
       OpenJPos(jspos);
     end;
  55:begin
       //next jrn page
       ChangeJPage(1);
       rqform:=false;
     end;
  56:begin
       //prev jrn page
       ChangeJPage(-1);
       rqform:=false;
     end;
  57:begin
       //next jrn page
       ChangeJPage(10);
       rqform:=false;
     end;
  58:begin
       //prev jrn page
       ChangeJPage(-10);
       rqform:=false;
     end;
  {end journal}
  49:begin
       //rqform CANCEL
       rqform:=false;
     end;
  10:BEGIN
       PlayerDrawCard(0);
       //MonsterTurn;
     END;
  11:BEGIN
      PlayerDrawCard(1);
       //MonsterTurn;
     END;
  12:BEGIN
       PlayerDrawCard(2);
       //MonsterTurn;
     END;
  13:BEGIN
       PlayerDrawCard(3);
       //MonsterTurn;
     END;
  14:BEGIN
       PlayerDrawCard(4);
       //MonsterTurn;
     END;
  15:BEGIN
       PlayerDrawCard(5);
       //MonsterTurn;
     END;
  53:BEGIN
       if dcrec=0 then
       begin
         PlayerDrawCard(6); //<-FIGHTING DISC (cpe=18)
         dcrec:=4-Round(player.intelligence/100);
       end
       else
       begin
         ShowRequestForm(strarr[370],strarr[371]+' '+IntToStr(dcrec),0,1,0,'');
       end;
       //MonsterTurn;
     END;
  16:begin
       SkipTurn;
       //MonsterTurn;
     end;
   17:begin
       //retreat button
       TryToEscape;
       if keepturn=false then
       begin
         turn:=turn+1;
       end
       else
       begin
         keepturn:=false;
       end;
     end;
  20:begin
       NGLaunch;
     end;
  21:begin
       LoadGame;
     end;
  22:begin
       {try Form15.GLFullScreenViewer1.Active:=false except end;
       Application.Terminate;}
       if fullscreen=false then
       begin
         Form1.Close;
       end
       else
       begin
         ShowRequestForm('',strarr[345],1,30,0,'');
       end;
       //Halt(0);
     end;
  23:begin
       player.face:=0;
       player.hair:=0;
       player.sex:=0;
       player.cloth:=0;
       intren:=true;
     end;
  24:begin
       player.face:=0;
       player.hair:=0;
       player.sex:=1;
       player.cloth:=0;
       intren:=true;
     end;
  25:begin
       player.hair:=player.hair+1;
       if player.sex=0 then
       begin
         if player.hair>(maxhairm-1) then player.hair:=0;
       end
       else
       begin
         if player.hair>(maxhairf-1) then player.hair:=0;
       end;
       intren:=true;
     end;
  26:begin
       player.face:=player.face+1;
       if player.sex=0 then
       begin
         if player.face>(maxheadsm-1) then player.face:=0;
       end
       else
         if player.face>(maxheadsf-1) then player.face:=0;
       intren:=true;
     end;
  27:begin
       {player.cloth:=player.cloth+1;
       if player.sex=0 then
       begin
         if player.cloth>(maxclothm-1) then player.cloth:=0;
       end
       else
         if player.cloth>(maxclothf-1) then player.cloth:=0;
       intren:=true;}
     end;
  28:begin
       if hardcore=false then
         SaveGame
       else
         ShowRequestForm(strarr[305],strarr[306],0,1,0,'');
     end;
  29:begin
       showspell:=false;
       SetupItemList;
       itemlistmode:=true;
       invmode:=false;
     end;
  47:begin
       showspell:=true;
       SetupItemList;
       itemlistmode:=true;
       invmode:=false;
     end;
  50:begin
       itemlistmode:=false;
       invmode:=true;
       intren:=true;
     end;
  38:begin
       ilpage:=ilpage-1;
       if ilpage<0 then ilpage:=9;
       SetupItemList;
     end;
  39:begin
       ilpage:=ilpage+1;
       if ilpage>9 then ilpage:=0;
       SetupItemList;
     end;
  30:begin
       if showenemy=false then
       begin
         spelltosee:=FindNextSpell(spelltosee,player)
       end
       else
       begin
         spelltosee:=FindNextSpell(spelltosee,enemy)
       end;
       gbtnv[30].matoverride:='card_'+inttostr(spelltosee)+'_';
       //ShowMessage('spelltosee='+inttostr(spelltosee)+'/'+inttostr(totcards-1));
       intren:=true;
     end;
  31:begin
       showenemy:=true;
       OpenUI(showenemy);
     end;
  32:begin
       Form5.Show;
     end;
  33:begin
       InventoryButtonClick(-1);
       usepitem:=false;
       intren:=true;
     end;
  34:begin
       InventoryButtonClick(0);
     end;
  35:begin
       InventoryButtonClick(1);
       usepitem:=false;
       intren:=true;
     end;
  36:begin
       Form2.Show;
     end;
  37:begin
       //rename the character
       ShowRequestForm(strarr[89],'',0,0,0,'');
     end;
  //CHOICE SECTION
  40:begin
       //choice
       bchoice:=0;
       rqform:=false;
       //RUNNING CARD SCRIPT
       //ShowMessage('Attemptig to run script: '+gameexe+'\scripts\'+afterch+'.txt');
       if fileexists(gameexe+'\scripts\'+afterch+'.txt')=true then
       begin
         Memo1.Lines.LoadFromFile(gameexe+'\scripts\'+afterch+'.txt');
         stxt:=Memo1.Text;
         //ShowMessage('Reading script');
         stxt:=preparescript(stxt);
         readscript(stxt);
       end;
     end;
  41:begin
       //choice
       bchoice:=1;
       rqform:=false;
       //RUNNING CARD SCRIPT
       if fileexists(gameexe+'\scripts\'+afterch+'.txt')=true then
       begin
         Memo1.Lines.LoadFromFile(gameexe+'\scripts\'+afterch+'.txt');
         stxt:=Memo1.Text;
         //ShowMessage('Reading script');
         stxt:=preparescript(stxt);
         readscript(stxt);
       end;
     end;
  42:begin
       //choice
       bchoice:=2;
       rqform:=false;
       //RUNNING CARD SCRIPT
       if fileexists(gameexe+'\scripts\'+afterch+'.txt')=true then
       begin
         Memo1.Lines.LoadFromFile(gameexe+'\scripts\'+afterch+'.txt');
         stxt:=Memo1.Text;
         //ShowMessage('Reading script');
         stxt:=preparescript(stxt);
         readscript(stxt);
       end;
     end;
  43:begin
       //choice
       bchoice:=3;
       rqform:=false;
       //RUNNING CARD SCRIPT
       if fileexists(gameexe+'\scripts\'+afterch+'.txt')=true then
       begin
         Memo1.Lines.LoadFromFile(gameexe+'\scripts\'+afterch+'.txt');
         stxt:=Memo1.Text;
         //ShowMessage('Reading script');
         stxt:=preparescript(stxt);
         readscript(stxt);
       end;
     end;
  44:begin
       //choice
       bchoice:=4;
       rqform:=false;
       //RUNNING CARD SCRIPT
       if fileexists(gameexe+'\scripts\'+afterch+'.txt')=true then
       begin
         Memo1.Lines.LoadFromFile(gameexe+'\scripts\'+afterch+'.txt');
         stxt:=Memo1.Text;
         //ShowMessage('Reading script');
         stxt:=preparescript(stxt);
         readscript(stxt);
       end;
     end;
  45:begin
       //choice
       bchoice:=5;
       rqform:=false;
       //RUNNING CARD SCRIPT
       if fileexists(gameexe+'\scripts\'+afterch+'.txt')=true then
       begin
         Memo1.Lines.LoadFromFile(gameexe+'\scripts\'+afterch+'.txt');
         stxt:=Memo1.Text;
         //ShowMessage('Reading script');
         stxt:=preparescript(stxt);
         readscript(stxt);
       end;
     end;
  46:begin

       //enable/disable spell

       ToggleSpell(spelltosee);

     end;

  end
  else
  begin

  end;
  if id<>-1 then
  begin
    gbtnv[id].state:=0;
  end;
end;

procedure TForm1.definebutsets;
var i:integer;
begin
  //preparing button sets
  for i:=0 to mb do
  begin
    imbutset[i]:=false;
    mmbutset[i]:=false;
    gmbutset[i]:=false;
  end;
  //inventory mode buttons
  imbutset[0]:=true;
  imbutset[1]:=true;
  imbutset[2]:=true;
  imbutset[3]:=true;
  imbutset[4]:=true;
  imbutset[30]:=true;
  imbutset[33]:=true;
  imbutset[34]:=true;
  imbutset[35]:=true;
  imbutset[37]:=true;
  imbutset[19]:=true;
  imbutset[29]:=true;

  //main menu buttons
  mmbutset[20]:=true;
  mmbutset[21]:=true;
  mmbutset[22]:=true;
  mmbutset[32]:=true;
  mmbutset[36]:=true;
  mmbutset[52]:=true;

  //game mode buttons
  gmbutset[5]:=true;
  gmbutset[6]:=true;
  gmbutset[7]:=true;
  gmbutset[28]:=true;
  gmbutset[51]:=true;
  gmbutset[54]:=true;

  //setting up buttons
  with gbtnv[0] do
  begin
    w:=90;
    h:=25;
    x:=round(csbackground.Position.X+csbackground.Width/2-w/2-5);
    y:=round(csbackground.Position.Y-csbackground.Height/2+h);
    caption:=strarr[0];
    matoverride:='';
    matname:='none';
  end;

  with gbtnv[37] do
  begin
    //rename character
    x:=5;
    y:=round(char_name.Position.Y);
    w:=25;
    h:=25;
    caption:=strarr[145];
    matoverride:='';
    matname:='none';
  end;


  with gbtnv[1] do
  begin
    //raise str
    x:=300;
    y:=100;
    w:=25;
    h:=25;
    caption:='+';
    matoverride:='';
    matname:='none';
    tooltip:=strarr[262];
  end;

  with gbtnv[2] do
  begin
    //raise int
    x:=300;
    y:=130;
    w:=25;
    h:=25;
    caption:='+';
    matoverride:='';
    matname:='none';
    tooltip:=strarr[262];
  end;

  with gbtnv[3] do
  begin
    //raise spd
    x:=300;
    y:=160;
    w:=25;
    h:=25;
    caption:='+';
    matoverride:='';
    matname:='none';
    tooltip:=strarr[262];
  end;

  with gbtnv[4] do
  begin
    //raise end
    x:=300;
    y:=190;
    w:=25;
    h:=25;
    caption:='+';
    matoverride:='';
    matname:='none';
    tooltip:=strarr[262];
  end;

  with gbtnv[5] do
  begin
    //search
    x:=20;
    y:=20;
    w:=32;
    h:=32;
    caption:='';
    matoverride:='search_';
    matname:='none';
    tooltip:=strarr[263];
  end;

  with gbtnv[6] do
  begin
    //use (VK_SPACE)
    x:=60;
    y:=20;
    w:=32;
    h:=32;
    caption:='';
    matoverride:='use_';
    matname:='none';
    tooltip:=strarr[264];
  end;

  with gbtnv[7] do
  begin
    //inventory (VK_TAB)
    x:=100;
    y:=20;
    w:=32;
    h:=32;
    caption:='';
    matoverride:='oui_';
    matname:='none';
    tooltip:=strarr[265];
  end;

  with gbtnv[51] do
  begin
    //inventory (VK_TAB)
    x:=180;
    y:=20;
    w:=32;
    h:=32;
    caption:='';
    matoverride:='mnu_';
    matname:='none';
    tooltip:=strarr[346];
  end;

  with gbtnv[54] do
  begin
    //journal
    x:=220;
    y:=20;
    w:=32;
    h:=32;
    caption:='';
    matoverride:='jrn_';
    matname:='none';
    tooltip:=strarr[389];
  end;

  with gbtnv[8] do
  begin
    //show/hide perk menu
    w:=20;
    h:=20;
    caption:='>';
    matoverride:='';
    matname:='none';
  end;

  with gbtnv[9] do
  begin
    //show/hide perk menu
    w:=20;
    h:=20;
    caption:='<';
    matoverride:='';
    matname:='none';
  end;

   with gbtnv[18] do
  begin
    //show/hide perk menu
    w:=120;
    h:=20;
    caption:='';
    matoverride:='';
    matname:='none';
  end;

  with gbtnv[19] do
  begin
    //show/hide perk menu
    w:=135;
    h:=25;
    matoverride:='';
    matname:='none';
    caption:=strarr[174];
    tooltip:=strarr[280];
  end;

  with gbtnv[28] do
  begin
    //save
    x:=140;
    y:=20;
    w:=32;
    h:=32;
    caption:='';
    matoverride:='save_';
    matname:='none';
    tooltip:=strarr[266];
  end;

  with gbtnv[48] do
  begin
    //Request form OK
    w:=140;
    h:=35;
    caption:=strarr[90];
    matoverride:='';
    matname:='none';
  end;

  with gbtnv[49] do
  begin
    //Request form Cancel
    w:=140;
    h:=35;
    caption:=strarr[1];
    matoverride:='';
    matname:='none';
  end;

  with gbtnv[55] do
  begin
    //Request form Next
    w:=140;
    h:=35;
    caption:=strarr[392];
    matoverride:='';
    matname:='none';
  end;

  with gbtnv[56] do
  begin
    //Request form Back
    w:=140;
    h:=35;
    caption:=strarr[393];
    matoverride:='';
    matname:='none';
  end;

  with gbtnv[57] do
  begin
    //Request form Next 10
    w:=140;
    h:=35;
    caption:=strarr[392]+' 10';
    matoverride:='';
    matname:='none';
  end;

  with gbtnv[58] do
  begin
    //Request form Back 10
    w:=140;
    h:=35;
    caption:=strarr[393]+' 10';
    matoverride:='';
    matname:='none';
  end;


  with gbtnv[53] do
  begin
    //fighting discipline
    caption:='';
    w:=70+cardmod;
    h:=110+cardmod;
    matoverride:='';
    matname:='none';
  end;

  with gbtnv[10] do
  begin
    //card 1
    caption:='';
    w:=140+cardmod;
    h:=220+cardmod;
    matoverride:='';
    matname:='none';
  end;
  with gbtnv[15] do
  begin
    //card 6
    caption:='';
    w:=140+cardmod;
    h:=220+cardmod;
    matoverride:='';
    matname:='none';
  end;
  with gbtnv[11] do
  begin
    //card 2
    caption:='';
    w:=140+cardmod;
    h:=220+cardmod;
    matoverride:='';
    matname:='none';
  end;
  with gbtnv[12] do
  begin
    //card 3
    caption:='';
    w:=140+cardmod;
    h:=220+cardmod;
    matoverride:='';
    matname:='none';
  end;
  with gbtnv[13] do
  begin
    //card 4
    caption:='';
    w:=140+cardmod;
    h:=220+cardmod;
    matoverride:='';
    matname:='none';
  end;
  with gbtnv[14] do
  begin
    //card 5
    caption:='';
    w:=140+cardmod;
    h:=220+cardmod;
    matoverride:='';
    matname:='none';
  end;

  with gbtnv[16] do
  begin
    //skip or smth
    caption:=strarr[62];
    w:=120;
    h:=30;
    matoverride:='';
    matname:='none';
  end;

  with gbtnv[17] do
  begin
    //run or smth
    caption:=strarr[127];
    w:=120;
    h:=30;
    matoverride:='';
    matname:='none';
    tooltip:=strarr[272];
  end;

  with gbtnv[20] do
  begin
    //start game
    x:=300;
    y:=190;
    w:=250;
    h:=35;
    caption:=strarr[2];
    matoverride:='';
    matname:='none';
  end;
  with gbtnv[52] do
  begin
    //load game
    x:=300;
    y:=190;
    w:=200;
    h:=30;
    caption:=strarr[347];
    matoverride:='';
    matname:='none';
  end;
  with gbtnv[21] do
  begin
    //load game
    x:=300;
    y:=190;
    w:=200;
    h:=30;
    caption:=strarr[3];
    matoverride:='';
    matname:='none';
  end;
  with gbtnv[32] do
  begin
    //settings
    x:=300;
    y:=190;
    w:=200;
    h:=30;
    caption:=strarr[108];
    matoverride:='';
    matname:='none';
  end;
  with gbtnv[36] do
  begin
    //quit
    x:=300;
    y:=190;
    w:=200;
    h:=30;
    caption:=strarr[122];
    matoverride:='';
    matname:='none';
  end;
  with gbtnv[22] do
  begin
    //quit
    x:=300;
    y:=190;
    w:=200;
    h:=30;
    caption:=strarr[4];
    matoverride:='';
    matname:='none';
  end;
  with gbtnv[23] do
  begin
    //raise end
    x:=300;
    y:=190;
    w:=100;
    h:=100;
    caption:='';
    matoverride:='male_';
    matname:='none';
    tooltip:=strarr[274];
  end;
  with gbtnv[24] do
  begin
    //raise end
    x:=300;
    y:=190;
    w:=100;
    h:=100;
    caption:='';
    matoverride:='female_';
    matname:='none';
    tooltip:=strarr[273];
  end;
  with gbtnv[25] do
  begin
    //change hair
    x:=300;
    y:=190;
    w:=60;
    h:=25;
    caption:=strarr[5];
    matoverride:='';
    matname:='none';
    tooltip:=strarr[275];
  end;
  with gbtnv[26] do
  begin
    //change face
    x:=300;
    y:=190;
    w:=60;
    h:=25;
    caption:=strarr[6];
    matoverride:='';
    matname:='none';
    tooltip:=strarr[276];
  end;
  with gbtnv[27] do
  begin
    //change armor (depr)
    x:=300;
    y:=190;
    w:=60;
    h:=25;
    caption:=strarr[7];
    matoverride:='';
    matname:='none';
  end;
  with gbtnv[30] do
  begin
    //spellbook button
    caption:='';
    w:=120;
    h:=200;
    x:=round(Form1.csbackground.Position.X+csbackground.Width/4);
    y:=700-round(h/2)-30;
    matoverride:='';
    matname:='none';
  end;

  with gbtnv[46] do
  begin
    //enable/disable spell button
    caption:='';
    w:=90;
    h:=20;
    x:=round(Form1.csbackground.Position.X+csbackground.Width/4);
    y:=700-round(h/2)-5;
    matoverride:='';
    matname:='none';
  end;


  with gbtnv[31] do
  begin
    //show enemy info
    caption:=strarr[8];
    w:=120;
    h:=30;
    matoverride:='';
    matname:='none';
    tooltip:=strarr[277];
  end;

  with gbtnv[33] do
  begin
    //-1 item
    w:=25;
    h:=25;
    caption:='<';
    matoverride:='';
    matname:='none';
  end;

  with gbtnv[35] do
  begin
    //-1 item
    w:=25;
    h:=25;
    caption:='>';
    matoverride:='';
    matname:='none';
  end;

  with gbtnv[34] do
  begin
    //take item
    w:=75;
    h:=25;
    caption:=strarr[117];
    matoverride:='';
    matname:='none';
  end;

  with gbtnv[29] do
  begin
    //open inv list
    w:=135;
    h:=25;
    caption:=strarr[191];
    matoverride:='';
    matname:='none';
    tooltip:=strarr[278];
  end;

  with gbtnv[47] do
  begin
    //open spell list
    w:=135;
    h:=25;
    caption:=strarr[209];
    matoverride:='';
    matname:='none';
    tooltip:=strarr[279];
  end;

  with gbtnv[38] do
  begin
    //-1 itmwlist page
    w:=25;
    h:=25;
    caption:='<';
    matoverride:='';
    matname:='none';
  end;

  with gbtnv[39] do
  begin
    //+1 itemlist page
    w:=25;
    h:=25;
    caption:='>';
    matoverride:='';
    matname:='none';
  end;

  with gbtnv[50] do
  begin
    //+1 itemlist page
    w:=25;
    h:=25;
    caption:='X';
    matoverride:='';
    matname:='none';
  end;

  with gbtnv[40] do
  begin
    //-1 item
    w:=600;
    h:=55;
    caption:='-';
    matoverride:='';
    matname:='none';
  end;

  with gbtnv[41] do
  begin
    //-1 item
    w:=600;
    h:=55;
    caption:='-';
    matoverride:='';
    matname:='none';
  end;

  with gbtnv[42] do
  begin
    //-1 item
    w:=600;
    h:=55;
    caption:='-';
    matoverride:='';
    matname:='none';
  end;

  with gbtnv[43] do
  begin
    //-1 item
    w:=600;
    h:=55;
    caption:='-';
    matoverride:='';
    matname:='none';
  end;

  with gbtnv[44] do
  begin
    //-1 item
    w:=600;
    h:=55;
    caption:='-';
    matoverride:='';
    matname:='none';
  end;

  with gbtnv[45] do
  begin
    //-1 item
    w:=600;
    h:=55;
    caption:='-';
    matoverride:='';
    matname:='none';
  end;

end;



function GetActiveButton(sx,sy:integer):integer;
var i,res:integer;
begin
  res:=-1;
  for i:=0 to mb do
  begin
    with gbtnv[i] do
    begin
      if (sx>=(x-w/2)) and (sx<=(x+w/2)) and
         (sy>=(y-h/2)) and (sy<=(y+h/2)) and
         (visible=true) then
      begin
        res:=i;
      end;
    end;
  end;
  result:=res;
end;


procedure TForm1.AddItem(n1,n2:integer);
begin
  itms[n1].count:=itms[n1].count+n2;

  if n2>0 then ShowRequestForm(strarr[303],itms[n1].overridename,0,99,0,'itm_'+inttostr(n1));
  if n2<0 then ShowRequestForm(strarr[304],itms[n1].overridename,0,99,0,'itm_'+inttostr(n1));

  if itms[n1].count<0 then itms[n1].count:=0;
  if (itms[n1].count>0) and (itms[n1].lb_crd<>-1) and (player.spellbook[itms[n1].lb_crd]=false) then //<-adding a spell provided by item
  begin
    AddNewCard(true,itms[n1].lb_crd,true,true,false,player);
  end;

  ClickGButton(35);
  usepitem:=false;
end;


procedure TForm1.FastAddMaterial(fn,mn,qs:string;emit:real;mode:integer);
var ffn:string;
begin
  ffn:=gameexe+'\textures\'+fn;
  if fileexists(ffn)=false then
  begin
    ffn:=gameexe+'\textures\'+qs+'\'+'empty.tga';
  end;
  with matlib.Materials.Add do
  begin
    Material.Texture.Image.LoadFromFile(ffn);
    Material.Texture.Disabled:= false;
    Material.BlendingMode:= bmTransparency;
    if mode=0 then
      Material.Texture.TextureMode:=tmModulate;
    if mode=1 then
      Material.Texture.TextureMode:=tmReplace;
    if mode=2 then
      Material.Texture.TextureMode:=tmBlend;
    if mode=3 then
      Material.Texture.TextureMode:=tmDecal;
    Material.FrontProperties.Emission.Red:=emit;
    Material.FrontProperties.Emission.Green:=emit;
    Material.FrontProperties.Emission.Blue:=emit;

    if qs='pq' then
    begin
      Material.Texture.MagFilter:=maNearest;
      Material.Texture.MinFilter:=miNearest;
    end;

    Name:=mn;
    lam:=mn;
  end;
end;

procedure TForm1.char_magicPicked(Sender: TObject);
begin
  Char_magic.Scale.X:=1.2;
end;

procedure TForm1.ClearLevel;
var i,j:integer;
begin

  mapid:='';
  for i:=0 to 100 do
  for j:=0 to 100 do
  with cells[i,j] do
  begin
    wall:=false;
    floor:=false;
    ceil:=false;
    spritename:='0';
    passable:=false;
    trap:=false;
    traptype:=0;
    wco:='';
    fco:='';
    cco:='';
    power:=0;
    chest:=false;
    door:=false;
    doorface:=0;
    chestno:=0;
    doorno:=0;
    textid:=-1;
    ta:=0;
    ra:=0;
    pa:=0;
    dx:=0;
    dy:=0;
    dz:=0;
    outdoors:=false;
    blockx1:=0;
    blockx2:=0;
    blocky1:=0;
    blocky2:=0;
    fwm:=false;
  end;

  for i:=0 to dw do
  for j:=0 to dh do
  with cells[i,j] do
  begin

    x:=i;
    y:=j;

    {this allows to create wall around all level}
    if (i=0) or (j=0) or (i=dw) or (j=dh) then
      wall:=True
    else
      wall:=false;

    if wall=true then
      passable:=false
    else
      passable:=true;

    if passable=true then
    begin
      floor:=true;
      ceil:=true;
    end
    else
    begin
      floor:=false;
      ceil:=false;
    end;

    spritename:='0';

    ta:=0;
    pa:=0;
    ra:=0;

    doorface:=0;

  end;

  for i:=0 to 200 do
  begin
    with gfreesprite[i] do
    begin
      enabled:=false;
      name:='';
      w:=0;
      h:=0;
      x:=0;
      y:=0;
    end;
    with gfreemesh[i] do
    begin
      enabled:=false;
      name:='';
      texture:='';
      sx:=0;
      sy:=0;
      sz:=0;
      ta:=0;
      ra:=0;
      pa:=0;
      x:=0;
      y:=0;
      z:=0;
      fire:=false;
      fdx:=0;
      fdy:=0;
      fdz:=0;
      bhv:=0;
    end;
    gfreemeshb[i]:=gfreemesh[i];
  end;

  for i:=0 to 19 do
  with visls[i] do
  begin
    enabled:=false;
  end;

  ProcessLights;

end;

procedure TForm1.AutoPlaceFloorCeil;
var i,j:integer;
begin
  for i:=0 to dw do
  for j:=0 to dh do
    begin
      with cells[i,j] do
      begin
        if passable=true then
        begin
          floor:=true;
          ceil:=true;
        end
        else
        begin
          if wall=true then
          begin
            floor:=false;
            ceil:=false;
          end
          else
          begin
            floor:=true;
            ceil:=true;
          end;
        end;
      end;
    end;
end;


procedure BuildCorridor(x1,y1,x2,y2:integer);
var bx,by,kx,ky:integer;
begin
  bx:=x1;
  by:=y1;
  repeat
    if bx>x2 then kx:=-1;
    if bx<x2 then kx:=1;
    if bx=x2 then kx:=0;
    if kx=0 then
    begin
      if by>y2 then ky:=-1;
      if by<y2 then ky:=1;
      if by=y2 then ky:=0;
    end
    else ky:=0;
    cells[bx,by].passable:=true;
    cells[bx,by].wall:=false;
    cells[bx,by].floor:=True;
    cells[bx,by].ceil:=True;
    bx:=bx+kx;
    by:=by+ky;
  until (bx=x2) and (by=y2);
end;

function getdist(x1,y1,x2,y2:real):real;
var a,b,c:real;
begin
  a:=(x2-x1);
  b:=(y2-y1);
  c:=sqrt(sqr(a)+sqr(b));
  result:=c;
end;

function getunusedfreesprite:integer;
var i:integer;
    done:boolean;
begin

  i:=0;
  done:=false;
  repeat
    if gfreesprite[i].enabled=false then done:=true;
    if done=false then i:=i+1;
  until (i=201) or (done=true);

  if done=true then Result:=i else Result:=-1;

end;

function getspriteofpurp(prp:integer):string;
var pool:array of string;
    i:integer;
begin
  SetLength(pool,1);
  pool[0]:='none';
  for i:=0 to Length(alitms)-1 do
  begin
    if alitms[i].purpose=prp then
    begin
      pool[Length(pool)-1]:=alitms[i].name;
      SetLength(pool,length(pool)+1);
    end;
  end;
  result:=pool[random(Length(pool)-1)];
end;

function getspritebyname(name:string):integer;
var i,r:integer;
begin
  r:=-1;
  for i:=0 to length(alitms)-1 do
  begin
    if alitms[i].name=name then
    begin
      r:=i;
    end;
  end;
  result:=r;
end;



procedure setposatwall(wx,wy,sw,sh,i:integer;sn:string;var x:integer; var y:integer; var z:integer; var w:integer; var h:integer; var dx:real; var dy:real; var tex:string; var r:boolean);
var n:integer;
    ii,jj:integer;
    wls:array[0..3]of integer;
begin

  r:=false;

  for ii:=-1 to 1 do
  for jj:=-1 to 1 do
  begin

    if ((ii=0) xor (jj=0)) then
    begin

      if (wx+ii>0) and (wx+ii<dw) and (wy+jj>0) and (wy+jj<dh) then
      begin
        if (cells[wx,wy].wall=true) and (cells[wx+ii,wy+jj].wall=false) and (cells[wx+ii,wy+jj].door=false) then
        begin
          x:=(wx*20)+ii*11;
          y:=(wy*20)+jj*11;
          z:=10;
          dx:=ii;
          dy:=jj;
          tex:=getspriteofpurp(1);
          n:=getspritebyname(tex);
          if (n<>-1) then
          begin
            w:=alitms[n].size;
            h:=alitms[n].size2;
          end
          else
          begin
            w:=sw;
            h:=sh;
          end;
          r:=true;

        end;
      end;

    end;

  end;
end;

procedure TForm1.RandomMap;
var i,j,o,rmsx,rmsy,bullx,bully,bully2,kx,ky,n,att:integer;
    uufs:integer;
    mcx,mcy:integer;
    rleft,rtot:integer;
    crw,crh,crx,cry,crp:integer;
    startx,starty,exx,exy:integer;
    csx,csy:integer;
    done:boolean;
    de:integer;
    rbx,rby1,rby2,sr:real;
    excon:integer;
    rc,rr:integer;
    gots,gote:boolean;
    ctfn:string;
    el:integer;
    r:boolean;
begin

  //intelligent random

  //1 - cleanup

  for i:=0 to 20 do visls[i].enabled:=false;
  for i:=0 to 200 do
  begin
    gfreesprite[i].enabled:=false;
    gfreemesh[i].enabled:=false;
  end;

  mapid:='';

  Form1.playerlight.ConstAttenuation:=0.5;
  Form1.playerlight.LinearAttenuation:=0.01;
  Form1.playerlight.QuadraticAttenuation:=0.01;
  Form1.playerlight.Diffuse.Red:=255/255;
  Form1.playerlight.Diffuse.Green:=127/255;
  Form1.playerlight.Diffuse.Blue:=0/255;

  dw:=round(10+2*power((sqr(level)/2),(1/3)))+(random(5)-2);
  dh:=round(10+2*power((sqr(level)/2),(1/3)))+(random(5)-2);

  if dw>99 then dw:=99;
  if dh>99 then dh:=99;
  if dw<15 then dw:=15;
  if dh<15 then dh:=15;

  repeat
    envir:=random(GetSets);
  until (env[envir].Enabled=true);

  skybox:=0;

  for i:=0 to dw do
  for j:=0 to dh do
  with cells[i,j] do
  begin
    Form2.ReadCellOverrides(i,j);
    trap:=false;
    wall:=true;
    passable:=false;
    spritename:='0';
    floor:=false;
    ceil:=false;
    fmo:='';
    wmo:='';
    wco:='';
    fco:='';
    cco:='';
    door:=false;
    chest:=false;
    minimapc[i,j]:=false;
    Form2.ReadCellOverrides(i,j);
  end;

  for i:=0 to 200 do
  begin
    gfreesprite[i].enabled:=false;
  end;

  //2 - defining start and exit
  done:=false;
  repeat
    Form2.Caption:='placing start and exit';
    application.ProcessMessages;
    startx:=Random(dw-2)+2;
    starty:=Random(dh-2)+2;
    exx:=Random(dw-2)+2;
    exy:=Random(dh-2)+2;
    if ((startx<>exx) and (starty<>exy)) and (getdist(startx,starty,exx,exy)>(((dw+dh)/2)-(dw+dh)/4)) then
    begin
      done:=true;
    end
    else
    begin
      done:=false;
    end;
  until (done=true);

  Form2.Caption:='MapEd';

  {spx:=startx;
  spy:=starty;
  epx:=exx;
  epy:=exy;}

  //3 - defining rooms

  rtot:=Random(round((dw+dh)/6))+round((dw+dh)/6);

  if rtot>(round((dw+dh)/3)) then rtot:=round((dw+dh)/3);
  if rtot<2 then rtot:=3;

  rmsx:=round((dw/dh)*sqrt(rtot));
  rmsy:=round((dh/dw)*sqrt(rtot));

  if rmsx<1 then rmsx:=1;
  if rmsy<1 then rmsy:=1;

  mcx:=round(dw/rmsx);
  mcy:=round(dh/rmsy);

  //ShowMessage('rmsx='+inttostr(rmsx)+';  rmsy='+inttostr(rmsy));


  excon:=Random(rtot-2)+2;

  rc:=0;
  rr:=0;
  gots:=false;
  gote:=false;

  for i:=(rtot-1) downto 0 do
  with rooms[i] do
  begin
    shape:=random(2);
    //if (dw<20) or (dh<20) then shape:=0;

    W:=random(5)+3;
    if w>(dw/(rtot/2)) then w:=round(dw/(rtot/2))-1;

    if (w>4) and (Random(2)>0) then w:=3;
    if w<=0 then w:=3;

    //if (shape=1) then w:=5+random(3);

    if shape=0 then
    begin
      H:=round(mcy/3)+random(5)-2;
      if h>(dh/(rtot/2)) then h:=round(dh/(rtot/2))-1;
      if (h>4) and (Random(2)>0) then h:=3;
      if h<=0 then h:=3;
      //if h>(dh/(rtot/2)) then h:=round(dh/(rtot/2));
    end
    else
      H:=W;


    if shape=0 then
    begin
      if h<3 then h:=3;
      if w<3 then w:=3;
    end
    else
    begin
      if h<5 then h:=5;
      if w<5 then w:=5;
    end;

    connection:=i+1;

    if (connection>(rtot-1)) then connection:=0;

    purp:=random(12)+2;


    if ((purp=6) or (purp=7) or (purp=8) or (purp=11)) and (Random(30)<1) then purp:=5; //lowering altar chance
    if ((purp=6) or (purp=7) or (purp=8)) and (level<5) then purp:=5; //lowering altar chance

    if (random(3)<1) and (gots=false) then
    begin
      gots:=true;
      purp:=0;
    end;

    if (random(3)<1) and (purp<>0) and(gote=false) then
    begin
      gote:=true;
      purp:=1;
    end;


    x:=round(rc*mcx)+random(round(w/2))+2;
    y:=round(rr*mcy)+random(round(h/2))+2;

    if x<(1) then x:=2;
    if y<(1) then y:=2;
    if x>(dw-1) then x:=(dw-2);
    if y>(dh-1) then y:=(dh-2);


    if (i=1) and (gote=false) then
    begin
      purp:=1;
    end;
    if (i=0) and (gots=false) then
    begin
      purp:=0;
    end;

    if purp=0 then
    begin
      connection:=excon;
      purp:=0;
      spx:=x;
      spy:=y;
    end;
    if purp=1 then
    begin
      connection:=excon;
      purp:=1;
      epx:=x;
      epy:=y;
    end;

    rc:=rc+1;

    if rc>=rmsx then
    begin
      rc:=0;
      rr:=rr+1;
    end;

  end;

  //4 - building rooms
  for i:=0 to (rtot-1) do
  with rooms[i] do
  begin

    if shape=0 then //square room
    begin
      for j:=round(x-w/2) to (round(x+w/2)) do
      for o:=round(y-h/2) to (round(y+h/2)) do
      begin

        bullx:=j;
        bully:=o;

        if (bullx>=0) and (bully>=0) and (bullx<dw) and (bully<dh) then
        begin
          cells[j,o].passable:=true;
          cells[j,o].wall:=false;
          cells[j,o].floor:=True;
          cells[j,o].ceil:=True;
        end;

      end;

    end;

    if (shape=1) then //circular room
    begin

      bully:=y;
      bully2:=y;
      o:=math.ceil(w/2);

      repeat
        bullx:=x-o;
        repeat
          if (bullx>=0) and (bully>=0) and (bullx<dw) and (bully<dh) then
          begin
            cells[bullx,bully].passable:=true;
            cells[bullx,bully].wall:=false;
            cells[bullx,bully].floor:=True;
            cells[bullx,bully].ceil:=True;
            cells[bullx,bully2].passable:=true;
            cells[bullx,bully2].wall:=false;
            cells[bullx,bully2].floor:=True;
            cells[bullx,bully2].ceil:=True;
          end;
          bullx:=bullx+1;
        until (bullx>=round(x+o));
        o:=o-1;
        bully:=bully+1;
        bully2:=bully2-1;
      until (o=0);

    end;

  end;

  //5 - building corridors

  for i:=0 to (rtot-1) do
  begin
    BuildCorridor(rooms[i].x,rooms[i].y,rooms[rooms[i].connection].x,rooms[rooms[i].connection].y);
  end;

  //6 - making rooms work
  for i:=0 to (rtot-1) do
  with cells[rooms[i].x,rooms[i].y] do
  begin
    case rooms[i].purp of
    0:begin
        spritename:='mark_enter';
        passable:=true;
      end;
    1:begin
        spritename:='mark_exit';
        passable:=true;
      end;
    2:begin
        spritename:='altar1';
        passable:=false;
        trap:=true;
        traptype:=4;
      end;
    3:begin
        spritename:='spr_keyshrines';
        passable:=false;
        trap:=true;
        traptype:=5;
      end;
    4:begin
        spritename:='spr_keyshrineg';
        passable:=false;
        trap:=true;
        traptype:=6;
      end;
    5:begin
        //spritename:='tex_';
        passable:=false;
        chest:=true;
        power:=Random(3);
      end;
    6:begin
        //spritename:='tex_';
        passable:=false;
        trap:=true;
        spritename:='spr_ang_alt';
        traptype:=12;
      end;
    7:begin
        //spritename:='tex_';
        passable:=false;
        trap:=true;
        spritename:='spr_ang_alt';
        traptype:=13;
      end;
     8:begin
        //spritename:='tex_';
        passable:=false;
        trap:=true;
        spritename:='spr_ang_alt';
        traptype:=14;
      end;
      9:begin
        //spritename:='tex_';
        passable:=false;
        trap:=true;
        spritename:='spr_barrel1';
        traptype:=16;
        doorno:=-1;
      end;
      10:begin
        //spritename:='tex_';
        passable:=false;
        trap:=true;
        spritename:='spr_altarsilence';
        traptype:=17;
      end;
      11:begin
        //spritename:='tex_';
        passable:=false;
        trap:=true;
        el:=random(5);
        spritename:='spr_ralt'+inttostr(el);
        traptype:=18;
        doorno:=el;
      end;

      12:begin //adds items from NOT random pool
        //spritename:='tex_';
        passable:=false;
        trap:=true;
        el:=GetUnownedItem;
        spritename:='spr_table';
        traptype:=16;
        doorno:=el;
      end;

      13:begin
        //spritename:='tex_';
        passable:=false;
        trap:=true;
        spritename:='spr_wisdom_orb';
        traptype:=19;
      end;

    end;
  end;


  AutoPlaceFloorCeil;

  //7. Adding doors
  for i:=1 to (dw-1) do
  for j:=1 to (dh-1) do
  begin
    if (CheckDoorSpot(i,j)=true) and (random(10)<3) then
    with cells[i,j] do
    begin
      door:=true;
      power:=0;
      passable:=false;
    end;
  end;

  Form2.autosetdoors;

  //8 - decorating level

  for i:=0 to 200 do
  begin
    gfreesprite[i].enabled:=false;
  end;

  for i:=0 to dw do
  for j:=0 to dh do
  begin
    if (cells[i,j].wall=true) and (random(100)<24) then
    begin
      uufs:=getunusedfreesprite;
      if uufs<>-1 then  //if this sprite even exists
      begin
        setposatwall(i,j,10,15,uufs,'',gfreesprite[uufs].x,gfreesprite[uufs].y,gfreesprite[uufs].z,gfreesprite[uufs].w,gfreesprite[uufs].h,gfreesprite[uufs].dirx,gfreesprite[uufs].diry,gfreesprite[uufs].name,r);
        if r=true then
        begin
          gfreesprite[uufs].z:=10;
          gfreesprite[uufs].fixed:=true;
          gfreesprite[uufs].enabled:=true;
        end;

      end;
    end;
  end;


end;


function TForm1.GetUnownedItem:integer;
var i:integer;
    allit:array[0..1000] of integer;
    max,res:integer;
begin
  max:=0;
  for i:=0 to 1000 do
  begin
    if (itms[i].count=0) and (itms[i].itmtype<>0) then
    begin
      allit[max]:=i;
      max:=max+1;
    end;
  end;

  if max<>0 then res:=Random(max) else res:=-1;

  result:=res;

end;

function IsCellFree(x,y:integer):boolean;
begin
  with cells[x,y] do
  begin
    if ((chest=false) and (door=false) and (trap=false) and (wall=false) and (spritename='0') and
        (passable=true)) then
      result:=true
    else
      result:=false;
  end;
end;


function TForm1.CheckDoorSpot(x,y:integer):boolean;
var c1,c2,c3:boolean;

begin
  c1:=false;
  c2:=false;
  c3:=false;

  c1:=iscellfree(x,y);

  if (((iscellfree(x-1,y))=true) and (cells[x,y-1].wall=true) and (iscellfree(x+1,y)=true) and (cells[x,y+1].wall=true)) or
     (((iscellfree(x,y-1))=true) and (cells[x-1,y].wall=true) and (iscellfree(x,y+1)=true) and (cells[x+1,y].wall=true)) then
  begin
    c2:=true;
  end;


  if (c1=true) and (c2=true) then
  begin
    result:=true
  end
  else
  begin
    result:=false
  end;

end;


procedure TForm1.FreeCell(i,j:integer);
var k:integer;
begin

  try  FreeAndNil(wall[i,j]);except end;
  try  FreeAndNil(door[i,j]);except end;
  try  FreeAndNil(ceil[i,j]);except end;
  try  FreeAndNil(chest[i,j]);except end;
  try  FreeAndNil(floor[i,j]);except end;
  try  FreeAndNil(sprite[i,j]);except end;

  for k:=0 to 100 do
  begin
    try FreeAndNil(grasssprite[i,j,k]); except end;
  end;

end;



procedure TForm1.BuildCell(i,j:integer);
var ext:string;
    dst:string;
    dex:string;
    ddx,ddy:integer;
    k:integer;
begin

    FreeCell(i,j);

    Form2.ReadCellOverrides(i,j);

    if (cells[i,j].wall=true) or (cells[i,j].fwm=true) then
    begin
      //creating cubes at wall cells

      wall[i,j]:=TGLFreeForm.CreateAsChild(Form1.dcgameb);

      //defining if there is alternate file for wall
      ext:='';

      if fileexists(gameexe+'\meshes\'+cells[i,j].wmo+'.3ds')=true then ext:='.3ds';
      if fileexists(gameexe+'\meshes\'+cells[i,j].wmo+'.obj')=true then ext:='.obj';

      if ext<>'' then
        TGLFreeForm(wall[i,j]).LoadFromFile(gameexe+'\meshes\'+cells[i,j].wmo+ext)
      else
        TGLFreeForm(wall[i,j]).LoadFromFile(gameexe+'\meshes\m_wall.obj');

      //TGLFreeForm(wall[i,j]).

      TGLFreeForm(wall[i,j]).Material.MaterialLibrary:=(Form1.matlib);

      if cells[i,j].wco='' then
        TGLFreeForm(wall[i,j]).Material.LibMaterialName:='etex_'+inttostr(envir)+'_0'
      else
        TGLFreeForm(wall[i,j]).Material.LibMaterialName:=cells[i,j].wco;

      with wall[i,j] do
      begin
        //Material.Texture.MappingMode:=tmmObjectLinear;
        //CubeWidth:=20;
        //CubeHeight:=20;
        //CubeDepth:=20;
        PitchAngle:=round(cells[i,j].pa);
        TurnAngle:=round(cells[i,j].ta);
        RollAngle:=round(cells[i,j].ra);
        Position.X:=i*20+cells[i,j].dx;
        Position.Y:=j*20+cells[i,j].dy;
        Position.Z:=10+cells[i,j].dz;
      end;

      //GLShadowVolume1.Occluders.AddCaster(wall[i,j]);

    end;

    if cells[i,j].door=true then
    begin
      //creating cubes at wall cells
      door[i,j]:=TGLFreeForm.CreateAsChild(Form1.dcgameb);

      if cells[i,j].passable=true then dst:='o' else dst:='c';

      if (fileexists(gameexe+'\meshes\m_door_'+inttostr(envir)+'_'+dst+'.3ds')=true) then dex:='3ds';
      if (fileexists(gameexe+'\meshes\m_door_'+inttostr(envir)+'_'+dst+'.obj')=true) then dex:='obj';

      if (fileexists(gameexe+'\meshes\m_door_'+inttostr(envir)+'_'+dst+'.'+dex)=true) and (no3ddoors=false) then
      begin
        TGLFreeForm(door[i,j]).LoadFromFile(gameexe+'\meshes\m_door_'+inttostr(envir)+'_'+dst+'.'+dex);
        cells[i,j].door3d:=true;
      end
      else
      begin
        TGLFreeForm(door[i,j]).LoadFromFile(gameexe+'\meshes\m_door.obj');
        cells[i,j].door3d:=false;
      end;

      TGLFreeForm(door[i,j]).Material.MaterialLibrary:=(Form1.matlib);
      if cells[i,j].power=0 then
        TGLFreeForm(door[i,j]).Material.LibMaterialName:='etex_'+inttostr(envir)+'_3';
      if cells[i,j].power=1 then
        TGLFreeForm(door[i,j]).Material.LibMaterialName:='etex_'+inttostr(envir)+'_5';
      if cells[i,j].power=2 then
        TGLFreeForm(door[i,j]).Material.LibMaterialName:='etex_'+inttostr(envir)+'_6';
      if cells[i,j].power>2 then
        TGLFreeForm(door[i,j]).Material.LibMaterialName:='etex_'+inttostr(envir)+'_3';
      if (dst='o') and (cells[i,j].door3d=true) then
        TGLFreeForm(door[i,j]).Material.LibMaterialName:='etex_'+inttostr(envir)+'_9';

      with door[i,j] do
      begin
        Position.X:=i*20;
        Position.Y:=j*20;
        Position.Z:=10;

        if cells[i,j].door3d=true then
        begin
          GetDirsFromLookside(cells[i,j].doorface,ddx,ddy);
          RollAngle:=cells[i,j].doorface;
        end
        else
          RollAngle:=0;
      end;
    end;

    if cells[i,j].chest=true then
    begin
      chest[i,j]:=TGLPlane.CreateAsChild(Form1.dcgame);
      chest[i,j].Material.MaterialLibrary:=(Form1.matlib);
      if cells[i,j].power=0 then
        TGLPlane(chest[i,j]).Material.LibMaterialName:='etex_'+inttostr(envir)+'_4';
      if cells[i,j].power=1 then
        TGLPlane(chest[i,j]).Material.LibMaterialName:='etex_'+inttostr(envir)+'_7';
      if cells[i,j].power=2 then
        TGLPlane(chest[i,j]).Material.LibMaterialName:='etex_'+inttostr(envir)+'_8';
      if cells[i,j].power>2 then
        TGLPlane(chest[i,j]).Material.LibMaterialName:='etex_'+inttostr(envir)+'_4';
      with chest[i,j] do
      begin
        Width:=20;
        Height:=20;
        Position.X:=i*20;
        Position.Y:=j*20;
        Position.Z:=10;
        TurnAngle:=90;
      end;
    end;

    if (cells[i,j].floor=true) then
    begin
      //creating ceiling and floor planes at nonwall cells
      //1 - floor
      floor[i,j]:=TGLFreeForm.CreateAsChild(Form1.dcgameb);

      ext:='';
      if fileexists(gameexe+'\meshes\'+cells[i,j].fmo+'.3ds')=true then ext:='.3ds';
      if fileexists(gameexe+'\meshes\'+cells[i,j].fmo+'.obj')=true then ext:='.obj';

      if ext<>'' then
        TGLFreeForm(floor[i,j]).LoadFromFile(gameexe+'\meshes\'+cells[i,j].fmo+ext)
      else
      begin
        //ShowMessage('floor is default');
        TGLFreeForm(floor[i,j]).LoadFromFile(gameexe+'\meshes\m_floor.obj');
        //ShowMessage('floor loaded');
      end;

      TGLFreeForm(floor[i,j]).Material.MaterialLibrary:=(Form1.matlib);

      if cells[i,j].fco='' then
        TGLFreeForm(floor[i,j]).Material.LibMaterialName:='etex_'+inttostr(envir)+'_1'
      else
        TGLFreeForm(floor[i,j]).Material.LibMaterialName:=cells[i,j].fco;

      with floor[i,j] do
      begin
        //Width:=20;
        //Height:=20;
        Position.X:=i*20;
        Position.Y:=j*20;
        Position.Z:=0;
      end;

      //GLShadowVolume1.Occluders.AddCaster(floor[i,j]);

    end;

    if (cells[i,j].ceil=true) then
    begin
      //2 - ceiling
      ceil[i,j]:=TGLPlane.CreateAsChild(Form1.dcgameb);
      ceil[i,j].Material.MaterialLibrary:=(Form1.matlib);

      if cells[i,j].cco='' then
        ceil[i,j].Material.LibMaterialName:='etex_'+inttostr(envir)+'_2'
      else
        TGLPlane(ceil[i,j]).Material.LibMaterialName:=cells[i,j].cco;

      with ceil[i,j] do
      begin
        Width:=20;
        Height:=20;
        Position.X:=i*20;
        Position.Y:=j*20;
        Position.Z:=20;
        TurnAngle:=180;
      end;

      //GLShadowVolume1.Occluders.AddCaster(ceil[i,j]);

    end;

    if cells[i,j].spritename<>'0' then
    begin
      sprite[i,j]:=TGLPlane.CreateAsChild(Form1.dcgame);
      sprite[i,j].Material.MaterialLibrary:=(Form1.matlib);
      TGLPlane(sprite[i,j]).Material.LibMaterialName:=cells[i,j].spritename;
      with sprite[i,j] do
      begin
        Width:=20;
        Height:=20;
        Position.X:=i*20;
        Position.Y:=j*20;
        Position.Z:=10;
      end;
    end;

    if (cells[i,j].grass=true) and (cells[i,j].gtp<>'') and (cells[i,j].dens>0) and (nograss=false) then
    begin
      for k:=0 to (cells[i,j].dens-1) do
      begin
        grasssprite[i,j,k]:=TGLSprite.CreateAsChild(Form1.dcgame);
        grasssprite[i,j,k].Material.MaterialLibrary:=(Form1.matlib);
        grasssprite[i,j,k].Material.LibMaterialName:=cells[i,j].gtp;
        with grasssprite[i,j,k] do
        begin
          Width:=5+random(5)-random(5);
          Height:=5+Random(5)-random(5);
          Position.X:=i*20+Random(10)-Random(10);
          Position.Y:=j*20+Random(10)-Random(10);
          Position.Z:=Height/2;
        end;
      end;
    end;

end;

procedure TForm1.ModFreeSprite(i:integer);
begin
  FreeAndNil(fsprite[i]);
  fsprite[i]:=TGLPlane.CreateAsChild(dcgame);
  fsprite[i].Width:=gfreesprite[i].w;
  fsprite[i].Height:=gfreesprite[i].h;
  fsprite[i].position.x:=gfreesprite[i].x;
  fsprite[i].position.y:=gfreesprite[i].y;
  fsprite[i].position.z:=gfreesprite[i].z;
  fsprite[i].Material.MaterialLibrary:=matlib;
  fsprite[i].Material.LibMaterialName:=gfreesprite[i].name;
  fsprite[i].Visible:=gfreesprite[i].enabled;
end;


procedure TForm1.ModFreeMesh(i:integer);
var ext:string;
begin
  with gfreemesh[i] do
  begin

    try FreeAndNil(firedummy[i]); except end;
    try FreeAndNil(fmesh[i]); except end;

    fmesh[i]:=TGLFreeForm.CreateAsChild(dcgameb);

    ext:='';
    if fileexists(gameexe+'\meshes\'+name+'.3ds')=true then ext:='.3ds';
    if fileexists(gameexe+'\meshes\'+name+'.obj')=true then ext:='.obj';

    if ext<>'' then
      TGLFreeForm(fmesh[i]).LoadFromFile(gameexe+'\meshes\'+name+ext)
    else
    begin
      TGLFreeForm(fmesh[i]).LoadFromFile(gameexe+'\meshes\m_floor.obj');
    end;

    {rx:=round(x);
    ry:=round(y);
    rz:=round(z);
    rta:=round(ta);
    rra:=round(ra);
    rpa:=round(pa);}

    if (bhv=0) then
    begin
      fmesh[i].position.x:=x;
      fmesh[i].position.y:=y;
      fmesh[i].position.z:=z;
      fmesh[i].TurnAngle:=ta;
      fmesh[i].PitchAngle:=pa;
      fmesh[i].RollAngle:=ra;
    end
    else
    begin
      fmesh[i].position.x:=rx;
      fmesh[i].position.y:=ry;
      fmesh[i].position.z:=rz;
      fmesh[i].TurnAngle:=rta;
      fmesh[i].PitchAngle:=rpa;
      fmesh[i].RollAngle:=rra;
    end;
    fmesh[i].Material.MaterialLibrary:=matlib;
    if texture='0' then
    begin
      if fileexists(gameexe+'\meshes\'+name+'.red')=false then
        fmesh[i].Material.LibMaterialName:='tex_fs_'+name
      else
      begin
        Form1.Memo5.Lines.LoadFromFile(gameexe+'\meshes\'+name+'.red');
        fmesh[i].Material.LibMaterialName:=Memo5.Lines[0];
      end;
    end
    else
    begin
      fmesh[i].Material.LibMaterialName:=texture;
    end;

    {if texture2<>'0' then
    begin
      fmesh[i].Material.LibMaterialName:=texture;
    end;}
    //fmesh[i].LightmapLibrary:=matlib;

    fmesh[i].Visible:=enabled;

    fmesh[i].Scale.X:=sx/100;
    fmesh[i].Scale.y:=sy/100;
    fmesh[i].Scale.z:=sz/100;

    TGLSphere(firedummy[i]):=TGLSphere.CreateAsChild(dcgame);
    firedummy[i].Material.MaterialLibrary:=matlib; firedummy[i].Effects.Clear;
    firedummy[i].Material.LibMaterialName:='transp';
    firedummy[i].Radius:=0.1;
    firedummy[i].Slices:=5;
    firedummy[i].Position.X:=fmesh[i].Position.X+fdx;
    firedummy[i].Position.Y:=fmesh[i].Position.Y+fdy;
    firedummy[i].Position.Z:=fmesh[i].Position.Z+fdz;
    firedummy[i].Visible:=enabled;

    if fire=true then firestart(i);

    //GLShadowVolume1.Occluders.AddCaster(fmesh[i]);

  end;
end;

procedure TForm1.Firestart(i:integer);
var flame:TGLBFireFX;
begin
  if (firedummy[i].Visible=true) and (nofire=false) then
  begin
    //ShowMessage('starting fire');
    flame:=TGLBFireFX.Create(firedummy[i].Effects);
    flame.Manager:=GLFireFXManager1;
  end;
end;


procedure TForm1.BuildLevel;
var i,j:integer;
    mn:string;
begin
  lip:=true;
  sip:=false;
 // clsr:=random(loadscrs);

  for i:=0 to 100 do
  for j:=0 to 100 do
  begin
    FreeCell(i,j);
  end;

  for i:=0 to dw do
  for j:=0 to dh do
  begin
    BuildCell(i,j);
  end;

  for i:=0 to 200 do
  begin
    ModFreeSprite(i);
  end;

  for i:=0 to 200 do
  begin
    ModFreeMesh(i);
  end;

  //making skybox
  if skybox<>0 then
  begin
    GLSkyBox1.Visible:=true;
    with GLSkyBox1 do
    begin
      MatNameTop:='sb_'+inttostr(skybox)+'_top';
      MatNameBottom:='sb_'+inttostr(skybox)+'_bottom';
      MatNameLeft:='sb_'+inttostr(skybox)+'_left';
      MatNameRight:='sb_'+inttostr(skybox)+'_right';
      MatNameFront:='sb_'+inttostr(skybox)+'_front';
      MatNameBack:='sb_'+inttostr(skybox)+'_back';
      MatNameClouds:='sb_'+inttostr(skybox)+'_clouds';
    end;
  end
  else
    GLSkyBox1.Visible:=false;

  try ProcessLights; except end;

  lip:=false;
end;

procedure TForm1.CheckLevelSwitch;
begin
  if (plx=epx) and (ply=epy) then
  begin
    ShowRequestForm(strarr[9],strarr[10],1,3,0,'');
  end;
end;


procedure TForm1.ExitGame;
var err:boolean;
begin

  try
    AlDeleteBuffers(1, @buffer1);
    AlDeleteSources(1, @source1);
    AlDeleteBuffers(1, @buffer2);
    AlDeleteSources(1, @source2);
    AlutExit();
  except

  end;

  wannaexit:=true;

  try
    cleargslist;
  except end;

  repeat
    Application.ProcessMessages;
  until (cdrstate=false);

  repeat
    try
      Application.Terminate;
      err:=false;
    except
      err:=true;
    end;
  until (err=false);

end;


procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ExitGame;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if fullscreen=false then
  begin
    if MessageDlg(strarr[345],mtConfirmation, mbYesNo, 0) = mrNo then
      CanClose := False;
  end
  else
  begin
    ShowRequestForm('',strarr[345],1,30,0,'');
    CanClose:=false;
  end;
end;

procedure fillepos;
var i:integer;
begin

    for i:=1 to 100 do
    begin
      epos[i]:=false;
    end;

    i:=1;
    epos[i]:=false;
    i:=i+1;
    epos[i]:=true;
    i:=i+1;
    epos[i]:=true;
    i:=i+1;
    epos[i]:=true;
    i:=i+1;
    epos[i]:=true;
    i:=i+1;
    epos[i]:=false;
    i:=i+1;
    epos[i]:=false;
    i:=i+1;
    epos[i]:=true;
    i:=i+1;
    epos[i]:=false;
    i:=i+1;
    epos[i]:=false;
    i:=i+1;
    epos[i]:=true;
    i:=i+1;
    epos[i]:=true;
    i:=i+1;
    epos[i]:=true;
    i:=i+1;
    epos[i]:=true;
    i:=i+1;
    epos[i]:=true;
    i:=i+1;
    epos[i]:=true;
    i:=i+1;
    epos[i]:=true;
    i:=i+1;
    epos[i]:=true;
    i:=i+1;
    epos[i]:=true;
    i:=i+1;
    epos[i]:=true;
    i:=i+1;
    epos[i]:=false;
    i:=i+1;
    epos[i]:=true;
    i:=i+1;
    epos[i]:=false;
    i:=i+1;
    epos[i]:=false;
    i:=i+1;
end;

procedure TForm1.FormCreate(Sender: TObject);
var i:integer;
    mngName:string;
    argv: array of PALByte;
begin

  loadinprogress:=true;
  lp:=0;


  verno:=GetAppVersionStr;
  Form1.Caption:='Lo of the Dark v. '+verno;

  for i:=0 to 10 do battlelist[i]:=-2; //<-IMMEADIATELY clean battle list

  InitOpenAL;
  //MainDevice := alcOpenDevice(nil);
  //MainContext := alcCreateContext(MainDevice,nil);
  //alcMakeContextCurrent(MainContext);
  AlutInit(nil,argv);
  AlListenerfv ( AL_POSITION, @listenerpos);
  AlListenerfv ( AL_VELOCITY, @listenervel);
  AlListenerfv ( AL_ORIENTATION, @listenerori);

  for i:=0 to 10000 do rqfpool[i].active:=false;

  Randomize;

  loadmessage:='Loading config';
  Application.ProcessMessages;

  with GLWindowsBitmapFont1 do
  begin
    Ranges[0].StartASCII:=#0;
    Ranges[0].StopASCII:=#151;
    Ranges[1].StartASCII:=#153;
    Ranges[1].StopASCII:=#255;
  end;
  with GLWindowsBitmapFont2 do
  begin
    Ranges[0].StartASCII:=#0;
    Ranges[0].StopASCII:=#151;
    Ranges[1].StartASCII:=#153;
    Ranges[1].StopASCII:=#255;
  end;
  gameexe:=extractfiledir(Application.ExeName);
  ReadConfig;

  setlength(cp,1);
  cp[0]:=-1;

  for i:=0 to 1000 do //disabling all cards in deck
  begin
    deck[i].enabled:=false;
    itms[i].count:=0;
  end;

  for i:=0 to 100 do
  with env[i] do
  begin
    name:='none';
    Enabled:=false;
  end;



  loadmessage:='Loading localization';
  Application.ProcessMessages;

  fillstrarr(lang,strarr);
  lp:=1;
  celang:=lang;
  form2.getcpeids;
  //form3.Edit2.Text:=celang;

  //ActiveSoundManager:=TGLSMWaveOut;
  //ActiveSoundManager.Active:=false;
  //GLSMWaveOut1.Active:=True;
  lp:=2;
  //  mngName:='WaveOut'
  //else mngName:='';

  preparematerials;

  for i:=0 to 6 do
  begin
    lsourc[i]:=TGLLightSource.CreateAsChild(dcmaingame);
    {with GLShadowVolume1.Lights do
    begin
      AddCaster(lsourc[i])
    end;}
    lsourc[i].LightStyle:=lsOmni;
    lsourc[i].LinearAttenuation:=0;
    lsourc[i].ConstAttenuation:=0;
    lsourc[i].QuadraticAttenuation:=0;
    lsourc[i].Shining:=false;
  end;

  loadmessage:=strarr[162];
  Application.ProcessMessages;

  prepareuiobjects;

  loadmessage:=strarr[162];
  lp:=12;
  Application.ProcessMessages;

  definebutsets;

  ClearLevel;


  player.name:='testchar';
  ResetStats;

  mmmode:=true;
  gmmode:=false;
  invmode:=false;
  chargen:=false;
  itemlistmode:=false;

  loadmessage:=strarr[163];
  lp:=13;
  Application.ProcessMessages;

  Form2.LoadMap(gameexe+'\levels\mm_map.map');
  GoToStart;
  lp:=14;
  BuildLevel;
  //ProcessLights;


  //DoOALPreps;

  if mskon=true then
  begin
    //MediaPlayer1.DeviceType:=dtAutoSelect;
    //MediaPlayer1.AutoOpen:=false;
    //MediaPlayer1.FileName:=gameexe+'\sounds\music\peace0.mp3';
    //MediaPlayer1.Open;
  end;
  lp:=15;

  loadinprogress:=false;

  EDThread:=TEDThread.Create(false);

  fillepos;

  GLCadencer1.Enabled:=true;

  //if multithread=true then
  //begin

  //end;


  //GLCadencer2.Enabled:=true;




end;

function TForm1.RandomLoot:integer;
begin
  Memo1.Lines.LoadFromFile(gameexe+'\items\lootlist.txt');
  result:=strtoint(Memo1.lines[Random(Memo1.Lines.Count)]);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  AlDeleteBuffers(1, @buffer1);
  AlDeleteSources(1, @source1);
  AlDeleteBuffers(1, @buffer2);
  AlDeleteSources(1, @source2);
  AlutExit();
end;

procedure TForm1.OpenUI(shen:boolean);
begin

  if shen=false then defineparbonuses;

  if invmode=true then
  begin
    invmode:=false;
    showenemy:=false;
  end
  else
  begin
    invmode:=true;
    try
      if shen=false then
        spelltosee:=FindNextSpell(totcards-1,player)
      else
        spelltosee:=FindNextSpell(totcards-1,enemy);
    except end;
  end;

  intren:=true;
end;


procedure Tform1.ActivateTrap(ttp,x,y,v:integer);
var np,i,j,k:integer;
    m1,m2:string;
    trno:integer;
    dn,cn:integer;
begin
  acx:=x;
  acy:=y;
  if v=0 then
  begin
    dn:=cells[x,y].doorno;
    cn:=cells[x,y].chestno;
  end;
  if v=1 then
  begin
    dn:=x;
    cn:=y;
  end;
    if ttp=1 then
    begin
      StartBattle(dn);
      if v=0 then
        cells[x,y].trap:=false;
    end;
    if ttp=2 then
    begin
      cells[dn,cn].passable:=true;
      if v=0 then
        cells[x,y].trap:=false;
    end;
    if ttp=3 then
    begin
      cells[dn,cn].passable:=true;
      cells[dn,cn].wall:=false;
      cells[dn,cn].ceil:=true;
      cells[dn,cn].floor:=true;
      BuildCell(dn,cn);
      cells[x,y].trap:=false;
    end;
    if ttp=4 then
    begin
      cells[x,y].trap:=false;
      np:=Random(4);
      if np=0 then
      begin
        player.bstr:=player.bstr+2;
        ShowRequestForm(strarr[11],strarr[12],0,1,0,'');
      end;
      if np=1 then
      begin
        player.bint:=player.bint+2;
        ShowRequestForm(strarr[13],strarr[14],0,1,0,'');
      end;
      if np=2 then
      begin
        player.bspd:=player.bspd+2;
        ShowRequestForm(strarr[15],strarr[16],0,1,0,'');
      end;
      if np=3 then
      begin
        player.bend:=player.bend+2;
        ShowRequestForm(strarr[17],strarr[18],0,1,0,'');
      end;
    end;

    if ttp=5 then
    begin
      cells[x,y].trap:=false;
      if cells[x,y].spritename='spr_keyshrines' then cells[x,y].spritename:='spr_keyshrinee';
      BuildCell(x,y);
      skeys:=skeys+1;
      if CheckCodedPerkEff(player,3)>0 then
      begin
        if Random(100)<20 then skeys:=skeys+1;
      end;
    end;

    if ttp=6 then
    begin
      cells[x,y].trap:=false;
      if cells[x,y].spritename='spr_keyshrineg' then cells[x,y].spritename:='spr_keyshrinee';
      BuildCell(x,y);
      gkeys:=gkeys+1;
      if CheckCodedPerkEff(player,3)>0 then
      begin
        if Random(100)<10 then gkeys:=gkeys+1;
      end;
    end;

    if ttp=7 then
    begin
      for i:=0 to dw do
      for j:=0 to dh do
      begin
        if (cells[i,j].textid=dn) then
        begin
          if (cells[i,j].wall=false) then
          begin
             cells[i,j].wall:=true;
             cells[i,j].passable:=false;
             cells[i,j].ceil:=false;
             cells[i,j].floor:=false;
          end
          else
          begin
            cells[i,j].wall:=false;
            cells[i,j].passable:=true;
            cells[i,j].ceil:=true;
            cells[i,j].floor:=true;
          end;
          BuildCell(i,j);
          //cells[x,y].trap:=false; <--we don't deactivate this trap
        end;
      end;
    end;

    if ttp=8 then
    begin
      plx:=dn;
      ply:=cn;
      teleportframe:=1;
      DoSound('snd_port');
      port:=true;
    end;

    if ttp=9 then
    begin
      Memo1.Lines.LoadFromFile(gameexe+'\text\'+lang+'\txt_'+inttostr(dn)+'_h.txt');
      m1:=Memo1.Text;
      Memo1.Lines.LoadFromFile(gameexe+'\text\'+lang+'\txt_'+inttostr(dn)+'.txt');
      m2:=Memo1.Text;
      ShowRequestForm(m1,m2,0,1,0,'');
    end;

    if ttp=10 then
    begin
      Memo1.Lines.LoadFromFile(gameexe+'\text\'+lang+'\txt_'+inttostr(dn)+'_h.txt');
      m1:=Memo1.Text;
      Memo1.Lines.LoadFromFile(gameexe+'\text\'+lang+'\txt_'+inttostr(dn)+'.txt');
      m2:=Memo1.Text;
      ShowRequestForm(m1,m2,0,10,0,'');
    end;

    if ttp=11 then
    begin
      Memo1.Lines.LoadFromFile(gameexe+'\scripts\scr_'+inttostr(cells[x,y].doorno)+'.txt');
      j:=0;
      k:=0;
      {for i:=0 to Memo1.Lines.Count-1 do
      begin
        j:=j+1;
        if j=1 then etrap.tet:=strtoint(Memo1.Lines[i]);
        if j=2 then etrap.tex:=strtoint(Memo1.Lines[i]);
        if j=3 then
        begin
          etrap.tey:=strtoint(Memo1.Lines[i]);
          j:=0;
          ActivateTrap(etrap.tet,etrap.tex,etrap.tey,1);
        end;
      end;  }
      for i:=0 to Memo1.Lines.Count-1 do
      begin
        if k=0 then begin try etrap[j].tet:=strtoint(Memo1.Lines[i]); except etrap[j].tet:=0; end; end;
        if k=1 then begin try etrap[j].tex:=strtoint(Memo1.Lines[i]); except etrap[j].tex:=0; end; end;
        if k=2 then begin try etrap[j].tey:=strtoint(Memo1.Lines[i]); except etrap[j].tey:=0; end; end;
        k:=k+1;
        if k>2 then
        begin
          k:=0;
          j:=j+1;
        end;
      end;

      for i:=0 to j do
      begin
        try ActivateTrap(etrap[i].tet,etrap[i].tex,etrap[i].tey,1); except end;
      end;

    end;

    if ttp=12 then
    begin
      //angelic altar
      if player.spec=0 then
      begin
        ShowRequestForm(strarr[98],strarr[99],1,20,0,'');
      end
      else
      begin
        ShowRequestForm(strarr[98],strarr[97],0,1,0,'');
      end;
    end;
    if ttp=13 then
    begin
      //demonic altar
      if player.spec=0 then
      begin
        ShowRequestForm(strarr[98],strarr[100],1,21,0,'');
      end
      else
      begin
        ShowRequestForm(strarr[98],strarr[97],0,1,0,'');
      end;
    end;
    if ttp=14 then
    begin
      //undead altar
      if player.spec=0 then
      begin
        ShowRequestForm(strarr[98],strarr[101],1,22,0,'');
      end
      else
      begin
        ShowRequestForm(strarr[98],strarr[97],0,1,0,'');
      end;
    end;

    if ttp=15 then
    begin
      //scroll stand
      AddNewCard(true,dn,true,true,false,player);
      //ShowRequestForm(strarr[25],strarr[33],0,5,0,'');
      if v=0 then
      begin
        cells[x,y].trap:=false;
        cells[x,y].spritename:='spr_stand_e';
        BuildCell(x,y);
      end;
    end;

    if ttp=16 then
    begin
      //add an item
      if dn=-1 then
      begin
        k:=RandomLoot;
      end
      else k:=dn;
      AddItem(k,1);
      if v=0 then
      begin
        cells[x,y].trap:=false;
        BuildCell(x,y);
      end;
    end;

    if ttp=17 then
    begin
      levelsteps:=round(levelsteps/2);
      ShowRequestForm(strarr[320],strarr[321],0,1,0,'');
      if v=0 then
        cells[x,y].trap:=false;
    end;

    if ttp=18 then
    begin
      //fire altar
      if player.element<>dn then
      begin
        ShowRequestForm(strarr[363],strarr[359]+' '+GetElName(dn,strarr)+'. '+strarr[360],1,39+dn,0,'');
      end
      else
      begin
        ShowRequestForm(strarr[363],strarr[362]+' '+GetElName(dn,strarr)+'. ',0,1,0,'');
      end;
    end;

    if ttp=19 then
    begin
      //orb of wisdom
      ShowRequestForm(strarr[384],strarr[385],0,1,0,'');
      AddPerkPoints(1);
      if v=0 then
        cells[x,y].trap:=false;
    end;

end;


procedure TForm1.ActivateCell(x,y:integer);
var ccont,rspell,i,np:integer;
    done,doopen:boolean;
    stxt:string;
begin


  ProcessLights;

  minimapc[x,y]:=true;


  actcx:=x;
  actcy:=y;

  //CELLSCRIPT
  if fileexists(gameexe+'\levels\'+mapid+'\script_'+inttostr(x)+'_'+inttostr(y)+'.txt') then
  begin
    Memo1.Lines.LoadFromFile(gameexe+'\levels\'+mapid+'\script_'+inttostr(x)+'_'+inttostr(y)+'.txt');
    stxt:=Memo1.Text;
    //ShowMessage('Reading script');
    stxt:=preparescript(stxt);
    readscript(stxt);
  end;

  //OPEN DOOR
  if (cells[x,y].door=true) and (cells[x,y].passable=false) then
  begin

    doopen:=false;
    if cells[x,y].power=0 then
    begin
      doopen:=true;
      DoSound('snd_door');
    end;
    if (cells[x,y].power=1) then
    begin
      if skeys>0 then
      begin
        skeys:=skeys-1;
        doopen:=true;

        DoSound('snd_door');

      end
      else
      begin
        ShowRequestForm(strarr[19],strarr[20],0,1,0,'');

        DoSound('snd_locked');

      end;
    end;

    if (cells[x,y].power=2) then
    begin
      if gkeys>0 then
      begin
        gkeys:=gkeys-1;
        doopen:=true;

        DoSound('snd_door');

      end
      else
      begin
        ShowRequestForm(strarr[21],strarr[22],0,1,0,'');
        DoSound('snd_locked');
      end;
    end;

    if doopen=true then
    begin
      cells[x,y].passable:=true;
    end;

    BuildCell(x,y);

  end;

  //OPEN CHEST
  if (cells[x,y].chest=true) and (cells[x,y].passable=false) then
  begin
    ccont:=random(4);
    if Random(100)<20 then ccont:=5;
    doopen:=false;
    if cells[x,y].power=0 then
    begin
      doopen:=true;
      DoSound('snd_chest');
    end;
    if (cells[x,y].power=1) then
    begin
      if skeys>0 then
      begin
        skeys:=skeys-1;
        doopen:=true;
        DoSound('snd_chest');
        if ccont<2 then ccont:=2+random(3);
      end
      else
      begin
        ShowRequestForm(strarr[19],strarr[23],0,1,0,'');
        DoSound('snd_locked');
      end;
    end;

    if (cells[x,y].power=2) then
    begin
      if gkeys>0 then
      begin
        gkeys:=gkeys-1;
        doopen:=true;
        DoSound('snd_chest');
        if ccont<3 then ccont:=3+random(2);
      end
      else
      begin
        ShowRequestForm(strarr[21],strarr[24],0,1,0,'');
        DoSound('snd_locked');
      end;
    end;


    if doopen=true then
    begin

      if ccont=0 then
      begin
        ShowRequestForm(strarr[25],strarr[30],0,1,0,'');
      end;
      if ccont=1 then
      begin
        ShowRequestForm(strarr[25],strarr[31],0,1,0,'');
        skeys:=skeys+1;
      end;
      if ccont=2 then
      begin
        ShowRequestForm(strarr[25],strarr[32],0,1,0,'');
        gkeys:=gkeys+1;
      end;
      if ccont=3 then
      begin
        AddNewCard(true,-1,true,true,false,player);
        //ShowRequestForm(strarr[25],strarr[33],0,5,0,'');
      end;
      if ccont=4 then
      begin
        np:=random(4);
        if np=0 then
        begin
          player.bstr:=player.bstr+1;
          ShowRequestForm(strarr[25],strarr[26],0,1,0,'');
        end;
        if np=1 then
        begin
          player.bint:=player.bint+1;
          ShowRequestForm(strarr[25],strarr[27],0,1,0,'');
        end;
        if np=2 then
        begin
          player.bspd:=player.bspd+1;
          ShowRequestForm(strarr[25],strarr[28],0,1,0,'');
        end;
        if np=3 then
        begin
          player.bend:=player.bend+1;
          ShowRequestForm(strarr[25],strarr[29],0,1,0,'');
        end;
      end;
      if ccont=5 then
      begin
        Memo1.Lines.LoadFromFile(gameexe+'\items\lootlist.txt');
        np:=strtoint(Memo1.lines[Random(Memo1.Lines.Count)]);
        AddItem(np,1);
      end;

      cells[x,y].passable:=true;

    end;


    BuildCell(x,y);

  end;

  //ACTIVATE TRAP
  if cells[x,y].trap=true then
  begin
    ActivateTrap(cells[x,y].traptype,x,y,0);
  end;

  defineparbonuses;

  FullMBW(mbd);

end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var moved:boolean;
    rs:integer;
begin

  rs:=random(120-tsb);
  moved:=false;

  if Key=VK_LEFT then
  begin
    if (mmmode=false) and (invmode=false) and (btlmode=false) and
       (itemlistmode=false) and (rqform=false) then
      PlayerTurn(-1);
  end;

  if Key=VK_RIGHT then
  begin
    if (mmmode=false) and (invmode=false) and (btlmode=false) and
       (itemlistmode=false) and (rqform=false) then
      PlayerTurn(1);
  end;

  if Key=VK_UP then
  begin
    if (mmmode=false) and (invmode=false) and (btlmode=false) and
       (itemlistmode=false) and (rqform=false) then
    begin
      moved:=true;
      MovePlayer(cdx,cdy,rs);
    end;
  end;

  if Key=VK_DOWN then
  begin
    if (mmmode=false) and (invmode=false) and (btlmode=false) and
       (itemlistmode=false) and (rqform=false) then
    begin
      moved:=true;
      MovePlayer((-1)*cdx,(-1)*cdy,rs);
    end;
  end;
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
var moved:boolean;
    rs:integer;
begin

  rs:=random(120-tsb);
  moved:=false;

  if rqform=false then
  begin
    if (key = 'J') or (key = 'j') or (key = 'Î') or (key = 'î') then
    begin
      {if mapmode=true then mapmode:=false
      else mapmode:=true;}
      if showmm=true then showmm:=false else showmm:=true;
      //Form12.Show;
    end;
    if (key = 'M') or (key = 'm') or (key = 'Ü') or (key = 'ü') then
    begin
      {if mapmode=true then mapmode:=false
      else mapmode:=true;}
      if showmm=true then showmm:=false else showmm:=true;
      //Form12.Show;
    end;
    if (key = 'D') or (key = 'd') or (key='Â') or (key='â') then
    begin
      if (mmmode=false) and (invmode=false) and (btlmode=false) and
       (itemlistmode=false) and (rqform=false) then
        PlayerTurn(1);
    end;
    if (key = 'A') or (key = 'a') or (key='Ô') or (key='ô') then
    begin
      if (mmmode=false) and (invmode=false) and (btlmode=false) and
       (itemlistmode=false) and (rqform=false) then
        PlayerTurn(-1);
    end;
    if (key = 'W') or (key = 'w') or (key='Ö') or (key='ö') then
    begin
      if (mmmode=false) and (btlmode=false) and (invmode=false) and (rqform=false) then
      begin
        moved:=true;
        MovePlayer(cdx,cdy,rs);
      end;
    end;
    if (key = 'S') or (key = 's') or (key='Û') or (key='û') then
    begin
      if (mmmode=false) and (btlmode=false) and (invmode=false) and (rqform=false) then
      begin
        moved:=true;
        MovePlayer((-1)*cdx,(-1)*cdy,rs);
      end;
    end;
  end;

  if rqform=true then
  begin
    if (rf_case=0) then
    begin
      //waiting for text
      rf_main_text:=rf_main_text+Key;
    end;
  end;
end;

procedure TForm1.SaveGame;
begin
  with Form2 do
  begin
    SaveMap(gameexe+'\saves\saved.map',false);
    SaveChar(Player,gameexe+'\saves\chsave1.sav');
    SavePlayer(gameexe+'\saves\chsave2.sav');
    SaveGS(gameexe+'\saves\gslist.txt');
    SaveJSeq(gameexe+'\saves\jseq.txt');
    with form1.playerlight do
      form2.savelight(ConstAttenuation,LinearAttenuation,QuadraticAttenuation,
                      Diffuse.Red,Diffuse.Green,Diffuse.Blue,2);
  end;
  ShowRequestForm(strarr[34],strarr[35],0,1,0,'');
end;


function canmovethere(kx,ky:integer):boolean;
begin
  with cells[plx,ply] do
  if ((kx<>0) and ((kx=blockx1) or (kx=blockx2))) or
     ((ky<>0) and ((ky=blocky1) or (ky=blocky2))) then
  begin
    result:=false; //path is blocked
  end
  else result:=true; //path is opened
end;


procedure TForm1.MovePlayer(kx,ky,rs:integer);
var aaa,atk,bla:integer;
begin



  if (cells[plx+kx,ply+ky].passable=true) and (canmovethere(kx,ky)=true) and
     ((mcam.Position.X=reqx) and (mcam.Position.y=reqy))
  then
  begin
    tsb:=tsb+1;
    defineparbonuses;
    plx:=plx+kx;
    ply:=ply+ky;
    reqx:=plx*20;
    reqy:=ply*20;
    reqz:=cells[plx+kx,ply+ky].plz;

    //initiating battle
    if (rs<=5) and (cells[plx,ply].trap=false) and (tsb>=5) then
    begin
      tsb:=0;
      StartBattle(-1);
      atk:=1;
      if random(40)<10 then
      repeat
        aaa:=random(2);
        atk:=atk+1;
        if random(2)=0 then
          bla:=GetRandomMonsterToFight
        else
          bla:=-1;
        AddToBL(bla);
      until (aaa=0) or (atk>=round(player.lvl/2)) or (atk>10);
    end;

    CheckLevelSwitch;
    ActivateCell(plx,ply);
    levelsteps:=levelsteps+1;
    //port:=true;

    DoSound('snd_footsteps');

  end;
end;


procedure TForm1.ToggleMenu;
begin
  if (rqform=false) and (btlmode=false) then
  begin
    if (mmmode=true) then
    begin
      if (mapid<>'mm_map') then
      begin
        mmmode:=false;
        gmmode:=true;
      end;
    end
    else
    begin
      mmmode:=true;
      gmmode:=false;
      invmode:=false;
      //btlmode:=false;
      itemlistmode:=false;
    end;
  end;
end;


procedure TForm1.PlayerTurn(sd:integer);
begin
  lookside:=lookside+sd;
  if lookside<0 then lookside:=3;
  if lookside>3 then lookside:=0;

  if spareproc=true then MonitorBlockVisibility(plx,ply,mbd,false);
end;


procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var moved:boolean;
    rs:integer;
    txt:string; i:integer;
begin

  rs:=random(120-tsb+difficulty);

  moved:=false;
  //cleaning text
  if (key=VK_BACK) and (rqform=True) and
     ((rf_case=0)) then
  begin
    rf_main_text:='';
  end;

  if KEY=VK_RETURN then
  begin
    if (rqform=true) then ClickGButton(48);
  end;

  if Key=VK_SPACE then
  begin
    if (mmmode=false) and (invmode=false) and (btlmode=false) and
       (itemlistmode=false) and (rqform=false) then
      ActivateCell(plx+cdx,ply+cdy);
  end;

  if key=VK_F4 then
  begin
    Form2.Show;
  end;

  if key=VK_F5 then
  begin
    BuildLevel;
  end;

  if key=VK_F6 then
  begin
    ClearLevel;
    RandomMap;
    BuildLevel;
    GoToStart;
  end;

  if key=VK_F7 then
  begin
    StartBattle(-1);
  end;

  if key=VK_F8 then
  begin
    if hardcore=false then
      SaveGame
    else
      ShowRequestForm(strarr[305],strarr[306],0,1,0,'');
  end;

  if key=VK_F9 then
  begin
    Form5.show;
  end;

  if key=VK_F10 then
  begin
    txt:='';
    If invmode=true then txt:=txt+'invmode ';
    If itemlistmode=true then txt:=txt+'itemlistmode ';
    If mmmode=true then txt:=txt+'mmmode ';
    If btlmode=true then txt:=txt+'btlmode ';
    If showenemy=true then txt:=txt+'showenemy ';
    If chargen=true then txt:=txt+'chargen ';
    ShowMessage(txt);
  end;

  if (key = VK_TAB) and ([ssShift]*Shift=[]) and (mmmode=false) and (chargen=false) then
  begin
    OpenUI(false);
  end;

  if (Key=VK_ESCAPE) then
  begin
    ToggleMenu;
  end;

  {if (key=VK_F12) and (btlmode=true) then
  begin
    txt:='';
    txt:='  e  /  p  '+#13#10;
    for i:=0 to 5 do
    begin
      txt:=txt+inttostr(i)+') '+deck[enemy.hand[i]].name+' / '+deck[player.hand[i]].name+#13#10;
      //if i<>5 then txt:=txt+#13#10;
    end;
    ShowMessage(txt);
  end; }

  if (key=VK_F12) and (rqform=true) then
  begin
    txt:='current: '+rf_ttl_text+'; '+rf_main_text+'; '+rf_img+#13#10;
    for i:=1 to 10000 do
    begin
      with rqfpool[i] do
      if active=true then
      begin
        txt:=txt+rqfpool[i].ttl_text+'; '+main_text+'; '+img+#13#10;
        //if i<>5 then txt:=txt+#13#10;
      end;
    end;
    ShowMessage(txt);
  end;

  intren:=true;

end;

procedure TForm1.FormResize(Sender: TObject);
begin
  intren:=true;
  ucf1.x:=usedcard.Width/2+5;
  ucf1.y:=scrn.Height/2;
  ucf2.x:=scrn.Width-(usedcard2.Width/2+5);
  ucf2.y:=scrn.Height/2;
  ProcessLoadScreen;
end;


procedure TForm1.FormShow(Sender: TObject);
begin
  //InitFullscreen;
end;

procedure TForm1.InitFullscreen;
begin

  if fullscreen=true then
  begin
    Form1.FormStyle:=fsStayOnTop;
    Form1.BorderStyle:=bsNone;
    Form1.Width:=Screen.Width;
    Form1.Height:=Screen.Height;
    Form1.WindowState:=wsNormal;
    Form1.WindowState:=wsMaximized;
    GLSceneViewer1.Refresh;
  end
  else
  begin
    Form1.FormStyle:=fsNormal;
    Form1.BorderStyle:=bsSizeable;
    Form1.WindowState:=wsNormal;
    Form1.WindowState:=wsMaximized;
    GLSceneViewer1.Refresh;
  end;

end;


function TForm1.getilundercursor(x,y:integer):integer;
var i,j,iic:integer;
begin
  //returns number of item in inventory
  i:=round((x-60)/68);
  j:=round((y-60)/68);
  if ((i<0) or (i>9) or (j<0) or (j>9)) then
    result:=-1
  else
    result:=itemlist[i,j,ilpage];
end;


procedure TForm1.SetupItemList;
var i,k,s,p,j,nk,ns,np:integer;
    inputlist:array[0..999]of integer;
    mnr,amnr:string;
    sw:boolean;
    tw:integer;
    iic:integer;
begin

  //1. Read and place items, sort them
  for k:=0 to 9 do
  for s:=0 to 9 do
  for p:=0 to 9 do
    itemlist[k,s,p]:=-1;


  for i:=0 to 999 do inputlist[i]:=i;

  if showspell=false then   //sorting items
  begin

    repeat

      sw:=false;
      for i:=0 to 998 do
      begin
        if (itms[inputlist[i]].itmtype<itms[inputlist[i+1]].itmtype) then
        begin
          sw:=true;
          iic:=inputlist[i];
          inputlist[i]:=inputlist[i+1];
          inputlist[i+1]:=iic;
        end;
      end;

    until (sw=false);

  end;


  if showspell=true then  //sorting spells
  begin

    repeat

      sw:=false;
      for i:=0 to 998 do
      begin
        if (deck[inputlist[i]].govskill>deck[inputlist[i+1]].govskill) then
        begin
          sw:=true;
          iic:=inputlist[i];
          inputlist[i]:=inputlist[i+1];
          inputlist[i+1]:=iic;
        end;
      end;

    until (sw=false);

  end;


  k:=0;
  s:=0;
  p:=0;
  for i:=0 to 999 do
  begin
    if showspell=false then
    begin
      if itms[inputlist[i]].count>0 then begin itemlist[k,s,p]:=inputlist[i]; k:=k+1; end  //adding an item
    end
    else
    begin
      if player.spellbook[inputlist[i]]=true then begin itemlist[k,s,p]:=inputlist[i]; k:=k+1; end; //adding a spell
    end;
    if k=9 then begin k:=0; s:=s+1; end; //next row
    if s=9 then begin s:=0; p:=p+1; end; //next page
  end;


  //2. Display itemlist
  p:=ilpage; //we look at current page
  if showspell=false then mnr:='itm' else mnr:='ch'; //we're showing an item or a card
  if showspell=false then amnr:='' else amnr:='';
  for k:=0 to 9 do  //we draw all items for page
  for s:=0 to 9 do
  begin
    if itemlist[k,s,p]<>-1 then
    begin
      itemslot[k,s].Material.LibMaterialName:=mnr+'_'+inttostr(itemlist[k,s,p])+amnr;
      itemslot[k,s].Material.FrontProperties.Emission.Red:=100;
      itemslot[k,s].Material.FrontProperties.Emission.Green:=100;
      itemslot[k,s].Material.FrontProperties.Emission.Blue:=100;
      if    ((mnr='itm') and ((asword=itemlist[k,s,p]) or (abow=itemlist[k,s,p]) or (aarm=itemlist[k,s,p])))
         or ((mnr='ch') and (player.spellen[itemlist[k,s,p]]=true)) then
      begin
        itemslot_frame[k,s].Material.LibMaterialName:='sframe_2';
      end
      else
      begin
        itemslot_frame[k,s].Material.LibMaterialName:='sframe_1';
      end;

      if (mnr='itm') and (itemlist[k,s,p]=pitem) then itemslot_frame[k,s].Material.LibMaterialName:='sframe_3';
      if (mnr='ch') and (itemlist[k,s,p]=fdc) then itemslot_frame[k,s].Material.LibMaterialName:='sframe_3';

      itemslot_frame[k,s].Material.FrontProperties.Emission.Red:=100;
      itemslot_frame[k,s].Material.FrontProperties.Emission.Green:=100;
      itemslot_frame[k,s].Material.FrontProperties.Emission.Blue:=100;

      if showspell=false then
      begin
        case itms[itemlist[k,s,p]].itmtype of
        0:itemslot_icon[k,s].Material.LibMaterialName:='iico_misc';
        1:itemslot_icon[k,s].Material.LibMaterialName:='iico_sword';
        2:itemslot_icon[k,s].Material.LibMaterialName:='iico_bow';
        3:itemslot_icon[k,s].Material.LibMaterialName:='iico_shield';
        4:itemslot_icon[k,s].Material.LibMaterialName:='iico_helm';
        end;

        itemslot_text[k,s].Text:=inttostr(itms[itemlist[k,s,p]].count);
        {itemslot_text[k,s].ModulateColor.Red:=1;
        itemslot_text[k,s].ModulateColor.Green:=0;
        itemslot_text[k,s].ModulateColor.Blue:=0;}

      end
      else
        case deck[itemlist[k,s,p]].govskill of
        0:itemslot_icon[k,s].Material.LibMaterialName:='iico_sword';
        1:itemslot_icon[k,s].Material.LibMaterialName:='iico_bow';
        2:itemslot_icon[k,s].Material.LibMaterialName:='iico_wand';
        3:itemslot_icon[k,s].Material.LibMaterialName:='iico_shield';
        end;

    end
    else
    begin
      itemslot[k,s].Material.LibMaterialName:='itm_0';
      itemslot[k,s].Material.FrontProperties.Emission.Red:=0;
      itemslot[k,s].Material.FrontProperties.Emission.Green:=0;
      itemslot[k,s].Material.FrontProperties.Emission.Blue:=0;
      itemslot_frame[k,s].Material.FrontProperties.Emission.Red:=0;
      itemslot_frame[k,s].Material.FrontProperties.Emission.Green:=0;
      itemslot_frame[k,s].Material.FrontProperties.Emission.Blue:=0;


    end;
  end;

  //3. Place everything in order
  itemlistbg.Width:=70*10+20;
  itemlistbg.Height:=70*10+20;
  itemlistbg.Position.X:=itemlistbg.Width/2+4;
  itemlistbg.Position.Y:=itemlistbg.Height/2+4;
  itemlistbg.MoveFirst;
  for k:=0 to 9 do
  for s:=0 to 9 do
  begin
    with itemslot[k,s] do
    begin
      if itemlist[k,s,p]<>-1 then
      begin
        Visible:=true;
        Position.X:=60+(k*60)+(k*8);
        Position.Y:=70+(s*60)+(s*5);
        if showspell=false then
        begin
          Width:=60;
          Height:=60;
          //tta[iic].text:=items[itemlist[k,s,p]]
        end
        else
        begin
          Width:=60;
          Height:=35;
        end;

      end
      else Visible:=false;
    end;
    with itemslot_frame[k,s] do
    begin
      if itemlist[k,s,p]<>-1 then
      begin
        Visible:=true;
        Position.X:=60+(k*60)+(k*8);
        Position.Y:=70+(s*60)+(s*5);
        Width:=60;
        Height:=60;
      end
      else Visible:=false;
    end;

    with itemslot_icon[k,s] do
    begin
      if itemlist[k,s,p]<>-1 then
      begin
        Visible:=true;
        Position.X:=60+(k*60)+(k*8)+30;
        Position.Y:=70+(s*60)+(s*5)-30;
        Width:=24;
        Height:=24;
      end
      else Visible:=false;
    end;

    with itemslot_text[k,s] do
    begin
      if (itemlist[k,s,p]<>-1) and (showspell=false) then
      begin
        Visible:=true;
        Position.X:=60+(k*60)+(k*8);
        Position.Y:=70+(s*60)+(s*5)+10;

      end
      else Visible:=false;


    end;

  end;

  //4. adding text
  with itemlisttitle do
  begin
    Position.X:=itemlistbg.Width/4;
    Position.Y:=itemlistbg.Position.Y-itemlistbg.Height/2;
    Text:=strarr[191]+' ('+strarr[192]+' '+inttostr(ilpage+1)+'/10)';
  end;
  with ilitemtitle do
  begin
    Position.X:=itemlistbg.Width/4;
    Position.Y:=itemlistbg.Position.Y+itemlistbg.Height/2;
    Text:='';
  end;
end;

function TForm1.GetRfWidth(text:string):integer;
var i,cl,longl:integer;
    gws,cws:string;
begin

  longl:=0; cl:=0; cws:=''; gws:='';
  for i:=1 to Length(text) do
  begin
    if (text[i]=#10) or (text[i]=#13) then
    begin
      if cl>longl then longl:=cl;
      cws:=gws;
      cl:=0;
      gws:='';
    end
    else
    begin
      cl:=cl+1;
      gws:=gws+text[i];
    end;
  end;
  if cl>longl then
  begin
    longl:=cl;
    cws:=gws;
  end;
  //Result:=longl*(GLWindowsBitmapFont2.CalcStringWidth('a'))+40;
  Result:=GLWindowsBitmapFont2.CalcStringWidth(cws)+80;

end;

procedure Tform1.GetDirsFromLookside(ls:integer; var dirx,diry:integer);
begin
  case ls of
  0:begin
      dirx:=1;
      diry:=0;
    end;
  1:begin
      dirx:=0;
      diry:=-1;
    end;
  2:begin
      dirx:=-1;
      diry:=0;
    end;
  3:begin
      dirx:=0;
      diry:=1;
    end;
  end;
end;

function TForm1.ShowCardInfo(iuc:integer):string;
var gotbonuses:boolean;
    itmtxt:string;
    gsl,ptdmg:integer;
    pst,pin,pend,psp:integer;
begin
      itmtxt:='';
      with deck[iuc] do
      if (player.spellbook[iuc]=true) and (iuc>=0) and (iuc<=1000) then
      begin
        pst:=(player.strength);
        pin:=(player.intelligence);
        pend:=(player.endurance);
        psp:=(player.speed);
        itmtxt:=itmtxt+strarr[210]+': ';
        if govskill=0 then begin itmtxt:=itmtxt+strarr[40]+#13#10; gsl:=round(player.sword*(1+(pst/100))) end;
        if govskill=1 then begin itmtxt:=itmtxt+strarr[41]+#13#10; gsl:=round(player.bow*(1+(psp/100))) end;
        if govskill=2 then begin itmtxt:=itmtxt+strarr[43]+#13#10; gsl:=round(player.magic*(1+(pin/100))) end;
        if govskill=3 then begin itmtxt:=itmtxt+strarr[42]+#13#10; gsl:=round(player.armor*(1+(pend/100))) end;
        itmtxt:=itmtxt+#13#10;
        itmtxt:=itmtxt+#13#10;
        itmtxt:=itmtxt+strarr[212]+#13#10;

        gotbonuses:=false;
        if dmgph>0 then
        begin
          if mindam=dmgph then
          begin
            itmtxt:=itmtxt+strarr[213]+': '+inttostr(dmgph)+#13#10;
            gotbonuses:=true;
          end
          else
          begin
            itmtxt:=itmtxt+strarr[213]+': '+inttostr(mindam)+' - '+inttostr(dmgph)+#13#10;
            gotbonuses:=true
          end;

        end;

        if ((dmgph>0) or (dmgperc>0)) and (itemlistmode=false) then
        begin
          ptdmg:=CalcDmg(iuc,gsl,pst,psp,pin,pend,
                         enemy.strength,enemy.speed,enemy.intelligence,enemy.endurance,player,enemy,false,false)
        end
        else
        begin
          ptdmg:=0;
        end;

        if dmgperc>0 then begin itmtxt:=itmtxt+strarr[216]+': '+inttostr(dmgperc)+'%'+#13#10; gotbonuses:=true; end;
        if addhp>0 then begin itmtxt:=itmtxt+strarr[218]+': '+inttostr(addhp)+' '+strarr[214]+#13#10; gotbonuses:=true; end;
        if addmp>0 then begin itmtxt:=itmtxt+strarr[219]+': '+inttostr(addhp)+' '+strarr[215]+#13#10; gotbonuses:=true; end;
        if element>=0 then begin itmtxt:=itmtxt+strarr[358]+': '+GetElName(element,strarr)+#13#10; gotbonuses:=true; end;
        if addeffect>0 then begin itmtxt:=itmtxt+strarr[211]+': '+GetETypeName(addeffect,strarr)+' ('+inttostr(efflgth)+' '+strarr[217]+')'+#13#10; gotbonuses:=true; end;
        if addeffect>0 then begin itmtxt:=itmtxt+GetETypeDesc(addeffect,strarr)+#13#10; gotbonuses:=true; end;
        if (effdir=0) and (addeffect>0) then begin itmtxt:=itmtxt+strarr[270]+': '+' '+strarr[268]+#13#10; gotbonuses:=true; end;
        if (effdir=1) and (addeffect>0) then begin itmtxt:=itmtxt+strarr[270]+': '+' '+strarr[269]+#13#10; gotbonuses:=true; end;
        if (accum=true) and (addeffect>0) then begin itmtxt:=itmtxt+strarr[271]+'.'+#13#10; gotbonuses:=true; end;
        if (consumes<>-1) then begin itmtxt:=itmtxt+strarr[311]+': '+itms[consumes].overridename+#13#10; gotbonuses:=true; end;
        if bonam>0 then begin itmtxt:=itmtxt+strarr[234]+': '+GetEClassName(bont,strarr)+' (+'+inttostr(bonam)+'%)'+#13#10; gotbonuses:=true; end;
        if bonam<0 then begin itmtxt:=itmtxt+strarr[234]+': '+GetEClassName(bont,strarr)+' ('+inttostr(bonam)+'%)'+#13#10; gotbonuses:=true; end;

        if gotbonuses=false then itmtxt:=itmtxt+'-'+#13#10;

        itmtxt:=itmtxt+#13#10;
        itmtxt:=itmtxt+strarr[220]+#13#10;
        gotbonuses:=false;

        if mc>0 then begin itmtxt:=itmtxt+strarr[215]+': '+inttostr(mc)+#13#10; gotbonuses:=true; end;
        if hpc>0 then begin itmtxt:=itmtxt+strarr[214]+': '+inttostr(hpc)+#13#10; gotbonuses:=true; end;

        if gotbonuses=false then itmtxt:=itmtxt+'-'+#13#10;

        if ptdmg>0 then itmtxt:=itmtxt+#13#10+#13#10+strarr[341]+': '+inttostr(ptdmg)+#13#10;

      end
      else
      begin
        itmtxt:='';
      end;

      result:=itmtxt;

end;


procedure TForm1.ProcessButtons;
begin


  try
  for i:=0 to mb do
  begin

    gbtnv[i].visible:=false;

    if mmmode=true then
    begin
      gbtnv[i].Visible:=mmbutset[i];
    end;
    if gmmode=true then
    begin
      gbtnv[i].Visible:=gmbutset[i];
    end;
    if invmode=true then
    begin
      gbtnv[i].Visible:=imbutset[i];
    end;

  end;
  except err:=err+' genbuts '; end;

  try
  //buttons with special treatment

  gbtnv[8].visible:=csperkbg.Visible;
  gbtnv[9].visible:=csperkbg.Visible;
  gbtnv[18].visible:=csperkbg.Visible;

  gbtnv[38].visible:=inventory.Visible;
  gbtnv[39].visible:=inventory.Visible;
  gbtnv[50].visible:=inventory.Visible;

  if csperkbg.Visible=true then
  begin
    gbtnv[8].x:=round(csperkbg.Position.X+csperkbg.Width/2-gbtnv[8].w-5);
    gbtnv[9].x:=round(csperkbg.Position.X-csperkbg.Width/2+gbtnv[9].w+5);
    gbtnv[18].x:=round(csperkbg.Position.X);
    gbtnv[8].y:=round(csperkbg.Position.y+csperkbg.height/2-gbtnv[8].h-5);
    gbtnv[9].y:=round(csperkbg.Position.y+csperkbg.height/2-gbtnv[8].h-5);
    gbtnv[18].y:=round(csperkbg.Position.y+csperkbg.height/2-gbtnv[8].h-5);
    if player.perks[perklist[currperk]]=true then
    begin
      gbtnv[18].caption:=strarr[176];
    end
    else
    begin
      gbtnv[18].caption:=strarr[117];
    end;
    gbtnv[19].caption:=strarr[174]+' ('+inttostr(perkpoints)+')';
  end;

  if (invmode=true) and (showenemy=false) and (player.bonuspoints>0) then
  begin
    if gbtnv[1].visible=false then gbtnv[1].visible:=true;
    if gbtnv[2].visible=false then gbtnv[2].visible:=true;
    if gbtnv[3].visible=false then gbtnv[3].visible:=true;
    if gbtnv[4].visible=false then gbtnv[4].visible:=true;
  end
  else
  begin
    if gbtnv[1].visible=true then gbtnv[1].visible:=false;
    if gbtnv[2].visible=true then gbtnv[2].visible:=false;
    if gbtnv[3].visible=true then gbtnv[3].visible:=false;
    if gbtnv[4].visible=true then gbtnv[4].visible:=false;
  end;


  if inventory.Visible=true then
  begin
    with gbtnv[38] do
    begin
      x:=round(itemlistbg.Position.X-itemlistbg.Width/2+w);
      y:=round(itemlistbg.Position.Y+itemlistbg.Height/2-h);
    end;
    with gbtnv[39] do
    begin
      x:=round(itemlistbg.Position.X+itemlistbg.Width/2-w);
      y:=round(itemlistbg.Position.Y+itemlistbg.Height/2-h);
    end;
    with gbtnv[50] do
    begin
      x:=round(itemlistbg.Position.X+itemlistbg.Width/2-w);
      y:=round(itemlistbg.Position.Y-itemlistbg.Height/2+h);
    end;
  end;

  if mmmode=true then
  begin
    with gbtnv[20] do
    begin
      x:=round(scrn.Width/2);
      y:=round(scrn.Height/2-80);
    end;
    with gbtnv[52] do
    begin
      x:=round(scrn.Width/2);
      y:=round(scrn.Height/2-40);
    end;
    with gbtnv[21] do
    begin
      x:=round(scrn.Width/2);
      y:=round(scrn.Height/2);
    end;
    with gbtnv[32] do
    begin
      x:=round(scrn.Width/2);
      y:=round(scrn.Height/2+40);
    end;
    with gbtnv[36] do
    begin
      x:=round(scrn.Width/2);
      y:=round(scrn.Height/2+80);
    end;
    with gbtnv[22] do
    begin
      x:=round(scrn.Width/2);
      y:=round(scrn.Height/2+120);
    end;
    with titlecard do
    begin
      Position.X:=scrn.Width/2;
      Position.Y:=Height/2+5;
    end;
  end;

  if invmode=true then
  begin
    {with charpic do
    begin
      //Position.X:=csbackground.position.x+csbackground.Width/2+charpic.Width/2+40;
      //Position.Y:=csbackground.position.y;
    end;}

    try


    try
    with gbtnv[0] do
    begin
      if chargen=true then
      begin
        w:=150;
        h:=40;
        x:=round(csbackground.Position.X+csbackground.Width/2-w/2-15);
        y:=round(csbackground.Position.Y-csbackground.Height/2+h/2+60);
        caption:=strarr[342];
      end
      else
      begin
        w:=90;
        h:=30;
        x:=round(csbackground.Position.X+csbackground.Width/2-w/2-10);
        y:=round(csbackground.Position.Y-csbackground.Height/2+h/2+60);
        caption:=strarr[0];
      end;
    end;  except err:=err+' 0 '; end;

    try
    with gbtnv[37] do
    begin
      If chargen=true then visible:=true else visible:=false;
      y:=Round(char_name.Position.Y);
      x:=Round(csbackground.Position.X-csbackground.Width/2);
    end;   except err:=err+' 37 '; end;
    try
    with gbtnv[23] do
    begin
      If chargen=true then visible:=true else visible:=false;
      x:=round((csbackground.Position.X+csbackground.Width/2)+((GLSceneViewer1.Width-(csbackground.Position.X+csbackground.Width/2))/2)-w/2-5);
      y:=round(GLSceneViewer1.Height-h/2-5);
      {x:=round(bpart1.Position.X-w/2-5);
      y:=round(bpart1.Position.Y+bpart1.Height/2-h/2-5);}
    end;     except err:=err+' 23 '; end;
    try
    with gbtnv[24] do
    begin
      If chargen=true then visible:=true else visible:=false;
      x:=round((csbackground.Position.X+csbackground.Width/2)+((GLSceneViewer1.Width-(csbackground.Position.X+csbackground.Width/2))/2)+w/2+5);
      y:=round(GLSceneViewer1.Height-h/2-5);
      {x:=round(bpart1.Position.X+w/2+5);
      y:=round(bpart1.Position.Y+bpart1.Height/2-h/2-5);}
    end; except err:=err+' 24 '; end;
    try
    with gbtnv[25] do
    begin
      If chargen=true then visible:=true else visible:=false;
      x:=round(gbtnv[23].x-gbtnv[23].w/2-w/2-20);
      y:=round(gbtnv[23].y-h-5);
    end;  except err:=err+' 25 '; end;
    try
    with gbtnv[26] do
    begin
      If chargen=true then visible:=true else visible:=false;
      x:=round(gbtnv[23].x-gbtnv[23].w/2-w/2-20);
      y:=round(gbtnv[23].y);
    end;  except err:=err+' 26 '; end;
    try
    with gbtnv[27] do
    begin
      If chargen=true then visible:=false else visible:=false;
      x:=round(gbtnv[23].x-gbtnv[23].w/2-w/2-20);
      y:=round(gbtnv[23].y+h+5);
    end;  except err:=err+' 27 '; end;
    try
    with gbtnv[34] do
    begin
      If showenemy=false then visible:=false else visible:=false;
      x:=round(aitem.Position.X);
      y:=round(aitem.Position.Y+aitem.Height/2+5+gbtnv[33].h/2);
    end; except err:=err+' 34 '; end;

    except err:=err+' inv0-34 '; end;

    try

    with gbtnv[29] do
    begin
       //items
      If (showenemy=false) and (chargen=false) {and (btlmode=false)} then visible:=true else visible:=false;
      x:=Round(csbackground.Position.X+csbackground.Width/2-w/2-20);
      y:=Round(csbackground.Position.Y+h+5);
      {x:=round(gbtnv[33].X+(w/2)-gbtnv[33].w/2);
      y:=round(aitem.Position.Y+aitem.Height/2+5+gbtnv[33].h/2+(h+5));}
    end;

    with gbtnv[30] do
    begin
      //spells
      If (showenemy=false) then visible:=false else visible:=true;
      x:=Round(csbackground.Position.X+csbackground.Width/2-w/2-20);
      y:=Round(csbackground.Position.Y);
      {x:=round(gbtnv[30].X);
      y:=round(gbtnv[30].y+gbtnv[30].h/2+h*2);}
    end;


    with gbtnv[47] do
    begin
      //spells
      If (showenemy=false) and (chargen=false) {and (btlmode=false)} then visible:=true else visible:=false;
      x:=Round(csbackground.Position.X+csbackground.Width/2-w/2-20);
      y:=Round(csbackground.Position.Y);
      {x:=round(gbtnv[30].X);
      y:=round(gbtnv[30].y+gbtnv[30].h/2+h*2);}
    end;

    except err:=err+' spellitm '; end;

    try

    with gbtnv[33] do
    begin
      If showenemy=false then visible:=false else visible:=false;
      x:=round(gbtnv[34].x-(gbtnv[34].w/2)-gbtnv[33].w/2-5);
      y:=gbtnv[34].y;
    end;

    with gbtnv[35] do
    begin
      If showenemy=false then visible:=false else visible:=false;
      x:=round(gbtnv[34].x+(gbtnv[34].w/2)+gbtnv[35].w/2+5);
      y:=gbtnv[34].y;
    end;

    with gbtnv[46] do
    begin
      If (showenemy=false) or (invmode=true) then
      begin
        visible:=false;
        if player.spellen[spelltosee]=true then
          caption:=strarr[168]
        else
          caption:=strarr[167];
      end
      else visible:=false;
    end;

    with gbtnv[19] do
    begin
      If showenemy=false then
      begin
        visible:=true;
        x:=Round(csbackground.Position.X+csbackground.Width/2-w/2-20);
        y:=round(csbackground.Position.Y+h*2+10);
      end
      else visible:=false;
    end;

    except err:=err+' blocked? '; end;

    try

    if (showenemy=true) and (aitem.visible=true) then
    begin
      aitem.Visible:=false
    end;

    if (showenemy=false) and (aitem.visible=false) then
    begin
      aitem.Visible:=false
    end;

    if (showenemy=true) and (aitem_name.visible=true) then
    begin
      aitem_name.Visible:=false
    end;

    if (showenemy=false) and (aitem_name.visible=false) then
    begin
      aitem_name.Visible:=false
    end;

    except err:=err+' aitem '; end;
  end;



  try

  if rqform=true then
  begin
    with gbtnv[48] do
    begin
      x:=round(reqform.Position.X+reqform.Width/2-w/2-5);
      y:=round(reqform.Position.Y+reqform.Height/2+5);
      visible:=true;
    end;
    with gbtnv[49] do
    begin
      x:=round(reqform.Position.X-reqform.Width/2+w/2+5);
      y:=round(reqform.Position.Y+reqform.Height/2+5);
      if rf_type<>0 then
        visible:=true;
    end;

    with gbtnv[55] do
    begin
      x:=round(reqform.Position.X+reqform.Width/2+w/2+5);
      y:=round(reqform.Position.Y);
      if rf_case=44 then
        visible:=true
      else
        visible:=false;
    end;

    with gbtnv[56] do
    begin
      x:=round(reqform.Position.X-reqform.Width/2-w/2-5);
      y:=round(reqform.Position.Y);
      if rf_case=44 then
        visible:=true
      else
        visible:=false;
    end;

    with gbtnv[57] do
    begin
      x:=round(reqform.Position.X+reqform.Width/2+w/2+5);
      y:=round(reqform.Position.Y+h+5);
      if rf_case=44 then
        visible:=true
      else
        visible:=false;
    end;

    with gbtnv[58] do
    begin
      x:=round(reqform.Position.X-reqform.Width/2-w/2-5);
      y:=round(reqform.Position.Y+h+5);
      if rf_case=44 then
        visible:=true
      else
        visible:=false;
    end;


    //CHOICE MODE
    if rf_case=25 then
    begin
      if gbtnv[48].visible=true then gbtnv[48].visible:=false;
      if gbtnv[49].visible=true then gbtnv[49].visible:=false;


      with gbtnv[40] do
      begin
        x:=round(scrn.Width/2);
        y:=round(reqform.Position.Y+(reqform.Height/2)+60);
        gbtnv[40].visible:=true;
        if caption='-' then visible:=false;
      end;

      with gbtnv[41] do
      begin
        x:=round(scrn.Width/2);
        y:=round(reqform.Position.Y+(reqform.Height/2)+60*2);
        gbtnv[41].visible:=true;
        if caption='-' then visible:=false;
      end;

      with gbtnv[42] do
      begin
        x:=round(scrn.Width/2);
        y:=round(reqform.Position.Y+(reqform.Height/2)+60*3);
        gbtnv[42].visible:=true;
        if caption='-' then visible:=false;
      end;

      with gbtnv[43] do
      begin
        x:=round(scrn.Width/2);
        y:=round(reqform.Position.Y+(reqform.Height/2)+60*4);
        gbtnv[43].visible:=true;
        if caption='-' then visible:=false;
      end;

      with gbtnv[44] do
      begin
        x:=round(scrn.Width/2);
        y:=round(reqform.Position.Y+(reqform.Height/2)+60*5);
        gbtnv[44].visible:=true;
        if caption='-' then visible:=false;
      end;

      with gbtnv[45] do
      begin
        x:=round(scrn.Width/2);
        y:=round(reqform.Position.Y+(reqform.Height/2)+60*6);
        gbtnv[45].visible:=true;
        if caption='-' then visible:=false;
      end;
    end;
    //END CHOICE MODE

  end;

  if rqform=false then
  begin
    if gbtnv[48].visible=true then gbtnv[48].visible:=false;
    if gbtnv[49].visible=true then gbtnv[49].visible:=false;
    if gbtnv[40].visible=true then gbtnv[40].visible:=false;
    if gbtnv[41].visible=true then gbtnv[41].visible:=false;
    if gbtnv[42].visible=true then gbtnv[42].visible:=false;
    if gbtnv[43].visible=true then gbtnv[43].visible:=false;
    if gbtnv[44].visible=true then gbtnv[44].visible:=false;
    if gbtnv[45].visible=true then gbtnv[45].visible:=false;
  end;
  except err:=err+' rqform '; end;

  except err:=err+' spectreat '; end;


  try
  if (btlmode=true) then
  begin

    //form1.Caption:='cimx1='+booltostr(cimx1)+'; cimx2='+BoolToStr(cimx2);

    with gbtnv[10] do
    begin
      if (invmode=false) and (itemlistmode=false) and (mmmode=false) and ((cimx1=false) and (cimx2=false)) then
        visible:=true
      else
        visible:=false;
      x:=scx-round(w/2)-2*w-20*3;
      y:=sh-h-10;
      matoverride:='card_'+inttostr(player.hand[0])+'_';
    end;
    with gbtnv[11] do
    begin
      if (invmode=false)and (itemlistmode=false) and (mmmode=false)and((cimx1=false) and (cimx2=false)) then
        visible:=true
      else
        visible:=false;
      x:=scx-round(w/2)-w-20*2;
      y:=sh-h-10;
      matoverride:='card_'+inttostr(player.hand[1])+'_';
    end;
    with gbtnv[12] do
    begin
      if (invmode=false)and (itemlistmode=false) and (mmmode=false)and((cimx1=false) and (cimx2=false)) then
        visible:=true
      else
        visible:=false;
      x:=scx-round(w/2)-10;
      y:=sh-h-10;
      matoverride:='card_'+inttostr(player.hand[2])+'_';
    end;
    with gbtnv[13] do
    begin
      if (invmode=false)and (itemlistmode=false) and (mmmode=false)and((cimx1=false) and (cimx2=false)) then
        visible:=true
      else
        visible:=false;
      x:=scx+round(w/2)+10;
      y:=sh-h-10;
      matoverride:='card_'+inttostr(player.hand[3])+'_';
    end;
    with gbtnv[14] do
    begin
      if (invmode=false)and (itemlistmode=false) and (mmmode=false)and((cimx1=false) and (cimx2=false)) then
        visible:=true
      else
        visible:=false;
      x:=scx+round(w/2)+w+20*2;
      y:=sh-h-10;
      matoverride:='card_'+inttostr(player.hand[4])+'_';
    end;
    with gbtnv[15] do
    begin
      if (invmode=false)and (itemlistmode=false) and (mmmode=false)and((cimx1=false) and (cimx2=false)) then
        visible:=true
      else
        visible:=false;
      x:=scx+round(w/2)+w*2+20*3;
      y:=sh-h-10;
      matoverride:='card_'+inttostr(player.hand[5])+'_';
    end;

    with gbtnv[53] do //fight disc
    begin
      if (invmode=false) and (itemlistmode=false) and (mmmode=false) and ((cimx1=false) and (cimx2=false)) and (CheckCodedPerkEff(player,18)>0) then
        visible:=true
      else
        visible:=false;
      x:=gbtnv[10].x;
      y:=gbtnv[10].y-round(gbtnv[10].h/2)-5-round(h/2);
      matoverride:='card_'+inttostr(player.hand[6])+'_';
    end;

    with gbtnv[16] do
    begin
      if (invmode=false)and (itemlistmode=false) and (mmmode=false)and((cimx1=false) and (cimx2=false)) then
        visible:=true
      else
        visible:=false;
      x:=gbtnv[15].x;
      y:=gbtnv[15].y+round(gbtnv[15].h/2+5+h/2);

      if ((player.speed>=35) and (skipped=false)) then
      begin
        caption:=strarr[206];
        tooltip:=strarr[300];
      end
      else
      begin
        caption:=strarr[62];
        tooltip:=strarr[299];
      end;

    end;

    with gbtnv[31] do
    begin
      if (invmode=false) and (itemlistmode=false)and (mmmode=false) then
        visible:=true
      else
        visible:=false;
      x:=gbtnv[16].x;
      y:=gbtnv[16].y+h+5;
    end;

    with gbtnv[30] do
    begin
      //matname:='none';
      matoverride:='card_'+inttostr(spelltosee)+'_';
    end;

    with gbtnv[17] do
    begin
      if (invmode=false) and (itemlistmode=false)then
        visible:=true
      else
        visible:=false;
      retch:=round(((player.speed-enemy.speed)/(enemy.speed+player.speed))*100);
      if (player.e[1]>0) or (player.e[23]>0) then retch:=round(retch/2);
      if retch>100 then retch:=100;
      if retch<0 then retch:=0;
      caption:=strarr[127]+' ('+inttostr(retch)+'%)';
      x:=gbtnv[31].x-round(gbtnv[31].w)-5;
      y:=gbtnv[31].y;
    end;


  end;
  except err:=err+' btlmodeprc ';  end;


  //finalizing button visualization

  try

  for i:=0 to mb do
  begin

    //defining button properties
    with gbtnv[i] do
    begin

      if (i=ab) and (state=0) then state:=1;
      if (i=ab) and (ab=oldab) and (state=2) then state:=2;
      if (ab<>oldab) or (ab<>i) then state:=0;
      if ab=-1 then state:=0;

      if matoverride<>'' then
        desbmn:=matoverride+inttostr(state)
      else
        desbmn:='but_'+inttostr(state);
    end;




    //processing visible button part
    if gbtnv[i].visible=true then
    begin
      with gbtn[i] do
      begin
        if desbmn<>gbtnv[i].matname then
        begin
          Material.LibMaterialName:=desbmn;
          gbtnv[i].matname:=desbmn;
          matchc:=matchc+1;
          //Form1.Caption:='Mapname mismatch'
        end
        else
        begin
          //Form1.Caption:='Mapname matches'
        end;
        position.x:=gbtnv[i].x;
        position.Y:=gbtnv[i].y;
        width:=gbtnv[i].w;
        Height:=gbtnv[i].h;
        Visible:=true;
      end;
      with gbtnt[i] do
      begin
        Alignment:=taCenter;
        Layout:=TGLTextLayout.tlCenter;
        position.x:=gbtnv[i].x;//-(gbtnv[i].w/2)+(0.05*gbtnv[i].w);
        position.Y:=gbtnv[i].y;//-(gbtnv[i].h/2)+(0.05*gbtnv[i].h);
        Text:=gbtnv[i].caption;
        visible:=true;
      end;
    end
    else
    begin
      gbtn[i].Visible:=false;
      gbtnt[i].Visible:=false;
    end;

  end;

  except err:=err+' finvis '; end;

end;


function CheckOvershoot(ccc,rcc,ac:real):boolean;
var res:boolean;
begin
  res:=false;

  if ac>0 then
  begin
    if ccc>rcc then res:=true;
  end;

  if ac<0 then
  begin
    if ccc<rcc then res:=true;
  end;

  if ac=0 then
  begin
    if rcc<>ccc then res:=true;
  end;

  result:=res;
end;


procedure TForm1.PositionCamera(deltatime:real);
begin
  with mcam do
  begin

    //DepthOfView:=mbd*20;

    if (mapmode=false) and (reqz<>cells[plx,ply].plz) then
      reqz:=cells[plx,ply].plz;
    {else
      Position.Z:=200;}

    mkz:=0;

    if position.Z<>reqz then
    begin
      if Position.z<reqx then mkz:=1;
      if Position.z>reqx then mkz:=-1;
      if Position.z=reqx then mkz:=0;
      Position.z:=Position.z+mkz*(mspeed/10)*deltatime;
      //if abs(Position.X-reqx)<=(1.1*(mspeed/10)*deltatime) then Position.x:=reqx;
      if CheckOvershoot(position.z,reqz,mkz)=true then Position.z:=reqz;
    end;


    if (mapmode=false) and (reqx<>plx*20) then
      reqx:=plx*20;
    {else
      reqx:=plx*20;}


    if editmode=true then Position.Z:=200;

    mkx:=0;

    if position.X<>reqx then
    begin
      if Position.X<reqx then mkx:=1;
      if Position.X>reqx then mkx:=-1;
      if Position.X=reqx then mkx:=0;
      Position.X:=Position.X+mkx*(mspeed/10)*deltatime;
      //if abs(Position.X-reqx)<=(1.1*(mspeed/10)*deltatime) then Position.x:=reqx;
      if CheckOvershoot(position.x,reqx,mkx)=true then Position.x:=reqx;
    end;

    if (mapmode=false) and (reqy<>ply*20) then
      reqy:=ply*20;
    {else
      reqy:=ply*20;}

    mky:=0;
    if position.Y<>reqy then
    begin
      if Position.Y<reqy then mky:=1;
      if Position.Y>reqy then mky:=-1;
      if Position.Y=reqy then mky:=0;
      Position.Y:=Position.Y+mky*(mspeed/10)*deltatime;
      //if abs(Position.Y-reqy)<=(1.1*(mspeed/10)*deltatime) then Position.Y:=reqy;
      if CheckOvershoot(position.Y,reqy,mky)=true then Position.Y:=reqy;
    end;

    if {((abs(Position.X-reqx)>20) or (abs(Position.Y-reqy)>20)) and} (port=true) then
    begin
      Position.X:=reqx; Position.Y:=reqy;
      port:=false;
      //showmessage('port!');
    end;

    GetDirsFromLookside(lookside,cdx,cdy);

    if (mapmode=false) and (mm=false) then
    begin
      GLSceneViewer1.Buffer.FogEnvironment.FogEnd:=fogd;
      mcam.DepthOfView:=camd;
      Up.X:=0;
      Up.Y:=0;
      Up.Z:=1;

      if Direction.X<cdx then Direction.X:=Direction.X+(deltatime*tspeed/10);
      if Direction.Y<cdy then Direction.y:=Direction.y+(deltatime*tspeed/10);
      if Direction.X>cdx then Direction.X:=Direction.X-(deltatime*tspeed/10);
      if Direction.Y>cdy then Direction.y:=Direction.y-(deltatime*tspeed/10);
      if ( abs(direction.X-cdx)<=(deltatime*tspeed/10) ) then
      begin
        Direction.X:=cdx;
        if spareproc=true then FullMBW(mbd);
      end;
      if ( abs(direction.Y-cdy)<=(deltatime*tspeed/10) ) then
      begin
        Direction.y:=cdy;
        if spareproc=true then FullMBW(mbd);
      end;
      if ( abs(direction.X-cdx)>1 ) then Direction.X:=cdx;
      if ( abs(direction.Y-cdy)>1 ) then Direction.y:=cdy;

      {Direction.X:=cdx;
      Direction.Y:=cdy;}
      Direction.Z:=0;
    end
    else
    begin
      if (mmmode=false) and (rqform=false) and (invmode=false) and (itemlistmode=false) and (btlmode=false) then
      begin
        mcam.TurnAngle:=mcam.TurnAngle+(mx-mposx)*0.1;
        cdx:=Round(mcam.Direction.X);
        cdy:=Round(mcam.Direction.y);
        if (cdx=1) and (cdy=0) then lookside:=0;
        if (cdx=0) and (cdy=-1) then lookside:=1;
        if (cdx=-1) and (cdy=0) then lookside:=2;
        if (cdx=0) and (cdy=1) then lookside:=3;
      end;
      {GLSceneViewer1.Buffer.FogEnvironment.FogEnd:=1000;
      mcam.DepthOfView:=1000;
      Up.X:=0;
      Up.Y:=1;
      Up.Z:=0;
      Direction.X:=0;
      Direction.Y:=0;
      Direction.Z:=-1;}
    end;


    if editmode=true then
    begin
      Up.Z:=0;
      Up.Y:=1;
      up.X:=0;
      direction.Y:=0;
      direction.X:=0;
      direction.Z:=-1;
      Position.Z:=200;
      Position.X:=wcx*20;
      Position.Y:=wcy*20;
    end;

  end;
end;


procedure TForm1.PositionLight;
begin
  with playerlight do
  begin
    Position.X:=mcam.Position.X;
    Position.Y:=mcam.Position.Y;
    Position.Z:=mcam.Position.Z;
    //Position.X:=plx*20;
    //Position.Y:=ply*20;
    LinearAttenuation:=0.01;
    ConstAttenuation:=1;
    QuadraticAttenuation:=0.001;
  end;
end;

procedure TForm1.AddPerkPoints(n:integer);
begin
  perkpoints:=perkpoints+n;
  ShowRequestForm(strarr[366],strarr[367]+': '+inttostr(n),0,1,1,'');
end;

procedure TForm1.AddAttrPoints(n:integer;useperk:boolean);
var bpq:integer;
begin
  bpq:=n;
  if useperk=true then
  begin
    bpq:=bpq+CheckCodedPerkEff(player,16);
  end;
  player.bonuspoints:=player.bonuspoints+bpq;
  ShowRequestForm(strarr[368],strarr[369]+': '+inttostr(bpq),0,1,1,'');
end;


procedure TForm1.LevelUp;
begin
  if player.xp>player.xpreq then
  begin
    player.xpreq:=player.xpreq*2;
    player.lvl:=player.lvl+1;
    ShowRequestForm(strarr[46],player.name+strarr[47]+inttostr(player.lvl),0,1,1,'');
    AddAttrPoints(4,true);
    if ((player.lvl mod 4)=0) then
    begin
      AddPerkPoints(1);
    end;
    if ((player.lvl mod 2)=0) then
    begin
      AddNewCard(true,-1,true,true,false,player);
    end;
  end;
end;

procedure TForm1.PlayerBTurn;
var pebon:integer;
    totmb:integer;
    i:integer;
    minddef:integer;
begin
  //initiates the turn for player
  //ShuffleHand(0);

  if (player.e[9]>0) and (ia=false) then //<-insanity
  begin
    minddef:=random(CheckCodedPerkEff(player,15)*100+player.intelligence);//insanity check
    if (minddef<70) then
    begin
      PlayerDrawCard(random(6));
    end
    else
    begin
      ia:=true;
    end;
  end;

  {if player.e[21]>0 then
  begin
    for i:=0 to 5 do player.hand[i]:=euphcard;
  end;}


  pebon:=random(2)+CheckCodedPerkEff(player,12);
  if (pebon>0) and (manado=true) then
  begin
    totmb:=pebon*random(round(player.intelligence/10));
    player.mana:=player.mana+totmb;
    dp:=setupdp(strarr[377]);
    if totmb>0 then AddDmgPop(turn,dp+inttostr(totmb),2);
    if player.mana>player.manamax then player.mana:=player.manamax;
    manado:=false;
  end;

  //pbt:=true;

end;


procedure TForm1.ControlBattle;
var shf:boolean;
begin

  if (btlmode=true) and ((cimx1=false) and (cimx2=false)) then
  begin

   //checking DEFEAT
   if (player.hp<=0) or (enemy.hp<=0) then
   begin

     if (player.hp<=0) and (CheckCodedPerkEff(player,2)>0) and (random(100)<=9) then
     begin
       player.hp:=round(player.hpmax/10);
     end;

     btlmode:=false;
     if player.hp<=0 then
     begin
       for i:=0 to 10 do battlelist[i]:=-2;
       hpkept:=-1;
       mpkept:=-1;
       KillPlayer;
     end;

     hpkept:=player.hp;
     mpkept:=player.mana;

     if (enemy.hp<=0) then
     begin
       AddXP(1,getcharworth(enemy),player);
       if (enemy.loot>-2) and (enemy.lootchance>(Random(100)+1)) then
       begin
         if enemy.loot<>-1 then
           AddItem(enemy.loot,1)
         else
           AddItem(RandomLoot,Random(5));
       end;
     end;
     //else ShowRequestForm(strarr[128],strarr[129],0,1,1,'');

     for i:=1 to 100 do
     begin
       player.e[i]:=0;
       enemy.e[i]:=0;
       player.estr[i]:=0;
       enemy.estr[i]:=0;
     end;

     Form1.VisualizeBattle(0);
     bphase:=0;

   end;


   //processing turns
   if (player.hp>0) and (enemy.hp>0) then
   begin

     if bphase=1 then
     begin

       puc:=false;

       case turn of
       0:begin
           PlayerBTurn;
         end;

       1:begin
           MonsterTurn;
         end;
       end;

       if puc=true then
         bphase:=bphase+1;

     end;

     if bphase=2 then
     begin

       if keepturn=false then
       begin
         bphase:=bphase+1;
         turn:=turn+1;
         if dcrec>0 then
           dcrec:=dcrec-1;
       end
       else
       begin
         bphase:=1;
         keepturn:=false;
       end;

     end;

   end;

 end;

 if bphase=3 then
 begin
   if turn>1 then
   begin
     downeff; //<-lower effect states at the end of turn
     turn:=0;
   end;
   if turn<0 then turn:=0;

   if puc=true then
   begin
     ShuffleHand(enemy,false);
     ShuffleHand(player,false);
   end;

   bphase:=1;
 end;

 //setting mana/hp
 if btlmode=false then
 begin
   player.hpmax:=CalcMaxHP(player,1,false);
   player.manamax:=player.intelligence;
 end;
end;



procedure TForm1.CadencerRun(deltatime:real);
var i,j:integer;
    tc:character;
    ii:integer;
    rfta:string;
begin

  if wannaexit=true then
  begin
    GLCadencer1.Enabled:=false;
    exit;
    ShowMessage('cadencer stopped');
  end;

  cdrstate:=true;

  //runs the cadencer procs
  err:='';

  try


  if fsinit=false then
  begin
    InitFullscreen;
    fsinit:=true;
  end;

  //ORIGINAL CADENCER 1

  //application.ProcessMessages;

  if (mmmode=true) and (mapid='mm_map') then
    ProcessLights;

  with scrn do
  begin
    if ((fullscreen=false) or (Form1.Visible=true)) then
    begin
      Width:=GLSceneViewer1.Width;
      Height:=GLSceneViewer1.Height;
    end
    else
    begin
      Width:=xres;
      Height:=yres;
    end;
  end;

  IF LIP=FALSE THEN
  BEGIN

  try
  if block1=true then
  begin

     //GLOBALSCRIPTS
     if (mmmode=false) and (loadinprogress=false) and (lip=false) then
     begin
       try processglobscripts;  except ShowMessage('error gs processing'); end;
     end;


     //VISUALS
     //positioning camera

    PositionCamera(deltaTime);
    lsk:=levelsteps/(lskmod);


    //positioning light
    PositionLight;

    //positioning player on a map
    if playercone.Visible=true then playercone.Visible:=false;



    if reqform_dark.Visible<>reqform.Visible then reqform_dark.Visible:=reqform.Visible;

    if reqform_dark.Visible=true then
    with reqform_dark do
    begin
      Width:=scrn.Width;
      Height:=scrn.Height;
      Position.X:=scrn.Width/2;
      Position.Y:=scrn.Height/2;
    end;

    //dmgpops
    HandleDMGPops(deltaTime);

    //effects (new)
    if btlmode=true then
    begin
      player.hand[6]:=fdc;
      fillefflist;
      ShowChEffects;
    end
    else
    begin
      HideChEffects;
    end;

    if ((invmode=True)or (itemlistmode=true)) and (btlmode=true) then HideChEffects;


    //starting a battle from battlelist
    if (battlelist[0]<>-2) and (btlmode=false) then
    begin
      StartBattle(battlelist[0]);
      for i:=0 to 9 do
      begin
        battlelist[i]:=battlelist[i+1];
      end;
      battlelist[10]:=-2;
    end;

    if battlelist[0]=-2 then
    begin
      hpkept:=-1;
      mpkept:=-1;
    end;

    //checking armor and hat
    if player.cloth<>itms[aarm].l_armor then player.cloth:=itms[aarm].l_armor;
    if player.hat<>itms[ahat].l_hat then player.hat:=itms[ahat].l_hat;


    //working on itemlist
    if invmode=true then itemlistmode:=false;
    if mmmode=true then itemlistmode:=false;
    if rqform=true then itemlistmode:=false;
    //if btlmode=true then itemlistmode:=false;

    if (itemlistmode=true) then
    begin
      //invmode:=false;
      if inventory.Visible=false then inventory.Visible:=true;
    end
    else
    begin
      if inventory.Visible=true then inventory.Visible:=false;
    end;




  end;
  except err:=err+'b1'; end;

  try
  if block2=true then
  begin

    if itemlistmode=true then
    begin
      if invitmdesc.Visible=false then invitmdesc.Visible:=true;
      if invitmdesctxt.Visible=false then invitmdesctxt.Visible:=true;
      if invitmimage.Visible=false then invitmimage.Visible:=true;
      invitmdesc.Position.Y:=itemlistbg.Position.Y;
      invitmdesc.Width:=scrn.Width-itemlistbg.Width-20;
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
          if count>1 then begin itmtxt:=itmtxt+strarr[312]+': '+inttostr(count)+#13#10;; gotbonuses:=true; end;
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

      if showspell=false then
        itmtxt:=itmtxt+#13#10+#13#10+strarr[334]+#13#10+strarr[335]+#13#10+strarr[336]
      else
        itmtxt:=itmtxt+#13#10+#13#10+strarr[337]+#13#10+strarr[364];

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
  except err:=err+'b2'; end;

  try
  if block3=true then
  begin

    //showing and hiding additional UI elements of battle
    if btlmode=true then
    begin
      monster_img.Visible:=true;
      monster_name.Visible:=true;
      player_hp.Visible:=true;
      player_mp.Visible:=true;
      battle_message.Visible:=true;
      pl_hpbar.Visible:=true;
      pl_mpbar.Visible:=true;
      pl_hpbar_bg.Visible:=true;
      pl_mpbar_bg.Visible:=true;
      monster_hpbar.Visible:=true;
      monster_hpbar_bg.Visible:=true;
      monster_sign.Visible:=true;
      mimy:=round(scrn.Height-(scrn.Height-gbtnv[10].y)-gbtnv[10].h/2-30);
      mimx:=mimy;
      if monster_img.Width<mimx then monster_img.Width:=monster_img.Width+deltaTime*1000 else monster_img.Width:=mimx; //<-monster appear animation
      if monster_img.Height<mimy then monster_img.Height:=monster_img.Height+deltaTime*1000 else monster_img.Height:=mimy;
      monster_img.Position.X:=scrn.Width/2;
      monster_img.Position.Y:=mimy/2;
      monster_name.Position.X:=monster_img.Position.X-mimx/2;
      monster_name.Position.Y:=monster_img.Position.Y-mimy/2;
      player_hp.Position.X:=gbtnv[10].x-gbtnv[10].w/2; //scrn.Width/2-100;
      player_mp.Position.X:=player_hp.Position.X;
      player_hp.Position.Y:=gbtnv[10].y+gbtnv[10].h/2+5;
      player_mp.Position.Y:=gbtnv[10].y+gbtnv[10].h/2+5+GLWindowsBitmapFont2.Font.Size;
      monster_name.Text:=enemy.name+' - '+GetEClassName(enemy.spec,strarr)+' ('+strarr[48]+': '+inttostr(enemy.hp)+'/'+inttostr(enemy.hpmax)+')';
      player_hp.Text:=strarr[48]+':'+inttostr(player.hp)+'/'+inttostr(player.hpmax);
      player_mp.Text:=strarr[49]+':'+inttostr(player.mana)+'/'+inttostr(player.manamax);
      battle_message.Text:=bmsg;
      battle_message.Position.X:=10;
      battle_message.Position.Y:=player_hp.Position.Y+25;

      trbg.Visible:=true;
      trbg.Width:=scrn.Width;
      trbg.Height:=scrn.Height;
      trbg.position.X:=scrn.Width/2;
      trbg.Position.Y:=scrn.Height/2;

      //smalling buttons down
      for i:=0 to 5 do
      with cardind[i] do
      begin
        if ((width>140+cardmod) or (height>220+cardmod)) and (gbtnv[10+i].visible=true) then
        begin
          if visible=false then visible:=true;
          Position.X:=gbtnv[10+i].x;
          Position.Y:=gbtnv[10+i].y;
          if (width>140+cardmod) then width:=width-400*deltaTime else width:=gbtnv[10+i].w;
          if (height>220+cardmod) then height:=height-400*deltaTime else height:=gbtnv[10+i].h;
          if (Material.LibMaterialName<>'card_'+inttostr(player.hand[i])+'_0') then Material.LibMaterialName:='card_'+inttostr(player.hand[i])+'_0';
        end
        else
        begin
         if visible=true then visible:=false;
        end;
      end;


      //health and mana bars
      with pl_hpbar_bg do
      begin
        Position.X:=scrn.Width/2;
        Width:=abs((gbtnv[11].x-gbtnv[11].w/2)-(gbtnv[14].x+gbtnv[14].w/2));
        Position.Y:=player_hp.Position.Y+GLWindowsBitmapFont2.Font.Size/2;
        Height:=GLWindowsBitmapFont2.Font.Size;
      end;

      with pl_mpbar_bg do
      begin
        Position.X:=scrn.Width/2;
        Width:=abs((gbtnv[11].x-gbtnv[11].w/2)-(gbtnv[14].x+gbtnv[14].w/2));
        Position.Y:=player_mp.Position.Y+GLWindowsBitmapFont2.Font.Size/2;
        Height:=GLWindowsBitmapFont2.Font.Size;
      end;

      with monster_hpbar_bg do
      begin
        Position.X:=scrn.Width/2;
        Width:=mimx;
        Position.Y:=monster_name.Position.Y+1.5*GLWindowsBitmapFont1.Font.Size+10;
        Height:=GLWindowsBitmapFont1.Font.Size;
      end;

      pl_hpperc:=player.hp/player.hpmax; pl_rwhp:=pl_hpbar_bg.Width*pl_hpperc;
      pl_mpperc:=player.mana/player.manamax; pl_rwmp:=pl_mpbar_bg.Width*pl_mpperc;
      monster_hpperc:=enemy.hp/enemy.hpmax; mon_rwhp:=monster_hpbar_bg.Width*monster_hpperc;


      with pl_hpbar do
      begin
        delta:=abs(Width-pl_rwhp);
        if Width>pl_rwhp then Width:=Width-(delta*10)*deltaTime else Width:=Width+(delta*10)*deltaTime;
        //if <40 then Width:=pl_rwhp;
        Height:=GLWindowsBitmapFont2.Font.Size;
        Position.X:=pl_hpbar_bg.Position.X-pl_hpbar_bg.Width/2+pl_hpbar.Width/2;
        Position.Y:=pl_hpbar_bg.Position.Y;
      end;

      with pl_mpbar do
      begin
        delta:=abs(Width-pl_rwmp);
        if Width>pl_rwmp then Width:=Width-(delta*10)*deltaTime else Width:=Width+(delta*10)*deltaTime;
        Height:=GLWindowsBitmapFont2.Font.Size;
        Position.X:=pl_mpbar_bg.Position.X-pl_mpbar_bg.Width/2+pl_mpbar.Width/2;
        Position.Y:=pl_mpbar_bg.Position.Y;
      end;

      with monster_hpbar do
      begin
        delta:=abs(Width-mon_rwhp);
        if Width>mon_rwhp then Width:=Width-(delta*10)*deltaTime else Width:=Width+(delta*10)*deltaTime;
        Height:=GLWindowsBitmapFont1.Font.Size;
        Position.X:=monster_hpbar_bg.Position.X-monster_hpbar_bg.Width/2+monster_hpbar.Width/2;
        Position.Y:=monster_hpbar_bg.Position.Y;
      end;

      with monster_sign do
      begin
        Width:=60;
        Height:=60;
        Position.X:=monster_img.Position.X;
        Position.Y:=monster_img.Position.Y+monster_img.Height/2-monster_sign.Height/2;
      end;

      //played cards
      usedcard.Width:=140;
      usedcard.Height:=220;

      if ucn<>-1 then
        usedcard.Visible:=true
      else
        usedcard.Visible:=false;

      usedcard2.Width:=140;
      usedcard2.Height:=220;

      if ucn2<>-1 then
        usedcard2.Visible:=true
      else
        usedcard2.Visible:=false;

      //moving used cards

      sd:=100;
      cx1:=usedcard.Width/2+5;
      cy1:=scrn.Height/2;
      cx2:=scrn.Width-(usedcard2.Width/2+5);
      cy2:=scrn.Height/2;

      if (abs(ucf1.x-cx1)<=sd*2) then
      begin
        ucf1.x:=cx1;
        ucf1.y:=cy1;
        cimx1:=false;
      end
      else
      begin
        cimx1:=true;
        sx1:=ucf1.sx;
        sy1:=ucf1.sy;
        if sx1>cx1 then mx1:=-1 else mx1:=1;
        if sy1>cy1 then my1:=-1 else my1:=1;

        rx1:=ucf1.x;
        ry1:=ucf1.y;
        ry1:=((cy1-sy1)/(cx1-sx1))*rx1+cy1-((cy1-sy1)/(cx1-sx1))*cx1;

        ucf1.x:=ucf1.x+(sd*mx1)*deltaTime*20;
       ucf1.y:=ry1;
      end;

      if (abs(ucf2.x-cx2)<=sd*2) then
      begin
        ucf2.x:=cx2;
        ucf2.y:=cy2;
        cimx2:=false;
      end
      else
      begin
        cimx2:=true;
        sx2:=ucf2.sx;
        sy2:=ucf2.sy;

        if sx2>cx2 then mx2:=-1 else mx2:=1;
        if sy2>cy2 then my2:=-1 else my2:=1;

        rx2:=ucf2.x;
        ry2:=ucf2.y;
        ry2:=((cy2-sy2)/(cx2-sx2))*rx2+cy2-((cy2-sy2)/(cx2-sx2))*cx2;

        ucf2.x:=ucf2.x+(sd*mx2)*deltaTime*20;
        ucf2.y:=ry2;
      end;

      usedcard.Position.X:=ucf1.x;
      usedcard.Position.Y:=ucf1.y;
      usedcard2.Position.X:=ucf2.x;
      usedcard2.Position.Y:=ucf2.y;

    end;


    //INVMODE

    if (btlmode=false) or (invmode=true) or (itemlistmode=true) then //hide battle elements
    begin
      monster_img.Visible:=false;
      monster_name.Visible:=false;
      monster_sign.Visible:=false;
      player_hp.Visible:=false;
      player_mp.Visible:=false;
      battle_message.Visible:=false;
      usedcard.Visible:=False;
      usedcard2.Visible:=False;
      pl_hpbar.Visible:=false;
      pl_mpbar.Visible:=false;
      pl_hpbar_bg.Visible:=false;
      pl_mpbar_bg.Visible:=false;
      monster_hpbar.Visible:=false;
      monster_hpbar_bg.Visible:=false;
      trbg.Visible:=false;
      for i:=0 to 5 do
      with cardind[i] do
      begin
        if visible=true then visible:=false;
      end;
    end;


    if invmode=true then
    begin
      dccharscreen.Visible:=true;
      dctextdummy.Visible:=true;
    end
    else
    begin
      dccharscreen.Visible:=false;
      dctextdummy.Visible:=false;
    end;



    //enabling/disabling UI elements
    if mmmode=true then
    begin
      dcmenu.Visible:=True;
    end
    else
    begin
      dcmenu.Visible:=false;
    end;


  end;
  except err:=err+'b3'; end;

  try
  if block4=true then
  begin

    //show/hide request form
    if rqform=true then
    begin
      reqform.Visible:=true;
      reqform.MoveLast;

      //assigning request form image
      if (rf_img<>'') and (spellfound.Material.LibMaterialName<>rf_img) then
      begin
        //ShowMessage(rf_img);
        spellfound.Material.LibMaterialName:=rf_img;
      end;


      with reqform do
      begin

        basew:=500;
        baseh:=200;

        if rf_pos=0 then
        begin
          Position.X:=scrn.Width/2;
          Position.Y:=scrn.Height/2;
        end;

        if (rf_case<>10){ or (rf_case=25)} then //for normal circumstances
        begin
          if reqform.Material.LibMaterialName<>'ui_bg' then
            reqform.Material.LibMaterialName:='ui_bg';

          rf_title.ModulateColor.Red:=1;
          rf_title.ModulateColor.Green:=1;
          rf_title.ModulateColor.Blue:=1;
          rf_text.ModulateColor.Red:=1;
          rf_text.ModulateColor.Green:=1;
          rf_text.ModulateColor.Blue:=1;

          basew:=400;
          baseh:=200;

        end;

        if rf_pos=1 then
        begin
          Position.X:=scrn.Width/2;
          Position.Y:=Height/2+10;
        end;

        if (rf_case=10) or (rf_case=44) then  //for scroll
        begin
          if reqform.Material.LibMaterialName<>'rf_scrollbg' then
            reqform.Material.LibMaterialName:='rf_scrollbg';
          basew:=500;
          baseh:=700;
          rf_title.ModulateColor.Red:=0;
          rf_title.ModulateColor.Green:=0;
          rf_title.ModulateColor.Blue:=0;
          rf_text.ModulateColor.Red:=0;
          rf_text.ModulateColor.Green:=0;
          rf_text.ModulateColor.Blue:=0;
        end;

        if rf_case=25 then
        begin
          Position.X:=scrn.Width/2;
          Position.Y:=10+reqform.Height/2;
        end;


        //calc rf width
        rfw:=GetRfWidth(rf_main_text);
        if rfw<basew then rfw:=basew;
        if rfw>scrn.Width then rfw:=scrn.Width;

        rfh:=baseh;
        if rfh<baseh then rfh:=baseh;
        if (rfh>scrn.Height-100) then rfh:=scrn.Height-100;

        //end

        //ones which OVERRIDE w/h params
        if rf_case=11 then
        begin
          if reqform.Material.LibMaterialName<>rf_img then
            reqform.Material.LibMaterialName:=rf_img;
          if scrn.Width>scrn.Height then
          begin
            rfh:=scrn.Height-50;
            rfw:=round(800*(rfh/600));
          end;
          if scrn.Width<=scrn.Height then
          begin
            rfw:=scrn.Width-50;
            rfh:=round(600*(rfw/800));
          end;
          rf_title.ModulateColor.Red:=0;
          rf_title.ModulateColor.Green:=0;
          rf_title.ModulateColor.Blue:=0;
          rf_text.ModulateColor.Red:=0;
          rf_text.ModulateColor.Green:=0;
          rf_text.ModulateColor.Blue:=0;
        end;

        Width:=rfw;
        Height:=rfh;

      end;

      with rf_title do
      begin
        visible:=true;
        Position.X:=Reqform.Position.X-reqform.Width/2+20;
        Position.Y:=Reqform.Position.Y-reqform.Height/2+20;
        Text:=rf_ttl_text;
      end;
      with rf_text do
      begin
        visible:=true;
        Position.X:=Reqform.Position.X-reqform.Width/2+40;
        Position.Y:=Reqform.Position.Y-reqform.Height/2+60;
        Text:=rf_main_text;
        if rf_case=0 then
        begin
          ii:=Length(rf_main_text);
          if ii<10 then ii:=10;
          for i:=0 to (ii+2) do
          begin
            rfta:=rfta+'_';
          end;
          Text:=Text+'|'+#13#10+rfta;
        end;
      end;

      if (rf_case=5) or
         ((rf_case=25)and(rf_img<>'')) then
      begin
        spellfound.Visible:=true;
        spellfound.Height:=reqform.Height;
        spellfound.Width:=120*(reqform.Height/200);
        spellfound.Position.X:=reqform.Position.X+reqform.Width/2+5+spellfound.Width/2;
        spellfound.Position.Y:=reqform.Position.Y;
      end;

      if rf_case=99 then
      begin
        spellfound.Visible:=true;
        spellfound.Height:=reqform.Height;
        spellfound.Width:=reqform.Height;
        spellfound.Position.X:=reqform.Position.X+reqform.Width/2+5+spellfound.Width/2;
        spellfound.Position.Y:=reqform.Position.Y;
      end;

    end;
    if (rqform=false) and (reqform.Visible=true) then
    begin
      reqform.Visible:=false;
      rf_text.Visible:=false;
      rf_title.Visible:=false;
      spellfound.Visible:=false;
      //rf_img:='none';
    end;



    //forming and positioning character infosheet

    if (invmode=true) and (intren=true) then
    begin

      //constructing elements of battle ui
      if (btlmode=true) then
      begin
        if showenemy=true then
        begin
          try
            bpart1.Visible:=false;
            bpart2.Visible:=false;
            bpart3.Visible:=false;
            bpart4.Visible:=false;
            bpart5.Visible:=false;
            if player.spec<>0 then
              bpart6.Visible:=false;
            bpart7.Visible:=false;
            bpart8.Visible:=false;
            bpart9.Visible:=false;
            bpart10.Visible:=false;
            bpart11.Visible:=false;
            bpart12.Visible:=false;
            bpart13.Visible:=false;
            charpic.Visible:=true;
          except
          end;

        end
        else
        begin
          try
            bpart1.Visible:=true;
            bpart2.Visible:=true;
            bpart3.Visible:=true;
            bpart4.Visible:=true;
            bpart5.Visible:=true;
            if player.spec<>0 then
              bpart6.Visible:=true;
            bpart7.Visible:=true;
            bpart8.Visible:=true;
            bpart9.Visible:=true;
            bpart10.Visible:=true;
            bpart11.Visible:=true;
            bpart12.Visible:=true;
            bpart13.Visible:=true;
            charpic.Visible:=false;
          except
          end;
        end;

      end;

      if showenemy=false then formperkvisuals(player)
      else formperkvisuals(enemy);

      defineparbonuses;

      csbackground.MoveFirst;

      with icon1 do
      begin
        uin:=2;
        position.x:=csbackground.Position.X-(csbackground.Width/2)+5;
        Position.Y:=csbackground.Position.Y-(csbackground.Height/2)+30*uin+10;
        width:=30;
        height:=30;
      end;
      with icon2 do
      begin
        uin:=3;
        position.x:=csbackground.Position.X-(csbackground.Width/2)+5;
        Position.Y:=csbackground.Position.Y-(csbackground.Height/2)+30*uin+10;
        width:=30;
        height:=30;
      end;
      with icon3 do
      begin
        uin:=4;
        position.x:=csbackground.Position.X-(csbackground.Width/2)+5;
        Position.Y:=csbackground.Position.Y-(csbackground.Height/2)+30*uin+10;
        width:=30;
        height:=30;
      end;
      with icon4 do
      begin
        uin:=5;
        position.x:=csbackground.Position.X-(csbackground.Width/2)+5;
        Position.Y:=csbackground.Position.Y-(csbackground.Height/2)+30*uin+10;
        width:=30;
        height:=30;
      end;

      with icon5 do
      begin
        uin:=7;
        position.x:=csbackground.Position.X-(csbackground.Width/2)+5;
        Position.Y:=csbackground.Position.Y-(csbackground.Height/2)+30*uin+10;
        width:=30;
        height:=30;
      end;
      with icon6 do
      begin
        uin:=8;
        position.x:=csbackground.Position.X-(csbackground.Width/2)+5;
        Position.Y:=csbackground.Position.Y-(csbackground.Height/2)+30*uin+10;
        width:=30;
        height:=30;
      end;
      with icon7 do
      begin
        uin:=9;
        position.x:=csbackground.Position.X-(csbackground.Width/2)+5;
        Position.Y:=csbackground.Position.Y-(csbackground.Height/2)+30*uin+10;
        width:=30;
        height:=30;
      end;
      with icon8 do
      begin
        uin:=10;
        position.x:=csbackground.Position.X-(csbackground.Width/2)+5;
        Position.Y:=csbackground.Position.Y-(csbackground.Height/2)+30*uin+10;
        width:=30;
        height:=30;
      end;

      with char_name do
      begin
        uin:=1;
        Position.X:=csbackground.Position.X-(csbackground.Width/2)+20;
        Position.Y:=csbackground.Position.Y-(csbackground.Height/2)+30*uin;
        Position.Z:=-1;
        if showenemy=false then
          Text:=player.name+' ('+GetEClassName(player.spec,strarr)+' '+strarr[95]+' '+inttostr(player.lvl)+')'
        else
          Text:=enemy.name+' ('+GetEClassName(enemy.spec,strarr)+' '+strarr[95]+' '+inttostr(enemy.lvl)+')';
        BitmapFont:=GLWindowsBitmapFont1;
        Font.Name:='Bookman Old Style';
        Font.Size:=40;
        MoveLast;
      end;

      with element_icon do
      begin
        position.x:=csbackground.Position.X;
        Position.Y:=csbackground.Position.Y-csbackground.Height/2;;
        width:=64;
        height:=64;
        Material.MaterialLibrary:=matlib;
        if showenemy=false then tc:=player else tc:=enemy;
        Material.LibMaterialName:='element_'+inttostr(tc.element);
      end;

      with char_strength do
      begin
        uin:=2;
        Position.X:=csbackground.Position.X-(csbackground.Width/2)+30;
        Position.Y:=csbackground.Position.Y-(csbackground.Height/2)+30*uin;
        if (player.bstr<>player.strength) then
        begin
          if player.bstr<player.strength then
            pa:=' +'+inttostr(abs(ibstr))
          else
            pa:=' -'+inttostr(abs(ibstr));
        end
        else pa:='';
        if showenemy=false then
          Text:=strarr[36]+': '+inttostr(player.bstr)+pa
        else
          Text:=strarr[36]+': '+inttostr(enemy.strength);
        BitmapFont:=GLWindowsBitmapFont1;
        Font.Name:='Bookman Old Style';
        Font.Size:=25;
      end;

      with char_intelligence do
      begin
        uin:=3;
        Position.X:=csbackground.Position.X-(csbackground.Width/2)+30;
        Position.Y:=csbackground.Position.Y-(csbackground.Height/2)+30*uin;
        if (player.bint<>player.intelligence) then
        begin
          if player.bint<player.intelligence then
            pa:=' +'+inttostr(abs(ibint))
          else
            pa:=' -'+inttostr(abs(ibint));
        end
        else pa:='';
        if showenemy=false then
          Text:=strarr[37]+': '+inttostr(player.bint)+pa
        else
          Text:=strarr[37]+': '+inttostr(enemy.intelligence);
        BitmapFont:=GLWindowsBitmapFont1;
        Font.Name:='Bookman Old Style';
        Font.Size:=25;
      end;

      with char_speed do
      begin
        uin:=4;
        Position.X:=csbackground.Position.X-(csbackground.Width/2)+30;
        Position.Y:=csbackground.Position.Y-(csbackground.Height/2)+30*uin;
        if (player.bspd<>player.speed) then
        begin
          if player.bspd<player.speed then
            pa:=' +'+inttostr(abs(ibspd))
          else
            pa:=' -'+inttostr(abs(ibspd));
        end
        else pa:='';
        if showenemy=false then
          Text:=strarr[38]+': '+inttostr(player.bspd)+pa
        else
          Text:=strarr[38]+': '+inttostr(enemy.speed);
        BitmapFont:=GLWindowsBitmapFont1;
        Font.Name:='Bookman Old Style';
        Font.Size:=25;
      end;

      with char_endurence do
      begin
        uin:=5;
        Position.X:=csbackground.Position.X-(csbackground.Width/2)+30;
        Position.Y:=csbackground.Position.Y-(csbackground.Height/2)+30*uin;
        if (player.bend<>player.endurance) then
        begin
          if player.bend<player.endurance then
             pa:=' +'+inttostr(abs(ibend))
          else
            pa:=' -'+inttostr(abs(ibend));
        end
        else pa:='';
        if showenemy=false then
          Text:=strarr[39]+': '+inttostr(player.bend)+pa
        else
          Text:=strarr[39]+': '+inttostr(enemy.endurance);
        BitmapFont:=GLWindowsBitmapFont1;
        Font.Name:='Bookman Old Style';
        Font.Size:=25;
      end;

      with char_sword do
      begin
        uin:=7;
        Position.X:=csbackground.Position.X-(csbackground.Width/2)+30;
        Position.Y:=csbackground.Position.Y-(csbackground.Height/2)+30*uin;
        if (player.bsw<>player.sword) then
        begin
          if player.bsw<player.sword then
            pa:=' +'+inttostr(abs(ibsw))
          else
            pa:=' -'+inttostr(abs(ibsw));
        end
        else pa:='';
        if showenemy=false then
          Text:=strarr[40]+': '+inttostr(player.bsw)+pa
        else
          Text:=strarr[40]+': '+inttostr(enemy.sword);
        BitmapFont:=GLWindowsBitmapFont1;
        Font.Name:='Bookman Old Style';
        Font.Size:=25;
      end;

      with char_bow do
      begin
        uin:=8;
        Position.X:=csbackground.Position.X-(csbackground.Width/2)+30;
        Position.Y:=csbackground.Position.Y-(csbackground.Height/2)+30*uin;
        if (player.bbw<>player.bow) then
        begin
          if player.bbw<player.bow then
            pa:=' +'+inttostr(abs(ibbw))
          else
            pa:=' -'+inttostr(abs(ibbw));
        end
        else pa:='';
        if showenemy=false then
          Text:=strarr[41]+': '+inttostr(player.bbw)+pa
        else
          Text:=strarr[41]+': '+inttostr(enemy.bow);
        BitmapFont:=GLWindowsBitmapFont1;
        Font.Name:='Bookman Old Style';
        Font.Size:=25;
      end;

      with char_armor do
      begin
        uin:=9;
        Position.X:=csbackground.Position.X-(csbackground.Width/2)+30;
        Position.Y:=csbackground.Position.Y-(csbackground.Height/2)+30*uin;
        if (player.bar<>player.armor) then
        begin
          if player.bar<player.armor then
            pa:=' +'+inttostr(abs(ibar))
          else
            pa:=' -'+inttostr(abs(ibar));
        end
        else pa:='';
        if showenemy=false then
          Text:=strarr[42]+': '+inttostr(player.bar)+pa
        else
          Text:=strarr[42]+': '+inttostr(enemy.armor);
        BitmapFont:=GLWindowsBitmapFont1;
        Font.Name:='Bookman Old Style';
        Font.Size:=25;
      end;

      with char_magic do
      begin
        uin:=10;
        Position.X:=csbackground.Position.X-(csbackground.Width/2)+30;
        Position.Y:=csbackground.Position.Y-(csbackground.Height/2)+30*uin;
        if (player.bmg<>player.magic) then
        begin
          if player.bmg<player.magic then
            pa:=' +'+inttostr(abs(ibmg))
          else
            pa:=' -'+inttostr(abs(ibmg));
        end
        else pa:='';
        if showenemy=false then
          Text:=strarr[43]+': '+inttostr(player.bmg)+pa
        else
          Text:=strarr[43]+': '+inttostr(enemy.magic);
        BitmapFont:=GLWindowsBitmapFont1;
        Font.Name:='Bookman Old Style';
        Font.Size:=25;
      end;

      with char_bp do
      begin
        uin:=12;
        Position.X:=csbackground.Position.X-(csbackground.Width/2)+30;
        Position.Y:=csbackground.Position.Y-(csbackground.Height/2)+30*uin;
        if showenemy=false then
          Text:=strarr[44]+': '+inttostr(player.bonuspoints)
        else
          Text:='';
        BitmapFont:=GLWindowsBitmapFont1;
      end;

      with char_xp do
      begin
        uin:=13;
        Position.X:=csbackground.Position.X-(csbackground.Width/2)+30;
        Position.Y:=csbackground.Position.Y-(csbackground.Height/2)+30*uin;
        if showenemy=false then
          Text:=strarr[45]+': '+inttostr(player.xp)+'/'+inttostr(player.xpreq)
        else
          Text:='';
        BitmapFont:=GLWindowsBitmapFont1;
      end;

      try
        with char_effects do
        begin
          uin:=15;
          Position.X:=csbackground.Position.X-(csbackground.Width/2)+30;
          Position.Y:=csbackground.Position.Y-(csbackground.Height/2)+30*uin;
          if btlmode=true then
          begin
            Text:=strarr[236]+#13#10;
            if showenemy=false then
            begin
              tch:=player;
              for ei:=1 to 100 do
              begin
                if tch.e[ei]>0 then Text:=Text+' - '+GetETypeName(ei,strarr)+#13#10;
              end;
            end
            else
            begin
              tch:=enemy;
              for ei:=1 to 100 do
              begin
                if tch.e[ei]>0 then Text:=Text+' - '+GetETypeName(ei,strarr)+#13#10;
              end;
            end;
          end
          else
          begin
            Text:='';
          end;
          BitmapFont:=GLWindowsBitmapFont1;
        end;
      except
      end;

    //inventory pic
    with aitem do
    begin

      Width:=csbackground.Width/3;
      Height:=csbackground.Width/3;
      Position.X:=csbackground.Position.X+csbackground.Width/2-(csbackground.Width/6)-5;
      Position.Y:=csbackground.Position.Y-csbackground.Height/2+(csbackground.Width/6)+90;
      Material.LibMaterialName:='itm_'+inttostr(pitem);

      Visible:=false;

    end;

    with aitem_name do
    begin

      if itms[pitem].overridename='' then
        Text:=itms[pitem].name
      else
        Text:=itms[pitem].overridename;

      if itms[pitem].count>1 then
        Text:=Text+' ('+inttostr(itms[pitem].count)+')';

      Position.X:=aitem.Position.X-aitem.Width/2;
      Position.Y:=aitem.Position.Y-aitem.Height/2-10;

      Visible:=false;

    end;

    with spellbook_txt do
    begin
      Text:=strarr[169];
      Position.X:=gbtn[30].position.x-gbtn[30].Width/2-10;
      Position.Y:=gbtn[30].Position.y-gbtn[30].Height/2-35;
      if showenemy=true then Visible:=true else Visible:=false;
    end;



    ConstructCharacter;


    try
      with charpic do
      begin
        if showenemy=false then
          Visible:=false
        else
          Visible:=true;
      end;
    except end;

    intren:=false;

  end;

  //SKYBOX
  with GLSkyBox1 do
  begin
    Position.X:=0;//*20;
    Position.Y:=0;//20;
    Up.X:=0;
    Up.Y:=0;
    Up.Z:=1;
    Direction.X:=1;
    Direction.Y:=0;
    Direction.Z:=0;
    //Direction:=mcam.Direction;
    //Up:=mcam.Up;
    //Scale.X:=10;
    //Scale.Y:=10;
    //Scale.Z:=10;

    //Position:=mcam.Position;
  end;

  end;
  except err:=err+'b4'; end;

  try
  if block5=true then begin

  //ORIGINAL CADENCER 2

   //teleport glow
  if teleportframe>0 then begin
    teleportframe:=teleportframe-deltatime;
    ag:=round(teleportframe*10);
    if ag>10 then ag:=10;
    if ag<0 then ag:=0;
    if teleport_glow.Width<>scrn.Width then teleport_glow.Width:=scrn.Width;
    if teleport_glow.Height<>scrn.Height then teleport_glow.Height:=scrn.Height;
    if teleport_glow.Position.X<>scrn.Width/2 then teleport_glow.Position.X:=scrn.Width/2;
    if teleport_glow.Position.Y<>scrn.Height/2 then teleport_glow.Position.Y:=scrn.Height/2;
    if teleport_glow.Visible=false then teleport_glow.Visible:=true;
    teleport_glow.Material.FrontProperties.Diffuse.Alpha:=ag/10;
    //teleport_glow.Material.FrontProperties.Diffuse.SetColor(1,1,1,teleportframe);
  end
  else
  begin
    if teleport_glow.Visible=true then teleport_glow.Visible:=false;
  end;

  //music controller
  ControlMusic;

 //overseeing battle
 ControlBattle;

 if (rqform=false) and (rqfpool[1].active=true) then DisplayRequestForm;

 if (btlmode=true) and (invmode=false) and (mmmode=false) then
 begin
   VisualizeBattle(eno);
 end;



  //checking for levelup
  LevelUp;

  //specvars
  scx:=round(scrn.Width/2);
  scy:=round(scrn.Height/2);
  sw:=round(scrn.Width);
  sh:=round(scrn.Height);

  end;

  except err:=err+'b5'; end;

  try
  if block6=true then
  begin

    //main ui elements

    ProcessBasicHUD;

  end;
  except err:=err+'b6'; end;

  try
  if block7=true then
  begin

    //minimap
    with minimap do
    begin
      if (invmode=false) and (mmmode=false) and (btlmode=false) and (showmm=true) then
      begin
        if visible=false then Visible:=true;
      end
      else
      begin
        if visible=true then Visible:=False;
      end;

      if Visible=true then
      begin
        WorkOnMinimap;
        Position.X:=Width/2+10;
        Position.Y:=scrn.Height-Height/2-40;
        Width:=200;
        Height:=200;
      end;

    end;

    ProcessPerkPanel;

  end;

  except err:=err+'b7'; end;


  try
  if block8=true then
  begin

    //parsing buttons
    try
      ProcessButtons;
    except err:=err+' procbts '; end;

    //visualizing battlelist
    if (btlmode=true) and (mmmode=false) and (invmode=false) and (itemlistmode=false) then
    begin

      at_w:=round(monster_img.Height/11);

      for i:=0 to 10 do
      with ico_battlelist[i] do
      begin

        if (battlelist[i]>-1) then
          desmn:='mon_'+inttostr(battlelist[i])
        else
          desmn:='unknown';

        if (Material.LibMaterialName<>desmn) and (battlelist[i]<>-2) then
        begin
          Material.LibMaterialName:=desmn;
        end;

        if battlelist[i]=-2 then
        begin
          Visible:=false;
        end
        else
        begin
          Visible:=true;
          Width:=at_w;
          Height:=at_w;
          Position.X:=monster_img.Position.X+monster_img.Width/2+Width/2;
          Position.Y:=(at_w*i)+(monster_img.Position.Y-monster_img.Height/2)+(Height/2);
        end;

      end;

    end
    else
    begin
      for i:=0 to 10 do ico_battlelist[i].Visible:=false;
    end;

    //block visibility
    if spareproc=false then MonitorBlockVisibility(plx,ply,mbd,false);
    ProcessFreemeshBehaviour(deltatime);

  end;

  except err:=err+'b8'; end;

  {if ahat<>-1 then
  begin
    player.hat:=itms[ahat].l_hat;
  end;}

  END
  ELSE //IF LIP=TRUE
  BEGIN

  END;


  ProcessLoadScreen;

  except  err:=err+' Render errors detected' end;

  If err<>'' then Form1.Caption:=err;

  cdrstate:=false;

end;


procedure TForm1.ProcessBasicHUD;
var rlsk:real;
begin

    with key_gold_no do
    begin
      Position.X:=scrn.Width-50;
      Position.Y:=15;
      Text:=inttostr(gkeys);
      if (gmmode=true) and (mmmode=false) then Visible:=true else Visible:=false;
    end;

    with key_gold do
    begin
      Position.X:=scrn.Width-80;
      Position.Y:=25;
      if (gmmode=true) and (mmmode=false) then Visible:=true else Visible:=false;
    end;

    with key_silver_no do
    begin
      Position.X:=scrn.Width-130;
      Position.Y:=15;
      Text:=inttostr(skeys);
      if (gmmode=true) and (mmmode=false) then Visible:=true else Visible:=false;
    end;

    with key_silver do
    begin
      Position.X:=scrn.Width-160;
      Position.Y:=25;
      if (gmmode=true) and (mmmode=false) then Visible:=true else Visible:=false;
    end;

    with monster_ico_no do
    begin
      Position.X:=scrn.Width-210;
      Position.Y:=15;

      rlsk:=lsk;
      if rlsk>2 then rlsk:=2;
      rlsk:=diffmod(difficulty,rlsk);

      Text:=inttostr(round(rlsk*100));

      if (gmmode=true) and (mmmode=false) and (invmode=false) then Visible:=true else Visible:=false;

    end;

    with monster_ico do
    begin
      Position.X:=scrn.Width-240;
      Position.Y:=25;
      if (gmmode=true) and (mmmode=false) then Visible:=true else Visible:=false;
    end;

    with corner_tl do
    begin
      Position.X:=width/2;
      Position.Y:=height/2;
      if (gmmode=true) and (mmmode=false) then Visible:=true else Visible:=false;
      if (invmode=true) or (itemlistmode=true) then visible:=false;
    end;

    with corner_tr do
    begin
      Position.X:=scrn.Width-width/2;
      Position.Y:=height/2;
      if (gmmode=true) and (mmmode=false) then Visible:=true else Visible:=false;
    end;

    with corner_bl do
    begin
      Position.X:=width/2;
      Position.Y:=scrn.Height-height/2;
      if (gmmode=true) and (mmmode=false) and (invmode=false) and(showmm=true) and
         (btlmode=false) then Visible:=true else Visible:=false;
    end;

    //hp and mp data
    with PL_HPMP do
    begin
      if btlmode=true then Visible:=false else Visible:=true;
      Position.X:=5;
      Position.Y:=scrn.Height-20;
      Text:=strarr[48]+': '+inttostr(player.hpmax)+' '+strarr[49]+': '+IntToStr(player.manamax);
      if (gmmode=true) and (mmmode=false) then Visible:=true else Visible:=false;
    end;

    //active item indicator

    with aitem_ui do
    begin
      if Visible=true then
      begin
        Width:=128;
        Height:=128;
        Position.X:=scrn.Width-Width/2;
        Position.Y:=scrn.Height-Height/2;
      end;

      if (usepitem=true) and (visible=false) then
      begin
        if Material.LibMaterialName<>'itm_'+inttostr(pitem) then
        Material.LibMaterialName:='itm_'+inttostr(pitem);
        Visible:=true;
      end;

      if (usepitem=false) and (visible=true) then
      begin
        visible:=false;
      end;
    end;

    //xp bar
    with xpbar_bg do
    begin

      Width:=200;
      Height:=40;
      Position.X:=scrn.Width/2;
      Position.Y:=30;
      if (invmode=false) and (mmmode=false) and (btlmode=false) then
      begin
        Visible:=true;
      end
      else
      begin
        Visible:=False;
      end;

    end;

    with xpbar do
    begin

      xpwd:=((xpbar_bg.Width)*player.xp)/player.xpreq;


      Width:=xpwd;
      Height:=28;
      Position.X:=xpbar_bg.Position.X-(xpbar_bg.Width/2)+xpwd/2;
      Position.Y:=30;
      if (invmode=false) and (mmmode=false) and (btlmode=false) then
      begin
        Visible:=true;
      end
      else
      begin
        Visible:=False;
      end;

    end;
end;


procedure TForm1.ProcessPerkPanel;
begin
  //showing perk panel
  if (invmode=true) and (showenemy=false) and (showperks=true) then
  begin
    with csperkbg do
    begin
      Width:=1024-(csbackground.Position.X+csbackground.Width/2+20);
      Height:=350;
      Position.X:=csbackground.Position.X+csbackground.Width/2+Width/2+10;
      Position.Y:=scrn.Height/2;
      if Visible=false then visible:=true;
    end;
  end
  else
  begin
    if csperkbg.Visible=true then csperkbg.Visible:=false;
  end;

  dcperked.Visible:=csperkbg.Visible;
  if dcperked.Visible=true then
  begin

    //ShowMessage('making perc desc');
    perk_name.Position.X:=csperkbg.Position.X-csperkbg.Width/2+15;
    perk_name.Position.y:=csperkbg.Position.y-csperkbg.height/2+15;
    perkdesc.Position.X:=csperkbg.Position.X-csperkbg.Width/2+20;
    perkdesc.Position.y:=perk_name.Position.y+30;
    perkdesc2.Position.X:=csperkbg.Position.X-csperkbg.Width/2+200;
    perkdesc2.Position.y:=perkdesc.Position.Y;
    perkdesc.Visible:=true;
    perkdesc2.Visible:=true;
    perk_name.Visible:=true;
    tts:=bperks[perklist[currperk]].name;
    if perk_name.Text<>tts then
    begin
      perk_name.Text:=tts;
      if player.perks[perklist[currperk]]=false then
      begin
        if checkperkrq(perklist[currperk])=true then
        begin
          perk_name.ModulateColor.Red:=0;
          perk_name.ModulateColor.Green:=255;
          perk_name.ModulateColor.Blue:=0;
        end
        else
        begin
          perk_name.ModulateColor.Red:=255;
          perk_name.ModulateColor.Green:=0;
          perk_name.ModulateColor.Blue:=0;
        end;
      end
      else
      begin
        perk_name.ModulateColor.Red:=255;
        perk_name.ModulateColor.Green:=255;
        perk_name.ModulateColor.Blue:=255;
      end;

    end;

    with bperks[perklist[currperk]] do
    begin

      b1:=#13#10;
      if (recst<>0) or (addst<>0) then b2:=strarr[36]+': '+#13#10 else b2:='';
      if (recin<>0) or (addin<>0) then b3:=strarr[37]+': '+#13#10 else b3:='';
      if (recagi<>0) or (addagi<>0) then b4:=strarr[38]+': '+#13#10 else b4:='';
      if (recend<>0) or (addend<>0) then b5:=strarr[39]+': '+#13#10 else b5:='';
      if (recsw<>0) or (addsw<>0) then b6:=strarr[40]+': '+#13#10 else b6:='';
      if (recbw<>0) or (addbw<>0) then b7:=strarr[41]+': '+#13#10 else b7:='';
      if (recar<>0) or (addar<>0) then b8:=strarr[42]+': '+#13#10 else b8:='';
      if (recmg<>0) or (addmg<>0) then b9:=strarr[43]+': '+#13#10 else b9:='';
      if (addcard<>-1) then b10:=strarr[194]+': '+#13#10 else b10:='';
      if (recperk<>-1) then b11:=strarr[179]+': '+#13#10 else b11:='';
      if (recrace<>-1) then b12:=strarr[182]+': '+#13#10 else b12:='';
      b13:=strarr[177]+': ';
      tts:=b1+b2+b3+b4+b5+b6+b7+b8+b9+b10+b11+b12+b13;
    end;
    if perkdesc.Text<>tts then perkdesc.Text:=tts;

    with bperks[perklist[currperk]] do
    begin
      b1:=strarr[172]+'/'+strarr[173]+#13#10;
      if (recst<>0) or (addst<>0) then b2:=inttostr(recst)+'  |  '+inttostr(addst)+#13#10 else b2:='';
      if (recin<>0) or (addin<>0) then b3:=inttostr(recin)+'  |  '+inttostr(addin)+#13#10 else b3:='';
      if (recagi<>0) or (addagi<>0) then b4:=inttostr(recagi)+'  |  '+inttostr(addagi)+#13#10 else b4:='';
      if (recend<>0) or (addend<>0) then b5:=inttostr(recend)+'  |  '+inttostr(addend)+#13#10 else b5:='';
      if (recsw<>0) or (addsw<>0) then b6:=inttostr(recsw)+'  |  '+inttostr(addsw)+#13#10 else b6:='';
      if (recbw<>0) or (addbw<>0) then b7:=inttostr(recbw)+'  |  '+inttostr(addbw)+#13#10 else b7:='';
      if (recar<>0) or (addar<>0) then b8:=inttostr(recar)+'  |  '+inttostr(addar)+#13#10 else b8:='';
      if (recmg<>0) or (addmg<>0) then b9:=inttostr(recmg)+'  |  '+inttostr(addmg)+#13#10 else b9:='';
      if (addcard<>-1) then b10:=deck[addcard].name+#13#10 else b10:='';
      if (recperk<>-1) then b11:=bperks[recperk].name+#13#10 else b11:='';
      if (recrace<>-1) then b12:=GetEClassName(recrace,strarr)+#13#10 else b12:='';
      b13:=cpeids[bperks[perklist[currperk]].addcoded];
      tts:=b1+b2+b3+b4+b5+b6+b7+b8+b9+b10+b11+b12+b13;
    end;
    if perkdesc2.Text<>tts then perkdesc2.Text:=tts;


    with perkimage do
    begin
      if Material.LibMaterialName<>'perkico_'+inttostr(perklist[currperk]) then Material.LibMaterialName:='perkico_'+inttostr(perklist[currperk]);
      Width:=100;
      Height:=100;
      Position.X:=csperkbg.Position.X;
      Position.Y:=csperkbg.Position.Y-csperkbg.Height/2-Height/2-5;
    end;

  end;
end;


function TForm1.CalcMaxHP(chr:character;uselvl:integer;ignorebl:boolean):integer;
var res,zbns,zlbns:integer;
    bbonus:integer;
begin
  with chr do
  begin
    if uselvl=0 then zlbns:=difficulty else zlbns:=lvl;
    res:=(endurance+zlbns)*5;
    zbns:=CheckCodedPerkEff(chr,6);
    if zbns>0 then res:=round((1+0.25*zbns)*res);
    if (ignorebl=false) and (getbattlelistlength>0) then
    begin
      bbonus:=getbattlelistlength*(5-difficulty);
      if bbonus<0 then bbonus:=0;
      res:=res+bbonus;
    end;
  end;
  result:=res;
end;

procedure TForm1.GLCadencer1Progress(Sender: TObject; const deltaTime,
  newTime: Double);
var i,j:integer;
begin

  if multithread=false then CadencerRun(deltatime) else
  begin
    if recalc=false then
    begin
      recalc:=true;
      dtout:=deltatime;
      EDThread.Execute;
    end;
  end;

end;

procedure TForm1.GLCadencer2Progress(Sender: TObject; const deltaTime,
  newTime: Double);
var mkx,mky,uin:integer;
    i,ik,sid:integer;
    desbmn,snm:string;
    scx,scy,sw,sh:integer;
    mngName:string;
    xpwd:real;
    retch:integer;
    tts:string; //text to show
    b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13:string;
    ag:integer;
begin
 //

end;


procedure TForm1.ProcessLoadScreen;
begin

  if (lip=true) then
  begin
    if dcload.Visible=false then dcload.Visible:=true;
    if loadscr_b.Material.LibMaterialName<>'etex_'+inttostr(envir)+'_0' then
      loadscr_b.Material.LibMaterialName:='etex_'+inttostr(envir)+'_0';
    if loadscr_f.Material.LibMaterialName<>'loadscr_'+inttostr(clsr) then
      loadscr_f.Material.LibMaterialName:='loadscr_'+inttostr(clsr);

    with loadscr_b do
    begin
      Position.X:=scrn.Width/2;
      Position.Y:=scrn.Height/2;
      Width:=scrn.Width;
      Height:=scrn.Height;
    end;

    with loadscr_f do
    begin
      Position.X:=scrn.Width/2;
      Position.Y:=scrn.Height/2;

      if scrn.Width<=scrn.Height then
      begin
        Width:=0.8*1024*(scrn.Width/1024);
        Height:=0.8*768*(scrn.Width/1024);
      end
      else
      begin
        Width:=0.8*1024*(scrn.Height/768);
        Height:=0.8*768*(scrn.Height/768);
      end;
    end;

    with loadtxt do
    begin
      Position.X:=10;
      Position.Y:=10;
      if sip=false then
        Text:=strarr[301]
      else
        Text:=strarr[302];
    end;

  end;

  if lip=false then
  begin
    if loadscr_f.Material.LibMaterialName<>'---' then loadscr_f.Material.LibMaterialName:='---';
    if dcload.Visible=true then dcload.Visible:=false;
  end;

end;

procedure TForm1.GLScene1BeforeProgress(Sender: TObject; const deltaTime,
  newTime: Double);
begin
  //Application.ProcessMessages;
end;

procedure TForm1.GLSceneViewer1DblClick(Sender: TObject);
var rs:integer;
begin
  {if (mmmode=false) and (btlmode=false) and (invmode=false) and (rqform=false) and (itemlistmode=false) then
  begin
    if (mx<scrn.Width/4) then
      PlayerTurn(-1);
    if (mx>(scrn.Width-(scrn.Width/4))) then
      PlayerTurn(1);
    if (mx>=scrn.Width/4) and(mx<=(scrn.Width-(scrn.Width/4))) then
    begin
      rs:=random(120-tsb);
      MovePlayer(cdx,cdy,rs);
    end;
  end; }
  if (mmmode=false) and (invmode=false) and (btlmode=false) and
       (itemlistmode=false) and (rqform=false) then
      ActivateCell(plx+cdx,ply+cdy);
end;

procedure TForm1.GeneralMouseDown(x,y,b:integer);
var rs:integer;
begin
  if ab<>-1 then
    gbtnv[ab].state:=2;
  mm:=true;

  if (b=1) and (mmmode=false) and (invmode=false) and (btlmode=false) and
     (itemlistmode=false) and (rqform=false) then
  begin
    rs:=random(120-tsb);
    MovePlayer(cdx,cdy,rs);
  end;
end;


procedure TForm1.GLSceneViewer1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var b:integer;
begin
  if Button=TMouseButton.mbLeft then b:=0 else b:=1;
  GeneralMouseDown(X,Y,b);
end;

procedure TForm1.GLSceneViewer1MouseLeave(Sender: TObject);
begin
  mm:=false;
end;

procedure TForm1.GeneralMouseMove(x,y:integer);
var i:integer;
begin
  mposx:=mx;
  mposy:=my;
  mx:=x;
  my:=y;
  ab:=GetActiveButton(x,y);

  if ab<>-1 then handletooltip(x,y,gbtnv[ab].tooltip,True)
  else
  begin
    handletooltip(0,0,'-',false);
    cttt:='';
  end;

  if (invmode=true) then
  for i:=0 to ttam do
  begin
    with tta[i]do
    begin
      if (x>x1) and (y>y1) and (x<x2) and (y<y2) and (text<>'') then
      begin
        handletooltip(x,y,text,true);
      end;
    end;
  end;

  if (ab=-1) and (mmmode=false) then
  begin

    try

    if invmode=true then
    begin

      //char name
      with char_name do
      begin
        if CheckMouseOnHUDObj(x,y,round(Position.X),round(Position.Y),BitmapFont.CalcStringWidth(text),Font.Size,true) and (invmode=True) then
        begin
          handletooltip(x,y,strarr[285],True);
        end;
      end;
      //char strength
      with char_strength do
      begin
        if CheckMouseOnHUDObj(x,y,round(Position.X),round(Position.Y),BitmapFont.CalcStringWidth(text),Font.Size,true) and (invmode=True) then
        begin
          handletooltip(x,y,strarr[286],True);
        end;
      end;
      //char intel
      with char_intelligence do
      begin
        if CheckMouseOnHUDObj(x,y,round(Position.X),round(Position.Y),BitmapFont.CalcStringWidth(text),Font.Size,true) and (invmode=True) then
        begin
          handletooltip(x,y,strarr[287],True);
        end;
      end;
      //char spd
      with char_speed do
      begin
        if CheckMouseOnHUDObj(x,y,round(Position.X),round(Position.Y),BitmapFont.CalcStringWidth(text),Font.Size,true) and (invmode=True) then
        begin
          handletooltip(x,y,strarr[288],True);
        end;
      end;
      //char end
      with char_endurence do
      begin
        if CheckMouseOnHUDObj(x,y,round(Position.X),round(Position.Y),BitmapFont.CalcStringWidth(text),Font.Size,true) and (invmode=True) then
        begin
          handletooltip(x,y,strarr[289],True);
        end;
      end;
      //char sword
      with char_sword do
      begin
        if CheckMouseOnHUDObj(x,y,round(Position.X),round(Position.Y),BitmapFont.CalcStringWidth(text),Font.Size,true) and (invmode=True) then
        begin
          handletooltip(x,y,strarr[290],True);
        end;
      end;
      //char bow
      with char_bow do
      begin
        if CheckMouseOnHUDObj(x,y,round(Position.X),round(Position.Y),BitmapFont.CalcStringWidth(text),Font.Size,true) and (invmode=True) then
        begin
          handletooltip(x,y,strarr[291],True);
        end;
      end;
      //char magic
      with char_magic do
      begin
        if CheckMouseOnHUDObj(x,y,round(Position.X),round(Position.Y),BitmapFont.CalcStringWidth(text),Font.Size,true) and (invmode=True) then
        begin
          handletooltip(x,y,strarr[292],True);
        end;
      end;
      //char armor
      with char_armor do
      begin
        if CheckMouseOnHUDObj(x,y,round(Position.X),round(Position.Y),BitmapFont.CalcStringWidth(text),Font.Size,true) and (invmode=True) then
        begin
          handletooltip(x,y,strarr[293],True);
        end;
      end;
      //free pts
      with char_bp do
      begin
        if CheckMouseOnHUDObj(x,y,round(Position.X),round(Position.Y),BitmapFont.CalcStringWidth(text),Font.Size,true) and (invmode=True) then
        begin
          handletooltip(x,y,strarr[294],True);
        end;
      end;

      //xp
      with char_xp do
      begin
        if CheckMouseOnHUDObj(x,y,round(Position.X),round(Position.Y),BitmapFont.CalcStringWidth(text),Font.Size,true) and (invmode=True) then
        begin
          handletooltip(x,y,strarr[298],True);
        end;
      end;

    end;


    //mon_diffic_mod
    with monster_ico do
    begin
      if CheckMouseOnHUDObj(x,y,round(Position.X),round(Position.Y),round(Width),round(Height),false) then
      begin
        handletooltip(x,y,strarr[295],True);
      end;
    end;

    with monster_ico_no do
    begin
      if CheckMouseOnHUDObj(x,y,round(Position.X),round(Position.Y),BitmapFont.CalcStringWidth(text),Font.Size,true) then
      begin
        handletooltip(x,y,strarr[295],True);
      end;
    end;

    //silver
    with key_silver do
    begin
      if CheckMouseOnHUDObj(x,y,round(Position.X),round(Position.Y),round(Width),round(Height),false)  then
      begin
        handletooltip(x,y,strarr[296],True);
      end;
    end;

    with key_silver_no do
    begin
      if CheckMouseOnHUDObj(x,y,round(Position.X),round(Position.Y),BitmapFont.CalcStringWidth(text),Font.Size,true)  then
      begin
        handletooltip(x,y,strarr[296],True);
      end;
    end;

    //gold
    with key_gold do
    begin
      if CheckMouseOnHUDObj(x,y,round(Position.X),round(Position.Y),round(Width),round(Height),false)  then
      begin
        handletooltip(x,y,strarr[297],True);
      end;
    end;

    with key_gold_no do
    begin
      if CheckMouseOnHUDObj(x,y,round(Position.X),round(Position.Y),BitmapFont.CalcStringWidth(text),Font.Size,true)  then
      begin
        handletooltip(x,y,strarr[297],True);
      end;
    end;

    except end;


  end;

  if ab<>oldab then
  begin
    if ab<>-1 then
    begin
      DoSound('snd_btnovr');
    end;
    oldab:=ab;
  end;

  if itemlistmode=true then
  begin

    iuc:=getilundercursor(x,y);

    if iuc<>-1 then
    begin

      if showspell=false then
        if ilitemtitle.Text<>itms[iuc].overridename then ilitemtitle.Text:=itms[iuc].overridename;
      if showspell=true then
        if ilitemtitle.Text<>deck[iuc].name then ilitemtitle.Text:=deck[iuc].name;

    end
    else
    begin
      if ilitemtitle.Text<>'' then ilitemtitle.Text:='';
    end;
  end;
end;


procedure TForm1.GLSceneViewer1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  GeneralMouseMove(X,Y);
end;


procedure TForm1.GeneralMouseUp(x,y:integer;button:TMouseButton);
begin
  if (itemlistmode=true) and (showspell=false) then
  begin
    if iuc<>-1 then
    begin
      if (button=TMouseButton.mbLeft) then
      begin
        pitem:=iuc;
        //usepitem:=true;
        InventoryButtonClick(0);
        SetupItemList;
      end
      else
      begin
        if usepitem=true then
          TryToCraft(pitem,iuc);
      end;
    end;
  end;

  if (itemlistmode=true) and (showspell=true) then
  begin
    if iuc<>-1 then
    begin
      if (button=TMouseButton.mbLeft) then
      begin
        pitem:=iuc;
        //usepitem:=true;
        ToggleSpell(iuc);
        SetupItemList;
      end
      else
      begin
        if btlmode=false then
        begin
          fdc:=iuc;
          SetupItemList;
        end;
      end;
    end;
  end;

  ClickGButton(ab);

  if (ab<>-1) and ((ab<10) or (ab>15)) then
  begin
    //playing sound
    DoSound('snd_btn');
  end;



  intren:=true;
  mm:=false;
end;


procedure TForm1.GLSceneViewer1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var b:integer;
begin

  GeneralMouseUp(X,Y,button);

end;

procedure TForm1.prepareuiobjects;
var i:integer;
begin
  //creating button objects
  for i:=0 to mb do
  begin

    if (i<>48) and (i<>49) and (i<>55) and (i<>56) and (i<>57) and (i<>58) and (i<>38) and (i<>39) and (i<>50) and
       (i<>40) and (i<>41) and(i<>42) and(i<>43) and(i<>44) and(i<>45)then
      gbtn[i]:=TGLHUDSprite.CreateAsChild(dcuimiddle)
    else
    begin
      if ((i>=40) and (i<=45)) or (i=48) or (i=49) or (i=55) or (i=56)or (i=57) or (i=58) then
        gbtn[i]:=TGLHUDSprite.CreateAsChild(dcrf);
      if (i=38) or (i=39) or (i=50) then
        gbtn[i]:=TGLHUDSprite.CreateAsChild(inventoryf1);
    end;

    gbtn[i].Material.MaterialLibrary:=matlib;

    if (i<>48) and (i<>49) and (i<>55) and (i<>56) and (i<>57) and (i<>58) and (i<>38) and (i<>39) and (i<>50)  and
       (i<>40) and (i<>41) and(i<>42) and(i<>43) and(i<>44) and(i<>45)then
      gbtnt[i]:=TGLHUDText.CreateAsChild(dcuifront)
    else
    begin
      if ((i>=40) and (i<=45)) or(i=48) or (i=49) or (i=55) or (i=56) or (i=57) or (i=58) then
        gbtnt[i]:=TGLHUDText.CreateAsChild(dcrff);
      if (i=38) or (i=39) or (i=50) then
        gbtnt[i]:=TGLHUDText.CreateAsChild(inventoryf2);
    end;

    gbtnt[i].BitmapFont:=GLWindowsBitmapFont2;
    with gbtnv[i] do
    begin
      x:=0; y:=0; w:=0; h:=0; caption:=''; state:=0; visible:=false;
      matname:='none'; matoverride:='';
    end;
  end;

  //creating secondary cards
  for i:=0 to 5 do
  begin
    cardind[i]:=TGLHUDSprite.CreateAsChild(dcuifront);
    cardind[i].Material.MaterialLibrary:=matlib;
  end;

  //creating perk icons
  for i:=0 to 100 do
  begin
    try FreeAndNil(perkicon[i]); except end;
    TGLHUDSprite(perkicon[i]):=TGLHUDSprite.CreateAsChild(dcperkicon);
    TGLHUDSprite(perkicon[i]).Material.MaterialLibrary:=matlib;
    TGLHUDSprite(perkicon[i]).Visible:=false;
  end;

  //loadscr
  loadscr_b.Material.LibMaterialName:='etex_'+inttostr(envir)+'_0';
  loadscr_f.Material.LibMaterialName:='loadscr_'+inttostr(random(loadscrs));

  //tooltip
  tooltipbg.Material.LibMaterialName:='ui_tooltip';

  //monsterimg
  monster_img.Material.MaterialLibrary:=matlib;

  //corner images
  corner_tl.Width:=250;
  corner_tl.Height:=90;
  corner_tr.Width:=270;
  corner_tr.Height:=90;
  corner_bl.Width:=230;
  corner_bl.Height:=250;

  //battlelist
  for i:=0 to 10 do
  begin
    try FreeAndNil(ico_battlelist[i]) except end;
    TGLHUDSprite(ico_battlelist[i]):=TGLHUDSprite.CreateAsChild(dcuibg);
    TGLHUDSprite(ico_battlelist[i]).Material.MaterialLibrary:=matlib;
  end;

  for i:=0 to 100 do
  begin
    TGLHUDText(dmpops[i]):=TGLHUDText.CreateAsChild(dcuifront);
    dmpops[i].BitmapFont:=GLWindowsBitmapFont1;
    Visible:=false;
  end;

end;

function getsm(cp:perk):integer;
var sm:integer;
begin
  with cp do
  begin
    sm:=sm+recst;
    sm:=sm+recagi;
    sm:=sm+recin;
    sm:=sm+recend;
    sm:=sm+recsw;
    sm:=sm+recbw;
    sm:=sm+recar;
    sm:=sm+recmg;
    sm:=sm+recperk;
  end;
  result:=sm;
end;

function TForm1.GetNextEnabledPerk(direc:integer):integer;
var i:integer;
    okay:boolean;
begin
  i:=currperk;
  repeat
    if (i>100) and (direc=1) then i:=-1;
    if (i<0) and (direc=-1) then i:=101;
    i:=i+direc;
    if bperks[perklist[i]].enabled=true then okay:=true else okay:=false;
  until (okay=true);
  Result:=i;
end;

procedure TForm1.genperklist;
var a,b,c,i:integer;
    sm,sm2:integer;
    cp:perk;
    swap:boolean;
begin
  for i:=-1 to 101 do perklist[i]:=i;
  repeat
    swap:=false;
    for i:=0 to 99 do
    begin

      cp:=bperks[perklist[i]];
      a:=bperks[perklist[i]].recrace;
      sm:=getsm(cp);
      cp:=bperks[perklist[i+1]];
      b:=bperks[perklist[i+1]].recrace;
      sm2:=getsm(cp);
      if (sm2<sm) {or (a<b)} then //there is a need to swap two elements
      begin
        swap:=true;
        c:=perklist[i];
        perklist[i]:=perklist[i+1];
        perklist[i+1]:=c;
      end;

    end;
  until (swap=false);

  repeat
    swap:=false;
    for i:=0 to 99 do
    begin

      cp:=bperks[perklist[i]];
      a:=bperks[perklist[i]].recrace;
      cp:=bperks[perklist[i+1]];
      b:=bperks[perklist[i+1]].recrace;
      if (a>b) then //there is a need to swap two elements
      begin
        swap:=true;
        c:=perklist[i];
        perklist[i]:=perklist[i+1];
        perklist[i+1]:=c;
      end;

    end;
  until (swap=false);

end;

procedure TForm1.formperkvisuals(perkman:character);
var n,i,totp,stp,stx,sty:integer;
    plist:array[0..100]of integer;
    plt:string;
begin

  if loadinprogress=false then
  begin

    n:=0;
    for i:=0 to 100 do
    begin
      plist[i]:=-1;
      perkicon[i].Visible:=false;
    end;

    for i:=0 to 100 do
    begin
      if perkman.perks[i]=true then
      begin
        plist[n]:=i;
        n:=n+1;
      end;
    end;

    totp:=n+1;
    stp:=round((csbackground.Height-60)/totp);
    if stp>70 then stp:=70;
    stx:=round(csbackground.Position.X+csbackground.Width/2+5);
    sty:=round(csbackground.Position.y-csbackground.Height/2+30);

    for i:=0 to 100 do
    with tta[i] do
    begin
      x1:=0;
      y1:=0;
      x2:=0;
      y2:=0;
      text:='';
    end;

    for i:=0 to (n-1) do
    begin
      perkicon[i].Visible:=true;
      perkicon[i].Position.X:=stx;
      perkicon[i].Position.Y:=sty;
      perkicon[i].Width:=35;
      perkicon[i].Height:=35;
      if plist[i]<>-1 then
      begin
        perkicon[i].Material.LibMaterialName:='perkico_'+inttostr(plist[i]);
      end;
      sty:=sty+stp;

      //adding tooltip area
      tta[i].x1:=round(perkicon[i].Position.X-perkicon[i].Width/2);
      tta[i].y1:=round(perkicon[i].Position.Y-perkicon[i].Height/2);
      tta[i].x2:=round(perkicon[i].Position.X+perkicon[i].Width/2);
      tta[i].y2:=round(perkicon[i].Position.Y+perkicon[i].Height/2);
      tta[i].text:=bperks[plist[i]].name;
      ttam:=i;
    end;

    {plt:='';
    for i:=0 to n-1 do
    begin
      plt:=plt+inttostr(plist[i])+'; '
    end;

    ShowMessage(plt);}

  end;

end;



function getmaxfaces(sex:integer):integer;
var i:integer;
    fn:string;
begin
  i:=0;
  repeat
    fn:=gameexe+'\textures\'+qs+'\bodies\'+inttostr(sex)+'\head_'+inttostr(i)+'.tga';
    if fileexists(fn)=true then i:=i+1;
  until (fileexists(fn)=false);
  //ShowMessage('getmaxfaces('+inttostr(sex)+')='+inttostr(i));
  result:=i;
end;


function getmaxhats(sex:integer):integer;
var i:integer;
    fn:string;
begin
  i:=0;
  repeat
    fn:=gameexe+'\textures\'+qs+'\bodies\'+inttostr(sex)+'\hat_'+inttostr(i)+'.tga';
    if fileexists(fn)=true then i:=i+1;
  until (fileexists(fn)=false);
  //ShowMessage('getmaxfaces('+inttostr(sex)+')='+inttostr(i));
  result:=i;
end;

function getmaxhair(sex:integer):integer;
var i:integer;
    fn:string;
begin
  i:=0;
  repeat
    fn:=gameexe+'\textures\'+qs+'\bodies\'+inttostr(sex)+'\hair_'+inttostr(i)+'.tga';
    if fileexists(fn)=true then i:=i+1;
  until (fileexists(fn)=false);
  //ShowMessage('getmaxhair('+inttostr(sex)+')='+inttostr(i));
  result:=i;
end;

function getmaxcloth(sex:integer):integer;
var i:integer;
    fn:string;
begin
  i:=0;
  repeat
    fn:=gameexe+'\textures\'+qs+'\bodies\'+inttostr(sex)+'\armor_'+inttostr(i)+'.tga';
    if fileexists(fn)=true then i:=i+1;
  until (fileexists(fn)=false);
  //ShowMessage('getmaxhair('+inttostr(sex)+')='+inttostr(i));
  result:=i;
end;


procedure TForm1.readbpartdata(sex,bpt,id:integer);
var fn,s1,s2,s3:string;
    bw,bh:integer;

begin
  //reading data to position a bodypart
  //sex: 0 - male, 1 - female
  //bpt: 0 - head, 1 - hair f, 2 - hair b, 3 - torso
  if sex=0 then s1:='0';
  if sex=1 then s1:='1';
  case bpt of
  0:s2:='head';
  1:s2:='hair';
  2:s2:='hairb';
  3:s2:='torso';
  4:s2:='hat';
  end;
  s3:=IntToStr(id);

  fn:=gameexe+'\bodypartdata\'+s1+'\'+s2+'_'+s3+'.txt';
  Memo1.Lines.LoadFromFile(fn);

  case bpt of
  0:begin
      head_w:=StrToFloat(Memo1.Lines[0]);
      head_h:=StrToFloat(Memo1.Lines[1]);
      head_dx:=StrToFloat(Memo1.Lines[2]);
      head_dy:=StrToFloat(Memo1.Lines[3]);
    end;
  1:begin
      hairf_w:=StrToFloat(Memo1.Lines[0]);
      hairf_h:=StrToFloat(Memo1.Lines[1]);
      hairf_dx:=StrToFloat(Memo1.Lines[2]);
      hairf_dy:=StrToFloat(Memo1.Lines[3]);
      try haseb:=StrToBool(Memo1.Lines[4]); except haseb:=false end;
      try hasbrd:=StrToBool(Memo1.Lines[5]); except hasbrd:=false; end;
    end;
  2:begin
      hairb_w:=StrToFloat(Memo1.Lines[0]);
      hairb_h:=StrToFloat(Memo1.Lines[1]);
      hairb_dx:=StrToFloat(Memo1.Lines[2]);
      hairb_dy:=StrToFloat(Memo1.Lines[3]);
    end;
  3:begin
      bw:=StrToInt(Memo1.Lines[0]);
      bh:=StrToInt(Memo1.Lines[1]);
      bodprop:=bw/bh;
    end;
  4:begin
      hat_w:=StrToFloat(Memo1.Lines[0]);
      hat_h:=StrToFloat(Memo1.Lines[1]);
      hat_dx:=StrToFloat(Memo1.Lines[2]);
      hat_dy:=StrToFloat(Memo1.Lines[3]);
    end;

  end;

end;

procedure TForm1.ConstructCharacter;
var pref:string;
    scac,tw,th:real;
    torson,hatn:integer;
    val1,val2:integer;
    bod_x,bod_y:real;
begin

  try
    FreeAndNil(bpart1);
    FreeAndNil(bpart2);
    FreeAndNil(bpart3);
    FreeAndNil(bpart4);
    FreeAndNil(bpart5);
    FreeAndNil(bpart6);
    FreeAndNil(bpart7);
    FreeAndNil(bpart8);
    FreeAndNil(bpart9);
    FreeAndNil(bpart10);
    FreeAndNil(bpart11);
    FreeAndNil(bpart12);
    FreeAndNil(bpart13);
    //FreeAndNil(charpic);
  except

  end;

  if showenemy=false then
  begin

    if player.sex=0 then pref:='mal_' else pref:='fem_';

    try
      readbpartdata(player.sex,0,player.face);
      readbpartdata(player.sex,1,player.hair);
      readbpartdata(player.sex,2,player.hair);
      readbpartdata(player.sex,3,0);
      readbpartdata(player.sex,4,player.hat);
    except
      head_w:=1020;
      head_h:=1020;
      head_dx:=50;
      head_dy:=15;
      hairf_w:=1020;
      hairf_h:=1020;
      hairf_dx:=50;
      hairf_dy:=15;
      hairb_w:=1020;
      hairb_h:=1020;
      hairb_dx:=50;
      hairb_dy:=15;
      bodprop:=0.6;
    end;

    th:=scrn.Height;
    tw:=Height*bodprop;
    scac:=th/4200;
    bod_x:=csbackground.Position.X+csbackground.Width/2+((scrn.Width-(csbackground.Width))/2);
    //scrn.Width-tw/2+30;
    bod_y:=scrn.Height/2;

    //wings
    if player.spec<>0 then
    begin

      bpart6:=TGLHUDSprite.CreateAsChild(dccharscreen);
      with bpart6 do
      begin
        Material.MaterialLibrary:=matlib;
        Material.LibMaterialName:='wings_'+inttostr(player.spec);
        Height:=1.2*th;
        Width:=1.2*tw;
        Position.X:=bod_x-(tw/2)+(tw*(head_dx/100));
        Position.Y:=bod_y;
        //BringToFront;
        //MoveLast;
      end;

    end;

    //sword
    bpart8:=TGLHUDSprite.CreateAsChild(dccharscreen);
    with bpart8 do
    begin
      Material.MaterialLibrary:=matlib;
      Material.LibMaterialName:='itm_'+inttostr(asword);
      Width:=0.8*tw;
      Height:=Width;
      Position.X:=bod_x-(tw/2)+(tw*(head_dx/100));
      Position.Y:=bod_y-(0.25*th);
      //BringToFront;
      //MoveLast;
    end;


    //bow
    bpart9:=TGLHUDSprite.CreateAsChild(dccharscreen);
    with bpart9 do
    begin
      Material.MaterialLibrary:=matlib;
      Material.LibMaterialName:='itm_'+inttostr(abow);
      Width:=0.8*tw;
      Height:=Width;
      Position.X:=bod_x-(tw/2)+(tw*(head_dx/100));
      Position.Y:=bod_y-(0.25*th);
      //BringToFront;
      //MoveLast;
    end;

    //hat
    bpart11:=TGLHUDSprite.CreateAsChild(dccharscreen);
    with bpart11 do
    begin
      Material.MaterialLibrary:=matlib;
      Material.LibMaterialName:=pref+'hatb_'+inttostr(player.hat);
      Height:=hat_h*scac;
      Width:=hat_w*scac;
      Position.X:=bod_x-(tw/2)+(tw*(hat_dx/100));
      Position.Y:=bod_y-(th/2)+(th*(hat_dy/100));
      if itms[ahat].nohair=true then
      {begin
        bpart9.Visible:=false;
        bpart7.Visible:=false;
      end;}
    end;

    //hair back
    if ((itms[ahat].nohair=false) and (ahat<>-1)) or (ahat=-1) then
    begin
      bpart7:=TGLHUDSprite.CreateAsChild(dccharscreen);
      with bpart7 do
      begin
        Material.MaterialLibrary:=matlib;
        Material.LibMaterialName:=pref+'hairb_'+inttostr(player.hair);
        Height:=hairb_h*scac;
        Width:=hairb_w*scac;
        Position.X:=bod_x-(tw/2)+(tw*(hairb_dx/100));
        Position.Y:=bod_y-(th/2)+(th*(hairb_dy/100));
        //BringToFront;
        //MoveLast;
      end;
    end;

    //torso
    bpart2:=TGLHUDSprite.CreateAsChild(dccharscreen);
    with bpart2 do
    begin
      Material.MaterialLibrary:=matlib;
      torson:=round(player.bstr/20);
      if torson>4 then torson:=4;
      Material.LibMaterialName:=pref+'torso_'+inttostr(torson);
      Height:=th;
      Width:=tw;
      Position.X:=bod_x;
      Position.Y:=bod_y;
      //BringToFront;
      //MoveLast;
    end;

    //arms
    bpart1:=TGLHUDSprite.CreateAsChild(dccharscreen);
    with bpart1 do
    begin
      Material.MaterialLibrary:=matlib;
      torson:=round(player.bstr/20);
      if torson>4 then torson:=4;
      Material.LibMaterialName:=pref+'arms_'+inttostr(torson);
      Height:=th;
      Width:=tw;
      Position.X:=bod_x;
      Position.Y:=bod_y;
      //BringToFront;
      MoveLast;
    end;

    //cloth
    bpart5:=TGLHUDSprite.CreateAsChild(dccharscreen);
    with bpart5 do
    begin
      Material.MaterialLibrary:=matlib;
      Material.LibMaterialName:=pref+'cloth_'+inttostr(player.cloth);
      Height:=bpart2.Height;
      Width:=bpart2.Width;
      Position.X:=bpart2.Position.X;
      Position.Y:=bpart2.Position.Y;
    end;

    //head
    bpart4:=TGLHUDSprite.CreateAsChild(dccharscreen);
    with bpart4 do
    begin
      Material.MaterialLibrary:=matlib;
      Material.LibMaterialName:=pref+'face_'+inttostr(player.face);
      Height:=head_h*scac;
      Width:=head_w*scac;
      Position.X:=bod_x-(tw/2)+(tw*(head_dx/100));
      Position.Y:=bod_y-(th/2)+(th*(head_dy/100));
      //BringToFront;
      MoveLast;
    end;

    //hair
    if ((itms[ahat].nohair=false) and (ahat<>-1)) or (ahat=-1) then
    begin
      bpart3:=TGLHUDSprite.CreateAsChild(dccharscreen);
      with bpart3 do
      begin
        Material.MaterialLibrary:=matlib;
        Material.LibMaterialName:=pref+'hair_'+inttostr(player.hair);
        Height:=hairf_h*scac;
        Width:=hairf_w*scac;
        Position.X:=bod_x-(tw/2)+(tw*(hairf_dx/100));
        Position.Y:=bod_y-(th/2)+(th*(hairf_dy/100));
        MoveLast;
      end;
    end;

    //eyebrows
    if (haseb=true) then
    begin
      bpart12:=TGLHUDSprite.CreateAsChild(dccharscreen);
      with bpart12 do
      begin
        Material.MaterialLibrary:=matlib;
        Material.LibMaterialName:=pref+'haireb_'+inttostr(player.hair);
        Height:=hairf_h*scac;
        Width:=hairf_w*scac;
        Position.X:=bod_x-(tw/2)+(tw*(hairf_dx/100));
        Position.Y:=bod_y-(th/2)+(th*(hairf_dy/100));
        MoveLast;
      end;
    end;

    //beard
    if (hasbrd=true) then
    begin
      bpart13:=TGLHUDSprite.CreateAsChild(dccharscreen);
      with bpart13 do
      begin
        Material.MaterialLibrary:=matlib;
        Material.LibMaterialName:=pref+'hairbrd_'+inttostr(player.hair);
        Height:=hairf_h*scac;
        Width:=hairf_w*scac;
        Position.X:=bod_x-(tw/2)+(tw*(hairf_dx/100));
        Position.Y:=bod_y-(th/2)+(th*(hairf_dy/100));
        MoveLast;
      end;
    end;

    //hat
    bpart10:=TGLHUDSprite.CreateAsChild(dccharscreen);
    with bpart10 do
    begin
      Material.MaterialLibrary:=matlib;
      Material.LibMaterialName:=pref+'hat_'+inttostr(player.hat);
      Height:=hat_h*scac;
      Width:=hat_w*scac;
      Position.X:=bod_x-(tw/2)+(tw*(hat_dx/100));
      Position.Y:=bod_y-(th/2)+(th*(hat_dy/100));
      MoveLast;
      {if itms[ahat].nohair=true then
      begin
        bpart9.Visible:=false;
        bpart7.Visible:=false;
      end;}
      if ahat=-1 then
      begin
        bpart10.Visible:=false;
        bpart11.Visible:=false;
      end;
    end;

    //charpic.Visible:=false;

  end;


  if showenemy=true then
  begin

    try freeandnil(charpic) except end;


    charpic:=TGLHUDSprite.CreateAsChild(dccharscreen);

    charpic.Material.MaterialLibrary:=matlib;
    charpic.Material.LibMaterialName:=monster_img.Material.LibMaterialName;

    val1:=round(scrn.Width-(csbackground.Position.X+csbackground.Width/2)-5);
    val2:=scrn.Height;

    if val1<val2 then
      charpic.Width:=val1
    else
      charpic.Width:=val2;

    charpic.Height:=charpic.Width;

    charpic.Position.X:=scrn.Width-charpic.Width/2-10;
    charpic.Position.Y:=scrn.Height/2;
  end;


end;


procedure tform1.cleanuplights;
var i:integer;
begin
  //creating lights
  for i:=0 to 19 do
  begin
    visls[i].enabled:=false;
  end;
end;

function TForm1.getslitem(text:string;id,ps:integer):string;
var s:string;
    k:string;
    i,j,b:integer;
begin

  s:=text;
  k:='';
  b:=0;
  for i:=1 to Length(s) do
  begin
    if (b=ps) and (s[i]<>',') then
    begin
      k:=k+s[i];
    end;
    if s[i]=',' then b:=b+1;
  end;

  if (k='') and (ps=1) then k:='-1';
  if (k='') and (ps=2) then k:='10';
  if (k='') and (ps=3) then k:='15';

  result:=k;

end;


procedure TForm1.preparematerials;
var fn,fnb,fl,mn,omn,tf:string;
    i,j,k:integer;

    argv: array of PalByte;
    format: TALEnum;
    size: TALSizei;
    freq: TALSizei;
    loop: TALInt;
    data: TALVoid;

    maxsnd:integer;

begin

  //loads all materials into library

  //--section 1 - special materials

    //background and icons

    loadmessage:=strarr[149]+': '+strarr[150];
    Application.ProcessMessages;

    icon1.Material.MaterialLibrary:=matlib;
    icon2.Material.MaterialLibrary:=matlib;
    icon3.Material.MaterialLibrary:=matlib;
    icon4.Material.MaterialLibrary:=matlib;
    icon5.Material.MaterialLibrary:=matlib;
    icon6.Material.MaterialLibrary:=matlib;
    icon7.Material.MaterialLibrary:=matlib;
    icon8.Material.MaterialLibrary:=matlib;
    element_icon.Material.MaterialLibrary:=matlib;
    titlecard.Material.MaterialLibrary:=matlib;
    FastAddMaterial(qs+'\'+'ui_bg.tga','ui_bg',qs,1,0);
    csbackground.Material.LibMaterialName:=lam;
    csperkbg.Material.LibMaterialName:=lam;
    reqform.Material.LibMaterialName:=lam;
    FastAddMaterial(qs+'\'+'ui_tooltip.tga','ui_tooltip',qs,1,0);
    FastAddMaterial(qs+'\'+'ico_strength.tga','ico_strength',qs,1,0);
    icon1.Material.LibMaterialName:=lam;
    FastAddMaterial(qs+'\'+'ico_intelligence.tga','ico_intelligence',qs,1,0);
    icon2.Material.LibMaterialName:=lam;
    FastAddMaterial(qs+'\'+'ico_speed.tga','ico_speed',qs,1,0);
    icon3.Material.LibMaterialName:=lam;
    FastAddMaterial(qs+'\'+'ico_endurance.tga','ico_endurance',qs,1,0);
    icon4.Material.LibMaterialName:=lam;
    FastAddMaterial(qs+'\'+'ico_sword.tga','ico_sword',qs,1,0);
    icon5.Material.LibMaterialName:=lam;
    FastAddMaterial(qs+'\'+'ico_bow.tga','ico_bow',qs,1,0);
    icon6.Material.LibMaterialName:=lam;
    FastAddMaterial(qs+'\'+'ico_armor.tga','ico_armor',qs,1,0);
    icon7.Material.LibMaterialName:=lam;
    FastAddMaterial(qs+'\'+'ico_magic.tga','ico_magic',qs,1,0);
    icon8.Material.LibMaterialName:=lam;
    FastAddMaterial(qs+'\'+'xpbar.tga','xpbar',qs,1,0);
    xpbar_bg.Material.LibMaterialName:=lam;
    FastAddMaterial(qs+'\'+'xpindic.tga','xpindic',qs,1,0);
    xpbar.Material.LibMaterialName:=lam;
    FastAddMaterial(qs+'\'+'transp.tga','transp',qs,1,0);
    FastAddMaterial(qs+'\'+'but_0.tga','but_0',qs,1,0);
    FastAddMaterial(qs+'\'+'but_1.tga','but_1',qs,1,0);
    FastAddMaterial(qs+'\'+'but_2.tga','but_2',qs,1,0);
    FastAddMaterial(qs+'\'+'male_0.tga','male_0',qs,1,0);
    FastAddMaterial(qs+'\'+'male_1.tga','male_1',qs,1,0);
    FastAddMaterial(qs+'\'+'male_2.tga','male_2',qs,1,0);
    FastAddMaterial(qs+'\'+'female_0.tga','female_0',qs,1,0);
    FastAddMaterial(qs+'\'+'female_1.tga','female_1',qs,1,0);
    FastAddMaterial(qs+'\'+'female_2.tga','female_2',qs,1,0);
    FastAddMaterial(qs+'\'+'search_0.tga','search_0',qs,1,0);
    FastAddMaterial(qs+'\'+'search_1.tga','search_1',qs,1,0);
    FastAddMaterial(qs+'\'+'search_2.tga','search_2',qs,1,0);
    FastAddMaterial(qs+'\'+'spr_door.tga','spr_door',qs,0,0);
    FastAddMaterial(qs+'\'+'spr_table.tga','spr_table',qs,0,0);
    FastAddMaterial(qs+'\'+'fem_char.tga','fem_char',qs,1,0);
    FastAddMaterial(qs+'\'+'mal_char.tga','mal_char',qs,1,0);
    FastAddMaterial(qs+'\'+'oui_0.tga','oui_0',qs,1,0);
    FastAddMaterial(qs+'\'+'oui_1.tga','oui_1',qs,1,0);
    FastAddMaterial(qs+'\'+'oui_2.tga','oui_2',qs,1,0);
    FastAddMaterial(qs+'\'+'use_0.tga','use_0',qs,1,0);
    FastAddMaterial(qs+'\'+'use_1.tga','use_1',qs,1,0);
    FastAddMaterial(qs+'\'+'use_2.tga','use_2',qs,1,0);
    FastAddMaterial(qs+'\'+'save_0.tga','save_0',qs,1,0);
    FastAddMaterial(qs+'\'+'save_1.tga','save_1',qs,1,0);
    FastAddMaterial(qs+'\'+'save_2.tga','save_2',qs,1,0);
    FastAddMaterial(qs+'\'+'mnu_0.tga','mnu_0',qs,1,0);
    FastAddMaterial(qs+'\'+'mnu_1.tga','mnu_1',qs,1,0);
    FastAddMaterial(qs+'\'+'mnu_2.tga','mnu_2',qs,1,0);
    FastAddMaterial(qs+'\'+'jrn_0.tga','jrn_0',qs,1,0);
    FastAddMaterial(qs+'\'+'jrn_1.tga','jrn_1',qs,1,0);
    FastAddMaterial(qs+'\'+'jrn_2.tga','jrn_2',qs,1,0);
    FastAddMaterial(qs+'\'+'rf_scrollbg.tga','rf_scrollbg',qs,1,0);
    FastAddMaterial(qs+'\'+'unknown.tga','unknown',qs,1,0);
    FastAddMaterial(qs+'\'+'title.tga','title',qs,1,0);
    titlecard.Material.LibMaterialName:=lam;
    FastAddMaterial(qs+'\'+'keys_silver.tga','keys_silver',qs,1,0);
    key_silver.Material.LibMaterialName:=lam;
    FastAddMaterial(qs+'\'+'keys_gold.tga','keys_gold',qs,1,0);
    key_gold.Material.LibMaterialName:=lam;
    FastAddMaterial(qs+'\'+'keys_monster.tga','keys_monster',qs,1,0);
    monster_ico.Material.LibMaterialName:=lam;
    titlecard.Height:=200;
    titlecard.Width:=400;
    FastAddMaterial(qs+'\'+'bar_bg.tga','bar_bg',qs,1,0);
    pl_hpbar_bg.Material.LibMaterialName:=lam;
    pl_mpbar_bg.Material.LibMaterialName:=lam;
    monster_hpbar_bg.Material.LibMaterialName:=lam;
    FastAddMaterial(qs+'\'+'hpbar.tga','hpbar',qs,1,0);
    pl_hpbar.Material.LibMaterialName:=lam;
    monster_hpbar.Material.LibMaterialName:=lam;
    monster_sign.Material.MaterialLibrary:=matlib;
    FastAddMaterial(qs+'\'+'mpbar.tga','mpbar',qs,1,0);
    pl_mpbar.Material.LibMaterialName:=lam;
    FastAddMaterial(qs+'\'+'corner_tl.tga','corner_tl',qs,1,0);
    corner_tl.Material.LibMaterialName:=lam;
    FastAddMaterial(qs+'\'+'corner_tr.tga','corner_tr',qs,1,0);
    corner_tr.Material.LibMaterialName:=lam;
    FastAddMaterial(qs+'\'+'corner_bl.tga','corner_bl',qs,1,0);
    corner_bl.Material.LibMaterialName:=lam;
    FastAddMaterial('trbg.tga','trbg',qs,1,0);
    trbg.Material.LibMaterialName:=lam;
    reqform_dark.Material.LibMaterialName:=lam;
    FastAddMaterial(qs+'\'+'sframe_1.tga','sframe_1',qs,1,0);
    FastAddMaterial(qs+'\'+'sframe_2.tga','sframe_2',qs,1,0);
    FastAddMaterial(qs+'\'+'sframe_3.tga','sframe_3',qs,1,0);
    FastAddMaterial(qs+'\'+'iico_misc.tga','iico_misc',qs,1,0);
    FastAddMaterial(qs+'\'+'iico_bow.tga','iico_bow',qs,1,0);
    FastAddMaterial(qs+'\'+'iico_sword.tga','iico_sword',qs,1,0);
    FastAddMaterial(qs+'\'+'iico_shield.tga','iico_shield',qs,1,0);
    FastAddMaterial(qs+'\'+'iico_wand.tga','iico_wand',qs,1,0);
    FastAddMaterial(qs+'\'+'iico_helm.tga','iico_helm',qs,1,0);

    //element icons
    for i:=0 to 4 do
    begin
      FastAddMaterial(qs+'\'+'element_'+inttostr(i)+'.tga','element_'+inttostr(i),qs,1,0);
    end;


    //preparing ITEM LIST ELEMENTS
    for i:=0 to 9 do
    for j:=0 to 9 do
    begin
      TGLHUDSprite(itemslot[i,j]):=TGLHUDSprite.CreateAsChild(inventory);
      TGLHUDSprite(itemslot[i,j]).Material.MaterialLibrary:=matlib;
      TGLHUDSprite(itemslot_frame[i,j]):=TGLHUDSprite.CreateAsChild(inventory);
      TGLHUDSprite(itemslot_frame[i,j]).Material.MaterialLibrary:=matlib;
    end;

    for i:=0 to 9 do
    for j:=0 to 9 do
    begin
      TGLHUDSprite(itemslot_icon[i,j]):=TGLHUDSprite.CreateAsChild(inventory);
      TGLHUDSprite(itemslot_icon[i,j]).Material.MaterialLibrary:=matlib;
      TGLHUDText(itemslot_text[i,j]):=TGLHUDText.CreateAsChild(inventory);
      TGLHUDText(itemslot_text[i,j]).BitmapFont:=GLWindowsBitmapFont1;

    end;

    TGLHUDSprite(itemlistbg):=TGLHUDSprite.CreateAsChild(inventory);
    TGLHUDSprite(itemlistbg).Material.MaterialLibrary:=matlib;
    TGLHUDSprite(itemlistbg).Material.LibMaterialName:='ui_bg';
    TGLHUDSprite(invitmdesc).Material.LibMaterialName:='ui_bg';
    itemlisttitle:=TGLHUDText.CreateAsChild(inventory);
    itemlisttitle.BitmapFont:=GLWindowsBitmapFont1;
    ilitemtitle:=TGLHUDText.CreateAsChild(inventory);
    ilitemtitle.BitmapFont:=GLWindowsBitmapFont1;


  //loading character bodyparts

    loadmessage:=strarr[149]+': '+strarr[151];
    lp:=3;
    Application.ProcessMessages;

    maxheadsm:=getmaxfaces(0);
    maxheadsf:=getmaxfaces(1);
    maxhatsm:=getmaxhats(0);
    maxhatsf:=getmaxhats(1);
    maxhairm:=getmaxhair(0);
    maxhairf:=getmaxhair(1);
    maxclothm:=getmaxcloth(0);
    maxclothf:=getmaxcloth(1);
    for i:=0 to maxheadsm-1 do
    begin
      FastAddMaterial(qs+'\'+'bodies\0\head_'+inttostr(i)+'.tga','mal_face_'+inttostr(i),qs,1,0);
    end;
    for i:=0 to maxheadsf-1 do
    begin
      FastAddMaterial(qs+'\'+'bodies\1\head_'+inttostr(i)+'.tga','fem_face_'+inttostr(i),qs,1,0);
    end;
    for i:=0 to maxhairm-1 do
    begin
      FastAddMaterial(qs+'\'+'bodies\0\hair_'+inttostr(i)+'.tga','mal_hair_'+inttostr(i),qs,1,0);
      FastAddMaterial(qs+'\'+'bodies\0\haireb_'+inttostr(i)+'.tga','mal_haireb_'+inttostr(i),qs,1,0);
      FastAddMaterial(qs+'\'+'bodies\0\hairbrd_'+inttostr(i)+'.tga','mal_hairbrd_'+inttostr(i),qs,1,0);
      FastAddMaterial(qs+'\'+'bodies\0\hairb_'+inttostr(i)+'.tga','mal_hairb_'+inttostr(i),qs,1,0);
    end;
    for i:=0 to maxhairf-1 do
    begin
      FastAddMaterial(qs+'\'+'bodies\1\hair_'+inttostr(i)+'.tga','fem_hair_'+inttostr(i),qs,1,0);
      FastAddMaterial(qs+'\'+'bodies\1\haireb_'+inttostr(i)+'.tga','fem_haireb_'+inttostr(i),qs,1,0);
      FastAddMaterial(qs+'\'+'bodies\1\hairbrd_'+inttostr(i)+'.tga','fem_hairbrd_'+inttostr(i),qs,1,0);
      FastAddMaterial(qs+'\'+'bodies\1\hairb_'+inttostr(i)+'.tga','fem_hairb_'+inttostr(i),qs,1,0);
    end;
    for i:=0 to maxhatsm-1 do
    begin
      FastAddMaterial(qs+'\'+'bodies\0\hat_'+inttostr(i)+'.tga','mal_hat_'+inttostr(i),qs,1,0);
      FastAddMaterial(qs+'\'+'bodies\0\hatb_'+inttostr(i)+'.tga','mal_hatb_'+inttostr(i),qs,1,0);
    end;
    for i:=0 to maxhatsf-1 do
    begin
      FastAddMaterial(qs+'\'+'bodies\1\hat_'+inttostr(i)+'.tga','fem_hat_'+inttostr(i),qs,1,0);
      FastAddMaterial(qs+'\'+'bodies\1\hatb_'+inttostr(i)+'.tga','fem_hatb_'+inttostr(i),qs,1,0);
    end;
    for i:=0 to 4 do
    begin
      FastAddMaterial(qs+'\'+'bodies\1\torso_'+inttostr(i)+'.tga','fem_torso_'+inttostr(i),qs,1,0);
      FastAddMaterial(qs+'\'+'bodies\1\arms_'+inttostr(i)+'.tga','fem_arms_'+inttostr(i),qs,1,0);

      FastAddMaterial(qs+'\'+'bodies\0\torso_'+inttostr(i)+'.tga','mal_torso_'+inttostr(i),qs,1,0);
      FastAddMaterial(qs+'\'+'bodies\0\arms_'+inttostr(i)+'.tga','mal_arms_'+inttostr(i),qs,1,0);
    end;
    for i:=0 to maxclothm-1 do
    begin
      FastAddMaterial(qs+'\'+'bodies\0\armor_'+inttostr(i)+'.tga','mal_cloth_'+inttostr(i),qs,1,0);
    end;
    for i:=0 to maxclothf-1 do
    begin
      FastAddMaterial(qs+'\'+'bodies\1\armor_'+inttostr(i)+'.tga','fem_cloth_'+inttostr(i),qs,1,0);
    end;

    FastAddMaterial(qs+'\'+'bodies\wings_1.tga','wings_1',qs,1,0);
    FastAddMaterial(qs+'\'+'bodies\wings_2.tga','wings_2',qs,1,0);
    FastAddMaterial(qs+'\'+'bodies\wings_3.tga','wings_3',qs,1,0);

  //loadscreens

    i:=-1;
    loadscrs:=0;
    repeat
      i:=i+1;
      if fileexists(gameexe+'\textures\'+qs+'\loadscr\'+inttostr(i)+'.tga')=true then
      begin
        FastAddMaterial(qs+'\loadscr\'+inttostr(i)+'.tga','loadscr_'+inttostr(i),qs,1,0);
        loadscrs:=loadscrs+1;
      end;
    until fileexists(gameexe+'\textures\'+qs+'\loadscr\'+inttostr(i)+'.tga')=false;
   loadscr_f.Material.LibMaterialName:='---';
   lp:=4;

  //--section 2 - universal materials

  loadmessage:=strarr[149]+': '+strarr[152];
  Application.ProcessMessages;

  sets:=GetSets;
  for i:=0 to (sets-1) do
  begin

    k:=0;
    repeat
      //loading texture
      FastAddMaterial(qs+'\'+inttostr(i)+'\tex_'+inttostr(k)+'.tga','etex'+'_'+inttostr(i)+'_'+inttostr(k),qs,0,0);
      k:=k+1;
    until k=10;

    try //trying to read set attributes
      Memo1.Lines.LoadFromFile(gameexe+'\textures\'+qs+'\'+inttostr(i)+'\arid.txt');
      env[i].name:=memo1.Lines[0];
      env[i].enabled:=strtobool(memo1.Lines[1]);
    except end;

  end;

  loadmessage:=strarr[149]+': '+strarr[153];
  lp:=5;
  Application.ProcessMessages;


  fn:=gameexe+'\textures\';
  Memo1.Lines.LoadFromFile(fn+'spritelist.txt');
  SetLength(alitms,Memo1.Lines.Count);
  for i:=0 to Memo1.Lines.Count-1 do
  begin
    alitms[i].name:=getslitem(memo1.Lines[i],i,0);
    alitms[i].purpose:=strtoint(getslitem(memo1.Lines[i],i,1));
    alitms[i].size:=strtoint(getslitem(memo1.Lines[i],i,2));
    alitms[i].size2:=strtoint(getslitem(memo1.Lines[i],i,3));
  end;

  for i:=0 to (Length(alitms)-1) do
  begin

    fn:=gameexe+'\textures\'+qs+'\'+alitms[i].name+'.tga';
    fnb:=gameexe+'\textures\'+qs+'\'+alitms[i].name+'_2.tga';

    if fileexists(fn)=false then
    begin
      fn:=gameexe+'\textures\'+qs+'\'+'empty.tga';
    end;

    omn:=alitms[i].name;

    with matlib.Materials.Add do
    begin
      Material.Texture.Image.LoadFromFile(fn);
      Material.Texture.Disabled:= false;
      Material.Texture.TextureMode:=tmModulate;
      Material.Texture.ImageAlpha:=tiaDefault;
      Material.BlendingMode:= bmTransparency;
      Material.FrontProperties.Emission.Red:=0;
      Material.FrontProperties.Emission.Green:=0;
      Material.FrontProperties.Emission.Blue:=0;
      if qs='pq' then
      begin
        Material.Texture.MagFilter:=maNearest;
        Material.Texture.MinFilter:=miNearest;
      end;
      {else
      begin
        Material.Texture.MagFilter:=maLinear;
        Material.Texture.MinFilter:=miLinear;
      end;}
      Name:=omn;
    end;

    //loading lm
    fn:=fnb;
    if fileexists(fn)=true then
    begin
      //if omn='tex_walltorch' then showmessage('walltorch opaq');
      mn:=omn+'_2';
      with matlib.Materials.Add do
      begin
        Material.Texture.Image.LoadFromFile(fn);
        Material.Texture.Disabled:= false;
        Material.BlendingMode:= bmTransparency;
        Material.Texture.ImageAlpha:=tiaDefault;
        Material.Texture.TextureMode:=tmModulate;
        Material.FrontProperties.Emission.Red:=0;
        Material.FrontProperties.Emission.green:=0;
        Material.FrontProperties.Emission.blue:=0;
        if qs='pq' then
        begin
          Material.Texture.MagFilter:=maNearest;
          Material.Texture.MinFilter:=miNearest;
        end;
        {else
        begin
          Material.Texture.MagFilter:=maLinear;
          Material.Texture.MinFilter:=miLinear;
        end; }
        Name:=mn;
      end;

      matlib.LibMaterialByName(omn).Texture2Name:=mn;

      matlib.LibMaterialByName(omn).Shader:=GLTexCombineShader1;

    end
    else
    begin
      //if omn='tex_walltorch' then showmessage('walltorch transp');
      matlib.LibMaterialByName(omn).Material.BlendingMode:= bmTransparency;
    end;
  end;

  //special UI elements

  loadmessage:=strarr[149]+': '+strarr[154];
  lp:=6;
    Application.ProcessMessages;

  fn:=gameexe+'\textures\';
  Memo1.Lines.LoadFromFile(fn+'uilist.txt');
  for i:=0 to Memo1.Lines.Count-1 do
  begin
    //ShowMessage('Adding UI: "'+Memo1.Lines[i]+'"');
    FastAddMaterial(qs+'\'+Memo1.Lines[i]+'.tga',Memo1.Lines[i],qs,1,0);
  end;


  //activating teleport glow
  FreeAndNil(teleport_glow);
  teleport_glow:=TGLHUDSprite.CreateAsChild(dcuimiddle);
  with teleport_glow do
  begin
    fn:=gameexe+'\textures\'+qs+'\'+'port_glow.tga';
    with teleport_glow.Material do
    begin
      BlendingMode:= bmTransparency;
      try
        Texture.Image.LoadFromFile(fn);
      except end;
      Texture.Disabled:= false;
      Texture.TextureMode:=tmModulate;
      FrontProperties.Emission.Red:=1;
      FrontProperties.Emission.Green:=1;
      FrontProperties.Emission.Blue:=1;
      FrontProperties.Diffuse.Alpha:=0;
    end;
    //hpsprite.Height:=1;
    Visible:=true;
  end;
  {with teleport_glow do
  begin
    Material.LibMaterialName:='port_glow';
    Material.BlendingMode:=bmTransparency;
    Material.Texture.TextureMode:=tmModulate;
  end;}


  //loading cards
  k:=0;
  FastAddMaterial('cards\'+lang+'\xp.png','card_xp',qs,1,0);
  repeat
     fl:=gameexe+'\cards\'+inttostr(k)+'.crd';
     if fileexists(fl)=true then
     begin
       try
         FastAddMaterial('cards\'+lang+'\'+inttostr(k)+'_0.png','card_'+inttostr(k)+'_0',qs,1,0);
         FastAddMaterial('cards\'+lang+'\'+inttostr(k)+'_1.png','card_'+inttostr(k)+'_1',qs,1,0);
         FastAddMaterial('cards\'+lang+'\'+inttostr(k)+'_2.png','card_'+inttostr(k)+'_2',qs,1,0);
         FastAddMaterial('cards\h'+inttostr(k)+'.jpg','ch_'+inttostr(k),qs,1,0);
         deck[k]:=Form2.LoadCard(fl,lang);
         //tf:=gameexe+'\text\'+lang+'\overrides\spells\'+inttostr(k)+'.txt';
         //if FileExists(tf)=true then
         //begin
         //  Memo1.Lines.LoadFromFile(tf);
         // deck[k].name:=Memo1.Lines[0];
         //end;
       except

       end;

     end
     else
     begin
       totcards:=k;
     end;
     k:=k+1;
  until fileexists(fl)=false;

  //adding perk icons
  loadmessage:=strarr[149]+': '+strarr[197];
  lp:=7;
  Application.ProcessMessages;

  for k:=0 to 100 do
  begin
    if fileexists(gameexe+'\textures\perkicons\'+inttostr(k)+'.tga')=true then
    begin
      FastAddMaterial('perkicons\'+inttostr(k)+'.tga','perkico_'+inttostr(k),qs,1,0);
    end;
  end;


  //loading monsters

  loadmessage:=strarr[149]+': '+strarr[155];
  Application.ProcessMessages;

  for k:=0 to 100 do
  begin
    monsters[k].name:='none';
  end;

  k:=0;
  repeat
     fn:=gameexe+'\textures\'+qs+'\'+'monsters\'+inttostr(k)+'.tga';
     fl:=gameexe+'\monsters\'+inttostr(k)+'.mon';
     if fileexists(fl)=true then
     begin
       FastAddMaterial(qs+'\'+'monsters\'+inttostr(k)+'.tga','mon_'+inttostr(k),qs,1,0);
       monsters[k]:=Form2.LoadChar(fl);
       tf:=gameexe+'\text\'+lang+'\overrides\monsters\'+inttostr(k)+'.txt';
       if FileExists(tf)=true then
       begin
         Memo1.Lines.LoadFromFile(tf);
         monsters[k].name:=Memo1.Lines[0];
       end;
     end
     else
     begin
       monstersno:=k+1;
     end;
     k:=k+1;
  until fileexists(fl)=false;


  //loading perks
  for i:=0 to 100 do
  begin
    if fileexists(gameexe+'\perks\p_'+inttostr(i)+'.prk')=true then
    begin
      bperks[i]:=Form2.LoadPerk(i,gameexe+'\perks\p_'+inttostr(i)+'.prk');
      if fileexists(gameexe+'\text\'+lang+'\overrides\perks\'+inttostr(i)+'.txt')=true then
      begin
        Memo1.Lines.Clear;
        Memo1.Lines.LoadFromFile(gameexe+'\text\'+lang+'\overrides\perks\'+inttostr(i)+'.txt');
        bperks[i].name:=Memo1.Lines[0];
      end;
    end
    else
      bperks[i].enabled:=false;
  end;
  bperks[-1].enabled:=false;
  bperks[101].enabled:=false;

  //loading effect icons
  loadmessage:=strarr[149]+': '+strarr[156];
  lp:=8;
    Application.ProcessMessages;

  for i:=1 to 100 do
  begin
    FastAddMaterial(qs+'\effect_'+inttostr(i)+'.tga','effect_'+inttostr(i),qs,1,0);
  end;

  //creating effect icons
  for j:=0 to 1 do
  for i:=1 to 100 do
  begin
    try
      FreeAndNil(effstate[j,i]);
      FreeAndNil(efflgtht[j,i]);
    except end;
    effstate[j,i]:=TGLHUDSprite.CreateAsChild(dcuifront);
    with effstate[j,i] do
    begin
      Width:=32;
      Height:=32;
      Material.MaterialLibrary:=matlib;
    end;
    efflgtht[j,i]:=TGLHUDText.CreateAsChild(dcuifront);
    with efflgtht[j,i] do
    begin
      BitmapFont:=GLWindowsBitmapFont1;
    end;
  end;

  //loading skyboxes
  loadmessage:=strarr[149]+': '+strarr[157];
  lp:=9;
    Application.ProcessMessages;
  k:=0;
  repeat
    k:=k+1;
    FastAddMaterial(qs+'\'+'skyboxes\'+inttostr(k)+'\top.tga','sb_'+inttostr(k)+'_top',qs,1,0);
    FastAddMaterial(qs+'\'+'skyboxes\'+inttostr(k)+'\bottom.tga','sb_'+inttostr(k)+'_bottom',qs,1,0);
    FastAddMaterial(qs+'\'+'skyboxes\'+inttostr(k)+'\left.tga','sb_'+inttostr(k)+'_left',qs,1,0);
    FastAddMaterial(qs+'\'+'skyboxes\'+inttostr(k)+'\right.tga','sb_'+inttostr(k)+'_right',qs,1,0);
    FastAddMaterial(qs+'\'+'skyboxes\'+inttostr(k)+'\front.tga','sb_'+inttostr(k)+'_front',qs,1,0);
    FastAddMaterial(qs+'\'+'skyboxes\'+inttostr(k)+'\back.tga','sb_'+inttostr(k)+'_back',qs,1,0);
    FastAddMaterial(qs+'\'+'skyboxes\'+inttostr(k)+'\clouds.tga','sb_'+inttostr(k)+'_clouds',qs,1,0);
  until (fileexists(gameexe+'\textures\'+qs+'\skyboxes\'+inttostr(k)+'\top.tga')=false);


  //items
  loadmessage:=strarr[149]+': '+strarr[158];
  lp:=10;
    Application.ProcessMessages;

  k:=0;
  repeat
    FastAddMaterial(qs+'\'+'items\'+inttostr(k)+'.tga','itm_'+inttostr(k),qs,1,0);

    try
      itms[k]:=Form2.LoadLoot(gameexe+'\items\'+inttostr(k)+'.lot');
      if k=0 then itms[k].count:=1; // adding item 0 forcedly
    except end;

    k:=k+1;
  until (fileexists(gameexe+'\textures\'+qs+'\'+'items\'+inttostr(k)+'.tga')=false);
  totitems:=k;


  //loading sounds
  {loadmessage:=strarr[159];
  Application.ProcessMessages;
  Memo1.Lines.LoadFromFile(gameexe+'\sounds\audio\soundlist.txt');
  GLSoundLibrary1.Samples.Clear;
  for i:=0 to Memo1.Lines.Count-1 do
  begin
    GLSoundLibrary1.Samples.AddFile(gameexe+'\sounds\audio\'+Memo1.Lines[i]+'.wav',Memo1.Lines[i]);
  end;}


  //NEW loadsounds

  loadmessage:=strarr[159];
  lp:=11;
  Application.ProcessMessages;

 { Memo1.Lines.LoadFromFile(gameexe+'\sounds\audio\soundlist.txt');

  AlGenBuffers(Memo1.Lines.Count, @bfr);

  for i:=0 to (Memo1.Lines.Count-1) do
  begin
    AlutLoadWavFile(gameexe+'\sounds\audio\'+Memo1.Lines[i]+'.wav', format, data, size, freq, loop);
    AlBufferData(bfr[i], format, data, size, freq);
    AlutUnloadWav(format, data, size, freq);
    soundarr[i].name:=Memo1.Lines[i];
    soundarr[i].id:=i;
  end;

  AlGenSources(Memo1.Lines.Count, @src);

  for i:=0 to (Memo1.Lines.Count-1) do
  begin
    AlSourcei  ( src[i], AL_BUFFER, bfr[i]);
    AlSourcef  ( src[i], AL_PITCH, 1.0 );
    AlSourcef  ( src[i], AL_GAIN, snd/100 );
    AlSourcefv ( src[i], AL_POSITION, @sourcepos);
    AlSourcefv ( src[i], AL_VELOCITY, @sourcevel);
    AlSourcei  ( src[i], AL_LOOPING, AL_FALSE);
    soundarr[i].name:=Memo1.Lines[i];
    soundarr[i].id:=i;
  end;

  //loading music
  Memo1.Lines.LoadFromFile(gameexe+'\sounds\music\musiclist.txt');

  AlGenBuffers(Memo1.Lines.Count, @bfr2);

  for i:=0 to (Memo1.Lines.Count-1) do
  begin
    AlutLoadWavFile(gameexe+'\sounds\music\'+Memo1.Lines[i]+'.wav', format, data, size, freq, loop);
    AlBufferData(bfr2[i], format, data, size, freq);
    AlutUnloadWav(format, data, size, freq);
    musicarr[i].name:=Memo1.Lines[i];
    musicarr[i].id:=i;
  end;

  AlGenSources(Memo1.Lines.Count, @src2);

  for i:=0 to (Memo1.Lines.Count-1) do
  begin
    AlSourcei  ( src2[i], AL_BUFFER, bfr2[i]);
    AlSourcef  ( src2[i], AL_PITCH, 1.0 );
    AlSourcef  ( src2[i], AL_GAIN, snd/100 );
    AlSourcefv ( src2[i], AL_POSITION, @sourcepos);
    AlSourcefv ( src2[i], AL_VELOCITY, @sourcevel);
    AlSourcei  ( src2[i], AL_LOOPING, AL_FALSE);
  end;


  //ShowMessage('sounds done');}

  LoadSounds;

end;


//NEW SOUND SYSTEM

//-----sound-----

//LOAD SOUNDS PROCEDURE 1
procedure TForm1.PrepareSound(sndname:string; sprp:integer);
var
  argv: array of PalByte;
  format: TALEnum;
  size: TALSizei;
  freq: TALSizei;
  loop: TALInt;
  data: TALVoid;
  //cbuf: TAluInt;

begin

  try

    alDeleteBuffers(1,@buffer1);
    alDeleteSources(1,@source1);

    AlGenBuffers(1, @buffer1);

    AlutLoadWavFile(sndname, format, data, size, freq, loop);
    AlBufferData(buffer1, format, data, size, freq);
    AlutUnloadWav(format, data, size, freq);

    AlGenSources(1, @source1);
    AlSourcei ( source1, AL_BUFFER, buffer1);
    AlSourcef ( source1, AL_PITCH, 1.0 );
    AlSourcef ( source1, AL_GAIN, msk/100 );
    AlSourcefv ( source1, AL_POSITION, @sourcepos);
    AlSourcefv ( source1, AL_VELOCITY, @sourcevel);
    AlSourcei ( source1, AL_LOOPING, AL_TRUE);
    AlListenerfv ( AL_POSITION, @listenerpos);
    AlListenerfv ( AL_VELOCITY, @listenervel);
    AlListenerfv ( AL_ORIENTATION, @listenerori);

   except ShowMessage('Sound Error') end;

end;

//loadsounds
procedure TForm1.LoadSounds;
var i:integer;
    argv: array of PalByte;
    format: TALEnum;
    size: TALSizei;
    freq: TALSizei;
    loop: TALInt;
    data: TALVoid;
    maxsnd:integer;
begin


  if b1c>0 then
    alDeleteBuffers(b1c,@bfr);
  if s1c>0 then
    alDeleteSources(s1c,@src);
  if b2c>0 then
    alDeleteBuffers(b2c,@bfr2);
  if s2c>0 then
    alDeleteSources(s2c,@src2);

  loadmessage:=strarr[159];
  Application.ProcessMessages;

  Memo5.Lines.LoadFromFile(gameexe+'\sounds\audio\soundlist.txt');

  loadmessage:=strarr[185]+':'+#10#13+Memo5.Text;
  //ShowMessage('List loaded:'+#10#13+Memo5.Text);
  Application.ProcessMessages;

  loadmessage:=strarr[186]+' ('+inttostr(Memo5.Lines.Count)+')';
  //ShowMessage('Generating buffers ('+inttostr(Memo5.Lines.Count)+')');
  Application.ProcessMessages;

  AlGenBuffers(Memo5.Lines.Count, @bfr);
  b1c:=Memo5.Lines.Count;

  for i:=0 to (Memo5.Lines.Count-1) do
  begin
    loadmessage:=strarr[187]+' ('+inttostr(i)+'/'+inttostr(Memo5.Lines.Count)+')';
    //ShowMessage('Loading sounds ('+inttostr(i)+'/'+inttostr(Memo5.Lines.Count)+')');
    Application.ProcessMessages;
    //try

      AlutLoadWavFile(gameexe+'\sounds\audio\'+Memo5.Lines[i]+'.wav', format, data, size, freq, loop);
      //showmessage('file: '+exen+'\sounds\audio\'+Memo5.Lines[i]+'.wav');
      AlBufferData(bfr[i], format, data, size, freq);
      //showmessage('bufferdata ok');
      AlutUnloadWav(format, data, size, freq);
      //showmessage('unload ok');
      soundarr[i].name:=Memo5.Lines[i];
      soundarr[i].id:=i;
    //except

    //end;
  end;

  AlGenSources(Memo5.Lines.Count, @src);
  s1c:=Memo5.Lines.Count;
  //showmessage('sources ok');

  for i:=0 to (Memo5.Lines.Count-1) do
  begin
    loadmessage:=strarr[188]+' ('+inttostr(i)+'/'+inttostr(Memo5.Lines.Count)+')';
    //ShowMessage('Creating sound sources ('+inttostr(i)+'/'+inttostr(Memo5.Lines.Count)+')');
    Application.ProcessMessages;
    try
      AlSourcei  ( src[i], AL_BUFFER, bfr[i]);
      AlSourcef  ( src[i], AL_PITCH, 1.0 );
      AlSourcef  ( src[i], AL_GAIN, 100 );
      AlSourcefv ( src[i], AL_POSITION, @sourcepos);
      AlSourcefv ( src[i], AL_VELOCITY, @sourcevel);
      AlSourcei  ( src[i], AL_LOOPING, AL_FALSE);
      soundarr[i].name:=Memo5.Lines[i];
      soundarr[i].id:=i;
    except

    end;
  end;

  //loading music
  Memo5.Clear;
  Memo5.Lines.LoadFromFile(gameexe+'\sounds\music\musiclist.txt');
  loadmessage:=strarr[185]+':'+#10#13+Memo5.Text;
  //ShowMessage('List loaded:'+#10#13+Memo5.Text);
  Application.ProcessMessages;

  loadmessage:=strarr[186]+' ('+inttostr(Memo5.Lines.Count)+')';
  //ShowMessage('Generating buffers ('+inttostr(Memo5.Lines.Count)+')');
  Application.ProcessMessages;

  AlGenBuffers(Memo5.Lines.Count, @bfr2);
  b2c:=Memo5.Lines.Count;
  //showmessage('buffers ok');

  for i:=0 to (Memo5.Lines.Count-1) do
  begin
    loadmessage:=strarr[189]+' ('+inttostr(i)+'/'+inttostr(Memo5.Lines.Count)+')';
    //showmessage('Loading music ('+inttostr(i)+'/'+inttostr(Memo5.Lines.Count)+')');
    Application.ProcessMessages;
    try
      //showmessage('file: '+exen+'\sounds\music\'+Memo5.Lines[i]+'.wav');
      AlutLoadWavFile(gameexe+'\sounds\music\'+Memo5.Lines[i]+'.wav', format, data, size, freq, loop);
      //showmessage('file ok');
      AlBufferData(bfr2[i], format, data, size, freq);
      //showmessage('bufferdata ok');
      AlutUnloadWav(format, data, size, freq);
      //showmessage('unload ok');
      musicarr[i].name:=Memo5.Lines[i];
      musicarr[i].id:=i;
    except

    end;
  end;

  AlGenSources(Memo5.Lines.Count, @src2);
  s2c:=Memo5.Lines.Count;

  for i:=0 to (Memo5.Lines.Count-1) do
  begin
    loadmessage:=strarr[190]+' ('+inttostr(i)+'/'+inttostr(Memo5.Lines.Count-1)+')';
    Application.ProcessMessages;
    try
      AlSourcei  ( src2[i], AL_BUFFER, bfr2[i]);
      AlSourcef  ( src2[i], AL_PITCH, 1.0 );
      AlSourcef  ( src2[i], AL_GAIN, 100 );
      AlSourcefv ( src2[i], AL_POSITION, @sourcepos);
      AlSourcefv ( src2[i], AL_VELOCITY, @sourcevel);
      AlSourcei  ( src2[i], AL_LOOPING, AL_FALSE);
    except

    end;
  end;

  AlListenerfv ( AL_POSITION, @listenerpos);
  AlListenerfv ( AL_VELOCITY, @listenervel);
  AlListenerfv ( AL_ORIENTATION, @listenerori);

  sloaded:=true;

end;


//music controller

procedure TForm1.ControlMusic;
var mkx,mky,uin:integer;
    i,ik,sid:integer;
    desbmn,snm:string;
    scx,scy,sw,sh:integer;
    mngName:string;
    xpwd:real;
    retch:integer;
begin
  //if oal=true then
  begin

  //music controller
  if sloaded=true then
  begin

  if mmmode=true then cmusic:='menu'
  else
  begin
    if btlmode=true then
    begin
      cmusic:='battle';
      if fileexists(gameexe+'\sounds\music\'+enemy.oname+'.wav')=true then
      begin
        cmusic:=enemy.oname;
        //ShowMessage(enemy.name);
      end;
    end
    else
    begin
      if fileexists(gameexe+'\sounds\music\'+'peace'+IntToStr(envir)+'.wav')=true then
        cmusic:='peace'+IntToStr(envir)
      else
        cmusic:='menu';
    end;
  end;

  if mskon=true then
  begin
    if (cmusic<>amusic) then
    begin
      amusic:=cmusic;

      try

        ik:=-1;

        repeat
          ik:=ik+1;
          snm:=musicarr[ik].name; //reading possible name from DB
          if (amusic=snm) then
          begin
            sid:=ik; //getting index if name fits
            pmsk:=msk;
          end;
        until (amusic=snm) or (ik>=1000);

        if sid<>-1 then
        begin
          alSourceStop(src2[cpm]);
          alSourcePlay(SRC2[sid]); //playing
          cpm:=sid;
        end;

      except

      end;

    end;
    if msk<>pmsk then AlSourcef  ( src2[cpm], AL_GAIN, msk/100 );
  end;

  if (mskon=false) and (amusic<>'') then
  begin
    alSourceStop(src2[cpm]);
    amusic:='';
  end;

 end;

 end; //<-ebd for if oal=true

end;


procedure Tform1.DoSound(sndn:string);
var ik:integer;
    sid:integer;
    snm:string;
begin

  //if oal=true then
  begin

    //playing sound
    if sloaded=true then
    try if sndon=true then
    begin

      ik:=-1;

      repeat
        ik:=ik+1;
        snm:=soundarr[ik].name; //reading possible name from DB
        if (sndn=snm) then
        begin
          sid:=ik; //getting index if name fits
        end;
      until (sndn=snm) or (ik>=1000);

      if ik>=1000 then
      begin
        sid:=-1; //disabling playback if name won't fit
      end;

      if sid<>-1 then
      begin
        AlSourcef  ( src[sid], AL_GAIN, snd/100 );
        alSourcePlay(SRC[sid]); //playing
      end;


    end; except end;

  end;
//----end sound

end;


//END NEW SOUND SYSTEM

end.
