unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TfrmMain = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

   uses Horse,
        horse.jhonson,
         Horse.CORS,
        Horse.BasicAuthentication,

        uController.Usuario,
        uController.Tarefas,


        uModel.Usuario;

{$R *.fmx}

procedure TfrmMain.FormShow(Sender: TObject);
begin
  THorse.Use(Jhonson());
  THorse.Use(Cors);

  { Basic Autentication }
    THorse.Use(HorseBasicAuthentication(
    function(const AUsername, APassword: string): Boolean
    begin
      Result := AUsername.Equals('DiegoRibas') and APassword.Equals('2222ribas');
    end));

  uController.Usuario.Registry; { =>  Registro das rotas de usuário  }
  uController.Tarefas.Registry; { =>   Registro de rotas tarefas      }


  THorse.Listen(9000);
end;

end.
