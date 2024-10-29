unit uT3SimManager;

interface

uses
  Classes, SysUtils, System.Win.Registry, System.Variants, Graphics, WbemScripting_TLB, Dialogs,
  Windows, forms, StrUtils, Math, DateUtils,

  MapXLib_TLB, uThreadTimer,  uVirtualTime, uLibSetting, uSimManager , uSimObjects, uT3UnitContainer,
  uT3EventManager, uT3Listener, uSteppers, uNetBaseSocket, uConsoleData, uClassData, uRecordData,
  uCoordConvertor;

type

  TT3SimManager = class(TSimManager)
  protected

    FTabSituationBoardID  : Integer;

    procedure FGameThread_OnTerminate(sender: TObject);
    procedure FGameThread_OnRunning(const dt: double); virtual;
    procedure FGameThread_OnPaused(const dt: double); virtual;

    procedure FNetworkThread_OnRunning(const dt: double);virtual;
    procedure FNetworkThread_OnPaused(const dt: double); virtual;
    procedure FNetworkThread_OnTerminate(sender: TObject);

    procedure CreateMapConverter(Map : TMap);

  private

    FReg       : TRegistry;
//    FConverter : TCoordConverter;

  protected
    FSessionID : integer;

    procedure setSessionID(const Value: integer);

    { use by goto time }
    procedure Run(const dt : Double);virtual;

  public

    SimConsole : TConsoleContainer;
    SimUserRole : TUserRoleContainer;
    SimTabProperties : TTabPropertiesContainer;
    SimChatting : TChattingContainer;
    SimOverlay : TOverlayTabContainer;

    EventManager    : TT3EventManager;

    constructor Create(Map : TMap);
    destructor Destroy; override;

    {$REGION ' Event Inherited '}
    function GetGameState: Boolean; virtual;

    procedure LoadConsoleID; virtual;
    procedure LoadDataAsset(const vSet: TGameDataSetting); virtual;

    procedure OnUserStateChange(const rec : TRecTCP_UserState); virtual;
    procedure OnSituationBoardTabPropertiesChange(const rec : TRecTCPSendSituationBoardTabProperties); virtual;
    procedure OnUserRoleChatChange(const rec : TrecTCPSendChatUserRole); virtual;
    {$ENDREGION}

    function GetSerialTabSituationBoardID : Integer;

    procedure GameStart; override;
    procedure GamePause; override;
    procedure GameTerminate; override;

    procedure InitNetwork; virtual;
    procedure StopNetwork;  virtual;

    property SessionID: integer read FSessionID write setSessionID;

//    property Converter : TCoordConverter read FConverter;

end;

var
  SimManager: TT3SimManager;

implementation

{ TT3SimManager }

constructor TT3SimManager.Create(Map : TMap);
begin
  inherited Create;

  CreateMapConverter(Map);

  FTabSituationBoardID := 0;

  FGameThread.Interval := 10;
  FGameThread.OnRunning   := FGameThread_OnRunning;
  FGameThread.OnTerminate := FGameThread_OnTerminate;
  FGameThread.Enabled := True;

  FNetworkThread.OnRunning := FNetworkThread_OnRunning;
  FNetworkThread.OnTerminate := FNetworkThread_OnTerminate;
  FNetworkThread.Enabled := True;

  SimConsole := TConsoleContainer.Create;
  SimUserRole := TUserRoleContainer.Create;
  SimTabProperties := TTabPropertiesContainer.Create;

  SimOverlay := TOverlayTabContainer.Create;
//  SimOverlay.Converter := Converter;
end;

procedure TT3SimManager.CreateMapConverter(Map: TMap);
begin

end;

destructor TT3SimManager.Destroy;
begin

  SimConsole.Free;
  SimUserRole.Free;
  SimTabProperties.Free;

  inherited;
end;


procedure TT3SimManager.FGameThread_OnTerminate(sender: TObject);
begin

end;

procedure TT3SimManager.FGameThread_OnPaused(const dt: double);
begin

end;

procedure TT3SimManager.FGameThread_OnRunning(const dt: double);
begin
  if SimManager.GetGameState then
    FMainVTime.IncreaseMillisecond(dt * 1000.0 );
end;


procedure TT3SimManager.GameStart;
begin
//  inherited;
  if FGameState = gsStop then
  begin
    FGameThread.OnRunning := FGameThread_OnRunning;
    FGameState := gsPlaying;
  end;
