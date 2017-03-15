program commandClient;

{$mode objfpc}{$H+}

uses
 {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
   {$ENDIF} {$ENDIF}
  Classes, SysUtils, CustApp, MQTTCommandLineClient
  { you can add units after this };

type

  { TMQTTCmdCllient }

  TMQTTCmdCllient = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

  { TMQTTCmdCllient }

  procedure TMQTTCmdCllient.DoRun;
  var
    ErrorMsg: string;
    client: TMQTTCommandLineClient;
  begin
    // quick check parameters
    ErrorMsg := CheckOptions('ip', ['ip', 'port']);
    if ErrorMsg <> '' then begin
      ShowException(Exception.Create(ErrorMsg));
      Terminate;
      Exit;
    end;

    // parse parameters
    if HasOption('h', 'help') then begin
      WriteHelp;
      Terminate;
      Exit;
    end;

    { add your program here }
    if HasOption('i', 'ip') and HasOption('p', 'port') then begin

      client := TMQTTCommandLineClient.Create(GetOptionValue('i','ip'), StrToInt(GetOptionValue('p','port')));
      client.Send('/jo/easy/RESS/R00001/R0004/SetPoint','Hello Dave..');
      Sleep(5000);
      client.Send('/jo/easy/RESS/R00001/R0004/SetPoint','Are you here ?');
      Sleep(1000);
      client.Send('/jo/easy/RESS/R00001/R0004/SetPoint','The void is waiting for you.');

    end else begin
      WriteHelp;
      Terminate;
      Exit;
    end;

    // stop program loop
    // Terminate;
  end;

  constructor TMQTTCmdCllient.Create(TheOwner: TComponent);
  begin
    inherited Create(TheOwner);
    StopOnException := True;
  end;

  destructor TMQTTCmdCllient.Destroy;
  begin
    inherited Destroy;
  end;

  procedure TMQTTCmdCllient.WriteHelp;
  begin
    { add your help code here }
    writeln('Usage: ', ExeName, ' -h');
    Writeln('Usage: ', ExeName, ' -i 120.0.0.1 -p 1883');
  end;

var
  Application: TMQTTCmdCllient;
begin
  Application := TMQTTCmdCllient.Create(nil);
  Application.Title:='MQTTCommandClient';
  Application.Run;
  Application.Free;
end.

