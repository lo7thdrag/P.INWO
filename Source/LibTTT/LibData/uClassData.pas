unit uClassData;

interface

uses
  System.Classes, MapXLib_TLB, Winapi.Windows, Vcl.Graphics, System.SysUtils,

  uRecordData, uConstantaData, uCoordConvertor, uDataTypes, uFormula, uBaseCoordSystem,
  uLibSetting;

type

  TRole = class
  private

  public
    FData  : TRecRole;

    constructor Create;
    destructor Destroy;override;

  end;

  TRoleContainer = class
  private
    FRoleList : TList;

  public
    constructor Create;
    destructor  Destroy; override;

    function  getRoleByID(Id : Integer): TRole;

    procedure addRole(Val : TRole);
    procedure deleteRole(Val : TRole);

    property RoleList : TList read FRoleList write FRoleList;
  end;

  TSubRole = class
  private

  public
    FData  : TRecSubRole;

    constructor Create;
    destructor Destroy;override;

  end;

  TSubRoleContainer = class
  private
    FSubRoleList : TList;

  public
    constructor Create;
    destructor  Destroy; override;

    function  getSubRoleByID(Id : Integer): TSubRole;

    procedure addSubRole(Val : TSubRole);
    procedure deleteSubRole(Val : TSubRole);

    property SubRoleList : TList read FSubRoleList write FSubRoleList;
  end;

  TUserRole = class
  private
    FConsoleIP : string;
    FisInUse : Boolean;

  public
    FData  : TRecUser_Role;
    FSubRoleData  : TRecSubRole;
    FRoleData  : TRecRole;

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

    function  getUserRoleByUsernamePassword(username, password : string): TUserRole;
    function  getUserRoleByID(Id : Integer): TUserRole;
    function  getUserRoleByIPAddress(IpAddress : string): TUserRole;

    procedure addUserRole(Val : TUserRole);
    procedure deleteUserRole(Val : TUserRole);

    property UserList : TList read FUserList write FUserList;
  end;

  TConsoleData = class
  private
    FIdentifier : string;
    FIpAdrres : string;
    FGroup : TConsoleGroup;
    FUserRoleData : TUserRole;

  public
    constructor Create;
    destructor  Destroy; override;

    procedure assignUserRoleData(Val : TUserRole);
    procedure UnassignUserRoleData(Val : TUserRole);

    property Identifier : string read FIdentifier write FIdentifier;
    property IpAdrres : string read FIpAdrres write FIpAdrres;
    property Group : TConsoleGroup read FGroup write FGroup;
    property UserRoleData : TUserRole read FUserRoleData write FUserRoleData;
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
    function DeleteTapProperties(OverlayTab : Integer):Boolean;

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
    function GetChattingByUserRole(UserRoleId : Integer; var chatList : TList): Boolean;

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

  TAsset = class
  public
    FData : TRecVehicle_Definition;

    constructor Create;
    destructor Destroy;override;
  end;

  THosted_Platform = class
  public
    FData: TRecHosted_Platform;
    FVehicle: TRecVehicle_Definition
  end;

  TVehicleOnBase = class
  public
    Name : string;
    Quantity : Integer;
    Simbol : string;
    IndexTaktisSymbol : Integer;
    constructor create;
    destructor Destroy; override;
  end;

  TLogisticOnBase = class
  public
    Name : string;
    Status : string;

    constructor create;
    destructor Destroy; override;
  end;

  TIntelijenInfo = class
  public
    Info : string;

    constructor create;
    destructor Destroy; override;
  end;

  TMainShape = class
  private
    FShapeId : Integer;
    FShapeOutline: Integer;
    FConverter: TCoordConverter;
    FShapeFill: Integer;
    FLineType: TPenStyle;
    FLineWeight: Integer;
    FBrushStyle: TBrushStyle;
    FIdentifier : string;
    FisSelected: Boolean;
    FisShow : Boolean;

    function SetTempHuruf(Huruf : TFont; id : Byte): TFont;
    procedure SetStyleHuruf(iCvs: TCanvas; iStyle: TFontStyle; iSize, iColor: Integer; iName: string);
    procedure SetLineProp(var gx: Integer;  x, gx1, gx2: Integer);
    procedure changeBitmapColor(bmp: TBitmap; clr: TColor);
    procedure drawObjek(FCanvas: TCanvas; id, x, y : Integer);

  public
    postCenter : t2DPoint;
    TableProp : t2DPoint;
    TempHuruf : TFont;

    constructor Create(cvt : TCoordConverter); virtual;
    destructor Destroy; virtual;

    function PackingName(OldName : string): string;
    function PackingQty(OldQty : Integer): string;
    function PackingInfo(OldStatus : string): string;

    procedure Clear;
    procedure Draw(aCnv: TCanvas); virtual;

    procedure Normalized(aCnv : TCanvas);

    property Identifier : string read FIdentifier write FIdentifier;
    property ShapeId : Integer read FShapeId write FShapeId;
    property ShapeOutline : Integer read FShapeOutline write FShapeOutline;
    property ShapeFill : Integer read FShapeFill write FShapeFill;
    property isSelected : Boolean read FisSelected write FisSelected;
    property isShow : Boolean read FisShow write FisShow;
    property Converter : TCoordConverter read FConverter write FConverter;
    property LineType : TPenStyle read FLineType write FLineType;
    property LineWeight : Integer read FLineWeight write FLineWeight;
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

  TIntelijenShape = class (TMainShape)
  public
    InfoList   : TList;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;

    procedure Draw(FCanvas: TCanvas); override;
  end;

  TLogisticShape = class (TMainShape)
  public
    LogisticList   : TList;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;

    procedure Draw(FCanvas: TCanvas); override;
  end;

  TPangkalanShape = class (TMainShape)
  public
    VehiclesList   : TList;
    idTaktis : Integer;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;

    procedure Draw(FCanvas: TCanvas); override;
  end;

  TRadarShape = class (TMainShape)
  public
    Radius : Double;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;

    procedure Draw(FCanvas: TCanvas); override;
  end;

  TPanahShape = class (TMainShape)
  public
    postEnd  : t2DPoint;
    isPostEnd : Boolean;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;

    procedure Draw(FCanvas: TCanvas); override;
  end;

  TPlatformShape = class (TMainShape)
  public
    simbol : string;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;

    procedure Draw(FCanvas: TCanvas); override;
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
    FPointId : Integer;
    FConverter: TCoordConverter;

  public
    Post : t2DPoint;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy;
    procedure Draw(aCnv : TCanvas);

    property PointId : Integer read FPointId write FPointId;
    property Converter : TCoordConverter read FConverter write FConverter;
  end;

  TFlagPointbContainer = class
  private
    FConverter: TCoordConverter;
    FFlagList : TList;

  public

    constructor Create;
    destructor Destroy; override;

    procedure Clear;
    procedure Draw(FCanvas: TCanvas);

    function GetFlagPoint(FlagPointId : Integer): TFlagPoint;

    property FlagList : TList read FFlagList write FFlagList;
    property Converter : TCoordConverter read FConverter write FConverter;

  end;

  TRuler = class
  private
    FConverter: TCoordConverter;

  protected

  public
    postStart : t2DPoint;
    postEnd : t2DPoint;
    IsVisible : Boolean;

    constructor Create(cvt : TCoordConverter);
    destructor Destroy; override;

    procedure Draw(FCanvas: TCanvas);

    property Converter : TCoordConverter read FConverter write FConverter;
  end;

  TFontTaktis = class
  public
    FData : TRecFontTaktis;

    constructor Create;
    destructor Destroy;override;

  end;

