unit uController.Usuario;

interface

  uses Vcl.Dialogs, System.SysUtils, System.JSON,
       uEntitity.Usuario,
       uModel.Usuario,

       system.Classes;

  type
  TControllerUsuario = class
    private
      FUsuario: TEntityUsuario;

    public
      property EntityUsuario : TEntityUsuario read FUsuario  write FUsuario ;

      function Gravausuario(AEntityUsuario : TEntityUsuario) : Boolean;
      function ListarUsuarios : TEntityListaUsuarios;

      constructor Create;
      destructor Destroy;
  end;

implementation

{ TControllerUsuario }



{ TControllerUsuario }

constructor TControllerUsuario.Create;
begin
  FUsuario := TEntityUsuario.Create;
end;

destructor TControllerUsuario.Destroy;
begin
  FreeAndNil(FUsuario);
end;

function TControllerUsuario.Gravausuario(AEntityUsuario: TEntityUsuario): Boolean;
var
  Modelusuario   : TModelUsuario;
  JsonretornoAPI : TJSONObject;

  function ValidaCampos( ANome,ALogin, ASenha : string ) : Boolean;
  begin
    Result := false;

    if ANome = '' then
    begin
      ShowMessage('NOME n�o preenchido !');
      Exit;
    end;

    if ALogin = '' then
    begin
      ShowMessage('LOGIN n�o preenchido !');
      Exit;
    end;

    if ASenha = '' then
    begin
      ShowMessage('SENHA n�o preenchido !');
      Exit;
    end;

    Result := True;
  end;
begin
  if not ValidaCampos(AEntityUsuario.Nome,AEntityUsuario.Longin,AEntityUsuario.Pass) then
    Exit;

  Modelusuario := TModelUsuario.Create;
  try
    with Modelusuario do
    begin
      EntityUsuario.Nome   := AEntityUsuario.Nome;
      EntityUsuario.Longin := AEntityUsuario.Longin;
      EntityUsuario.Pass   := AEntityUsuario.Pass;
    end;

    JsonretornoAPI := Modelusuario.Gravar;

  finally
    FreeAndNil(Modelusuario);
  end;

  Result := True;
end;

function TControllerUsuario.ListarUsuarios: TEntityListaUsuarios;
var
  Modelusuario  : TModelUsuario;
  jObject       : TJSONObject;
  jArray        : TJSONArray;
  ListaUsuarios : TEntityListaUsuarios;
  i             : Integer;
begin
  Modelusuario  := TModelUsuario.Create;
  ListaUsuarios := TEntityListaUsuarios.Create;

  try
    jObject := Modelusuario.Listar;
  finally
    FreeAndNil(Modelusuario);
  end;

  jArray := jObject.GetValue<TJSONArray>('Usuarios') as TJSONArray;
  try
    for I := 0 to Pred(jArray.Count) do
      begin
        jObject := jArray.Items[i] as TJSONObject;

        ListaUsuarios.UsuarioEntity.ID     := jObject.GetValue<Integer>('id');
        ListaUsuarios.UsuarioEntity.Nome   := jObject.GetValue<string>('nome');
        ListaUsuarios.UsuarioEntity.Longin := jObject.GetValue<string>('login');
        ListaUsuarios.UsuarioEntity.Pass   := jObject.GetValue<string>('pass');

        ListaUsuarios.AddUsuario(ListaUsuarios.UsuarioEntity);
      end;
  finally
    FreeAndNil(jArray);
  end;

  Result := ListaUsuarios;

end;

end.
