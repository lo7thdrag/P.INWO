unit uClassData;

interface

uses
  System.Classes, MapXLib_TLB, Winapi.Windows, Vcl.Graphics,
  uRecordData, uConstantaData, uCoordConvertor, uDataTypes, uFormula, uBaseCoordSystem;

type

  TUser_Role = class
  private
    FConsoleIP : string;
    FisInUse : Boolean;

  public
    FData  : TRecUser_Role;

    constructor Create;
    destructor Destroy;override;

    property ConsoleIP: string read FConsoleIP write FConsoleIP;
    property isInUse: Boolean read FisInUse write FisInUse;
  end;

  TUserRoleContainer = class
  private
    FUserList : TList;

  public
    constructor Create;
    destructor  Destroy; override;

    function  getUserRoleByUsernamePassword(username, password : string): TUser_Role;
    function  getUserRoleByID(Id : Integer): TUser_Role;
    function  getUserRoleByIPAddress(IpAddress : string): TUser_Role;

    procedure addUserRole(Val : TUser_Role);
    procedure deleteUserRole(Val : TUser_Role);

    property UserList : TList read FUserList write FUserList;
  end;

  TConsoleData = class
  private
    FIdentifier : string;
    FIpAdrres : string;
    FGroup : TConsoleGroup;
    FUserRoleData : TRecUser_Role;
//    FTacticalSymbol : TRecTactical_Symbol;
    FTipeTahapan : Byte;

  public
    constructor Create;
    destructor  Destroy; override;

    procedure assignUserRoleData(Val : TRecUser_Role);
    procedure UnassignUserRoleData(Val : TRecUser_Role);

    property Identifier : string read FIdentifier write FIdentifier;
    property IpAdrres : string read FIpAdrres write FIpAdrres;
    property Group : TConsoleGroup read FGroup write FGroup;
    property UserRoleData : TRecUser_Role read FUserRoleData write FUserRoleData;