implementation

{$REGION ' TRole '}

constructor TRole.Create;
begin

end;

destructor TRole.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TRoleContainer '}

procedure TRoleContainer.addRole(Val: TRole);
begin
  FRoleList.Add(Val);
end;

constructor TRoleContainer.Create;
begin
  FRoleList := TList.Create;
end;

procedure TRoleContainer.deleteRole(Val: TRole);
begin
  FRoleList.Remove(Val);
end;

destructor TRoleContainer.Destroy;
begin
  FRoleList.Free;
  inherited;
end;

function TRoleContainer.getRoleByID(Id: Integer): TRole;
var
  i : Integer;
  roleTemp : TRole;
begin
  Result := nil;

  for i := 0 to FRoleList.Count-1 do
  begin
    roleTemp := FRoleList.Items[i];

    if roleTemp.FData.RoleIndex = Id then
    begin
      Result := roleTemp;
      Exit;
    end;
  end;
end;

{$ENDREGION}

{$REGION ' TSubRole '}

constructor TSubRole.Create;
begin

end;

destructor TSubRole.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TSubRoleContainer '}

procedure TSubRoleContainer.addSubRole(Val: TSubRole);
begin
  FSubRoleList.Add(Val);
end;

constructor TSubRoleContainer.Create;
begin
  FSubRoleList := TList.Create;
