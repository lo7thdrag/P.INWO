unit ufrmBombOnBoardPickList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Vcl.Imaging.pngimage,

  uDBAsset_Weapon, uClassData, uSimContainers;

type
  TfrmBombOnBoardPickList = class(TForm)
    lbAllBombDef: TListBox;
    lbAllBombOnBoard: TListBox;
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
    lblClose: TLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure lbAllBombDefClick(Sender: TObject);
    procedure lbAllBombOnBoardClick(Sender: TObject);

    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);


  private
    FAllBombDefList : TList;
    FAllBombOnBoardList : TList;

    FSelectedVehicle : TAsset;
    FSelectedBomb : TBomb_On_Board;

    procedure UpdateBombList;

  public
    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;
  end;

var
  frmBombOnBoardPickList: TfrmBombOnBoardPickList;

implementation

uses
  uDataModule, ufrmBombMount;

{$R *.dfm}

{$REGION ' Form Handle '}

procedure TfrmBombOnBoardPickList.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  FreeItemsAndFreeList(FAllBombDefList);
  FreeItemsAndFreeList(FAllBombOnBoardList);
  Action := cafree;
end;

procedure TfrmBombOnBoardPickList.FormCreate(Sender: TObject);
begin
  FAllBombDefList := TList.Create;
  FAllBombOnBoardList := TList.Create;
end;

procedure TfrmBombOnBoardPickList.FormShow(Sender: TObject);
begin
  UpdateBombList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmBombOnBoardPickList.btnAddClick(Sender: TObject);
begin
  if lbAllBombDef.ItemIndex = -1 then
    Exit;

  if not Assigned(frmBombMount) then
    frmBombMount := TfrmBombMount.Create(Self);
  try
    with frmBombMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedBomb := FSelectedBomb;
      Show;
    end;
  finally
  end;

//  UpdateBombList;
end;

procedure TfrmBombOnBoardPickList.btnEditClick(Sender: TObject);
begin
  if lbAllBombOnBoard.ItemIndex = -1 then
    Exit;

  if not Assigned(frmBombMount) then
    frmBombMount := TfrmBombMount.Create(Self);
  try
    with frmBombMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedBomb := FSelectedBomb;
      Show;
    end;
  finally
  end;

//  UpdateBombList;
end;

procedure TfrmBombOnBoardPickList.btnRemoveClick(Sender: TObject);
begin
  if lbAllBombOnBoard.ItemIndex = -1 then
    Exit;

  with FSelectedBomb.FData do
  begin
    dmINWO.DeletePointEffectOnBoard(2, Point_Effect_Index);
  end;

//  UpdateBombList;
end;

procedure TfrmBombOnBoardPickList.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmBombOnBoardPickList.lbAllBombDefClick(Sender: TObject);
begin
  if lbAllBombDef.ItemIndex = -1 then
    Exit;

  FSelectedBomb := TBomb_On_Board(lbAllBombDef.Items.Objects[lbAllBombDef.ItemIndex]);
end;

procedure TfrmBombOnBoardPickList.lbAllBombOnBoardClick(Sender: TObject);
begin
  if lbAllBombOnBoard.ItemIndex = -1 then
    Exit;

  FSelectedBomb := TBomb_On_Board(lbAllBombOnBoard.Items.Objects[lbAllBombOnBoard.ItemIndex]);
end;

procedure TfrmBombOnBoardPickList.UpdateBombList;
var
  i : Integer;
  bomb :  TBomb_On_Board;
begin
  lbAllBombDef.Items.Clear;
  lbAllBombOnBoard.Items.Clear;

  dmINWO.GetAllBombDef(FAllBombDefList);
  dmINWO.GetBombOnBoard(FSelectedVehicle.FData.VehicleIndex,FAllBombOnBoardList);

  for i := 0 to FAllBombDefList.Count - 1 do
  begin
    bomb := FAllBombDefList.Items[i];
    lbAllBombDef.Items.AddObject(bomb.FDef.Bomb_Identifier, bomb);
  end;

  for i := 0 to FAllBombOnBoardList.Count - 1 do
  begin
    bomb := FAllBombOnBoardList.Items[i];
    lbAllBombOnBoard.Items.AddObject(bomb.FData.Instance_Identifier, bomb);
  end;
end;

{$ENDREGION}

end.