//    property TacticalSymbolData : TRecTactical_Symbol read FTacticalSymbol write FTacticalSymbol;
    property TipeTahapan : byte read FTipeTahapan write FTipeTahapan;
  end;

  TFile_Data = class
  private

  public
    FData  : TRecFile_Data;

    constructor Create;
    destructor  Destroy; override;
  end;

  TTabProperties = class

  private
    FIdTab : Integer;
    FIdUserRoleTab : Integer;
    FIdOverlayTab : Integer;
    FCaptionTab : string;
    FActiveTab : Boolean;
    FTypeTab : Byte;
    FAddressTab : string;

  public
    constructor Create;
    destructor Destroy;override;

    property IdTab: Integer read FIdTab write FIdTab;
    property IdUserRoleTab: Integer read FIdUserRoleTab write FIdUserRoleTab;
    property IdOverlayTab: Integer read FIdOverlayTab write FIdOverlayTab;
    property CaptionTab: string read FCaptionTab write FCaptionTab;
    property ActiveTab: Boolean read FActiveTab write FActiveTab;
    property TypeTab: Byte read FTypeTab write FTypeTab;
    property AddressTab: string read FAddressTab write FAddressTab;

  end;

  TTabPropertiesContainer = class
  private
    FTabList : TList;

  public
    constructor Create;
    destructor  Destroy; override;

    function GetCountActiveTab(IdRole : Integer): Integer;
    function GetActiveTab(IdRole, IdTag : Integer): Boolean;
    function GetCaptionTab(IdRole, IdTag : Integer): string;
    function GetTapProperties(IdRole, IdTag : Integer): TTabProperties;

    property TabList : TList read FTabList write FTabList;
  end;

  TChatting = class

  private
    FIdChat : Integer;
    FIdUserRoleSending : Integer;
    FIdUserRoleReceive : Integer;
    FChatMessage : string;

  public
    constructor Create;
    destructor Destroy;override;

    property IdChat: Integer read FIdChat write FIdChat;
    property IdUserRoleSending: Integer read FIdUserRoleSending write FIdUserRoleSending;
    property IdUserRoleReceive: Integer read FIdUserRoleReceive write FIdUserRoleReceive;
    property ChatMessage: string read FChatMessage write FChatMessage;

  end;

  TChattingContainer = class
  private
    FChattingList : TList;

  public
    constructor Create;
    destructor  Destroy; override;

    function GetChattingBySending(IdRoleReceiving, IdRoleSending : Integer; var chatList : TList): Boolean;

    property ChattingList : TList read FChattingList write FChattingList;
  end;

  TGame_Area_Definition = class
  private

  public
    FData : TRecGame_Area_Definition;

    constructor Create;
    destructor Destroy;override;
  end;

  TTactical_Symbol = class
  private
   FImagePath: string;

  public
    FData  : TRecTactical_Symbol;
    property ImagePath: string read FImagePath write FImagePath;

    constructor Create;
    destructor Destroy;override;
  end;

  TMainShape = class
  private
    FShapeId : Integer;
    FColor: Integer;
    FSelected: Boolean;
    FConverter: TCoordConverter;
    FColorFill: Integer;
    FLineType: TPenStyle;
    FWeight: Integer;
    FBrushStyle: TBrushStyle;

  public

    constructor Create(cvt : TCoordConverter); virtual;
    destructor Destroy; virtual;

    procedure Clear;
    procedure Draw(aCnv: TCanvas); virtual;

    property ShapeId : Integer read FShapeId write FShapeId;
    property Color : Integer read FColor write FColor;
    property isSelected : Boolean read FSelected write FSelected;
    property Converter : TCoordConverter read FConverter write FConverter;
    property ColorFill : Integer read FColorFill write FColorFill;
    property LineType : TPenStyle read FLineType write FLineType;
    property Weight : Integer read FWeight write FWeight;
    property BrushStyle : TBrushStyle read FBrushStyle write FBrushStyle;

  end;

  TTextShape = class(TMainShape)
  public
    postStart : t2DPoint;
    size : Integer;
    words : String;

    procedure Draw(aCnv: TCanvas); override;

    constructor Create(cvt : TCoordConverter); override;
    destructor Destroy; override;
  end;

  TLineShape = class(TMainShape)
  public
    postStart : t2DPoint;
    postEnd : t2DPoint;

    procedure Draw(aCnv: TCanvas); override;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;
  end;

  TRectangleShape = class(TMainShape)
  public
    postStart : t2DPoint;
    postEnd : t2DPoint;

    procedure Draw(aCnv: TCanvas); override;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;
  end;

  TCircleShape = class(TMainShape)
  public
    postCenter : t2DPoint;
    radius : Double;

    procedure Draw(aCnv: TCanvas); override;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;
  end;

  TEllipseShape = class(TMainShape)
  public
    postCenter : t2DPoint;
    Hradius, Vradius : Double;

    procedure Draw(aCnv: TCanvas); override;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;
  end;

  TArcShape = class(TMainShape)
  public
    postCenter : t2DPoint;
    radius : Double;
    StartAngle, EndAngle : Integer;

    procedure Draw(aCnv: TCanvas); override;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;
  end;

  TSectorShape = class(TMainShape)
  public
    postCenter : t2DPoint;
    Oradius, Iradius : Double;
    StartAngle, EndAngle : Integer;

    procedure Draw(aCnv: TCanvas); override;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;
  end;

  TGridShape = class(TMainShape)
  public
    postCenter : t2DPoint;
    HCount, WCount, Rotation : Integer;
    Height, Width : Double;

    procedure Draw(aCnv: TCanvas); override;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;
  end;

  TPolygonShape = class(TMainShape)
  public
    polyPoint : Array of TPoint;
    polyList : TList;

    procedure Draw(aCnv: TCanvas); override;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;
  end;

  TOverlayTab = class
  private
    FIdOverlayTab : Integer;
    FIdUserRole : Integer;
    FRoleName : string;
    FMemberList : TList;

  public
    Formula : TFormula;
    constructor create;
    destructor Destroy; override;

    procedure Draw(FCanvas: TCanvas); virtual;

    function GetShapeById(IdShape : Integer): TMainShape;

    property IdOverlayTab : Integer read FIdOverlayTab write FIdOverlayTab;
    property IdUserRole : Integer read FIdUserRole write FIdUserRole;
    property RoleName : string read FRoleName write FRoleName;
    property MemberList : TList read FMemberList write FMemberList;
  end;

  TOverlayTabContainer = class
  private
    FTabList : TList;

  public

    constructor Create;
    destructor Destroy; override;

    function GetOverlayTabByID(IdOverlay: Integer): TOverlayTab;

    procedure Draw(FCanvas: TCanvas; Map1: TMap; IdOverlayTab : Integer);

    procedure AddOverlayTab(OvelayTab : TOverlayTab);
    procedure RemoveOverlayTab(OvelayTab : TOverlayTab);

    property TabList : TList read FTabList write FTabList;

  end;

  TDotShape = class
  public
    X, Y : Double;
    constructor Create;
    destructor Destroy; override;
  end;

  TFlagPoint = class
  private
    FConverter: TCoordConverter;
    procedure SetConverter(const Value: TCoordConverter);

  public
    Post : t2DPoint;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy;
    procedure Draw(aCnv : TCanvas);

    property Converter : TCoordConverter read FConverter write SetConverter;
  end;



implementation

{$REGION ' TUser_Role '}

constructor TUser_Role.Create;
begin
  FisInUse := False;
  FConsoleIP := '';
end;

destructor TUser_Role.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TUserRoleContainer '}

procedure TUserRoleContainer.addUserRole(Val: TUser_Role);
begin
  FUserList.Add(Val);
end;

constructor TUserRoleContainer.Create;
begin
  FUserList := TList.Create;
end;

procedure TUserRoleContainer.deleteUserRole(Val: TUser_Role);
begin
  FUserList.Remove(Val);
end;

destructor TUserRoleContainer.Destroy;
begin
  FUserList.Free;
  inherited;
end;

function TUserRoleContainer.getUserRoleByID(Id: Integer): TUser_Role;
var
  i : Integer;
  userRoleTemp : TUser_Role;