end;

procedure TSubRoleContainer.deleteSubRole(Val: TSubRole);
begin
  FSubRoleList.Remove(Val);
end;

destructor TSubRoleContainer.Destroy;
begin
  FSubRoleList.Free;
  inherited;
end;

function TSubRoleContainer.getSubRoleByID(Id: Integer): TSubRole;
var
  i : Integer;
  subRoleTemp : TSubRole;
begin
  Result := nil;

  for i := 0 to FSubRoleList.Count-1 do
  begin
    subRoleTemp := FSubRoleList.Items[i];

    if subRoleTemp.FData.SubRoleIndex = Id then
    begin
      Result := subRoleTemp;
      Exit;
    end;
  end;
end;

{$ENDREGION}

{$REGION ' TUser_Role '}

constructor TUserRole.Create;
begin
  FisInUse := False;
  FConsoleIP := '';
end;

destructor TUserRole.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TUserRoleContainer '}

procedure TUserRoleContainer.addUserRole(Val: TUserRole);
begin
  FUserList.Add(Val);
end;

constructor TUserRoleContainer.Create;
begin
  FUserList := TList.Create;
end;

procedure TUserRoleContainer.deleteUserRole(Val: TUserRole);
begin
  FUserList.Remove(Val);
end;

destructor TUserRoleContainer.Destroy;
begin
  FUserList.Free;
  inherited;
end;

function TUserRoleContainer.getUserRoleByID(Id: Integer): TUserRole;
var
  i : Integer;
  userRoleTemp : TUserRole;
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

function TUserRoleContainer.getUserRoleByIPAddress(IpAddress : string): TUserRole;
var
  i : Integer;
  userRoleTemp : TUserRole;
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

function TUserRoleContainer.getUserRoleByUsernamePassword(username, password: string): TUserRole;
var
  i : Integer;
  userRoleTemp : TUserRole;
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

constructor TConsoleData.Create;
begin
  FUserRoleData := TUserRole.Create;
end;

destructor TConsoleData.Destroy;
begin
  FUserRoleData.Free;
  inherited;
end;

procedure TConsoleData.assignUserRoleData(Val: TUserRole);
begin
  FUserRoleData.FConsoleIP                      := IpAdrres;
  FUserRoleData.isInUse                         := Val.isInUse;

  FUserRoleData.FData.UserRoleIndex             := Val.FData.UserRoleIndex;
  FUserRoleData.FData.RoleIndex                 := Val.FData.RoleIndex;
  FUserRoleData.FData.SubRoleIndex              := Val.FData.SubRoleIndex;
  FUserRoleData.FData.UserRoleAcronim           := Val.FData.UserRoleAcronim;
  FUserRoleData.FData.UserRoleIdentifier        := Val.FData.UserRoleIdentifier;
  FUserRoleData.FData.Username                  := Val.FData.Username;
  FUserRoleData.FData.Password                  := Val.FData.Password;

  FUserRoleData.FSubRoleData.SubRoleIndex       := Val.FSubRoleData.SubRoleIndex;
  FUserRoleData.FSubRoleData.RoleIndex          := Val.FSubRoleData.RoleIndex;
  FUserRoleData.FSubRoleData.SubRoleAcronim     := Val.FSubRoleData.SubRoleAcronim;
  FUserRoleData.FSubRoleData.SubRoleIdentifier  := Val.FSubRoleData.SubRoleIdentifier;
  FUserRoleData.FSubRoleData.Perencanaan        := Val.FSubRoleData.Perencanaan;
  FUserRoleData.FSubRoleData.Persiapan          := Val.FSubRoleData.Persiapan;
  FUserRoleData.FSubRoleData.Pelaksanaan        := Val.FSubRoleData.Pelaksanaan;
  FUserRoleData.FSubRoleData.Pengakhiran        := Val.FSubRoleData.Pengakhiran;

  FUserRoleData.FRoleData.RoleIndex             := Val.FRoleData.RoleIndex;
  FUserRoleData.FRoleData.RoleAcronim           := Val.FRoleData.RoleAcronim;
  FUserRoleData.FRoleData.RoleIdentifier        := Val.FRoleData.RoleIdentifier;
