unit uT3SimManager;

interface

uses
  Classes, SysUtils, System.Win.Registry, System.Variants, Graphics, WbemScripting_TLB, Dialogs,
  Windows, forms, StrUtils, Math, DateUtils,

  MapXLib_TLB, uThreadTimer,  uVirtualTime, uLibSetting, uSimManager , uSimObjects, uT3UnitContainer,
  uT3EventManager, uT3Listener, uSteppers, uNetBaseSocket, uConsoleData, uClassData, uRecordData,
  uCoordConvertor, uConstantaData;

type

  TT3SimManager = class(TSimManager)
  protected

    FShapeID  : Integer;
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
    FConverter : TCoordConverter;

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
    procedure OnUserRoleChatChange(const rec : TRecTCPSendChatUserRole); virtual;
    procedure OnOverlayShape(const rec : TRecTCPSendOverlayShape); virtual;
    {$ENDREGION}

    function GetSerialTabSituationBoardID : Integer;
    function GetSerialShapeID : Integer;

    procedure GameStart; override;
    procedure GamePause; override;
    procedure GameTerminate; override;

    procedure InitNetwork; virtual;
    procedure StopNetwork;  virtual;

    property SessionID: integer read FSessionID write setSessionID;

    property Converter : TCoordConverter read FConverter;

end;

var
  SimManager: TT3SimManager;

implementation

{ TT3SimManager }

constructor TT3SimManager.Create(Map : TMap);
begin
  inherited Create;

  CreateMapConverter(Map);

  FShapeID := 0;
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
  FConverter      := TCoordConverter.Create;
  FConverter.FMap := Map;
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

procedure TT3SimManager.OnOverlayShape(const rec: TRecTCPSendOverlayShape);
var
  i, j : Integer;
//  Point1 : TDotStatic;
  TextShape : TTextShape;
//  LineShape : TLineStatic;
//  RectangleShape : TRectangleStatic;
//  CircleShape : TCircleStatic;
//  EllipseShape : TEllipseStatic;
//  ArcShape : TArcStatic;
//  SectorShape : TSectorStatic;
//  GridShape : TGridStatic;
//  PolygonShape : TPolygonStatic;
  overlayTabTemp : TOverlayTab;

begin
  overlayTabTemp := SimOverlay.GetOverlayTabByID(rec.TemplateId);

  if Assigned(overlayTabTemp) then
  begin
    case rec.IdAction of
      caAdd, caEdit :
      begin
        case rec.ShapeType of
          ovText :
          begin
            {$Region' Text '}
            if rec.IdAction = caAdd then
            begin
              TextShape := TTextShape.Create(Converter);
              TextShape.ShapeId := GetSerialShapeID
            end
            else
              TextShape := overlayTabTemp.GetShapeById(rec.IdSelectShape) as TTextShape;

            TextShape.postStart := rec.PostStart;
            TextShape.size := rec.Size;
            TextShape.words := rec.Words;
            TextShape.Color := rec.color;
            TextShape.isSelected := False;

            if rec.IdAction = caAdd then
              overlayTabTemp.MemberList.Add(TextShape);
            {$ENDREGION}
          end;
          ovLine :
          begin
            {$Region' Line '}
//            if rec.IdAction = caAdd then
//              LineShape := TLineStatic.Create(Converter)
//            else
//              LineShape := OverlayTemplate.StaticList.Items[rec.IdSelectShape];
//
//            LineShape.postStart := rec.PostStart;
//            LineShape.postEnd := rec.PostEnd;
//            LineShape.color := rec.color;
//            LineShape.ColorFill := rec.ColorFill;
//            LineShape.LineType := rec.lineType;
//            LineShape.Weight := rec.weight;
//            LineShape.BrushStyle := rec.BrushStyle;
//            LineShape.isSelected := False;
//
//            if rec.IdAction = caAdd then
//              OverlayTemplate.StaticList.Add(LineShape);
            {$ENDREGION}
          end;
          ovRectangle :
          begin
            {$Region' Rectangle '}
