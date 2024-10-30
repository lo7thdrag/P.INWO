unit uClassData;

interface

uses
  System.Classes, Vcl.Graphics, MapXLib_TLB,
  uRecordData, uConstantaData, uCoordConvertor, uDataTypes;

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

  TOverlayTab = class
  private
    FIdOverlayTab : Integer;
    FIdUserRole : Integer;
    FRoleName : string;
    FMemberList : TList;

  public

    constructor create;
    destructor Destroy; override;

    procedure Draw(FCanvas: TCanvas); virtual;

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

    procedure Draw(FCanvas: TCanvas; Map1: TMap; IdOverlayTab : Integer);

    procedure AddOverlayTab(OvelayTab : TOverlayTab);
    procedure RemoveOverlayTab(OvelayTab : TOverlayTab);

    property TabList : TList read FTabList write FTabList;

  end;

  TMainShape = class
  private
    FColor: Integer;
    FSelected: Boolean;
    FConverter: TCoordConverter;
    FColorFill: Integer;
    FLineType: TPenStyle;
    FWeight: Integer;
    FBrushStyle: TBrushStyle;

  public
//    FFormula : TFormula;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;

//    procedure FindPoint(postCont: t2DPoint; var postValue : t2DPoint; vd, vi: Double);
    procedure Clear;
    procedure Draw(aCnv: TCanvas); virtual;

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

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;
  end;

//  TLineStatic = class(TMainShape)
//  public
//    postStart : t2DPoint;
//    postEnd : t2DPoint;
//
//    procedure Draw(aCnv: TCanvas); override;
//
//    constructor Create(cvt : TCoordConverter);
//    destructor Destroy; override;
//  end;
//
//  TRectangleStatic = class(TMainShape)
//  public
//    postStart : t2DPoint;
//    postEnd : t2DPoint;
//
//    procedure Draw(aCnv: TCanvas); override;
//
//    constructor Create(cvt : TCoordConverter);
//    destructor Destroy; override;
//  end;
//
//  TCircleStatic = class(TMainShape)
//  public
//    postCenter : t2DPoint;
//    radius : Double;
//
//    procedure Draw(aCnv: TCanvas); override;
//
//    constructor Create(cvt : TCoordConverter);
//    destructor Destroy; override;
//  end;
//
//  TEllipseStatic = class(TMainShape)
//  public
//    postCenter : t2DPoint;
//    Hradius, Vradius : Double;
//
//    procedure Draw(aCnv: TCanvas); override;
//
//    constructor Create(cvt : TCoordConverter);
//    destructor Destroy; override;
//  end;
//
//  TArcStatic = class(TMainShape)
//  public
//    postCenter : t2DPoint;
//    radius : Double;
//    StartAngle, EndAngle : Integer;
//
//    procedure Draw(aCnv: TCanvas); override;
//
//    constructor Create(cvt : TCoordConverter);
//    destructor Destroy; override;
//  end;
//
//  TSectorStatic = class(TMainShape)
//  public
//    postCenter : t2DPoint;
//    Oradius, Iradius : Double;
//    StartAngle, EndAngle : Integer;
//
//    procedure Draw(aCnv: TCanvas); override;
//
//    constructor Create(cvt : TCoordConverter);
//    destructor Destroy; override;
//  end;
//
//  TGridStatic = class(TMainShape)
//  public
//    postCenter : t2DPoint;
//    HCount, WCount, Rotation : Integer;
//    Height, Width : Double;
//
//    procedure Draw(aCnv: TCanvas); override;
//
//    constructor Create(cvt : TCoordConverter);
//    destructor Destroy; override;
//  end;
//
//  TPolygonStatic = class(TMainShape)
//  public
//    polyPoint : Array of TPoint;
//    polyList : TList;
//
//    procedure Draw(aCnv: TCanvas); override;
//
//    constructor Create(cvt : TCoordConverter);
//    destructor Destroy; override;
//  end;
//
//  TDotStatic = class
//  public
//    X, Y : Double;
//    constructor Create;
//    destructor Destroy; override;
//  end;
//
//  TFlagPoint = class
//  private
//    FConverter: TCoordConverter;
//    procedure SetConverter(const Value: TCoordConverter);
//
//  public
//    Post : t2DPoint;
//
//    constructor Create(cvt : TCoordConverter);
//    destructor Destroy;
//    procedure Draw(aCnv : TCanvas);
//
//    property Converter : TCoordConverter read FConverter write SetConverter;
//  end;



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
begin

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

end.