end;

procedure TConsoleData.UnassignUserRoleData(Val: TUserRole);
begin
  FUserRoleData.FConsoleIP                      := '';
  FUserRoleData.isInUse                         := False;

  FUserRoleData.FData.UserRoleIndex             := 0;
  FUserRoleData.FData.RoleIndex                 := 0;
  FUserRoleData.FData.SubRoleIndex              := 0;
  FUserRoleData.FData.UserRoleAcronim           := '';
  FUserRoleData.FData.UserRoleIdentifier        := '';
  FUserRoleData.FData.Username                  := '';
  FUserRoleData.FData.Password                  := '';

  FUserRoleData.FSubRoleData.SubRoleIndex       := 0;
  FUserRoleData.FSubRoleData.RoleIndex          := 0;
  FUserRoleData.FSubRoleData.SubRoleAcronim     := '';
  FUserRoleData.FSubRoleData.SubRoleIdentifier  := '';
  FUserRoleData.FSubRoleData.Perencanaan        := 0;
  FUserRoleData.FSubRoleData.Persiapan          := 0;
  FUserRoleData.FSubRoleData.Pelaksanaan        := 0;
  FUserRoleData.FSubRoleData.Pengakhiran        := 0;

  FUserRoleData.FRoleData.RoleIndex             := 0;
  FUserRoleData.FRoleData.RoleAcronim           := '';
  FUserRoleData.FRoleData.RoleIdentifier        := '';
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

function TTabPropertiesContainer.DeleteTapProperties(OverlayTab: Integer): Boolean;
var
  i : Integer;
  tabPropertiesTemp : TTabProperties;

begin

  Result := False;

  for i := 0 to FTabList.Count - 1 do
  begin
    tabPropertiesTemp := FTabList.Items[i];

    if (tabPropertiesTemp.FIdOverlayTab = OverlayTab) then
    begin
      FTabList.Remove(tabPropertiesTemp);
      Result := True;

      Break;
    end;
  end;
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

//    if (chattingTemp.FIdUserRoleReceive = IdRoleReceiving) and (chattingTemp.FIdUserRoleSending = IdRoleReceiving) then
      if ((chattingTemp.FIdUserRoleReceive = IdRoleReceiving) and (chattingTemp.FIdUserRoleSending = IdRoleSending)) or
         ((chattingTemp.FIdUserRoleReceive = IdRoleSending) and (chattingTemp.FIdUserRoleSending = IdRoleReceiving)) then
      chatList.Add(chattingTemp);

  end;
end;

function TChattingContainer.GetChattingByUserRole(UserRoleId: Integer; var chatList: TList): Boolean;
var
  i : Integer;
  chattingTemp : TChatting;
begin
  for i := 0 to FChattingList.Count - 1 do
  begin
    chattingTemp := FChattingList.Items[i];

    if (chattingTemp.FIdUserRoleReceive = UserRoleId) then
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

procedure TMainShape.changeBitmapColor(bmp: TBitmap; clr: TColor);
type
    TArrayByte = array[0..255] of Byte;
    PAByte = ^TArrayByte;
var i, j: Integer;
    pB : PAByte;
    hPal: HPALETTE;
    dClr, bClr : byte;
begin
  bmp.PixelFormat := pf8bit;
  hPal   := bmp.Palette;
  bClr := GetNearestPaletteIndex(hPal, clBlack);
  dClr := GetNearestPaletteIndex(hPal, clr);

  for j := 0 to bmp.Height - 1 do begin
    pb := bmp.ScanLine[j];
    for i := 0 to bmp.Width-1  do  begin
      if pB[i] = bClr then
        pB[i] := dClr;
    end;
  end;
