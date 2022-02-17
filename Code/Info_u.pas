unit Info_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.GIFImg,
  Vcl.ExtCtrls, System.ImageList, Vcl.ImgList;

type
  TInfoForm = class(TForm)
    Image1: TImage;
    Label2: TLabel;
    Label3: TLabel;
    btnOK: TButton;
    Label1: TLabel;
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InfoForm: TInfoForm;

implementation

{$R *.dfm}

procedure TInfoForm.btnOKClick(Sender: TObject);
begin
  Close;
end;

procedure TInfoForm.FormCreate(Sender: TObject);
begin
 (Image1.Picture.Graphic as TGIFImage).Animate := true;
end;

end.