begin
  Result := nil;

  for i := 0 to FUserList.Count-1 do
  begin
    userRoleTemp := FUserList.Items[i];

    if userRoleTemp.FData.UserRoleIndex = Id then
    begin
      Result := userRoleTemp;
      Exit;
    end;
  end;
end;

function TUserRoleContainer.getUserRoleByIPAddress(IpAddress : string): TUser_Role;
var
  i : Integer;
  userRoleTemp : TUser_Role;
begin
  Result := nil;

  for i := 0 to FUserList.Count-1 do
  begin
    userRoleTemp := FUserList.Items[i];

    if (userRoleTemp.FConsoleIP = IpAddress) then
    begin
      Result := userRoleTemp;
      Exit;
    end;
  end;
end;

function TUserRoleContainer.getUserRoleByUsernamePassword(username, password: string): TUser_Role;
var
  i : Integer;
  userRoleTemp : TUser_Role;
begin
  Result := nil;

  for i := 0 to FUserList.Count-1 do
  begin
    userRoleTemp := FUserList.Items[i];

    if (userRoleTemp.FData.Username = username) and (userRoleTemp.FData.Password = password) then
    begin
      Result := userRoleTemp;
      Exit;
    end;
  end;
end;

{$ENDREGION}

{$REGION ' TConsoleData '}

procedure TConsoleData.assignUserRoleData(Val: TRecUser_Role);
begin
  FUserRoleData.UserRoleIndex       := Val.UserRoleIndex;
  FUserRoleData.OrganisasiTugas     := Val.OrganisasiTugas;
  FUserRoleData.SubOrganisasiTugas  := Val.SubOrganisasiTugas;
  FUserRoleData.Perencanaan         := Val.Perencanaan;
  FUserRoleData.Persiapan           := Val.Persiapan;
  FUserRoleData.Pelaksanaan         := Val.Pelaksanaan;
  FUserRoleData.Pengakhiran         := Val.Pengakhiran;
  FUserRoleData.UserRoleIdentifier  := Val.UserRoleIdentifier;
  FUserRoleData.Username            := Val.Username;
  FUserRoleData.Password            := Val.Password;
end;

constructor TConsoleData.Create;
begin

end;

destructor TConsoleData.Destroy;
begin

  inherited;
end;

procedure TConsoleData.UnassignUserRoleData(Val: TRecUser_Role);
begin
  FUserRoleData.UserRoleIndex       := 0;
  FUserRoleData.OrganisasiTugas     := 0;
  FUserRoleData.SubOrganisasiTugas  := 0;
  FUserRoleData.Perencanaan         := 0;
  FUserRoleData.Persiapan           := 0;
  FUserRoleData.Pelaksanaan         := 0;
  FUserRoleData.Pengakhiran         := 0;
  FUserRoleData.UserRoleIdentifier  := '';
  FUserRoleData.Username            := '';
  FUserRoleData.Password            := '';
end;

{$ENDREGION}

{$REGION ' TFile_Data '}

constructor TFile_Data.Create;
begin

end;

destructor TFile_Data.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TTabProperties '}

constructor TTabProperties.Create;
begin

end;

destructor TTabProperties.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TTabPropertiesContainer '}

constructor TTabPropertiesContainer.Create;
begin
  TabList := TList.Create;
end;

destructor TTabPropertiesContainer.Destroy;
begin
  TabList.Free;
  inherited;
end;

function TTabPropertiesContainer.GetActiveTab(IdRole, IdTag : Integer): Boolean;
var
  i : Integer;
  tabPropertiesTemp : TTabProperties;

begin
  Result := False;

  for i := 0 to FTabList.Count - 1 do
  begin
    tabPropertiesTemp := FTabList.Items[i];

    if (tabPropertiesTemp.FIdUserRoleTab = IdRole) and (tabPropertiesTemp.FIdTab = IdTag) then
    begin
      if tabPropertiesTemp.FActiveTab then
      begin
        Result := True;
        Break;
      end;
    end;
  end;

end;

function TTabPropertiesContainer.GetCaptionTab(IdRole, IdTag : Integer): string;
var
  i : Integer;
  tabPropertiesTemp : TTabProperties;

begin
  for i := 0 to FTabList.Count - 1 do
  begin
    tabPropertiesTemp := FTabList.Items[i];

    if (tabPropertiesTemp.FIdUserRoleTab = IdRole) and (tabPropertiesTemp.FIdTab = IdTag) then
      Result := tabPropertiesTemp.FCaptionTab;
  end;
end;

function TTabPropertiesContainer.GetCountActiveTab(IdRole : Integer): Integer;
var
  i : Integer;
  tabPropertiesTemp : TTabProperties;

begin
  Result := 0;

  for i := 0 to FTabList.Count - 1 do
  begin
    tabPropertiesTemp := FTabList.Items[i];

    if tabPropertiesTemp.FActiveTab then
      inc(Result)
  end;

end;

function TTabPropertiesContainer.GetTapProperties(IdRole, IdTag : Integer): TTabProperties;
var
  i : Integer;
  tabPropertiesTemp : TTabProperties;