end;

procedure TMainShape.Clear;
begin

end;

constructor TMainShape.Create(cvt: TCoordConverter);
begin
  FConverter := cvt;
  TempHuruf := TFont.Create;
end;

destructor TMainShape.Destroy;
begin
  TempHuruf.Free;

  inherited;
end;

procedure TMainShape.Draw(aCnv: TCanvas);
begin

end;

procedure TMainShape.drawObjek(FCanvas: TCanvas; id, x, y: Integer);
var
  x1, y1 : Integer;
  lengthName : Integer;
  bmp : TBitmap;

begin
  with FCanvas do
  begin
    Pen.Style := psSolid;
    Brush.Style := bsClear;

    {draw lambang}
    bmp := TBitmap.Create;
    case id of
      ovIntelijen, ovLogistic, ovPangkalan :
      begin
        bmp.Transparent := true;
        bmp.LoadFromFile(vGameDataSetting.ImgPath + pctLogisticPoint + '.bmp');
      end;
      ovRadar: bmp.LoadFromFile(vGameDataSetting.ImgPath + pctBaseRadar + '.bmp');
//      ovPangkalan: bmp.LoadFromFile(vGameDataSetting.ImgPath + pctBaseAL + '.bmp');
      ovPanah:
      begin
        bmp.Transparent := true;
        bmp.LoadFromFile(vGameDataSetting.ImgPath + pctPanah + '.bmp');
      end;
    end;
    changeBitmapColor(bmp, ShapeOutline);

    x1 := x - (bmp.Width div 2);
    y1 := y - (bmp.Height div 2);

    Draw(x1, y1, bmp);

   {draw name}
//    if not isShow then
//    begin
      lengthName := (length(Identifier) div 2) * 8;
      SetStyleHuruf(FCanvas, fsBold, 10, ShapeOutline, 'Maiandra GD');
      TextOut(round(x-lengthName), round(y + (bmp.Height/2)), Identifier);
//    end;

    bmp.Free;
  end;
end;

procedure TMainShape.Normalized(aCnv: TCanvas);
begin
  with aCnv do
  begin
    Pen.Color := clBlack;
    Pen.Width := 1;
    Pen.Style := psSolid;
  end;
end;

function TMainShape.PackingInfo(OldStatus: string): string;
var
  s, i : Integer;
begin
  Result := OldStatus;

  s := Length(OldStatus);
  if s < 40 then
  begin
    for i := s to 39 do
    begin
      Result := Result + ' ';
    end;
  end;
end;

function TMainShape.PackingName(OldName: string): string;
var
  s, i : Integer;
begin
  Result := OldName;

  s := Length(OldName);
  if s < 16 then
  begin
    for i := s to 20 do
    begin
      Result := Result + ' ';
    end;
  end;
end;

function TMainShape.PackingQty(OldQty: Integer): string;
var
  NewQty : Double;
begin
  Result := IntToStr(OldQty);

  if OldQty > 999 then
  begin
    NewQty := OldQty div 1000;
    OldQty := Round(NewQty);
    Result := IntToStr(OldQty) + 'K';
  end;
end;

procedure TMainShape.SetLineProp(var gx: Integer; x, gx1, gx2: Integer);
var
  range1, range2 : Integer;

begin
  range1 := Abs(x - (gx1));
  range2 := Abs(x - (gx2));

  if range1 < range2 then
    gx := gx1
  else
    gx := gx2;
end;

procedure TMainShape.SetStyleHuruf(iCvs: TCanvas; iStyle: TFontStyle; iSize, iColor: Integer; iName: string);
begin
  with iCvs do
  begin
    Brush.Style := bsClear;
    Font.Style  := [iStyle];

    if iStyle <> fsBold then
      Font.Style  := [];

    Font.Size   := iSize;
    Font.Color  := iColor;
    Font.Name   := iName;
  end;
end;

