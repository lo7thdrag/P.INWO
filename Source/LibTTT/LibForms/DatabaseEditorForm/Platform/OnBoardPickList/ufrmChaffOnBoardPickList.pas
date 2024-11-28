unit ufrmChaffOnBoardPickList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Vcl.Imaging.pngimage,

  uClassData, uDBAsset_Countermeasure, uSimContainers;

type
  TfrmChaffOnBoardPickList = class(TForm)
    lbAllChaffDef: TListBox;
    lbAllChaffOnBoard: TListBox;
    btnAdd: TImage;
    btnEdit: TImage;
    btnRemove: TImage;
    ImgBackgroundAvailable: TImage;
    ImgBackgroundForm: TImage;
    ImgBackgroundOnBoard: TImage;
    ImgHeaderAvailable: TImage;
    ImgHeaderOnBoard: TImage;
    Label2: TLabel;
    Label3: TLabel;
    lblClose: TLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure lbAlChaffDefClick(Sender: TObject);
    procedure lbAllChaffOnBoardClick(Sender: TObject);

    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);


  private
    FAllChaffDefList : TList;
    FAllChaffOnBoardList : TList;

    FSelectedVehicle : TAsset;
    FSelectedChaff : TChaff_On_Board;

  public
    procedure UpdateChaffList;

    property SelectedVehicle : TAsset read FSelectedVehicle write FSelectedVehicle;

  end;

var
  frmChaffOnBoardPickList: TfrmChaffOnBoardPickList;

implementation

uses
  uDataModule, ufrmChaffMount;

{$R *.dfm}


{$REGION ' Form Handle '}

procedure TfrmChaffOnBoardPickList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  FreeItemsAndFreeList(FAllChaffDefList);
//  FreeItemsAndFreeList(FAllChaffOnBoardList);
//  Action := cafree;
end;

procedure TfrmChaffOnBoardPickList.FormCreate(Sender: TObject);
begin
  FAllChaffDefList := TList.Create;
  FAllChaffOnBoardList := TList.Create;
end;

procedure TfrmChaffOnBoardPickList.FormShow(Sender: TObject);
begin
  UpdateChaffList;
end;

{$ENDREGION}

{$REGION ' Button Handle '}

procedure TfrmChaffOnBoardPickList.btnAddClick(Sender: TObject);
begin
  if lbAllChaffDef.ItemIndex = -1 then
    Exit;

  if not Assigned(frmChaffMount) then
    frmChaffMount := TfrmChaffMount.Create(Self);

  try
    with frmChaffMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedChaff := FSelectedChaff;
      Show;
    end;
  finally
  end;
end;

procedure TfrmChaffOnBoardPickList.btnEditClick(Sender: TObject);
begin
  if lbAllChaffOnBoard.ItemIndex = -1 then
    Exit;

  if not Assigned(frmChaffMount) then
    frmChaffMount := TfrmChaffMount.Create(Self);

  try
    with frmChaffMount do
    begin
      SelectedVehicle := FSelectedVehicle;
      SelectedChaff := FSelectedChaff;
      Show;
    end;
  finally
  end;

//  UpdateChaffList;
end;

procedure TfrmChaffOnBoardPickList.btnRemoveClick(Sender: TObject);
begin
  if lbAllChaffOnBoard.ItemIndex = -1 then
    Exit;

  with FSelectedChaff.FData do
  begin
    dmINWO.DeleteChaffOnBoard(2, Chaff_Instance_Index);
  end;
  UpdateChaffList;
end;

procedure TfrmChaffOnBoardPickList.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmChaffOnBoardPickList.lbAlChaffDefClick(Sender: TObject);
begin
  if lbAllChaffDef.ItemIndex = -1 then
    Exit;

  FSelectedChaff := TChaff_On_Board(lbAllChaffDef.Items.Objects[lbAllChaffDef.ItemIndex]);
end;

procedure TfrmChaffOnBoardPickList.lbAllChaffOnBoardClick(Sender: TObject);
begin
  if lbAllChaffOnBoard.ItemIndex = -1 then
    Exit;

  FSelectedChaff := TChaff_On_Board(lbAllChaffOnBoard.Items.Objects[lbAllChaffOnBoard.ItemIndex]);
end;

procedure TfrmChaffOnBoardPickList.UpdateChaffList;
var
  i : Integer;
  chaff : TChaff_On_Board;
begin
  lbAllChaffDef.Items.Clear;
  lbAllChaffOnBoard.Items.Clear;

  dmINWO.GetAllChaffDef(FAllChaffDefList);
  dmINWO.GetChaffOnBoard(FSelectedVehicle.FData.VehicleIndex,FAllChaffOnBoardList);

  for i := 0 to FAllChaffDefList.Count - 1 do
  begin
    chaff := FAllChaffDefList.Items[i];
    lbAllChaffDef.Items.AddObject(chaff.FDef.Chaff_Identifier, chaff);
  end;

  for i := 0 to FAllChaffOnBoardList.Count - 1 do
  begin
    chaff := FAllChaffOnBoardList.Items[i];
    lbAllChaffOnBoard.Items.AddObject(chaff.FData.Instance_Identifier, chaff);
  end;
end;

{$ENDREGION}

end.
