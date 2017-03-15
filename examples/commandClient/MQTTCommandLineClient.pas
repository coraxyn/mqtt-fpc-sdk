unit MQTTCommandLineClient;

{$mode objfpc}{$H+}

interface

type

  TMQTTCommandLineClient = class
  private
    brokerIp:   ShortString;
    brokerPort: smallint;
  public
    constructor Create(const ip: ShortString; const port: smallint);
    function Send(const channel: ShortString; const message: ShortString): boolean;
  end;




implementation

uses
  Classes, SysUtils, MQTT;

constructor TMQTTCommandLineClient.Create(const ip: ShortString;
  const port: smallint);
begin
  brokerIp   := ip;
  brokerPort := port;
end;

function TMQTTCommandLineClient.Send(const channel: ShortString; const message: ShortString): boolean;
var
  client: TMQTTClient;
begin
  client := TMQTTClient.Create(self.brokerIp, self.brokerPort);

  client.Connect;
  WriteLn('connecting to...' + self.brokerIp);
  Sleep(100);
  if client.isConnected then begin
    WriteLn('client connected');
    if client.Publish(channel, message) then
      WriteLn( channel + '-->' + message + ' SENT')
    else
      WriteLn('Message not sent');
    client.Disconnect;
    client.Free;
  end else begin
    WriteLn('connexion failed');
  end;
end;

end.