function TMainShape.SetTempHuruf(Huruf: TFont; id: Byte): TFont;
begin
  case id of
    0:
    begin
      TempHuruf.Style  := Huruf.Style;
      TempHuruf.Name   := Huruf.Name;
      TempHuruf.Size   := Huruf.Size;
      TempHuruf.Color  := Huruf.Color;
    end;
    1:
    begin
      Huruf.Style := TempHuruf.Style;
      Huruf.Name  := TempHuruf.Name;
      Huruf.Size  := TempHuruf.Size;
      Huruf.Color := TempHuruf.Color;
    end;
  end;

  Result := Huruf;
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
begin
  inherited;
end;

{$ENDREGION}

{$REGION ' TLineShape '}
constructor TLineShape.Create(cvt: TCoordConverter);
begin
  inherited;
end;

destructor TLineShape.Destroy;
begin
   inherited;
end;

procedure TLineShape.Draw(aCnv: TCanvas);
begin
  inherited;
end;

{$ENDREGION}

{$REGION ' TRectangleShape '}
constructor TRectangleShape.Create(cvt: TCoordConverter);
begin
  inherited;
end;

destructor TRectangleShape.Destroy;
begin
  inherited;
end;

procedure TRectangleShape.Draw(aCnv: TCanvas);
begin
  inherited;

end;

{$ENDREGION}

{$REGION ' TCircleShape' }
constructor TCircleShape.Create(cvt: TCoordConverter);
begin
  inherited;
end;

destructor TCircleShape.Destroy;
begin
  inherited;
end;

procedure TCircleShape.Draw(aCnv: TCanvas);
begin
  inherited;
end;

{$ENDREGION}

{$REGION ' TEllipseShape '}

constructor TEllipseShape.Create(cvt: TCoordConverter);
begin
  inherited;
end;

destructor TEllipseShape.Destroy;
begin
   inherited;
end;

procedure TEllipseShape.Draw(aCnv: TCanvas);
begin
  inherited;

end;

{$ENDREGION}

{$REGION ' TArcShape '}
constructor TArcShape.Create(cvt: TCoordConverter);
begin
  inherited;
end;

destructor TArcShape.Destroy;
begin
  inherited;
end;

procedure TArcShape.Draw(aCnv: TCanvas);
begin
  inherited;
end;

{$ENDREGION}

{$REGION ' TSectorShape '}
constructor TSectorShape.Create(cvt: TCoordConverter);
begin
  inherited;
end;

destructor TSectorShape.Destroy;
begin
  inherited;
end;

procedure TSectorShape.Draw(aCnv: TCanvas);
begin
  inherited;

end;

{$ENDREGION}

{$REGION ' TGridShape '}

constructor TGridShape.Create(cvt: TCoordConverter);
begin
  inherited;
end;

destructor TGridShape.Destroy;
begin
  inherited;
end;

procedure TGridShape.Draw(aCnv: TCanvas);
begin
  inherited;
end;

{$ENDREGION}

{$REGION ' TPolygonShape '}

constructor TPolygonShape.Create(cvt: TCoordConverter);
begin
  inherited;
end;

destructor TPolygonShape.Destroy;
begin
  inherited;
end;

procedure TPolygonShape.Draw(aCnv: TCanvas);

begin
  inherited;

end;

{$ENDREGION}

{$REGION ' TDotShape '}

constructor TDotShape.Create;
begin
//  inherited;
end;

destructor TDotShape.Destroy;
begin
  inherited;
end;

{$ENDREGION}

{$REGION ' TFlagPoint '}

constructor TFlagPoint.Create(cvt: TCoordConverter);
begin
  FConverter := cvt;
end;

destructor TFlagPoint.Destroy;
begin
  inherited;
end;

procedure TFlagPoint.Draw(aCnv: TCanvas);

begin

end;

{$ENDREGION}

{$REGION ' TIntelijenShape '}

constructor TIntelijenShape.Create(cvt: TCoordConverter);
begin
  inherited;
  InfoList := TList.Create;
end;

destructor TIntelijenShape.Destroy;
begin
  inherited;
  InfoList.Free;
end;

procedure TIntelijenShape.Draw(FCanvas: TCanvas);

begin
  inherited;

end;

{$ENDREGION}

{$REGION ' TLogisticShape '}

constructor TLogisticShape.Create(cvt: TCoordConverter);
begin
  inherited;
  LogisticList := TList.Create;
