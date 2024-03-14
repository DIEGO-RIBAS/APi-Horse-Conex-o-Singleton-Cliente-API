unit uView.Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Buttons, dxGDIPlusClasses,
  uController.Login;

type
  TfrmLogin = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    btnEntrar: TSpeedButton;
    BtnSair: TSpeedButton;
    edtLogin: TEdit;
    Label1: TLabel;
    edtPassWord: TEdit;
    Label2: TLabel;
    Image1: TImage;
    Label3: TLabel;
    LblAguarde: TLabel;
    Label4: TLabel;
    procedure BtnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEntrarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    idUsuario : Integer;
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

procedure TfrmLogin.btnEntrarClick(Sender: TObject);
var
  ControllerLogin : TControllerLogin;
begin
  idUsuario := 0;

  if ((edtLogin.Text <> '') or (edtPassWord.Text <> '')) then
  begin
    LblAguarde.Caption := 'Aguiarde...';
    Repaint;

    ControllerLogin := TControllerLogin.Create;
    try
      ControllerLogin.Longin := edtLogin.Text;
      ControllerLogin.Pass   := edtPassWord.Text;
      idUsuario := ControllerLogin.ValidaUsuario;
    finally
      FreeAndNil(ControllerLogin);
    end;

    LblAguarde.Caption := '';

    { Usu�rio n�o localizado }
    if idUsuario = 0 then
      Exit;
  end;

  Close;
end;

procedure TfrmLogin.BtnSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  edtLogin.SetFocus;
end;

end.
