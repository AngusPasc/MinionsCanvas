unit MAIN;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, ComCtrls, StdActns,
  ActnList, ToolWin, ImgList, GR32_Image, icLayerPanelManager,
  icLayersListBox, GR32_RangeBars, icBase;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileCloseItem: TMenuItem;
    Window1: TMenuItem;
    Help1: TMenuItem;
    N1: TMenuItem;
    FileExitItem: TMenuItem;
    WindowCascadeItem: TMenuItem;
    WindowTileItem: TMenuItem;
    WindowArrangeItem: TMenuItem;
    HelpAboutItem: TMenuItem;
    OpenDialog: TOpenDialog;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    Edit1: TMenuItem;
    CutItem: TMenuItem;
    CopyItem: TMenuItem;
    PasteItem: TMenuItem;
    WindowMinimizeItem: TMenuItem;
    StatusBar: TStatusBar;
    ActionList1: TActionList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    FileNew1: TAction;
    FileSave1: TAction;
    FileExit1: TAction;
    FileOpen1: TAction;
    FileSaveAs1: TAction;
    WindowCascade1: TWindowCascade;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowArrangeAll1: TWindowArrange;
    WindowMinimizeAll1: TWindowMinimizeAll;
    HelpAbout1: TAction;
    FileClose1: TWindowClose;
    WindowTileVertical1: TWindowTileVertical;
    WindowTileItem2: TMenuItem;
    ToolBar2: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton9: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ImageList1: TImageList;
    pnlLayer: TPanel;
    tlbrLayers: TToolBar;
    tlbnSeparator1: TToolButton;
    tlbtnNewFillAdjustmentLayer: TToolButton;
    tlbrAddMask: TToolButton;
    btnLayer_New: TToolButton;
    btnLayer_Delete: TToolButton;
    actTool_Brush: TAction;
    actTool_Pencil: TAction;
    ToolButton13: TToolButton;
    btnTool_Brush: TToolButton;
    btnTool_Pencil: TToolButton;
    actLayer_New: TAction;
    actLayer_Delete: TAction;
    tlbrBlendModes: TToolBar;
    tlbnSeparator2: TToolButton;
    cmbbxBlendModes: TComboBox;
    tlbrLayerOpacity: TToolBar;
    ToolButton12: TToolButton;
    ggbrLayerOpacity: TGaugeBar;
    edtLayerOpacity: TEdit;
    lblLayerOpacity: TLabel;
    actUndo: TAction;
    actRedo: TAction;
    btn1: TToolButton;
    btnUndo: TToolButton;
    btnRedo: TToolButton;
    spl1: TSplitter;
    pmUndo: TPopupMenu;
    pmRedo: TPopupMenu;
    lyrs1: TicLayersListBox;
    igAgent1: TicAgent;
    lbName: TLabel;
    actUndo1: TMenuItem;
    actRedo1: TMenuItem;
    N2: TMenuItem;
    btnLCD: TToolButton;
    actTool_LcdPen: TAction;
    pnlZoom: TPanel;
    gbrZoom: TGaugeBar;
    btnLine: TToolButton;
    actTool_LcdLine: TAction;
    dlgSave1: TSaveDialog;
    actLCD_invert: TAction;
    btnInvert: TToolButton;
    ToolButton14: TToolButton;
    actLCD_SwapColor: TAction;
    btnSwapCOlor: TToolButton;
    actTool_LcdFloodfill: TAction;
    btnFloodFill: TToolButton;
    procedure FileNew1Execute(Sender: TObject);
    procedure FileOpen1Execute(Sender: TObject);
    procedure HelpAbout1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure btnLayer_NewClick(Sender: TObject);
    procedure actTool_BrushExecute(Sender: TObject);
    procedure actTool_PencilExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EnabledWhenMDIavailabled(Sender: TObject);
    procedure actLayer_DeleteExecute(Sender: TObject);
    procedure actUndoExecute(Sender: TObject);
    procedure actRedoExecute(Sender: TObject);
    procedure actUndoUpdate(Sender: TObject);
    procedure actRedoUpdate(Sender: TObject);
    procedure pmUndoPopup(Sender: TObject);
    procedure pmRedoPopup(Sender: TObject);
    procedure igAgent1SelectionChange(Sender: TObject);
    procedure cmbbxBlendModesChange(Sender: TObject);
    procedure ggbrLayerOpacityUserChange(Sender: TObject);
    procedure actTool_LcdPenExecute(Sender: TObject);
    procedure actTool_LcdLineExecute(Sender: TObject);
    procedure FileSave1Execute(Sender: TObject);
    procedure actLCD_invertExecute(Sender: TObject);
    procedure actLCD_SwapColorExecute(Sender: TObject);
    procedure actTool_LcdFloodfillExecute(Sender: TObject);
  private
    { Private declarations }
    procedure CreateMDIChild(const Name: string);
  public
    { Public declarations }
    procedure UndoPopupClick(Sender : TObject);
    procedure RedoPopupClick(Sender : TObject);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses CHILDWIN, about,
  GR32_Add_BlendModes,
  icComboboxBlendModes,
  icLayers, icLiquidCrystal,
  icTool_BrushSimple,
  icTool_PencilSimple,
  icTool_LcdPen, icTool_LcdLine, icTool_LcdFloodfill;

