unit uT3ClientEventManager;

interface

uses
  {Delphi Uses}
  SysUtils, Variants, ComCtrls, Classes,Math, Windows,

  {Project Uses}
  uConstantaData, uT3Listener, uT3EventManager, uT3SimManager, uBaseCoordSystem, uDataTypes, uClassData, uRecordData,
  ufrmSituationBoard, ufrmDisplayArea;

type
  TT3ClientEventManager = class(TT3EventManager)
  private

  public

    procedure OnUpdateUserStateChange(state : Integer); override;
    procedure OnUpdateSituationBoardTabPropertiesChange; override;
    procedure OnUpdateUserRoleChatChange(id : integer); override;

  end;

implementation

uses
  ufrmTacticalDisplay ;

{ TT3ClientEventManager }

procedure TT3ClientEventManager.OnUpdateSituationBoardTabPropertiesChange;
begin
  inherited;

  frmSituationBoard.UpdateTab;
  frmSituationBoard.RefreshTab;

end;

procedure TT3ClientEventManager.OnUpdateUserRoleChatChange(id : integer);
begin
  inherited;
  frmDisplayArea.UpdateClientHistoryChat(id, 1);
  frmDisplayArea.UpdateClientChatting;

end;

procedure TT3ClientEventManager.OnUpdateUserStateChange(state: Integer);
begin
  inherited;

  case state of
    CORD_ID_LOGIN  : frmTacticalDisplay.UpdateClientLogin(nil);
    CORD_ID_LOGOUT : frmTacticalDisplay.UpdateClientLogout(nil);
  end;
end;
end.
