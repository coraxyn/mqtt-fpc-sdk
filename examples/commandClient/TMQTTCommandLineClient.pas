unit MQTTCommandLineClient;

{$mode objfpc}{$H+}

interface

type

TMQTTCommandLineClient = class
public
  constructor Create(const ip:ShortString;const port:SmallInt);
  function Send( const message:ShortString):Boolean;
end;


uses
  Classes, SysUtils;

implementation

end.