type TicCustomLayerPanelAccess = class(TicBitmapLayer);
  
procedure TMainForm.CreateMDIChild(const Name: string);
var
  Child: TMDIChild;
begin
  { create a new MDI child window }
  Child := TMDIChild.Create(Application);
  Child.Caption := ExtractFileName(Name);
  if FileExists(Name) then Child.LoadDocument(Name);
end;

procedure TMainForm.FileNew1Execute(Sender: TObject);
begin
  CreateMDIChild(NONAME + IntToStr(MDIChildCount + 1));
end;

procedure TMainForm.FileOpen1Execute(Sender: TObject);
begin
  if OpenDialog.Execute then
    CreateMDIChild(OpenDialog.FileName);
end;

procedure TMainForm.HelpAbout1Execute(Sender: TObject);
begin

  AboutBox.ShowModal;
end;

procedure TMainForm.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.btnLayer_NewClick(Sender: TObject);
var
  LLayerPanel : TicBitmapLayer;
  LPanelIndex : Integer;
var cmd : TicCmdLayer_New;
begin
  if not Assigned(GIntegrator.ActivePaintBox) then
    Exit;

  Screen.Cursor := crHourGlass;
  try
    //with gActiveChildForm do
    begin
      Randomize;

      //LLayerPanel := CreateNormalLayer( $FF000000 or Cardinal(Random($FFFFFF)), False );
      //LLayerPanel := TicNormalLayerPanel.Create(GIntegrator.ActivePaintBox.LayerList); //error access violation
      LLayerPanel := TicNormalLayerPanel.Create(nil);
      LLayerPanel.BeginUpdate;
      with GIntegrator.ActivePaintBox.Bitmap do
      LLayerPanel.LayerBitmap.SetSize(Width,height);
      LLayerPanel.LayerBitmap.Clear($FF000000 or Cardinal(Random($FFFFFF)));
      //LLayerPanel.UpdateLayerThumbnail;
      LLayerPanel.EndUpdate;

      LPanelIndex := GIntegrator.ActivePaintBox.SelectedLayer.Index + 1;

      //GIntegrator.ActivePaintBox.LayerList.Insert(LPanelIndex, LLayerPanel);
      LLayerPanel.Index := LPanelIndex;

      cmd := TicCmdLayer_New.Create(GIntegrator.ActivePaintBox.UndoRedo);
      cmd.ChangedLayer(LLayerPanel);
      GIntegrator.ActivePaintBox.UndoRedo.AddUndo(cmd,'New Layer');

    end;
  finally
    Screen.Cursor := crDefault;
  end;

end;

procedure TMainForm.actTool_BrushExecute(Sender: TObject);
begin
  //set a drawing tool for mouse operation's response.
  actTool_Brush.Checked := GIntegrator.ActivateTool(TicToolBrushSimple);
end;

procedure TMainForm.actTool_PencilExecute(Sender: TObject);
begin
  actTool_Pencil.Checked := GIntegrator.ActivateTool(TicToolPencilSimple);
end;