//            if rec.IdAction = caAdd then
//              RectangleShape := TRectangleStatic.Create(Converter)
//            else
//              RectangleShape := OverlayTemplate.StaticList.Items[rec.IdSelectShape];
//
//            RectangleShape.postStart := rec.PostStart;
//            RectangleShape.postEnd := rec.PostEnd;
//            RectangleShape.color := rec.color;
//            RectangleShape.ColorFill := rec.ColorFill;
//            RectangleShape.LineType := rec.lineType;
//            RectangleShape.Weight := rec.weight;
//            RectangleShape.BrushStyle := rec.BrushStyle;
//
//            RectangleShape.isSelected := False;
//
//            if rec.IdAction = caAdd then
//              OverlayTemplate.StaticList.Add(RectangleShape);
            {$ENDREGION}
          end;
          ovCircle :
          begin
            {$Region' Circle '}
//            if rec.IdAction = caAdd then
//              CircleShape := TCircleStatic.Create(Converter)
//            else
//              CircleShape := OverlayTemplate.StaticList.Items[rec.IdSelectShape];
//
//            CircleShape.postCenter := rec.PostStart;
//            CircleShape.radius := rec.Radius1;
//            CircleShape.Color := rec.color;
//            CircleShape.ColorFill := rec.ColorFill;
//            CircleShape.LineType := rec.lineType;
//            CircleShape.Weight := rec.weight;
//            CircleShape.BrushStyle := rec.BrushStyle;
//            CircleShape.isSelected := False;
//
//            if rec.IdAction = caAdd then
//              OverlayTemplate.StaticList.Add(CircleShape);
            {$ENDREGION}
          end;
          ovEllipse :
          begin
            {$Region' Ellipse '}
//            if rec.IdAction = caAdd then
//              EllipseShape := TEllipseStatic.Create(Converter)
//            else
//              EllipseShape := OverlayTemplate.StaticList.Items[rec.IdSelectShape];
//
//            EllipseShape.postCenter := rec.PostStart;
//            EllipseShape.Hradius := rec.Radius1;
//            EllipseShape.Vradius := rec.Radius2;
//            EllipseShape.Color := rec.color;
//            EllipseShape.ColorFill := rec.ColorFill;
//            EllipseShape.LineType := rec.lineType;
//            EllipseShape.Weight := rec.weight;
//            EllipseShape.BrushStyle := rec.BrushStyle;
//            EllipseShape.isSelected := False;
//
//            if rec.IdAction = caAdd then
//              OverlayTemplate.StaticList.Add(EllipseShape);
            {$ENDREGION}
          end;
          ovArc :
          begin
            {$Region' Arc '}
//            if rec.IdAction = caAdd then
//              ArcShape := TArcStatic.Create(Converter)
//            else
//              ArcShape := OverlayTemplate.StaticList.Items[rec.IdSelectShape];
//
//            ArcShape.postCenter := rec.PostStart;
//            ArcShape.radius := rec.Radius1;
//            ArcShape.StartAngle := rec.StartAngle;
//            ArcShape.EndAngle := rec.EndAngle;
//            ArcShape.Color := rec.color;
//            ArcShape.LineType := rec.lineType;
//            ArcShape.Weight := rec.weight;
//            ArcShape.BrushStyle := rec.BrushStyle;
//            ArcShape.isSelected := False;
//
//            if rec.IdAction = caAdd then
//              OverlayTemplate.StaticList.Add(ArcShape);
            {$ENDREGION}
          end;
          ovSector :
          begin
            {$Region' Sector '}
//            if rec.IdAction = caAdd then
//              SectorShape := TSectorStatic.Create(Converter)
//            else
//              SectorShape := OverlayTemplate.StaticList.Items[rec.IdSelectShape];
//
//            SectorShape.postCenter := rec.PostStart;
//            SectorShape.Oradius := rec.Radius1;
//            SectorShape.Iradius := rec.Radius2;
//            SectorShape.StartAngle := rec.StartAngle;
//            SectorShape.EndAngle := rec.EndAngle;
//            SectorShape.Color := rec.color;
//            SectorShape.LineType := rec.lineType;
//            SectorShape.Weight := rec.weight;
//            SectorShape.BrushStyle := rec.BrushStyle;
//            SectorShape.isSelected := False;
//
//            if rec.IdAction = caAdd then
//              OverlayTemplate.StaticList.Add(SectorShape);
            {$ENDREGION}
          end;
          ovGrid :
          begin
            {$Region' Sector '}
