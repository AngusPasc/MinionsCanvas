unit CHILDWIN;

interface

uses Windows, Classes, Graphics, Forms, Controls, StdCtrls, GR32, GR32_Image,
  icBase;

type
  TMDIChild = class(TForm)
    img1: TicPaintBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    //property DocumentName : string read DocumentName
    procedure LoadDocument(AFileName : string);
  end;

implementation

uses
  icLayers, jpeg;

{$R *.dfm}

procedure TMDIChild.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TMDIChild.FormActivate(Sender: TObject);
begin
  img1.SetFocus(); //I dont know how to delete this line :(
end;

procedure TMDIChild.LoadDocument(AFileName: string);
var P : TPicture;
begin
  p := TPicture.Create;
  p.LoadFromFile(AFileName);
  ///with TicNormalLayerPanel(img1.LayerList.LayerPanels[0]) do
  with TicNormalLayerPanel(img1.Layers[0]) do
  begin

    //LayerBitmap.LoadFromFile(AFileName);
    LayerBitmap.Assign(p);
    img1.Bitmap.SetSizeFrom(LayerBitmap);
    ///img1.LayerList.CombineResult.SetSizeFrom(img1.Bitmap);
    Changed;
  end;
end;

procedure TMDIChild.FormCreate(Sender: TObject);
var
  LLayerPanel :  TicNormalLayerPanel;
begin
    LLayerPanel :=  TicNormalLayerPanel.Create(img1.Layers);
    LLayerPanel.IsAsBackground := True;
    //LLayerPanel.SetBounds( FloatRect( img1.Bitmap.BoundsRect) );
    LLayerPanel.LayerBitmap.SetSize(  img1.Bitmap.Width, img1.Bitmap.Height);
    LLayerPanel.LayerBitmap.Clear(clWhite32);
    LLayerPanel.SetBounds( FloatRect( LLayerPanel.LayerBitmap.BoundsRect) );
    //LLayerPanel.UpdateLayerThumbnail;
    //TicNormalLayerPanel(LLayerPanel).IsAsBackground := True;
    img1.SelectedLayer := LLayerPanel;
    //img1.LayerList.Add(LLayerPanel);

end;

end.