begin

  Result := nil;

  for i := 0 to FTabList.Count - 1 do
  begin
    tabPropertiesTemp := FTabList.Items[i];

    if (tabPropertiesTemp.FIdUserRoleTab = IdRole) and (tabPropertiesTemp.FIdTab = IdTag) then
    begin
      Result := tabPropertiesTemp;
      Break;
    end;
  end;
end;

{$ENDREGION}

{$REGION ' TChatting '}

constructor TChatting.Create;
begin

end;

destructor TChatting.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TChattingContainer '}

constructor TChattingContainer.Create;
begin
  ChattingList := TList.Create;
end;

destructor TChattingContainer.Destroy;
begin
  ChattingList.Free;
  inherited;
end;

function TChattingContainer.GetChattingBySending(IdRoleReceiving, IdRoleSending : Integer; var chatList : TList): Boolean;
var
  i : Integer;
  chattingTemp : TChatting;
begin
  for i := 0 to FChattingList.Count - 1 do
  begin
    chattingTemp := FChattingList.Items[i];

    if (chattingTemp.FIdUserRoleReceive = IdRoleReceiving) and (chattingTemp.FIdUserRoleSending = IdRoleSending) then
      chatList.Add(chattingTemp);
  end;
end;

{$ENDREGION}

{$REGION ' TGame_Area_Definition '}

constructor TGame_Area_Definition.Create;
begin

end;

destructor TGame_Area_Definition.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$Region ' TTactical_Symbol ' }

constructor TTactical_Symbol.Create;
begin

end;

destructor TTactical_Symbol.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TOverlayContainer '}

constructor TOverlayTabContainer.Create;
begin
  FTabList := TList.Create;
end;

destructor TOverlayTabContainer.Destroy;
begin
  FTabList.Free;
  inherited;
end;

procedure TOverlayTabContainer.Draw(FCanvas: TCanvas; Map1: TMap; IdOverlayTab : Integer);
var
  i : Integer;
  overlayTabTemp : TOverlayTab;

begin
  for I := 0 to FTabList.Count - 1 do
  begin
    overlayTabTemp := FTabList[I];

    if overlayTabTemp.FIdOverlayTab = IdOverlayTab  then
      overlayTabTemp.Draw(FCanvas);
  end;
end;

function TOverlayTabContainer.GetOverlayTabByID(IdOverlay: Integer): TOverlayTab;
var
  i : Integer;
  overlayTabTemp : TOverlayTab;

begin
  Result := nil;

  for i := 0 to FTabList.Count - 1 do
  begin
    overlayTabTemp := TOverlayTab(FTabList.Items[i]);

    if overlayTabTemp.FIdOverlayTab = IdOverlay then
    begin
      Result := overlayTabTemp;
    end;
  end;
end;

procedure TOverlayTabContainer.AddOverlayTab(OvelayTab: TOverlayTab);
begin
  FTabList.Add(OvelayTab);
end;

procedure TOverlayTabContainer.RemoveOverlayTab(OvelayTab: TOverlayTab);
begin
  FTabList.Remove(OvelayTab);
end;

{$ENDREGION}

{$REGION ' TOverlayTab '}

constructor TOverlayTab.create;
begin
  FMemberList := TList.Create;
end;

destructor TOverlayTab.Destroy;
begin
  FMemberList.Free;
  inherited;
end;

procedure TOverlayTab.Draw(FCanvas: TCanvas);
var
  i : Integer;
  mainShape : TMainShape;

begin
  for i := 0 to FMemberList.Count - 1 do
  begin
    mainShape := FMemberList[i];
    mainShape.Draw(FCanvas);
  end;
end;

function TOverlayTab.GetShapeById(IdShape: Integer): TMainShape;
var
  i : Integer;
  mainShapeTemp : TMainShape;

begin
  Result := nil;

  for i := 0 to MemberList.Count - 1 do
  begin
    mainShapeTemp := TMainShape(MemberList.Items[i]);

    if mainShapeTemp.ShapeId = IdShape then
    begin
      Result := mainShapeTemp;
    end;
  end;
end;

{$ENDREGION}

{$REGION ' TMainShape '}

procedure TMainShape.Clear;
begin

end;

constructor TMainShape.Create(cvt: TCoordConverter);
begin
  FConverter := cvt;
end;

destructor TMainShape.Destroy;
begin

  inherited;
end;

procedure TMainShape.Draw(aCnv: TCanvas);
begin

end;

{$ENDREGION}