//            if rec.IdAction = caAdd then
//              GridShape := TGridStatic.Create(Converter)
//            else
//              GridShape := OverlayTemplate.StaticList.Items[rec.IdSelectShape];
//
//            GridShape.postCenter := rec.PostStart;
//            GridShape.Height := rec.Radius1;
//            GridShape.Width := rec.Radius2;
//            GridShape.HCount := rec.Kolom;
//            GridShape.WCount := rec.Baris;
//            GridShape.Rotation := rec.Rotasi;
//            GridShape.Color := rec.color;
//            GridShape.ColorFill := rec.ColorFill;
//            GridShape.LineType := rec.lineType;
//            GridShape.Weight := rec.weight;
//            GridShape.BrushStyle := rec.BrushStyle;
//            GridShape.isSelected := False;
//
//            if rec.IdAction = caAdd then
//              OverlayTemplate.StaticList.Add(GridShape);
            {$ENDREGION}
          end;
          ovPolygon  :
          begin
            {$Region' Polygon '}
//            case rec.IdAction of
//              caAdd :
//              begin
//                PolygonShape := TPolygonStatic.Create(Converter);
//              end;
//              caEdit :
//              begin
//                PolygonShape := OverlayTemplate.StaticList.Items[rec.IdSelectShape];
//                PolygonShape.polyList.Clear;
//              end;
//            end;
//
//            PolygonShape.Color := rec.color;
//            PolygonShape.ColorFill := rec.ColorFill;
//            PolygonShape.LineType := rec.lineType;
//            PolygonShape.Weight := rec.weight;
//            PolygonShape.BrushStyle := rec.BrushStyle;
//            PolygonShape.isSelected := False;
//
//            for i := 0 to 12 do
//            begin
//              if (rec.polyPoint[i].X = 0) and (rec.polyPoint[i].Y = 0) then
//                Continue;
//
//              Point1 := TDotStatic.Create;
//              Point1.X := rec.polyPoint[i].X;
//              Point1.Y := rec.polyPoint[i].Y;
//              PolygonShape.polyList.Add(Point1);
//            end;
//
//            if rec.IdAction = caAdd then
//              OverlayTemplate.StaticList.Add(PolygonShape);
            {$ENDREGION}
          end;
        end;
      end;
      caDelete :
      begin
        overlayTabTemp.MemberList.Delete(rec.IdSelectShape);
      end;
    end;
  end;
end;

procedure TT3SimManager.OnSituationBoardTabPropertiesChange(const rec: TRecTCPSendSituationBoardTabProperties);
var
  IdTemp : Integer;
  tabPropertiesTemp : TTabProperties;
  tabOverlayTemp : TOverlayTab;

begin

  case rec.OrderID of
    NEW_TAB :
    begin
      IdTemp := GetSerialTabSituationBoardID;

      tabPropertiesTemp := TTabProperties.Create;
      tabPropertiesTemp.IdTab := rec.TabId;
      tabPropertiesTemp.IdUserRoleTab := rec.UserRoleId;
      tabPropertiesTemp.IdOverlayTab := IdTemp;
      tabPropertiesTemp.CaptionTab := rec.TabCaption;
      tabPropertiesTemp.TypeTab := rec.TabType;
      tabPropertiesTemp.ActiveTab := True;
      tabPropertiesTemp.AddressTab := rec.TabAddres;

      SimTabProperties.TabList.Add(tabPropertiesTemp);

      tabOverlayTemp := TOverlayTab.Create;
      tabOverlayTemp.IdOverlayTab := IdTemp;
      tabOverlayTemp.IdUserRole := rec.UserRoleId;

      SimOverlay.TabList.Add(tabOverlayTemp);
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

procedure TT3SimManager.OnUserRoleChatChange(const rec: TRecTCPSendChatUserRole);
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

function TT3SimManager.GetSerialShapeID: Integer;
begin
  Result := FShapeID;
  Inc(FShapeID);
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