end;

procedure TT3SimManager.GamePause;
begin
  if FGameState = gsPlaying then
  begin

    FGameThread.OnRunning := FGameThread_OnPaused;
    // thread do nothing. :P
    FGameState := gsStop;
  end;
end;

procedure TT3SimManager.GameTerminate;
begin
  FGameState := gsTerminated;
  FGameThread.Terminate;
end;

procedure TT3SimManager.Run(const dt: Double);
begin
  FMainVTime.IncreaseMillisecond(dt * 1000.0 );
end;

procedure TT3SimManager.setSessionID(const Value: integer);
begin
  FSessionID := Value;
end;

procedure TT3SimManager.LoadConsoleID;
begin
  SimConsole.LoadFromFile(vGameDataSetting.GroupSetting);
end;

procedure TT3SimManager.LoadDataAsset(const vSet: TGameDataSetting);
begin

  FMainVTime.Reset(0);
  FMainVTime.DateTimeOffset := 0;
end;

procedure TT3SimManager.OnSituationBoardTabPropertiesChange(const rec: TRecTCPSendSituationBoardTabProperties);
var
  tabPropertiesTemp : TTabProperties;
begin

  case rec.OrderID of
    NEW_TAB :
    begin
      tabPropertiesTemp := TTabProperties.Create;
      tabPropertiesTemp.IdTab := rec.TabId;
      tabPropertiesTemp.IdUserRoleTab := rec.UserRoleId;
      tabPropertiesTemp.IdOverlayTab := GetSerialTabSituationBoardID;
      tabPropertiesTemp.CaptionTab := rec.TabCaption;
      tabPropertiesTemp.TypeTab := rec.TabType;
      tabPropertiesTemp.ActiveTab := True;
      tabPropertiesTemp.AddressTab := rec.TabAddres;

      SimTabProperties.TabList.Add(tabPropertiesTemp);
    end;
    EDIT_TAB :
    begin
      tabPropertiesTemp := SimTabProperties.GetTapProperties(rec.UserRoleId, rec.TabId);

      if Assigned(tabPropertiesTemp) then
      begin
        tabPropertiesTemp.AddressTab := rec.TabAddres;
      end;
    end;
  end;
end;

procedure TT3SimManager.OnUserRoleChatChange(const rec: TrecTCPSendChatUserRole);
var
chatTemp : Tchatting;
begin
  case rec.OrderID of
    SEND_CHAT :
    begin
      chatTemp.IdUserRoleSending := rec.SenderUserRoleId;
      chatTemp.IdUserRoleReceive := rec.ReceiverUserRoleId;
      chatTemp.ChatMessage := rec.ChatMessage;

      SimChatting.ChattingList.Add(chatTemp);
    end;
  end;

end;

procedure TT3SimManager.OnUserStateChange(const rec: TRecTCP_UserState);
var
  userRoleTemp : TUser_Role;

begin

  {$REGION ' Merubah data yang ada di list user role '}
  userRoleTemp := SimUserRole.getUserRoleByID(rec.UserRoleId);

  if Assigned(userRoleTemp) then
  begin
    case rec.OrderID of
      CORD_ID_LOGIN :
      begin
        userRoleTemp.isInUse := True;
        userRoleTemp.ConsoleIP := rec.ConsoleIP;
      end;
      CORD_ID_LOGOUT :
      begin
        userRoleTemp.isInUse := False;
        userRoleTemp.ConsoleIP := '';
      end;
    end;
  end;
  {$ENDREGION}

end;

procedure TT3SimManager.InitNetwork;
begin
  // some of register packet
end;


function TT3SimManager.GetGameState: Boolean;
begin
  if FGameState = gsPlaying then
    Result := True
  else
    Result := False;
end;

function TT3SimManager.GetSerialTabSituationBoardID: Integer;
begin
  Result := FTabSituationBoardID;
  Inc(FTabSituationBoardID);
end;

procedure TT3SimManager.StopNetwork;
begin
 // unregister all packet
end;

procedure TT3SimManager.FNetworkThread_OnPaused(const dt: double);
begin
//x
end;

procedure TT3SimManager.FNetworkThread_OnRunning(const dt: double);
begin
//x
end;

procedure TT3SimManager.FNetworkThread_OnTerminate(sender: TObject);
begin
//x
end;

end.
