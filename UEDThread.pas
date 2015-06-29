unit UEDThread;

interface

uses
  System.Classes, UED_Main;

type
  EDThread = class(TThread)
  protected
    procedure CdRn;
    procedure Execute; override;
  end;

implementation

{ 
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);  

  and UpdateCaption could look like,

    procedure EDThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; 
    
    or 
    
    Synchronize( 
      procedure 
      begin
        Form1.Caption := 'Updated in thread via an anonymous method' 
      end
      )
    );
    
  where an anonymous method is passed.
  
  Similarly, the developer can call the Queue method with similar parameters as 
  above, instead passing another TThread class as the first parameter, putting
  the calling thread in a queue with the other thread.
    
}

{ EDThread }

procedure EDThread.CdRn;
begin
  if multithread=true then
    begin
      Form1.CadencerRun(0.01);
      Sleep(10);
    end;
end;

procedure EDThread.Execute;
begin
  NameThreadForDebugging('CDThread');
  FreeOnTerminate := True;
  { Place thread code here }

  while multithread=true do
  begin
    if Form1.GLCadencer1.Enabled=true then Synchronize(CdRn);
  end;

end;

end.