procedure TMainForm.actTool_LcdPenExecute(Sender: TObject);
begin
  //set a drawing tool for mouse operation's response.
  actTool_LcdPen.Checked := GIntegrator.ActivateTool(TicToolLcdPen);
end;

procedure TMainForm.actTool_LcdLineExecute(Sender: TObject);
begin
  actTool_LcdLine.Checked := GIntegrator.ActivateTool(TicToolLcdLine);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  //actTool_Pencil.Execute(); failed
  GetBlendModeList(cmbbxBlendModes.Items);
  self.actTool_PencilExecute(self);
  self.actTool_BrushExecute(self);
  Self.actTool_LcdLineExecute(Self);

end;

procedure TMainForm.EnabledWhenMDIavailabled(Sender: TObject);
begin
  TAction(Sender).Enabled := MDIChildCount > 0;
end;

procedure TMainForm.actLayer_DeleteExecute(Sender: TObject);
var cmd : TicCmdLayer_Delete;
begin
  if not Assigned(GIntegrator.ActivePaintBox) then
    Exit;
    cmd := TicCmdLayer_Delete.Create(GIntegrator.ActivePaintBox.UndoRedo);
    cmd.ChangingLayer(GIntegrator.ActivePaintBox.SelectedLayer); //save
    //GIntegrator.ActivePaintBox.LayerList.DeleteSelectedLayerPanel;
    cmd.Play; //delete
    GIntegrator.ActivePaintBox.UndoRedo.AddUndo(cmd,'Delete Layer');
end;

procedure TMainForm.actUndoExecute(Sender: TObject);
begin
  if not Assigned(GIntegrator.ActivePaintBox) then Exit;
  GIntegrator.ActivePaintBox.UndoRedo.Undo;
end;

procedure TMainForm.actRedoExecute(Sender: TObject);
begin
  if not Assigned(GIntegrator.ActivePaintBox) then Exit;
  GIntegrator.ActivePaintBox.UndoRedo.Redo;
end;

procedure TMainForm.actUndoUpdate(Sender: TObject);
var LCaption : string;
  LEnabled : Boolean;
begin
  LCaption := 'Undo';
  LEnabled := False;
  if Assigned(GIntegrator.ActivePaintBox) then
    with GIntegrator.ActivePaintBox.UndoRedo do

      if IsUndoAllowed then
      begin
        LCaption := 'Undo '+Strings[ItemIndex];
        LEnabled := True;
      end;

  if actUndo.Caption <> LCaption then //avoid flicker
    actUndo.Caption := LCaption;
  actUndo.Enabled := LEnabled;
end;

procedure TMainForm.actRedoUpdate(Sender: TObject);
var LCaption : string;
  LEnabled : Boolean;
begin
  LCaption := 'Redo';
  LEnabled := False;
  if Assigned(GIntegrator.ActivePaintBox) then
    with GIntegrator.ActivePaintBox.UndoRedo do

      if IsRedoAllowed then
      begin
        LCaption := 'Redo '+Strings[ItemIndex+1];
        LEnabled := True;
      end;

  if actRedo.Caption <> LCaption then //avoid flicker
    actRedo.Caption := LCaption;
  actRedo.Enabled := LEnabled;

end;

procedure TMainForm.pmUndoPopup(Sender: TObject);
var i : Integer;
  m : TMenuItem;
begin
  pmUndo.Items.Clear;
  if not Assigned(GIntegrator.ActivePaintBox) then Exit;
  with GIntegrator.ActivePaintBox.UndoRedo do
  begin
    for i := ItemIndex downto 0 do
    begin
      m := TMenuItem.Create(pmUndo);
      m.Caption := 'Undo '+Strings[i];
      m.Tag := i;
      m.OnClick := UndoPopupClick; 
      pmundo.Items.Add(m);
    end;
  end;
end;

procedure TMainForm.UndoPopupClick(Sender: TObject);
begin
  if not Assigned(GIntegrator.ActivePaintBox) then Exit;
    GIntegrator.ActivePaintBox.UndoRedo.UndoTo(TMenuItem(Sender).Tag);
end;

