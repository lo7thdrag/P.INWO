unit ufrmTorpedoOnBoardPickList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Vcl.Imaging.pngimage,

  uDBAsset_Weapon, uClassData, uSimContainers;

type
  TfrmTorpedoOnBoardPickList = class(TForm)
    lbAllTorpedoDef: TListBox;
    lbTorpedoOnBoard: TListBox;
    btnAdd: TImage;
    btnEdit: TImage;
    btnRemove: TImage;
    ImgBackgroundAvailable: TImage;
    ImgBackgroundForm: TImage;
    ImgBackgroundOnBoard: TImage;
    ImgHeaderAvailable: TImage;
    ImgHeaderOnBoard: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblClose: TLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure lbAllTorpedoDefClick(Sender: TObject);
    procedure lbAllTorpedoOnBoardClick(Sender: TObject);

    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);


  private
    FAllTorpedoDefList : TList;
    FAllTorpedoOnBoardList : TList;

    FSelectedVehicle : TAsset;
    FSelectedTorpedo : TTorpedo_On_Board;

  public
    procedure UpdateTorpedoList;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
  end;

var
  frmTorpedoOnBoardPickList: TfrmTorpedoOnBoardPickList;

implementation

uses
  uDataModule, ufrmTorpedoMount, ufrmAsset;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmTorpedoOnBoardPickList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  FreeItemsAndFreeList(FAllTorpedoDefList);
//  FreeItemsAndFreeList(FAllTorpedoOnBoardList);
//  Action := cafree;
end;

procedure TfrmTorpedoOnBoardPickList.FormCreate(Sender: TObject);
begin
  FAllTorpedoDefList := TList.Create;
  FAllTorpedoOnBoardList := TList.Create;
end;

procedure TfrmTorpedoOnBoardPickList.FormShow(Sender: TObject);
begin
  UpdateTorpedoList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmTorpedoOnBoardPickList.btnAddClick(Sender: TObject);
begin
  if lbAllTorpedoDef.ItemIndex = -1 then
    Exit;

  if not Assigned(frmTorpedoMount) then
    frmTorpedoMount := TfrmTorpedoMount.Create(Self);
  try
    with frmTorpedoMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedTorpedo := FSelectedTorpedo;
      Show;
    end;
  finally
  end;

//  UpdateTorpedoList;
end;

procedure TfrmTorpedoOnBoardPickList.btnEditClick(Sender: TObject);
begin
  if lbTorpedoOnBoard.ItemIndex = -1 then
    Exit;

  if not Assigned(frmTorpedoMount) then
    frmTorpedoMount := TfrmTorpedoMount.Create(Self);
  try
    with frmTorpedoMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedTorpedo := FSelectedTorpedo;
      Show;
    end;
  finally
  end;

//  UpdateTorpedoList;
end;

procedure TfrmTorpedoOnBoardPickList.btnRemoveClick(Sender: TObject);
begin
  if lbTorpedoOnBoard.ItemIndex = -1 then
    Exit;

  with FSelectedTorpedo.FData do
  begin
//    dmINWO.DeleteFittedWeaponLauncherOnBoard(2, Fitted_Weap_Index);
    dmINWO.DeleteFittedWeaponOnBoard(2, Fitted_Weap_Index);
  end;

  UpdateTorpedoList;
end;

procedure TfrmTorpedoOnBoardPickList.btnCloseClick(Sender: TObject);
begin
  frmAsset.UpdateWeaponData;
  Close;
end;

procedure TfrmTorpedoOnBoardPickList.lbAllTorpedoDefClick(Sender: TObject);
begin
  if lbAllTorpedoDef.ItemIndex = -1 then
    Exit;

  FSelectedTorpedo := TTorpedo_On_Board(lbAllTorpedoDef.Items.Objects[lbAllTorpedoDef.ItemIndex]);
end;

procedure TfrmTorpedoOnBoardPickList.lbAllTorpedoOnBoardClick(Sender: TObject);
begin
  if lbTorpedoOnBoard.ItemIndex = -1 then
    Exit;

  FSelectedTorpedo := TTorpedo_On_Board(lbTorpedoOnBoard.Items.Objects[lbTorpedoOnBoard.ItemIndex]);
end;

procedure TfrmTorpedoOnBoardPickList.UpdateTorpedoList;
var
  i : Integer;
  torpedo : TTorpedo_On_Board;
begin
  lbAllTorpedoDef.Items.Clear;
  lbTorpedoOnBoard.Items.Clear;

  dmINWO.GetAllTorpedoDef(FAllTorpedoDefList);
  dmINWO.GetTorpedoOnBoard(FSelectedVehicle.FData.VehicleIndex,FAllTorpedoOnBoardList);

  for i := 0 to FAllTorpedoDefList.Count - 1 do
  begin
    torpedo := FAllTorpedoDefList.Items[i];
    lbAllTorpedoDef.Items.AddObject(torpedo.FDef.Class_Identifier, torpedo);
  end;

  for i := 0 to FAllTorpedoOnBoardList.Count - 1 do
  begin
    torpedo := FAllTorpedoOnBoardList.Items[i];
    lbTorpedoOnBoard.Items.AddObject(torpedo.FData.Instance_Identifier, torpedo);
  end;
end;

{$ENDREGION}

end.