{$REGION ' TTextShape }

constructor TTextShape.Create(cvt: TCoordConverter);
begin
  inherited;
end;

destructor TTextShape.Destroy;
begin

  inherited;
end;

procedure TTextShape.Draw(aCnv: TCanvas);
var
  sx, sy: Integer;
begin
  inherited;

  with aCnv do
  begin
    Converter.ConvertToScreen(postStart.X, postStart.Y, sx, sy);

    Brush.Style := bsClear;

    Font.Color := Color;
    Font.Size := size;

    if isSelected then
     Font.Color  := clWhite;

    TextOut(sx, sy, words);

    {font dinormalkan lagi}
    Font.Size := 10;
  end;
end;

{$ENDREGION}

{$REGION ' TLineShape '}
constructor TLineShape.Create(cvt: TCoordConverter);
begin

end;

destructor TLineShape.Destroy;
begin

  inherited;
end;

procedure TLineShape.Draw(aCnv: TCanvas);
var
  sx, sy, ex, ey: Integer;
begin
  inherited;

  Converter.ConvertToScreen(postStart.X, postStart.Y, sx, sy);
  Converter.ConvertToScreen(postEnd.X, postEnd.Y, ex, ey);

  with aCnv do
  begin
    Brush.Style := bsClear;
    Pen.Width := Weight;
    Pen.Style := LineType;
    Pen.Color := Color;

    if isSelected then
     Pen.color   := clWhite;

    MoveTo(sx, sy);
    LineTo(ex, ey);
  end;
//  normalized(aCnv);
end;

{$ENDREGION}

{$REGION ' TRectangleShape '}
constructor TRectangleShape.Create(cvt: TCoordConverter);
begin

end;

destructor TRectangleShape.Destroy;
begin

  inherited;
end;

procedure TRectangleShape.Draw(aCnv: TCanvas);
var
  sx, sy, ex, ey: Integer;
begin
  inherited;

  Converter.ConvertToScreen(postStart.X, postStart.Y, sx, sy);
  Converter.ConvertToScreen(postEnd.X, postEnd.Y, ex, ey);

  with aCnv do
  begin
    Pen.Color := Color;
    Pen.Width := Weight;
    Pen.Style := LineType;

    if BrushStyle = bsClear then
    begin
      Brush.Style := BrushStyle
    end
    else
    begin
      Brush.Style := BrushStyle;
      Brush.Color := ColorFill;
    end;

    if isSelected then
     Pen.color   := clWhite;

    Rectangle(sx, sy, ex, ey);
  end;
//  normalized(aCnv);
end;

{$ENDREGION}

{$REGION ' TCircleShape' }
constructor TCircleShape.Create(cvt: TCoordConverter);
begin

end;

destructor TCircleShape.Destroy;
begin

  inherited;
end;

procedure TCircleShape.Draw(aCnv: TCanvas);
var
  cx, cy, ex, ey, r: Integer;
  dx, dy : Double;
  point : TRect;
  bmp : TBitmap;
begin
  inherited;

  dx := postCenter.X + radius/60;
  dy := postCenter.Y;

  Converter.ConvertToScreen(postCenter.X, postCenter.Y, cx, cy);
  Converter.ConvertToScreen(dx, dy, ex, ey);

  r := Abs(cx - ex);

  point.Left    := cx - r;
  point.Top     := cy - r;
  point.Right   := cx + r;
  point.Bottom  := cy + r;

  with aCnv do
  begin
    Brush.Style := bsClear;

    bmp := TBitmap.Create;
    bmp.Transparent := true;
//    bmp.LoadFromFile(vSymbolSetting.ImgPath + pctFlagPoint + '.bmp');

    cx := cx - (bmp.Width div 2);
    cy := cy - (bmp.Height div 2);

    Draw(cx, cy, bmp);
    bmp.Free;

    Pen.Color := Color;
    Pen.Width := Weight;
    Pen.Style := LineType;

    if BrushStyle = bsClear then
    begin
      Brush.Style := BrushStyle
    end
    else
    begin
      Brush.Style := BrushStyle;
      Brush.Color := ColorFill;
    end;

    if isSelected then
     Pen.color   := clWhite;

    Ellipse(point.Left, point.Top, point.Right, point.Bottom);

    {untuk menormalkan pen yg tidak diset}
    Pen.Width:=1;
  end;
//  normalized(aCnv);
end;

{$ENDREGION}

{$REGION ' TEllipseShape '}

constructor TEllipseShape.Create(cvt: TCoordConverter);
begin

end;

destructor TEllipseShape.Destroy;
begin

  inherited;
end;

procedure TEllipseShape.Draw(aCnv: TCanvas);
var
  cx, cy, ex, ey, Hr, Vr: Integer;
  dx, dy : Double;
  point : TRect;
  bmp : TBitmap;
begin
  inherited;

  dx := postCenter.X + Hradius/60;
  dy := postCenter.Y + Vradius/60;

  Converter.ConvertToScreen(postCenter.X, postCenter.Y, cx, cy);
  Converter.ConvertToScreen(dx, dy, ex, ey);

  Hr := Abs(cx - ex);
  Vr := Abs(cy - ey);

  point.Left    := cx - Hr;
  point.Top     := cy - Vr;
  point.Right   := cx + Hr;
  point.Bottom  := cy + Vr;

  with aCnv do
  begin
    Brush.Style := bsClear;

    bmp := TBitmap.Create;
    bmp.Transparent := true;
//    bmp.LoadFromFile(vSymbolSetting.ImgPath + pctFlagPoint + '.bmp');

    cx := cx - (bmp.Width div 2);
    cy := cy - (bmp.Height div 2);

    Draw(cx, cy, bmp);
    bmp.Free;

    Pen.Color := Color;
    Pen.Width := Weight;
    Pen.Style := LineType;

    if BrushStyle = bsClear then
    begin
      Brush.Style := BrushStyle
    end
    else
    begin
      Brush.Style := BrushStyle;
      Brush.Color := ColorFill;
    end;

    if isSelected then
     Pen.color   := clWhite;

    Ellipse(point.Left, point.Top, point.Right, point.Bottom);

    {untuk menormalkan pen yg tidak diset}
    Pen.Width:=1;
  end;
//  normalized(aCnv);
end;

{$ENDREGION}

{$REGION ' TArcShape '}
constructor TArcShape.Create(cvt: TCoordConverter);
begin

end;

destructor TArcShape.Destroy;
begin

  inherited;
end;

procedure TArcShape.Draw(aCnv: TCanvas);
var
  cx, cy, sx, sy, ex, ey,
  tx, ty, r: Integer;
  dx, dy : Double;
  StartPoint, EndPoint  :  t2DPoint;
  point : TRect;
  bmp : TBitmap;
begin
  inherited;

  FindPoint(postCenter, StartPoint, radius, StartAngle);  {Start Angle}
  FindPoint(postCenter, EndPoint, radius, EndAngle);      {End Angle}

  dx := postCenter.X + radius/60;
  dy := postCenter.Y ;

  Converter.ConvertToScreen(postCenter.X, postCenter.Y, cx, cy);
  Converter.ConvertToScreen(StartPoint.X, StartPoint.Y, sx, sy);
  Converter.ConvertToScreen(EndPoint.X, EndPoint.Y, ex, ey);

  Converter.ConvertToScreen(dx, dy, tx, ty);
  r := Abs(cx - tx);

  point.Left    := cx - r;
  point.Top     := cy - r;
  point.Right   := cx + r;
  point.Bottom  := cy + r;

  with aCnv do
  begin
    Brush.Style := bsClear;

    bmp := TBitmap.Create;
    bmp.Transparent := true;
//    bmp.LoadFromFile(vSymbolSetting.ImgPath + pctFlagPoint + '.bmp');

    cx := cx - (bmp.Width div 2);
    cy := cy - (bmp.Height div 2);

    Draw(cx, cy, bmp);
    bmp.Free;

    Pen.Color := Color;
    Pen.Width := Weight;
    Pen.Style := LineType;

    Brush.Style := bsClear;

    if isSelected then
     Pen.color   := clWhite;

    Arc(point.Left, point.Top, point.Right, point.Bottom, ex, ey, sx, sy);

    {untuk menormalkan pen yg tidak diset}
    Pen.Width:=1;
  end;
//  normalized(aCnv);
end;

{$ENDREGION}

{$REGION ' TSectorShape '}
constructor TSectorShape.Create(cvt: TCoordConverter);
begin

end;

destructor TSectorShape.Destroy;
begin

  inherited;
end;

procedure TSectorShape.Draw(aCnv: TCanvas);
var
  cx, cy,
  Isx, Isy, Iex, Iey,
  Osx, Osy, Oex, Oey,
  tx, ty, rIn, rOut  : Integer;
  Idx, Idy, Odx, Ody : Double;
  IStartPoint, IEndPoint : t2DPoint;
  OStartPoint, OEndPoint : t2DPoint;
  Ipoint, Opoint : TRect;
  bmp : TBitmap;
begin
  inherited;

  FindPoint(postCenter, IStartPoint, Iradius, StartAngle);  {Start Angle}
  FindPoint(postCenter, IEndPoint, Iradius, EndAngle);      {End Angle}

  FindPoint(postCenter, OStartPoint, Oradius, StartAngle);  {Start Angle}
  FindPoint(postCenter, OEndPoint, Oradius, EndAngle);      {End Angle}

  Idx := postCenter.X + Iradius/60;
  Idy := postCenter.Y;

  Odx := postCenter.X + Oradius/60;
  Ody := postCenter.Y;

  Converter.ConvertToScreen(postCenter.X, postCenter.Y, cx, cy);
  Converter.ConvertToScreen(IStartPoint.X, IStartPoint.Y, Isx, Isy);
  Converter.ConvertToScreen(IEndPoint.X, IEndPoint.Y, Iex, Iey);
  Converter.ConvertToScreen(Idx, Idy, tx, ty);

  rIn := Abs(cx - tx);
  Ipoint.Left    := cx - rIn;
  Ipoint.Top     := cy - rIn;
  Ipoint.Right   := cx + rIn;
  Ipoint.Bottom  := cy + rIn;

  Converter.ConvertToScreen(OStartPoint.X, OStartPoint.Y, Osx, Osy);
  Converter.ConvertToScreen(OEndPoint.X, OEndPoint.Y, Oex, Oey);
  Converter.ConvertToScreen(Odx, Ody, tx, ty);

  rOut := Abs(cx - tx);
  Opoint.Left    := cx - rOut;
  Opoint.Top     := cy - rOut;
  Opoint.Right   := cx + rOut;
  Opoint.Bottom  := cy + rOut;

  with aCnv do
  begin
    Brush.Style := bsClear;

    bmp := TBitmap.Create;
    bmp.Transparent := true;
//    bmp.LoadFromFile(vSymbolSetting.ImgPath + pctFlagPoint + '.bmp');

    cx := cx - (bmp.Width div 2);
    cy := cy - (bmp.Height div 2);

    Draw(cx, cy, bmp);
    bmp.Free;

    Pen.Color := Color;
    Pen.Width := Weight;
    Pen.Style := LineType;

    Brush.Style := bsClear;

    if isSelected then
     Pen.color   := clWhite;

    Arc(Ipoint.Left, Ipoint.Top, Ipoint.Right, Ipoint.Bottom, Iex, Iey, Isx, Isy);
    Arc(Opoint.Left, Opoint.Top, Opoint.Right, Opoint.Bottom, Oex, Oey, Osx, Osy);
    MoveTo(Iex, Iey); LineTo(Oex, Oey);
    MoveTo(Isx, Isy); LineTo(Osx, Osy);

    {untuk menormalkan pen yg tidak diset}
    Pen.Width:=1;
  end;
//  normalized(aCnv);
end;

{$ENDREGION}

{$REGION ' TGridShape '}

constructor TGridShape.Create(cvt: TCoordConverter);
begin

end;

destructor TGridShape.Destroy;
begin

  inherited;
end;

procedure TGridShape.Draw(aCnv: TCanvas);
var
  i,
  Isx, Isy, Iex, Iey,
  Osx, Osy, Oex, Oey : Integer;

  TempX, TempY,
  Idx, Idy, Odx, Ody : Double;

  IStart, IEnd, OStart, OEnd,
  Row1, Row2, Row3, Row4,
  Col1, Col2, Col3, Col4  : t2DPoint;

  NewBearing, NewRange,
  RKiAts, RKaAts, RKiBwh, RKaBwh,
  BKiAts, BKaAts, BKiBwh, BKaBwh : Double;

begin
  inherited;

  //Point Kiri Atas
  IStart.X := postCenter.X - ((Width/60)*(WCount/2));
  IStart.Y := postCenter.Y + ((Height/60)*(HCount)/2);

  //Point Kanan Atas
  IEnd.X := postCenter.X + ((Width/60)*(WCount/2));
  IEnd.Y := postCenter.Y + ((Height/60)*(HCount)/2);

  //Point Kanan Bawah
  OStart.X := postCenter.X + ((Width/60)*(WCount/2));
  OStart.Y := postCenter.Y - ((Height/60)*(HCount)/2);

  //Point Kiri Bawah
  OEnd.X := postCenter.X - ((Width/60)*(WCount/2));
  OEnd.Y := postCenter.Y - ((Height/60)*(HCount)/2);

  BKiAts   := CalcBearing(postCenter.X, postCenter.Y, IStart.X, IStart.Y);
  BKaAts  := CalcBearing(postCenter.X, postCenter.Y, IEnd.X, IEnd.Y);
  BKaBwh := CalcBearing(postCenter.X, postCenter.Y, OStart.X, OStart.Y);
  BKiBwh  := CalcBearing(postCenter.X, postCenter.Y, OEnd.X, OEnd.Y);

  RKiAts     := CalcRange(postCenter.X, postCenter.Y, IStart.X, IStart.Y);
  RKaAts    := CalcRange(postCenter.X, postCenter.Y, IEnd.X, IEnd.Y);
  RKaBwh   := CalcRange(postCenter.X, postCenter.Y, OStart.X, OStart.Y);
  RKiBwh    := CalcRange(postCenter.X, postCenter.Y, OEnd.X, OEnd.Y);

  FindPoint(postCenter, IStart, RKiAts, BKiAts + Rotation);
  FindPoint(postCenter, IEnd, RKaAts, BKaAts + Rotation);
  FindPoint(postCenter, OStart, RKaBwh, BKaBwh + Rotation);
  FindPoint(postCenter, OEnd, RKiBwh, BKiBwh + Rotation);

  // Point 1
  Row1 := IStart;
  Col1 := IStart;

  // Point 2
  Row2 := IEnd;
  Col2 := IEnd;

  // Point 3
  Row3 := OEnd;
  Col3 := OEnd;

  // Point 4
  Row4 := OStart;
  Col4 := OStart;

  Converter.ConvertToScreen(IStart.X,  IStart.Y,  Isx, Isy);
  Converter.ConvertToScreen(IEnd.X,    IEnd.Y,    Iex, Iey);
  Converter.ConvertToScreen(OStart.X,  OStart.Y,  Osx, Osy);
  Converter.ConvertToScreen(OEnd.X,    OEnd.Y,    Oex, Oey);

  with aCnv do
  begin
    Pen.Color := Color;
    Pen.Width := Weight;
    Pen.Style := LineType;

    Brush.Style := bsClear;

    if isSelected then
     Pen.color   := clWhite;

    MoveTo(Isx, Isy); LineTo(Iex, Iey);
  end;

  for i := 1 to HCount do // loop for baris
  begin
    // Point 3
    TempX := Row1.X;
    TempY := Row1.Y - (Height / 60);

    NewBearing := CalcBearing(Row1.X, Row1.Y, TempX, TempY);
    NewRange := CalcRange(Row1.X, Row1.Y, TempX, TempY);
    FindPoint(Row1, Row3, NewRange, NewBearing + Rotation);

    // Point 4
    TempX := Row2.X;
    TempY := Row2.Y - (Height / 60);

    NewBearing := CalcBearing(Row2.X, Row2.Y, TempX, TempY);
    NewRange := CalcRange(Row2.X, Row2.Y, TempX, TempY);
    FindPoint(Row2, Row4, NewRange, NewBearing + Rotation);

    Converter.ConvertToScreen(Row1.X, Row1.Y, Isx, Isy);
    Converter.ConvertToScreen(Row2.X, Row2.Y, Iex, Iey);
    Converter.ConvertToScreen(Row3.X, Row3.Y, Osx, Osy);
    Converter.ConvertToScreen(Row4.X, Row4.Y, Oex, Oey);

    with aCnv do
    begin
      MoveTo(Isx, Isy); LineTo(Osx, Osy);
      MoveTo(Osx, Osy); LineTo(Oex, Oey);
      MoveTo(Iex, Iey); LineTo(Oex, Oey);
    end;

    Row1.X := Row3.X;
    Row1.Y := Row3.Y;
    Row2.X := Row4.X;
    Row2.Y := Row4.Y;
  end;

  for i := 1 to WCount do // loop for kolom
  begin
    // Point 2
    TempX := Col1.X + (Width / 60);
    TempY := Col1.Y;

    NewBearing := CalcBearing(Col1.X, Col1.Y, TempX, TempY);
    NewRange := CalcRange(Col1.X, Col1.Y, TempX, TempY);
    FindPoint(Col1, Col2, NewRange, NewBearing + Rotation);

    // Point 4
    TempX := Col3.X + (Width / 60);
    TempY := Col3.Y;

    NewBearing := CalcBearing(Col3.X, Col3.Y, TempX, TempY);
    NewRange := CalcRange(Col3.X, Col3.Y, TempX, TempY);
    FindPoint(Col3, Col4, NewRange, NewBearing + Rotation);

    Converter.ConvertToScreen(Col1.X, Col1.Y, Isx, Isy);
    Converter.ConvertToScreen(Col2.X, Col2.Y, Iex, Iey);
    Converter.ConvertToScreen(Col3.X, Col3.Y, Osx, Osy);
    Converter.ConvertToScreen(Col4.X, Col4.Y, Oex, Oey);

    with aCnv do
    begin
      MoveTo(Isx, Isy); LineTo(Iex, Iey);
      MoveTo(Iex, Iey); LineTo(Oex, Oey);
      MoveTo(Osx, Osy); LineTo(Oex, Oey);
    end;

    Col1.X := Col2.X;
    Col1.Y := Col2.Y;
    Col3.X := Col4.X;
    Col3.Y := Col4.Y;
  end;
//  normalized(aCnv);
end;

{$ENDREGION}

{$REGION ' TPolygonShape '}

constructor TPolygonShape.Create(cvt: TCoordConverter);
begin

end;

destructor TPolygonShape.Destroy;
begin

  inherited;
end;

procedure TPolygonShape.Draw(aCnv: TCanvas);
var
  i,
  Isx, Isy : Integer;
  point : TDotShape;
  polyPoint : Array of TPoint;
begin
  inherited;
  SetLength(polyPoint, polyList.Count);

  for i := 0 to polyList.Count - 1 do
  begin
    point := polyList.Items[i];

    Converter.ConvertToScreen(point.X, point.Y, Isx, Isy);
    polyPoint[i].x := Isx;
    polyPoint[i].y := Isy;
  end;

  with aCnv do
  begin
    Pen.Color := Color;
    Pen.Width := Weight;
    Pen.Style := LineType;

    if BrushStyle = bsClear then
      Brush.Style := BrushStyle
    else
    begin
      Brush.Style := BrushStyle;;
      Brush.Color := ColorFill;
    end;

    if isSelected then
     Pen.color   := clWhite;

    Polygon(polyPoint);
  end;
//  normalized(aCnv);
end;

{$ENDREGION}

{$REGION ' TDotShape '}

constructor TDotShape.Create;
begin

end;

destructor TDotShape.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TFlagPoint '}

constructor TFlagPoint.Create(cvt: TCoordConverter);
begin

end;

destructor TFlagPoint.Destroy;
begin

end;

procedure TFlagPoint.Draw(aCnv: TCanvas);
var
  x, y : Integer;
  bmp : TBitmap;
begin
  with aCnv do
  begin
    Converter.ConvertToScreen(Post.X, Post.Y, x, y);

    Brush.Style := bsClear;
    Pen.Style := psSolid;

    bmp := TBitmap.Create;
    bmp.Transparent := true;
//    bmp.LoadFromFile(vSymbolSetting.ImgPath + pctFlagPoint + '.bmp');

    x := x - (bmp.Width div 2);
    y := y - (bmp.Height div 2);

    Draw(x, y, bmp);
    bmp.Free;

    {untuk menormalkan pen yg tidak diset}
    Pen.Width:=1;
  end;
end;

procedure TFlagPoint.SetConverter(const Value: TCoordConverter);
begin

end;
{$ENDREGION}

end.