procedure TMainForm.RedoPopupClick(Sender: TObject);
begin
  if not Assigned(GIntegrator.ActivePaintBox) then Exit;
    GIntegrator.ActivePaintBox.UndoRedo.RedoTo(TMenuItem(Sender).Tag);
end;

procedure TMainForm.pmRedoPopup(Sender: TObject);
var i : Integer;
  m : TMenuItem;
begin
  pmRedo.Items.Clear;
  if not Assigned(GIntegrator.ActivePaintBox) then Exit;
  with GIntegrator.ActivePaintBox.UndoRedo do
  begin
    for i := ItemIndex +1 to Count -1 do
    begin
      m := TMenuItem.Create(pmRedo);
      m.Caption := 'Redo '+Strings[i];
      m.Tag := i;
      m.OnClick := RedoPopupClick;
      pmRedo.Items.Add(m);
    end;
  end;
end;

procedure TMainForm.igAgent1SelectionChange(Sender: TObject);
var LLayer : TicBitmapLayer;
begin
{  if assigned(GIntegrator.ActivePaintBox) then
  begin
    LLayer := GIntegrator.ActivePaintBox.SelectedLayer as TicBitmapLayer;
    if assigned(LLayer) then
    begin
      lbName.Caption := llayer.DisplayName;
      if LLayer is TicBitmapLayer then
      begin

        cmbbxBlendModes.ItemIndex :=  ord(LLayer.LayerBlendMode);
        ggbrLayerOpacity.Position :=  LLayer.LayerOpacity;
      end;
    end;
  end;}
end;

procedure TMainForm.cmbbxBlendModesChange(Sender: TObject);
var LLayer : TicBitmapLayer;
begin
{  if assigned(GIntegrator.ActivePaintBox) then
  begin
    LLayer := GIntegrator.ActivePaintBox.SelectedLayer as TicBitmapLayer;
    if assigned(LLayer) then
    begin
      if LLayer is TicBitmapLayer then
      begin
        LLayer.LayerBlendMode := TBlendMode32(cmbbxBlendModes.ItemIndex);
      end;
    end;
  end;
}
end;

procedure TMainForm.ggbrLayerOpacityUserChange(Sender: TObject);
var LLayer : TicBitmapLayer;
begin
{  if assigned(GIntegrator.ActivePaintBox) then
  begin
    LLayer := GIntegrator.ActivePaintBox.SelectedLayer as TicBitmapLayer;
    if assigned(LLayer) then
    begin
      if LLayer is TicBitmapLayer then
      begin
        LLayer.LayerOpacity := ggbrLayerOpacity.Position;
      end;
    end;
  end;}
end;




procedure TMainForm.FileSave1Execute(Sender: TObject);
var P : TPicture;
begin
  p := TPicture.Create;
  //p.SaveToFile();
  if assigned(GIntegrator.ActivePaintBox) and dlgSave1.Execute then
  begin
    GIntegrator.ActivePaintBox.Bitmap.SaveToFile( dlgSave1.FileName );
  end;
end;

procedure TMainForm.actLCD_invertExecute(Sender: TObject);
var i : Integer;
begin
  if not Assigned(GIntegrator.ActivePaintBox) then Exit;
  with GIntegrator.ActivePaintBox.Layers do
  begin
    for i := 0 to Count -1 do
      if Items[i] is TicLiquidCrystal then
      begin
        TicLiquidCrystal(Items[i]).Invert;
        TicLiquidCrystal(Items[i]).Changed;
        Break;
      end;
  end;
end;

procedure TMainForm.actLCD_SwapColorExecute(Sender: TObject);
var i : Integer;
begin
  if not Assigned(GIntegrator.ActivePaintBox) then Exit;
  with GIntegrator.ActivePaintBox.Layers do
  begin
    for i := 0 to Count -1 do
      if Items[i] is TicLiquidCrystal then
      begin
        TicLiquidCrystal(Items[i]).SwapColor;
        //TicLiquidCrystal(LayerPanels[i]).Changed;
        Break;
      end;
  end;
end;

procedure TMainForm.actTool_LcdFloodfillExecute(Sender: TObject);
begin
  actTool_LcdFloodfill.Checked := GIntegrator.ActivateTool(TicToolLcdFloodfill);
end;

end.