end;

destructor TLogisticShape.Destroy;
begin
  inherited;
  LogisticList.Free;
end;

procedure TLogisticShape.Draw(FCanvas: TCanvas);
begin
  inherited;

end;

{$ENDREGION}

{$REGION ' TPangkalanShape '}

constructor TPangkalanShape.Create(cvt: TCoordConverter);
begin
  inherited;
  VehiclesList := TList.Create;
end;

destructor TPangkalanShape.Destroy;
begin
  inherited;
  VehiclesList.Free;
end;

procedure TPangkalanShape.Draw(FCanvas: TCanvas);

begin
  inherited;

end;

{$ENDREGION}

{$REGION ' TRadarShape '}

constructor TRadarShape.Create(cvt: TCoordConverter);
begin
  inherited;
end;

destructor TRadarShape.Destroy;
begin

  inherited;
end;

procedure TRadarShape.Draw(FCanvas: TCanvas);

begin
  inherited;

end;

{$ENDREGION}

{$REGION ' TPanahShape '}

constructor TPanahShape.Create(cvt: TCoordConverter);
begin
  inherited;

end;

destructor TPanahShape.Destroy;
begin

  inherited;
end;

procedure TPanahShape.Draw(FCanvas: TCanvas);

begin
  inherited;

end;

{$ENDREGION}

{$REGION ' TVehicleOnBase '}

constructor TVehicleOnBase.create;
begin

end;

destructor TVehicleOnBase.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TLogisticOnBase '}

constructor TLogisticOnBase.create;
begin

end;

destructor TLogisticOnBase.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TIntelijenInfo '}

constructor TIntelijenInfo.create;
begin

end;

destructor TIntelijenInfo.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TFlagPointbContainer '}

procedure TFlagPointbContainer.Clear;
begin
  FFlagList.Clear;
end;

constructor TFlagPointbContainer.Create;
begin
  FFlagList := TList.Create;
end;

destructor TFlagPointbContainer.Destroy;
begin
  FFlagList.Free;

  inherited;
end;

procedure TFlagPointbContainer.Draw(FCanvas: TCanvas);
var
  i : Integer;
  item : TFlagPoint;
begin
  for i := 0 to FFlagList.Count - 1 do
  begin
    item := FFlagList[i];
    item.Draw(FCanvas);
  end;
end;

function TFlagPointbContainer.GetFlagPoint(FlagPointId: Integer): TFlagPoint;
var
  i : Integer;
  item : TFlagPoint;
begin
  Result := nil;
  for i := 0 to FFlagList.Count - 1 do
  begin
    item := FFlagList[i];

    if item.PointId = FlagPointId then
    begin
      Result := item;
      Exit;
    end;
  end;
end;

{$ENDREGION}

{$REGION ' TRuler '}

constructor TRuler.Create(cvt: TCoordConverter);
begin
  FConverter := cvt;
end;

destructor TRuler.Destroy;
begin

  inherited;
end;

procedure TRuler.Draw(FCanvas: TCanvas);
begin
  inherited;

end;

{$ENDREGION}

{$REGION ' TAsset '}

constructor TAsset.Create;
begin

end;

destructor TAsset.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION ' TFontTaktis '}

constructor TFontTaktis.Create;
begin

end;

destructor TFontTaktis.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{ TPlatformShape }

constructor TPlatformShape.Create(cvt: TCoordConverter);
begin
  inherited;
end;

destructor TPlatformShape.Destroy;
begin

  inherited;
end;

procedure TPlatformShape.Draw(FCanvas: TCanvas);
var
  cx, cy: Integer;
begin
  inherited;

  SetTempHuruf(FCanvas.Font, 0);

  with FCanvas do
  begin
    Converter.ConvertToScreen(postCenter.X, postCenter.Y, cx, cy);

    Brush.Style := bsClear;

    Font.Color := ShapeOutline;
    Font.Size := 14;

    if isSelected then
     Font.Color  := clWhite;

    SetStyleHuruf(FCanvas, fsBold, 20, ShapeOutline, 'TAKTIS_AL');
    TextOut(cx, cy,simbol);

    Font := SetTempHuruf(Font, 1);
  end;
end;

end.
