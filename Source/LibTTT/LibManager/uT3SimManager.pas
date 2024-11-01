﻿unit uT3SimManager;

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
  Point1 : TDotShape;
  TextShape : TTextShape;
  LineShape : TLineShape;
  RectangleShape : TRectangleShape;
  CircleShape : TCircleShape;
  EllipseShape : TEllipseShape;
  ArcShape : TArcShape;
  SectorShape : TSectorShape;
  GridShape : TGridShape;
  PolygonShape : TPolygonShape;
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
            TextShape.ShapeOutline := rec.color;
            TextShape.isSelected := False;

            if rec.IdAction = caAdd then
              overlayTabTemp.MemberList.Add(TextShape);
            {$ENDREGION}
          end;
          ovLine :
          begin
            {$Region' Line '}
            if rec.IdAction = caAdd then
            begin
              LineShape := TLineShape.Create(Converter);
              LineShape.ShapeId := GetSerialShapeID
            end
            else
              LineShape := overlayTabTemp.GetShapeById(rec.IdSelectShape) as TLineShape;

            LineShape.postStart := rec.PostStart;
            LineShape.postEnd := rec.PostEnd;
            LineShape.ShapeOutline := rec.color;
            LineShape.ShapeFill := rec.ColorFill;
            LineShape.LineType := rec.lineType;
            LineShape.LineWeight := rec.weight;
            LineShape.BrushStyle := rec.BrushStyle;
            LineShape.isSelected := False;

            if rec.IdAction = caAdd then
              overlayTabTemp.MemberList.Add(LineShape);
            {$ENDREGION}
          end;
          ovRectangle :
          begin
            {$Region' Rectangle '}
            if rec.IdAction = caAdd then
            begin
              RectangleShape := TRectangleShape.Create(Converter);
              RectangleShape.ShapeId := GetSerialShapeID
            end
            else
              RectangleShape := overlayTabTemp.GetShapeById(rec.IdSelectShape) as TRectangleShape;

            RectangleShape.postStart := rec.PostStart;
            RectangleShape.postEnd := rec.PostEnd;
            RectangleShape.ShapeOutline := rec.color;
            RectangleShape.ShapeFill := rec.ColorFill;
            RectangleShape.LineType := rec.lineType;
            RectangleShape.LineWeight := rec.weight;
            RectangleShape.BrushStyle := rec.BrushStyle;
            RectangleShape.isSelected := False;

            if rec.IdAction = caAdd then
              overlayTabTemp.MemberList.Add(RectangleShape);
            {$ENDREGION}
          end;
          ovCircle :
          begin
            {$Region' Circle '}
            if rec.IdAction = caAdd then
            begin
              CircleShape := TCircleShape.Create(Converter);
              CircleShape.ShapeId := GetSerialShapeID
            end
            else
              CircleShape := overlayTabTemp.GetShapeById(rec.IdSelectShape) as TCircleShape;

            CircleShape.postCenter := rec.PostStart;
            CircleShape.radius := rec.Radius1;
            CircleShape.ShapeOutline := rec.color;
            CircleShape.ShapeFill := rec.ColorFill;
            CircleShape.LineType := rec.lineType;
            CircleShape.LineWeight := rec.weight;
            CircleShape.BrushStyle := rec.BrushStyle;
            CircleShape.isSelected := False;

            if rec.IdAction = caAdd then
             overlayTabTemp.MemberList.Add(CircleShape);
            {$ENDREGION}
          end;
          ovEllipse :
          begin
            {$Region' Ellipse '}
            if rec.IdAction = caAdd then
            begin
              EllipseShape := TEllipseShape.Create(Converter);
              EllipseShape.ShapeId := GetSerialShapeID
            end
            else
             EllipseShape := overlayTabTemp.GetShapeById(rec.IdSelectShape) as TEllipseShape;

            EllipseShape.postCenter := rec.PostStart;
            EllipseShape.Hradius := rec.Radius1;
            EllipseShape.Vradius := rec.Radius2;
            EllipseShape.ShapeOutline := rec.color;
            EllipseShape.ShapeFill := rec.ColorFill;
            EllipseShape.LineType := rec.lineType;
            EllipseShape.LineWeight := rec.weight;
            EllipseShape.BrushStyle := rec.BrushStyle;
            EllipseShape.isSelected := False;

            if rec.IdAction = caAdd then
              overlayTabTemp.MemberList.Add(EllipseShape);
            {$ENDREGION}
          end;
          ovArc :
          begin
            {$Region' Arc '}
            if rec.IdAction = caAdd then
            begin
              ArcShape := TArcShape.Create(Converter);
              ArcShape.ShapeId := GetSerialShapeID
            end
            else
              ArcShape := overlayTabTemp.GetShapeById(rec.IdSelectShape) as TArcShape;

            ArcShape.postCenter := rec.PostStart;
            ArcShape.radius := rec.Radius1;
            ArcShape.StartAngle := rec.StartAngle;
            ArcShape.EndAngle := rec.EndAngle;
            ArcShape.ShapeOutline := rec.color;
            ArcShape.LineType := rec.lineType;
            ArcShape.LineWeight := rec.weight;
            ArcShape.BrushStyle := rec.BrushStyle;
            ArcShape.isSelected := False;

            if rec.IdAction = caAdd then
              overlayTabTemp.MemberList.Add(ArcShape);
            {$ENDREGION}
          end;
          ovSector :
          begin
            {$Region' Sector '}
            if rec.IdAction = caAdd then
            begin
              SectorShape := TSectorShape.Create(Converter);
              SectorShape.ShapeId := GetSerialShapeID
            end
            else
              SectorShape := overlayTabTemp.GetShapeById(rec.IdSelectShape) as TSectorShape;

            SectorShape.postCenter := rec.PostStart;
            SectorShape.Oradius := rec.Radius1;
            SectorShape.Iradius := rec.Radius2;
            SectorShape.StartAngle := rec.StartAngle;
            SectorShape.EndAngle := rec.EndAngle;
            SectorShape.ShapeOutline := rec.color;
            SectorShape.LineType := rec.lineType;
            SectorShape.LineWeight := rec.weight;
            SectorShape.BrushStyle := rec.BrushStyle;
            SectorShape.isSelected := False;

            if rec.IdAction = caAdd then
              overlayTabTemp.MemberList.Add(SectorShape);
            {$ENDREGION}
          end;
          ovGrid :
          begin
            {$Region' Grid '}
            if rec.IdAction = caAdd then
            begin
              GridShape := TGridShape.Create(Converter);
              GridShape.ShapeId := GetSerialShapeID
            end
            else
              GridShape := overlayTabTemp.GetShapeById(rec.IdSelectShape) as TGridShape;

            GridShape.postCenter := rec.PostStart;
            GridShape.Height := rec.Radius1;
            GridShape.Width := rec.Radius2;
            GridShape.HCount := rec.Kolom;
            GridShape.WCount := rec.Baris;
            GridShape.Rotation := rec.Rotasi;
            GridShape.ShapeOutline := rec.color;
            GridShape.ShapeFill := rec.ColorFill;
            GridShape.LineType := rec.lineType;
            GridShape.LineWeight := rec.weight;
            GridShape.BrushStyle := rec.BrushStyle;
            GridShape.isSelected := False;

            if rec.IdAction = caAdd then
              overlayTabTemp.MemberList.Add(GridShape);
            {$ENDREGION}
          end;
          ovPolygon  :
          begin
            {$Region' Polygon '}
            case rec.IdAction of
              caAdd :
              begin
                PolygonShape := TPolygonShape.Create(Converter);
                PolygonShape.ShapeId := GetSerialShapeID
              end;
              caEdit :
              begin
                PolygonShape := overlayTabTemp.GetShapeById(rec.IdSelectShape) as TPolygonShape;
                PolygonShape.polyList.Clear;
              end;
            end;

            PolygonShape.ShapeOutline := rec.color;
            PolygonShape.ShapeFill := rec.ColorFill;
            PolygonShape.LineType := rec.lineType;
            PolygonShape.LineWeight := rec.weight;
            PolygonShape.BrushStyle := rec.BrushStyle;
            PolygonShape.isSelected := False;

            for i := 0 to 12 do
            begin
              if (rec.polyPoint[i].X = 0) and (rec.polyPoint[i].Y = 0) then
                Continue;

              Point1 := TDotShape.Create;
              Point1.X := rec.polyPoint[i].X;
              Point1.Y := rec.polyPoint[i].Y;
              PolygonShape.polyList.Add(Point1);
            end;

            if rec.IdAction = caAdd then
              overlayTabTemp.MemberList.Add(PolygonShape);
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
