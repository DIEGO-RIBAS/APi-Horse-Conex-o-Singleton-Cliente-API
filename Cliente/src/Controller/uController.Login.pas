unit uController.Login;

interface

  uses System.SysUtils, System.JSON, Vcl.Dialogs,  System.Variants, System.Classes, Vcl.Graphics,
       Vcl.Controls, Vcl.Forms,
       uModel.Login;

  type

    TControllerLogin = class
      private
        FLogin: string;
        FPass: string;

      public
        property  Longin : string read FLogin write FLogin;
        property  Pass   : string read FPass  write FPass;

        function ValidaUsuario : Integer;

        constructor Create;
        destructor Destroy;
    end;

implementation

{ TControllerLogin }

constructor TControllerLogin.Create;
begin

end;

destructor TControllerLogin.Destroy;
begin

end;

function TControllerLogin.ValidaUsuario: Integer;
var
  ModelLogin    : TModelLogin;
  JsonReturnAPI : TJSONObject;
  APIComErro    : Boolean;
  MensagemErro  : string;

  function ValidaCampos(ALogin, APass : String):Boolean;
  begin
    Result := false;

    if ALogin = '' then
    begin
      ShowMessage('LOGIN deve ser informado !');
      Exit;
    end;

    if APass = '' then
    begin
      ShowMessage('SENHA deve ser informada !');
      Exit;
    end;

    Result := True;
  end;
begin
  if not ValidaCampos(FLogin,FPass) then
    Exit;

  { Result = id do usu�rio }
  Result := 0;

  ModelLogin := TModelLogin.create;
  try
    ModelLogin.Longin := FLogin;
    ModelLogin.Pass   := FPass;

    try
      JsonReturnAPI := ModelLogin.Validar; {=> Pega o Json retornado pela api }

      if JsonReturnAPI <> nil then
      begin
        APIComErro := StrToBool(JsonReturnAPI.GetValue('Erro').Value);

        { Retorno de erro na api }
        if APIComErro then
        begin
          MensagemErro := JsonReturnAPI.GetValue('Mensagem').Value;
          ShowMessage(PChar(MensagemErro));
        end
          else
          begin
            Result := StrToInt(JsonReturnAPI.GetValue('Usuario').Value);

            { Se result = 0 ent�o n�o encontreou usu�rio com este login e senha }
            if Result = 0 then
            begin
              ShowMessage('Usu�rio n�o localizado !');
            end;
          end;

      end;
    finally
      FreeAndNil(JsonReturnAPI);
    end;
  finally
    FreeAndNil(ModelLogin);
  end;
end;

end.
